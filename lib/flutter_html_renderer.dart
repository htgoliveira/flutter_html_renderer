library flutter_html_renderer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html_renderer/widgets_factory.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;

import 'Components/handler/link_handler.dart';

/// Widgets, that renders HTML as an flutter Widgets
/// Widgets are rendered with [WidgetsFactory]. See documentation of this class
/// for more information about rendering rules and ways to override default
/// behaviour.
class Html extends StatefulWidget {
  /// Initial HTML String. Only one of data and initialNodes
  /// can be used
  final String data;

  ///Initial list of  nodes  Only one of data and initialNodes
  /// can be used
  final NodeList initialNodes;

  /// Cache with [AutomaticKeepAliveClientMixin]
  final bool keepAlive;

  /// Optional handler of <a> clicks
  final LinkHandler linkHandler;

  Html({
    this.data,
    this.initialNodes,
    this.keepAlive = false,
    this.linkHandler,
  });

  @override
  HtmlRendererState createState() => HtmlRendererState();
}

/// State of [HtmlRenderer] widget
class HtmlRendererState extends State<Html>
    with AutomaticKeepAliveClientMixin<Html> {
  /// Current HTML tree
  NodeList _htmlTree;

  /// Factory instance used for rendering
  WidgetsFactory _widgetsFactory;

  /// Future for waiting to render Widget tree
  Future<Widget> _rendererFuture;

  @override
  void initState() {
    super.initState();

    assert((widget.initialNodes != null) != (widget.data != null));
    _widgetsFactory = WidgetsFactory();
    // if (widget.data != null) {
    //   _htmlTree = htmlParser.parse(widget.data, generateSpans: true).nodes;
    // } else {
    //   _htmlTree = widget.initialNodes;
    // }
    _rendererFuture = _widgetsFactory.nodeListToWidgets(_htmlTree, context,
        linkHandler: widget.linkHandler);
  }

  @override
  Widget build(BuildContext context) {
    //NOTE: Subclasses must implement wantKeepAlive, and their build methods
    // must call super.build
    // (the return value will always return null, and should be ignored)
    super.build(context);

    return FutureBuilder<Widget>(
      future: _rendererFuture,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Align(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  set htmlTree(NodeList value) {
    assert(value?.isNotEmpty ?? false);

    setState(() {
      _htmlTree = value;
      _rendererFuture = _widgetsFactory.nodeListToWidgets(_htmlTree, context,
          linkHandler: widget.linkHandler);
    });
  }

  set htmlString(String html) {
    assert(html?.isNotEmpty ?? false);

    setState(() {
      _htmlTree = htmlParser.parse(html, generateSpans: false).nodes;
      _rendererFuture = _widgetsFactory.nodeListToWidgets(_htmlTree, context,
          linkHandler: widget.linkHandler);
    });
  }
}

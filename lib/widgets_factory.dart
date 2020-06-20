library flutter_html_renderer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;

import 'Components/element/element_descriptor.dart';
import 'Components/element/element_descriptor_conf.dart';
import 'Components/handler/link_handler.dart';
import 'Components/rendering_context.dart';

/// Factory for rewriting HTML into widget sets.
/// Despite changes in HTML5, this renderer uses HTML4 logic of
/// block and inline elements. This is mainly because of simplicity.
/// Block level elements are by default rendered wrapper of their
/// inner content with no padding nor margin. Block level elements are always
/// rendered on a new row.
/// On contrary, inline elements are organized into flows. Inline elements
/// in the same flow are rendered inside [Row] widgets. If there is block
/// element as a sibling of inline elements, block element marks the end
/// of the currentFlow. By applying same logic, block elements are rendered as
/// single element in its own flow.
///
/// For example:
///
/// <img>
/// <span id='firstSpan'></span>
/// <p></p>
/// <span id='secondSpan'></span
///
/// would be rendered as:
/// Flow 1:
/// img span#firstSpan
/// Flow 2:
/// p
/// Flow 3:
/// span#secondSpan
///
/// These flows are rendered inside [Column] widget. Widget tree is also
/// optimized as following:
///
/// 1. If flow contains only one element, no [Row] widget is added
/// 2. If flow doesn't have any sibling no [Column] widget is added
///
/// For example:
/// <img src='http://example.com/foo.jpg'>
/// <span id='firstSpan'>Lorem ipsum</span>
/// <p>Docor sit</p>
/// <span id='secondSpan'>net</span>
///
/// Renders as following Widget tree:
///
/// [Column]
///   [Row]
///     [TransitionToImage]
///       [AdvancedNetworkImage]
///     [Text] = Lorem ipsum
///   [Text] - Docor sit
///   [Text] - net
///
/// To extend rendering of tag, extend [ElementDescriptor] class, implement
/// [ElementDescriptor]#render method and replace descriptor in
/// [WidgetsFactory]#allElements map.
class WidgetsFactory {
  /// Convert HTML to WidgetTree
  Future<Widget> nodeListToWidgets(
    dom.NodeList nodes,
    BuildContext context, {
    LinkHandler linkHandler,
    RenderingContext renderingContext,
  }) async {
    assert(nodes?.isNotEmpty ?? false);
    renderingContext ??= RenderingContext();
    List<Widget> widgets = [];
    List<Widget> currentFlow = [];

    for (dom.Node node in nodes) {
      if (node is dom.Text) {
        if (node.text.trim() != "") {
          if (renderingContext.hasAnchorParent) {
            currentFlow.add(Text(
              node.text,
              style: Theme.of(context).textTheme.bodyText2,
              softWrap: true,
            ));
          } else if (renderingContext.hasHeaderParent) {
            currentFlow.add(Text(
              node.text,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.start,
              softWrap: true,
            ));
          } else {
            currentFlow.add(Text(
              node.text,
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
            ));
          }
        }
      } else if (node is dom.Element) {
        ElementDescriptor descriptor =
            ElementDescriptorConf.allElements[node.localName];
        if (descriptor == null) {
          print('Warning: unknown HTML element ${node.localName} ignored');
        } else if (descriptor.supported) {
          if (descriptor.isBlock) {
            if (currentFlow.isNotEmpty) {
              _addFlowToWidgets(widgets, currentFlow);
              currentFlow = [];
            }
            widgets.add(await parseNode(
                node, descriptor, context, renderingContext,
                linkHandler: linkHandler));
          } else {
            currentFlow.add(await parseNode(
                node, descriptor, context, renderingContext,
                linkHandler: linkHandler));
          }
        }
      }
    }
    if (currentFlow.isNotEmpty) {
      _addFlowToWidgets(widgets, currentFlow);
    }
    return widgets.length > 1
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          )
        : widgets.length > 0 ? widgets[0] : Container();
  }

  /// Add currentFlow to list of widgets
  void _addFlowToWidgets(List<Widget> widgets, List<Widget> currentFlow) {
    if (currentFlow.length > 1) {
      widgets.add(Row(children: currentFlow));
    } else {
      widgets.add(currentFlow[0]);
    }
  }

  /// Parse single node of HTML
  Future<Widget> parseNode(
    dom.Element node,
    ElementDescriptor descriptor,
    BuildContext context,
    RenderingContext renderingContext, {
    LinkHandler linkHandler,
  }) async {
    Widget children;
    Widget rendered = await descriptor.render(
        node, context, this, linkHandler, renderingContext);
    if (rendered == null) {
      if (node.nodes.isNotEmpty) {
        children = await nodeListToWidgets(node.nodes, context,
            linkHandler: linkHandler);
      }
      if (children == null) {
        return Container();
      }
      return children;
    }
    return rendered;
  }
}

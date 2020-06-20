import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../element/element_descriptor.dart';
import '../rendering_context.dart';

/// Descriptor of the <a> tag.
/// This will pass a copy of the [RenderingContext] with hasAnchorParent=true
/// to default rendering
/// of child nodes, and wraps them in a [GestureDetector].
///
/// On click:
/// If linkHandler is not null, it is called. If is null, or returns false,
/// we will check if link can be launched in browser and potentially launch
/// browser
class AnchorDescriptor extends ElementDescriptor {
  const AnchorDescriptor()
      : super(
          name: 'a',
          supported: true,
          isInline: true,
          isBlock: false,
        );

  @override
  Future<Widget> render(
      dom.Element element,
      BuildContext context,
      WidgetsFactory widgetsFactory,
      LinkHandler linkHandler,
      RenderingContext renderingContext) async {
    String url = element.attributes['href'];
    Widget children;
    renderingContext = RenderingContext.copy(renderingContext);
    renderingContext.hasAnchorParent = true;
    if (element.nodes.isNotEmpty) {
      children = await widgetsFactory.nodeListToWidgets(element.nodes, context,
          linkHandler: linkHandler);
    }
    children ??= Container();

    return GestureDetector(
      child: children,
      onTap: () async {
        if (linkHandler == null || !(await linkHandler(url))) {
          if (await canLaunch(url)) {
            await launch(url);
          }
        }
      },
    );
  }
}

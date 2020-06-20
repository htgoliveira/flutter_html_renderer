import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../element/element_descriptor.dart';
import '../rendering_context.dart';

/// <h1> -<h6> and <header> descriptor.
/// This will pass a copy of the [RenderingContext] with hasHeaderParent=true
/// to default rendering
/// of child nodes
class HeaderDescriptor extends ElementDescriptor {
  const HeaderDescriptor({String name})
      : super(
          name: name,
          supported: true,
          isInline: false,
          isBlock: true,
        );

  @override
  Future<Widget> render(
      dom.Element element,
      BuildContext context,
      WidgetsFactory widgetsFactory,
      LinkHandler linkHandler,
      RenderingContext renderingContext) async {
    Widget children;
    renderingContext = RenderingContext.copy(renderingContext);
    renderingContext.hasHeaderParent = true;
    if (element.nodes.isNotEmpty) {
      children = await widgetsFactory.nodeListToWidgets(element.nodes, context,
          linkHandler: linkHandler, renderingContext: renderingContext);
    }
    children ??= Container();
    return Padding(
      child: children,
      padding: EdgeInsets.symmetric(vertical: 5),
    );
  }
}

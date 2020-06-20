import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../element/element_descriptor.dart';
import '../rendering_context.dart';

/// <p> descriptor.
/// This will add padding after default rendering
/// of child nodes
class PDescriptor extends ElementDescriptor {
  const PDescriptor()
      : super(
          name: 'p',
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
    if (element.nodes.isNotEmpty) {
      children = await widgetsFactory.nodeListToWidgets(element.nodes, context,
          linkHandler: linkHandler, renderingContext: renderingContext);
    }
    children ??= Container();
    return Padding(
      child: children,
      padding: EdgeInsets.only(bottom: 5),
    );
  }
}

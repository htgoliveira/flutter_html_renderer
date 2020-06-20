import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import '../handler/link_handler.dart';
import '../rendering_context.dart';
import 'element_descriptor.dart';

class ElementParser {
  /// Parse single node of HTML
  ///
  // Future<Widget> parseNode(
  //   dom.Element node,
  //   ElementDescriptor descriptor,
  //   BuildContext context,
  //   RenderingContext renderingContext, {
  //   LinkHandler linkHandler,
  // }) async {
  //   Widget children;
  //   Widget rendered = await descriptor.render(
  //       node, context, this, linkHandler, renderingContext);
  //   if (rendered == null) {
  //     if (node.nodes.isNotEmpty) {
  //       children = await nodeListToWidgets(node.nodes, context,
  //           linkHandler: linkHandler);
  //     }
  //     if (children == null) {
  //       return Container();
  //     }
  //     return children;
  //   }
  //   return rendered;
  // }
}

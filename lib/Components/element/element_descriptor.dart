import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../rendering_context.dart';

/// Descriptor of Html element. Provides information, about how should
/// be widget rendered
class ElementDescriptor {
  /// HTML name of the element
  final String name;

  /// Flag that provides information if this element is supported
  final bool supported;

  /// Flag that provides information if this is an inline element
  final bool isInline;

  /// Flag that provides ionformation if this is a block element
  final bool isBlock;

  /// Render element. If this returns null, default rendering is used
  Future<Widget> render(
    dom.Element element,
    BuildContext context,
    WidgetsFactory widgetsFactory,
    LinkHandler linkHandler,
    RenderingContext renderingContext,
  ) async {
    return null;
  }

  const ElementDescriptor({
    this.name,
    this.supported,
    this.isInline = false,
    this.isBlock = false,
  });
}

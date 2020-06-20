import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:html/dom.dart' as dom;

import '../../widgets_factory.dart';
import '../handler/link_handler.dart';
import '../element/element_descriptor.dart';
import '../rendering_context.dart';

/// Descriptor for the <img> tag.
/// If src attribute is null or empty, returns empty [Container]
///
/// If src starts with data:, it is treated as base64 encoded image and returns
/// [Image] widget.
///
/// Otherwise, [AdvancedNetworkImage] wrapped in a [TransitionToImage] is used
class ImgDescriptor extends ElementDescriptor {
  const ImgDescriptor()
      : super(
          name: 'img',
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
    String src = element.attributes['src'];
    if (src == null || src.trim().isEmpty) {
      return Container();
    }
    if (src.startsWith('data:')) {
      final UriData data = Uri.parse(src).data;
      return Image.memory(
        data.contentAsBytes(),
        fit: BoxFit.contain,
        gaplessPlayback: true,
      );
    }
    return TransitionToImage(
      image: AdvancedNetworkImage(
        src,
        useDiskCache: true,
      ),
      loadingWidget: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
      fit: BoxFit.contain,
      placeholder: const Icon(Icons.refresh),
    );
  }
}

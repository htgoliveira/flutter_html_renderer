import '../descriptor/anchor_descriptor.dart';
import '../descriptor/iframe_descriptor.dart';
import '../descriptor/img_descriptor.dart';
import '../descriptor/p_descriptor.dart';
import '../descriptor/header_descriptor.dart';

import 'element_descriptor.dart';

class ElementDescriptorConf {
  static const List<ElementDescriptor> _blockElements = [
    ElementDescriptor(name: 'body', supported: true, isBlock: true),
    ElementDescriptor(name: 'html', supported: true, isBlock: true),
    ElementDescriptor(name: 'head', supported: false, isBlock: true),
    ElementDescriptor(name: 'address', supported: true, isBlock: true),
    ElementDescriptor(name: 'article', supported: true, isBlock: true),
    ElementDescriptor(name: 'aside', supported: true, isBlock: true),
    ElementDescriptor(name: 'blockquote', supported: true, isBlock: true),
    ElementDescriptor(name: 'details', supported: true, isBlock: true),
    ElementDescriptor(name: 'dialog', supported: true, isBlock: true),
    ElementDescriptor(name: 'dd', supported: false, isBlock: true),
    ElementDescriptor(name: 'div', supported: true, isBlock: true),
    ElementDescriptor(name: 'dl', supported: true, isBlock: true),
    ElementDescriptor(name: 'dt', supported: true, isBlock: true),
    ElementDescriptor(name: 'fieldset', supported: true, isBlock: true),
    ElementDescriptor(name: 'figcaption', supported: true, isBlock: true),
    ElementDescriptor(name: 'figure', supported: true, isBlock: true),
    ElementDescriptor(name: 'footer', supported: true, isBlock: true),
    ElementDescriptor(name: 'form', supported: false, isBlock: true),
    HeaderDescriptor(name: 'h1'),
    HeaderDescriptor(name: 'h2'),
    HeaderDescriptor(name: 'h3'),
    HeaderDescriptor(name: 'h4'),
    HeaderDescriptor(name: 'h5'),
    HeaderDescriptor(name: 'h6'),
    HeaderDescriptor(name: 'header'),
    ElementDescriptor(name: 'hgroup', supported: true, isBlock: true),
    ElementDescriptor(name: 'hr', supported: false, isBlock: true),
    ElementDescriptor(name: 'li', supported: false, isBlock: true),
    ElementDescriptor(name: 'main', supported: true, isBlock: true),
    ElementDescriptor(name: 'nav', supported: true, isBlock: true),
    ElementDescriptor(name: 'ol', supported: false, isBlock: true),
    PDescriptor(),
    ElementDescriptor(name: 'pre', supported: false, isBlock: true),
    ElementDescriptor(name: 'section', supported: true, isBlock: true),
    ElementDescriptor(name: 'table', supported: false, isBlock: true),
    ElementDescriptor(name: 'ul', supported: false, isBlock: true),
  ];

  static const List<ElementDescriptor> _inlineElements = [
    AnchorDescriptor(),
    ElementDescriptor(name: 'abbr', supported: true, isInline: true),
    ElementDescriptor(name: 'acronym', supported: true, isInline: true),
    ElementDescriptor(name: 'audio', supported: false, isInline: true),
    ElementDescriptor(name: 'b', supported: false, isInline: true),
    ElementDescriptor(name: 'bdi', supported: false, isInline: true),
    ElementDescriptor(name: 'bdo', supported: false, isInline: true),
    ElementDescriptor(name: 'big', supported: false, isInline: true),
    ElementDescriptor(name: 'br', supported: false, isInline: true),
    ElementDescriptor(name: 'button', supported: false, isInline: true),
    ElementDescriptor(name: 'canvas', supported: false, isInline: true),
    ElementDescriptor(name: 'cite', supported: true, isInline: true),
    ElementDescriptor(name: 'code', supported: false, isInline: true),
    ElementDescriptor(name: 'data', supported: false, isInline: true),
    ElementDescriptor(name: 'datalist', supported: false, isInline: true),
    ElementDescriptor(name: 'del', supported: false, isInline: true),
    ElementDescriptor(name: 'dfn', supported: false, isInline: true),
    ElementDescriptor(name: 'em', supported: false, isInline: true),
    ElementDescriptor(name: 'embed', supported: false, isInline: true),
    ElementDescriptor(name: 'i', supported: false, isInline: true),
    IframeDescriptor(),
    ImgDescriptor(),
    ElementDescriptor(name: 'input', supported: false, isInline: true),
    ElementDescriptor(name: 'ins', supported: false, isInline: true),
    ElementDescriptor(name: 'kbd', supported: false, isInline: true),
    ElementDescriptor(name: 'label', supported: true, isInline: true),
    ElementDescriptor(name: 'map', supported: false, isInline: true),
    ElementDescriptor(name: 'mark', supported: false, isInline: true),
    ElementDescriptor(name: 'meter', supported: false, isInline: true),
    ElementDescriptor(name: 'noscript', supported: true, isInline: true),
    ElementDescriptor(name: 'object', supported: false, isInline: true),
    ElementDescriptor(name: 'output', supported: false, isInline: true),
    ElementDescriptor(name: 'picture', supported: false, isInline: true),
    ElementDescriptor(name: 'progress', supported: false, isInline: true),
    ElementDescriptor(name: 'q', supported: false, isInline: true),
    ElementDescriptor(name: 'ruby', supported: false, isInline: true),
    ElementDescriptor(name: 's', supported: false, isInline: true),
    ElementDescriptor(name: 'samp', supported: false, isInline: true),
    ElementDescriptor(name: 'script', supported: false, isInline: true),
    ElementDescriptor(name: 'select', supported: false, isInline: true),
    ElementDescriptor(name: 'slot', supported: false, isInline: true),
    ElementDescriptor(name: 'small', supported: false, isInline: true),
    ElementDescriptor(name: 'span', supported: true, isInline: true),
    ElementDescriptor(name: 'strong', supported: false, isInline: true),
    ElementDescriptor(name: 'sub', supported: false, isInline: true),
    ElementDescriptor(name: 'sup', supported: false, isInline: true),
    ElementDescriptor(name: 'svg', supported: false, isInline: true),
    ElementDescriptor(name: 'template', supported: false, isInline: true),
    ElementDescriptor(name: 'textarea', supported: false, isInline: true),
    ElementDescriptor(name: 'time', supported: false, isInline: true),
    ElementDescriptor(name: 'u', supported: false, isInline: true),
    ElementDescriptor(name: 'tt', supported: false, isInline: true),
    ElementDescriptor(name: 'var', supported: false, isInline: true),
    ElementDescriptor(name: 'video', supported: false, isInline: true),
    ElementDescriptor(name: 'wbr', supported: false, isInline: true),
  ];

  /// Map of all recognized elements. Key is the name of the element.
  static final Map<String, ElementDescriptor> allElements =
      new Map.fromIterable(
          <ElementDescriptor>[]
            ..addAll(_blockElements)
            ..addAll(_inlineElements),
          key: (dynamic el) => el.name);
}

class RenderingContext {
  bool hasAnchorParent = false;
  bool hasHeaderParent = false;

  RenderingContext();

  RenderingContext.copy(RenderingContext other) {
    hasAnchorParent = other.hasAnchorParent;
  }
}

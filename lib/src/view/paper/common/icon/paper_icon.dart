part of stagexl_commons;

class PaperIcon {
  static SvgDisplayObject color(String rawSvg, int color) {
    double r = ((color >> 16) & 0xFF) / 255;
    double g = ((color >> 8) & 0xFF) / 255;
    double b = ((color >> 0) & 0xFF) / 255;
    //double a = ((color >> 24) & 0xFF) / 255;

    String svg = """
      <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48">
        <filter id="matrix-grey">
          <feColorMatrix in="SourceGraphic" type="matrix" values="1 0 0 0 ${r}
                                                                  0 1 0 0 ${g}
                                                                  0 0 1 0 ${b}
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-grey)">
          ${rawSvg}
        </g>
      </svg>""";

    return new SvgDisplayObject(svg);
  }

  static SvgDisplayObject inverted(String rawSvg) {
    String svg = """
      <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48">
        <filter id="matrix-invert">
          <feColorMatrix type="matrix" values="-1 0 0 0 1
                                                                  0 -1 0 0 1
                                                                  0 0 -1 0 1
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-invert)">
          ${rawSvg}
        </g>
      </svg>""";

    return new SvgDisplayObject(svg);
  }

  static SvgDisplayObject black(String rawSvg) {
    return color(rawSvg, PaperColor.BLACK);
  }

  static SvgDisplayObject white(String rawSvg) {
    return inverted(rawSvg);
  }
}

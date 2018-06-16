part of acanvas_commons;

class MdIcon {
  static SvgDisplayObject color(String rawSvg, int color, {int size: 24}) {
    double r = ((color >> 16) & 0xFF) / 255;
    double g = ((color >> 8) & 0xFF) / 255;
    double b = ((color >> 0) & 0xFF) / 255;
    //double a = ((color >> 24) & 0xFF) / 255;

    String svg = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
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

    return new SvgDisplayObject(svg, width: size, height: size);
  }

  static SvgDisplayObject inverted(String rawSvg, {int size: 24}) {
    String svg = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
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

    return new SvgDisplayObject(svg, width: size, height: size);
  }

  static SvgDisplayObject black(String rawSvg, {int size: 24}) {
    return color(rawSvg, MdColor.BLACK, size: size);
  }

  static SvgDisplayObject white(String rawSvg, {int size: 24}) {
    return inverted(rawSvg, size: size);
  }
}

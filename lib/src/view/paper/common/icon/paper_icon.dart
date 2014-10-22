part of stagexl_commons;

class PaperIcon {
  
  static final String  greySVG = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
        <filter id="matrix-grey">
          <feColorMatrix in="SourceGraphic" type="matrix" values="1 0 0 0 .5 
                                                                  0 1 0 0 .5 
                                                                  0 0 1 0 .5
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-grey)">        
          #R#
        </g>
      </svg>""";

  static final String  redSVG = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
        <filter id="matrix-red">
          <feColorMatrix in="SourceGraphic" type="matrix" values="1 0 0 0 0.8235 
                                                                  0 1 0 0 0.2470
                                                                  0 0 1 0 0.1921
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-red)">        
          #R#
        </g>
      </svg>""";

  static final String  invertedSVG = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
        <filter id="matrix-invert">
          <feColorMatrix type="matrix" values="-1 0 0 0 1 
                                                                  0 -1 0 0 1 
                                                                  0 0 -1 0 1
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-invert)">        
          #R#
        </g>
      </svg>""";

  static final String  normalSVG = """
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24">
        #R#
      </svg>""";
  
  static SvgDisplayObject black(String rawSVG){
    String svg = normalSVG.replaceFirst(new RegExp(r'#R#'), rawSVG);
    return new SvgDisplayObject(svg);
  }
  static SvgDisplayObject white(String rawSVG){
    String svg = invertedSVG.replaceFirst(new RegExp(r'#R#'), rawSVG);
    return new SvgDisplayObject(svg);
  }
  static SvgDisplayObject grey(String rawSVG){
    String svg = greySVG.replaceFirst(new RegExp(r'#R#'), rawSVG);
    return new SvgDisplayObject(svg);
  }
  static SvgDisplayObject red(String rawSVG){
    String svg = redSVG.replaceFirst(new RegExp(r'#R#'), rawSVG);
    return new SvgDisplayObject(svg);
  }
  
}

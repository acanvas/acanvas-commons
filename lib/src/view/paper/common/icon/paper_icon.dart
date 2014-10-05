part of dart_commons;

class PaperIcon {
  
  static final String  greySVG = """
      <svg xmlns="http://www.w3.org/2000/svg">
        <filter id="matrix-invert">
          <feColorMatrix in="SourceGraphic" type="matrix" values="1 0 0 0 .5 
                                                                  0 1 0 0 .5 
                                                                  0 0 1 0 .5
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-invert)">        
          #R#
        </g>
      </svg>""";

  static final String  invertedSVG = """
      <svg xmlns="http://www.w3.org/2000/svg">
        <filter id="matrix-invert">
          <feColorMatrix in="SourceGraphic" type="matrix" values="-1 0 0 0 1 
                                                                  0 -1 0 0 1 
                                                                  0 0 -1 0 1
                                                                  0 0 0 1 0"/>
        </filter>
        <g filter="url(#matrix-invert)">        
          #R#
        </g>
      </svg>""";

  static final String  normalSVG = """
      <svg xmlns="http://www.w3.org/2000/svg">
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
  
}

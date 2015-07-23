part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
enum AlignV {TOP, CENTER, BOTTOM}
enum AlignH {LEFT, CENTER, RIGHT}

abstract class MBox {

  //-------- Child Alignment

  AlignH _alignH = AlignH.LEFT;
  void set alignH (AlignH alignH) => _alignH = alignH;
  AlignH get alignH => _alignH;

  AlignV _alignV = AlignV.TOP;
  void set alignV (AlignV alignV) => _alignV = alignV;
  AlignV get alignV => _alignV;


  bool _inheritAlignH = false;
  void set inheritAlignH (bool inheritAlignH) => _inheritAlignH = inheritAlignH;
  bool get inheritAlignH => _inheritAlignH;

  bool _inheritAlignV = false;
  void set inheritAlignV (bool inheritAlignV) => _inheritAlignV = inheritAlignV;
  bool get inheritAlignV => _inheritAlignV;

  //-------- Margin, Padding, Span
  num _padding = 0;
  void set padding (num padding) => _padding = padding;
  num get padding => _padding;

  num _margin = 0;
  void set margin (num margin) => _margin = margin;
  num get margin => _margin;

  num _spanWidth = 0;
  void set spanWidth (num spanWidth) => _spanWidth = spanWidth;
  num get spanWidth => _spanWidth;

  num _spanHeight = 0;
  void set spanHeight (num spanHeight) => _spanHeight = spanHeight;
  num get spanHeight => _spanHeight;

  bool _inheritSpan = false;
  void set inheritSpan (bool inheritSpan) => _inheritSpan = inheritSpan;
  bool get inheritSpan => _inheritSpan;
  
  bool _inheritPadding = false;
  void set inheritPadding (bool inheritPadding) => _inheritPadding = inheritPadding;
  bool get inheritPadding => _inheritPadding;

  ///this one might be stupid
  bool _inheritMargin = false;
  void set inheritMargin (bool inheritMargin) => _inheritMargin = inheritMargin;
  bool get inheritMargin => _inheritMargin;

  bool _inheritRefresh = true;
  void set inheritRefresh (bool inheritRefresh) => _inheritRefresh = inheritRefresh;
  bool get inheritRefresh => _inheritRefresh;

  bool _inheritDispose = true;
  void set inheritDispose (bool inheritDispose) => _inheritDispose = inheritDispose;
  bool get inheritDispose => _inheritDispose;

  void span(num spanWidth, num spanHeight, {bool refresh: true}){
    _spanWidth = spanWidth;
    _spanHeight = spanHeight;
  }

  void refresh();
  void dispose();

}
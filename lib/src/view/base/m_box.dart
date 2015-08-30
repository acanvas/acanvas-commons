part of stagexl_commons;

/// Vertical Alignment options of [BoxSprite]
enum AlignV {
  TOP, CENTER, BOTTOM
}
/// Horizontal Alignment options of [BoxSprite]
enum AlignH {
  LEFT, CENTER, RIGHT
}

/// The Mixin class for [BoxSprite].
///
/// Using [BoxSprite] (and its sub classes) greatly simplifies working with StageXL's display list.
/// [BoxSprite] adds box model features to StageXL.
/// See the examples.
abstract class MBox {

  //-------- Child Alignment

  /// Setter/Getter of horizontal alignment.
  void set alignH(AlignH alignH) {
    _alignH = alignH;
  }

  /// Returns the horizontal alignment.
  AlignH get alignH => _alignH;

  AlignH _alignH = AlignH.LEFT;

  /// Setter/Getter of horizontal alignment inheritance.
  ///
  /// The default value is false.
  /// If set to true, then a parent [BoxSprite]'s [alignH] setter
  /// would invoke the [alignH] setter of this class, using the same value.
  bool _inheritAlignH = false;

  void set inheritAlignH(bool inheritAlignH) {
    _inheritAlignH = inheritAlignH;
  }

  bool get inheritAlignH => _inheritAlignH;

  /// Setter/Getter of vertical alignment.
  void set alignV(AlignV alignV) {
    _alignV = alignV;
  }

  /// Returns the vertical alignment.
  AlignV get alignV => _alignV;

  AlignV _alignV = AlignV.TOP;

  /// Setter/Getter of vertical alignment inheritance.
  ///
  /// The default value is false.
  /// If set to true, then a parent [BoxSprite]'s [alignV] setter
  /// would invoke the [alignV] setter of this class, using the same value.
  void set inheritAlignV(bool inheritAlignV) {
    _inheritAlignV = inheritAlignV;
  }

  /// Returns the vertical alignment inheritance.
  bool get inheritAlignV => _inheritAlignV;

  bool _inheritAlignV = false;

  //-------- Margin, Padding, Span

  /// Setter/Getter of padding of the box model.
  void set padding(num padding) {
    _padding = padding;
  }

  /// Returns the padding of the box model.
  num get padding => _padding;

  num _padding = 0;

  /// Setter/Getter of width to use with the box model.
  void set spanWidth(num spanWidth) {
    _spanWidth = spanWidth;
  }

  /// Returns the width used by the box model.
  num get spanWidth => _spanWidth;

  num _spanWidth = 0;

  /// Setter/Getter of height to use with the box model.
  void set spanHeight(num spanHeight) {
    _spanHeight = spanHeight;
  }

  /// Returns the height used by the box model.
  num get spanHeight => _spanHeight;

  num _spanHeight = 0;

  /// Setter/Getter of inheritance behaviour of the box model's width and height.
  ///
  /// The default value is false.
  /// If set to true, then a parent [BoxSprite]'s [span] method
  /// would invoke the [span] method of this class, using the same values.
  void set inheritSpan(bool inheritSpan) {
    _inheritSpan = inheritSpan;
  }

  /// Returns the inheritance behaviour of the box model's width and height
  bool get inheritSpan => _inheritSpan;

  bool _inheritSpan = false;

  /// Setter/Getter of span to the actual width and height of this [Sprite] after [refresh].
  ///
  /// The default value is false.
  /// If true, then after each call to [refresh], the [span] box will get
  /// updated with the actual [width] and [height] of this [BoxSprite].
  void set autoSpan(bool autoSpan) {
    _autoSpan = autoSpan;
  }

  /// Returns the automatic span behaviour
  bool get autoSpan => _autoSpan;

  bool _autoSpan = false;

  /// Setter/Getter of inheritance behaviour of the box model's padding.
  ///
  /// The default value is false.
  /// If set to true, then a parent [BoxSprite]'s [padding] setter
  /// would invoke the [padding] setter of this class, using the same values.
  bool _inheritPadding = false;

  void set inheritPadding(bool inheritPadding) {
    _inheritPadding = inheritPadding;
  }

  /// Returns the inheritance behaviour of the box model's padding
  bool get inheritPadding => _inheritPadding;

  /// Setter/Getter of autoRefresh behaviour.
  ///
  /// The default value is false.
  /// If true, then [refresh] will get called as soon
  /// as this class is added as a child to another [BoxSprite].
  void set autoRefresh(bool autoRefresh) {
    _autoRefresh = autoRefresh;
  }

  /// Returns the autoRefresh behaviour.
  bool get autoRefresh => _autoRefresh;

  bool _autoRefresh = false;

  /// Setter/Getter of inheritance behaviour of the [dispose] method.
  ///
  /// The default value is true.
  /// If set to true, then a parent [BoxSprite]'s [dispose] method
  /// would invoke the [dispose] method of this class.
  void set inheritDispose(bool inheritDispose) {
    _inheritDispose = inheritDispose;
  }

  /// Returns the inheritance behaviour of the [dispose] method
  bool get inheritDispose => _inheritDispose;

  bool _inheritDispose = true;

  /// Setter/Getter of box model's width and height.
  ///
  /// An optional parameter, bool refresh, indicates whether the [refresh] method should get called.
  void span(num spanWidth, num spanHeight, {bool refresh: true}) {
    _spanWidth = spanWidth;
    _spanHeight = spanHeight;
  }

  /// Triggered by [BoxSprite] and other managing classes,
  /// whenever positioning and size need an update.
  /// This method is implemented by [BoxSprite], but only manages logic.
  /// You will have to implement positioning of children by yourself.
  /// See [PaperButton] for an example.
  ///
  /// But it's simple: Just remember to put all positioning logic
  /// ALWAYS into the [refresh] method.
  ///
  /// Setting [autoRefresh] to true would treat this automatically.
  /// See [Button] class.
  void refresh();

  /// Ensures a full cleanup of the class.
  ///
  /// This method is implemented by [BoxSprite] and *really* cleans up.
  /// Override to add additional cleanup, for example of custom listeners.
  void dispose();

}
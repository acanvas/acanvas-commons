part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

enum ScrollOrientation {
  HORIZONTAL, VERTICAL, BOTH
}

abstract class MScroll {

  ScrollOrientation _scrollOrientaton = ScrollOrientation.BOTH;

  void set scrollOrientation(ScrollOrientation scrollOrientation) => _scrollOrientaton = scrollOrientation;

  ScrollOrientation get scrollOrientation => _scrollOrientaton;

  bool _doubleClickEnabled = false;

  void set doubleClickEnabled(bool doubleClickEnabled) => _doubleClickEnabled = doubleClickEnabled;

  bool get doubleClickEnabled => _doubleClickEnabled;

  bool _keyboardEnabled = false;

  void set keyboardEnabled(bool keyboardEnabled) => _keyboardEnabled = keyboardEnabled;

  bool get keyboardEnabled => _keyboardEnabled;

  bool _doubleClickToZoom = false;

  void set doubleClickToZoom(bool doubleClickToZoom) => _doubleClickToZoom = doubleClickToZoom;

  bool get doubleClickToZoom => _doubleClickToZoom;

  bool _bounce = ContextTool.MOBILE ? true : false;

  void set bounce(bool bounce) => _bounce = bounce;

  bool get bounce => _bounce;

  bool _autoHide = ContextTool.MOBILE ? true : false;

  void set autoHideScrollbars(bool autoHide) => _autoHide = autoHide;

  bool get autoHideScrollbars => _autoHide;

  bool _maskEnabled = true;

  void set maskEnabled(bool maskEnabled) => _maskEnabled = maskEnabled;

  bool get maskEnabled => _maskEnabled;

  bool _useNativeWidth = true;

  void set useNativeWidth(bool useNativeWidth) => _useNativeWidth = useNativeWidth;

  bool get useNativeWidth => _useNativeWidth;

  bool _useNativeHeight = true;

  void set useNativeHeight(bool useNativeHeight) => _useNativeHeight = useNativeHeight;

  bool get useNativeHeight => _useNativeHeight;

  int _scrollStep = 10;

  void set scrollStep(int scrollStep) => _scrollStep = scrollStep;

  int get scrollStep => _scrollStep;

  num _zoomInValue = 2.0;

  void set zoomInValue(num zoomInValue) => _zoomInValue = zoomInValue;

  num get zoomInValue => _zoomInValue;

  num _zoomOutValue = 1.0;

  void set zoomOutValue(num zoomOutValue) => _zoomOutValue = zoomOutValue;

  num get zoomOutValue => _zoomOutValue;

}

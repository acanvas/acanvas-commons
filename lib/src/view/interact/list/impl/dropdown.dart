part of stagexl_commons;

class ComponentDropdown extends BehaveSprite {
  static const String ROLLOUT_OPEN = "OPEN";
  static const String ROLLOUT_CLOSE = "CLOSE";

  BoxSprite _sprRollout;
  Button btnRolloutToggle;
  ListSprite cmpListFlyout;
  bool _blnMirrorButtonOnToggle = false;

  String _strRolloutState;
  Function _onToggleCallback;

  ComponentDropdown() : super() {
    _sprRollout = new BoxSprite();
    addChild(_sprRollout);

    if (cmpListFlyout != null) {
      cmpListFlyout.submitCallback = _onCellSubmit;
      _sprRollout.addChild(cmpListFlyout);
      //dartcomment
      //cmpListFlyout.refresh();
    }

    _strRolloutState = ROLLOUT_CLOSE;

    btnRolloutToggle.submitCallback = toggleRollout;
    addChild(btnRolloutToggle);
  }

  void setListSizeMax(int w, int h) {
    if (cmpListFlyout != null) {
      cmpListFlyout.span(w, h);
    }
  }

  @override
  void refresh() {
    super.refresh();

    btnRolloutToggle.span(spanWidth, spanHeight);

    _sprRollout.x = btnRolloutToggle.x + spanWidth - _sprRollout.width + 43;
    _sprRollout.y = -_sprRollout.height;

    this.mask = new Mask.rectangle(0, 0, _sprRollout.width + 20, _sprRollout.height + 2);
  }

  void toggleRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_CLOSE) {
      openRollout();
    } else {
      closeRollout();
    }
  }

  void openRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_CLOSE) {
      if (_blnMirrorButtonOnToggle) {
        btnRolloutToggle.scaleY = -1;
        btnRolloutToggle.y = spanHeight - 1;
      }

      _sprRollout.visible = true;
      _strRolloutState = ROLLOUT_OPEN;
      RdEnvironment.JUGGLER.addTween(_sprRollout, 0.5)..animate.y.to(spanHeight);
      if (_onToggleCallback != null) {
        _onToggleCallback.call(_strRolloutState);
      }
    }
  }

  void closeRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_OPEN) {
      if (_blnMirrorButtonOnToggle) {
        btnRolloutToggle.scaleY = 1;
        btnRolloutToggle.y = -1;
      }
      _strRolloutState = ROLLOUT_CLOSE;
      RdEnvironment.JUGGLER.addTween(_sprRollout, 0)
        ..animate.y.to(-_sprRollout.height)
        ..onComplete = _onCloseRolloutComplete;
    }
  }

  void _onCloseRolloutComplete() {
    _sprRollout.visible = false;

    if (_onToggleCallback != null) {
      _onToggleCallback.call(_strRolloutState);
    }
  }

  void _onCellSubmit(SelectableButton cell) {
    btnRolloutToggle.labelText = cell.data;

    if (submitCallback != null) {
      submitCallback.call(cell);
    }

    closeRollout();
  }

  void set onToggleCallback(Function onToggleCallback) {
    _onToggleCallback = onToggleCallback;
  }
}

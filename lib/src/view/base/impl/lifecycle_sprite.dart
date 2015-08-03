part of stagexl_commons;

class LifecycleSprite extends BehaveSprite with MLifecycle {

  //TODO logger
  Logger log;

  LifecycleSprite(String id) : super() {
    if (id != null) {
      this.name = id;
    }
  }

  @override
  void span(num spanWidth, num spanHeight, {bool refresh: true}) {
    if (this.spanWidth != spanWidth || this.spanHeight != spanHeight) {
      if (spanWidth > 0) this.spanWidth = spanWidth;
      if (spanHeight > 0) this.spanHeight = spanHeight;

      children.where((c) => c is MBox && c.inheritSpan).forEach((child) {
        child.span(spanWidth, spanHeight, refresh: refresh);
      });

      if (refresh && initialized) {
        this.refresh();
      }
    }
  }

  void init({Map params: null}) {
    this.params = params;
    if (spanHeight == 0 || spanWidth == 0) {
      log.warn("You really should set XLSprite.spanWidth and XLSprite.spanHeight properties before invoking XLSprite.init().");
    }
  }

  void onInitComplete() {
    initialized = true;
    children.where((c) => c is MLifecycle && c.inheritInit && !c.initialized).forEach((child) {
      if (child.inheritSpan) {
        child.span(spanWidth, spanHeight, refresh: false);
      }
      child.init();
    });
    refresh();
    dispatchEvent(new LifecycleEvent(LifecycleEvent.INIT_COMPLETE));
  }

  void load({Map params: null}) {
    if (requiresLoading) {
      throw new StateError("You cannot invoke XLSprite.load() directly. Override it.");
    }
    else {
      onLoadComplete();
    }
  }

  void onLoadComplete([Event e = null]) {
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_COMPLETE));
  }

  void onLoadError(String errorMessage) {
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_ERROR, errorMessage));
  }

  @override
  void refresh() {
  }

  @override
  void appear({double duration: MLifecycle.APPEAR_DURATION_DEFAULT}) {
    children.where((c) => c is MLifecycle && c.inheritAppear).forEach((child) {
      child.appear(duration: duration);
    });

    super.appear(duration: duration);

  }

  @override
  void disappear({double duration: MLifecycle.DISAPPEAR_DURATION_DEFAULT, bool autoDispose : false}) {
    children.where((c) => c is MLifecycle && c.inheritDisappear).forEach((child) {
      child.disappear(duration: duration, autoDispose: autoDispose);
    });
    ContextTool.JUGGLER.delayCall(() {
      dispatchEvent(new LifecycleEvent(LifecycleEvent.DISAPPEAR_COMPLETE));
      if (autoDispose) {
        this.dispose();
      }
    }, duration);

  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    if (child is MLifecycle && !(child as MLifecycle).initialized && (child as MLifecycle).inheritInit && initialized) {
      if (spanWidth > 0 && spanHeight > 0) {
        if ((child as MBox).inheritSpan) {
          (child as MBox).span(spanWidth, spanHeight, refresh: false);
        }
        (child as MLifecycle).init();
      }
    }
  }

}
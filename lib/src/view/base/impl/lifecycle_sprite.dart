part of rockdot_commons;

class LifecycleSprite extends BehaveSprite with MLifecycle {
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

      children.where((c) => c is MBox && (c as MBox).inheritSpan).forEach((child) {
        (child as MBox).span(spanWidth, spanHeight, refresh: refresh);
      });

      if (refresh && initialized) {
        this.refresh();
      }
    }
  }

  init({Map<String, String> params: null}) {
    this.params = params;
    if (spanHeight == 0 || spanWidth == 0) {
      Rd.log.warning(
          "You really should set LifecycleSprite.spanWidth and LifecycleSprite.spanHeight properties before invoking LifecycleSprite.init().");
    }
  }

  void onInitComplete() {
    initialized = true;
    children
        .where((c) => c is MLifecycle && (c as MLifecycle).inheritInit && !(c as MLifecycle).initialized)
        .forEach((child) {
      if ((child as MBox).inheritSpan) {
        (child as MBox).span(spanWidth, spanHeight, refresh: false);
      }
      (child as MLifecycle).init();
    });
    refresh();
    dispatchEvent(new LifecycleEvent(LifecycleEvent.INIT_COMPLETE));
  }

  Future load({Map params: null}) async {
    if (requiresLoading) {
      throw new StateError("You cannot invoke LifecycleSprite.load() directly. Override it.");
    } else {
      onLoadComplete();
    }
  }

  void onLoadComplete([Event e = null]) {
    requiresLoading = false;
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_COMPLETE));
  }

  void onLoadError(String errorMessage) {
    requiresLoading = false;
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_ERROR, errorMessage));
  }

  @override
  void appear({double duration: MLifecycle.APPEAR_DURATION_DEFAULT}) {
    children.where((c) => c is MLifecycle && (c as MLifecycle).inheritAppear).forEach((child) {
      (child as MLifecycle).appear(duration: duration);
    });

    super.appear(duration: duration);
  }

  @override
  void disappear({double duration: MLifecycle.DISAPPEAR_DURATION_DEFAULT, bool autoDispose: false}) {
    children.where((c) => c is MLifecycle && (c as MLifecycle).inheritDisappear).forEach((child) {
      (child as MLifecycle).disappear(duration: duration, autoDispose: autoDispose);
    });
    Rd.JUGGLER.delayCall(() {
      dispatchEvent(new LifecycleEvent(LifecycleEvent.DISAPPEAR_COMPLETE));
      if (autoDispose) {
        this.dispose();
      }
    }, duration);
  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);

    child.x = padding;
    child.y = padding;

    if (child is MBox &&  (child as MBox).inheritSpan) {
      int csw = (spanWidth - 2 * padding).round();
      int csh = (spanHeight - 2 * padding).round();
      if (csw > 0 && csh > 0) {
        (child as MBox).span(csw, csh, refresh: false);
      }
    }

    if (child is MLifecycle && !(child as MLifecycle).initialized && (child as MLifecycle).inheritInit && initialized) {
        (child as MLifecycle).init();
    }
  }
}

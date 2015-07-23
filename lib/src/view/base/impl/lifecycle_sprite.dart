part of stagexl_commons;

class LifecycleSprite extends BehaveSprite with MLifecycle{

  //TODO logger
  Logger log;

  LifecycleSprite([String id]) : super(){
    if(id != null){
      this.name = id;
    }
  }

  @override
  void span(num spanWidth, num spanHeight, {bool refresh: true}){
    if (this.spanWidth != spanWidth || this.spanHeight != spanHeight) {
      if (spanWidth > 0) this.spanWidth = spanWidth;
      if (spanHeight > 0) this.spanHeight = spanHeight;

      children.where((c) => c is MBox && c.inheritSpan).forEach( (child){
        child.span(spanWidth, spanHeight, refresh: refresh);
      });

      if (refresh && initialized) {
        this.refresh();
      }
    }
  }

  void init({Map params: null}){
    this.params = params;
    if(spanHeight == 0 || spanWidth == 0){
      throw new StateError("You need to set XLSprite.spanWidth and XLSprite.spanHeight properties before invoking XLSprite.init().");
    }
  }

  void onInitComplete(){
    initialized = true;
    refresh();
    dispatchEvent(new LifecycleEvent(LifecycleEvent.INIT_COMPLETE));
  }

  void load({Map params: null}){
    if(requiresLoading){
      throw new StateError("You cannot invoke XLSprite.load() directly. Override it.");
    }
    else{
      onLoadComplete();
    }
  }

  void onLoadComplete([Event e = null]){
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_COMPLETE));
  }

  void onLoadError(String errorMessage) {
    dispatchEvent(new LifecycleEvent(LifecycleEvent.LOAD_ERROR, errorMessage));
  }

  @override
  void refresh() {
    throw new StateError("You cannot invoke XLSprite.refresh() directly. Override it.");
  }

  @override
  void appear({double duration: MLifecycle.APPEAR_DURATION_DEFAULT}){
    children.where((c) => c is MLifecycle && c.inheritAppear).forEach( (child){
      child.appear(duration: duration);
    });

    super.appear(duration: duration);

  }

  @override
  void disappear({double duration: MLifecycle.DISAPPEAR_DURATION_DEFAULT, bool autoDestroy : false}){
    children.where((c) => c is MLifecycle && c.inheritDisappear).forEach( (child){
      child.disappear(duration: duration, autoDestroy: autoDestroy);
    });
    ContextTool.JUGGLER.delayCall((){
      dispatchEvent(new LifecycleEvent(LifecycleEvent.DISAPPEAR_COMPLETE));
    }, duration);

  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    if (child is MLifecycle && (child as MLifecycle).inheritInit && initialized) {
      (child as MLifecycle).init();
    }
  }

}
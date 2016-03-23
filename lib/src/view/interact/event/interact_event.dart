part of rockdot_commons;

class InteractEvent extends Event {
  static final String DOWN_ACTION = "InteractEvent.DOWN_ACTION";
  static final String UP_ACTION = "InteractEvent.UP_ACTION";
  static final String OVER_ACTION = "InteractEvent.OVER_ACTION";
  static final String OUT_ACTION = "InteractEvent.OUT_ACTION";
  static final String SELECT_ACTION = "InteractEvent.SELECT_ACTION";
  static final String DESELECT_ACTION = "InteractEvent.DESELECT_ACTION";
  static final String DRAG_START_ACTION = "InteractEvent.DRAG_START_ACTION";
  static final String DRAG_STOP_ACTION = "InteractEvent.DRAG_STOP_ACTION";

  /// Creates an [InteractEvent] of specified [type].
  InteractEvent(String type, [bool bubbles = false]) : super(type, bubbles){

  }

  Event clone() {
    return new InteractEvent(type, bubbles);
  }

}


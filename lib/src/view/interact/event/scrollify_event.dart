part of acanvas_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class ScrollifyEvent extends Event {
  static const String CHANGE_START = "ScrollifyEvent.CHANGE_START";
  static const String CHANGE_END = "ScrollifyEvent.CHANGE_END";
  static const String INTERACTION_START = "ScrollifyEvent.INTERACTION_START";
  static const String INTERACTION_END = "ScrollifyEvent.INTERACTION_END";

  ScrollifyEvent(String type, [bool bubbles = false, bool cancelable = false]) : super(type, bubbles) {}

  Event clone() {
    return new ScrollifyEvent(type, bubbles);
  }
}

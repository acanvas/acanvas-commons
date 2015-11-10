part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

class SelectableButton extends Button with MSelectable {
  SelectableButton() : super() {
    selfSelect = true;
  }

  SelectableButton clone() => new SelectableButton();

  @override void downAction([InputEvent event = null]) {
    super.downAction(event);
  }

  @override void upAction([InputEvent event = null, bool submit = true]) {

    super.upAction(event, submit);
    if (selfSelect) {
      selected = !selected;
      //will trigger de/select()
    }
  }

  @override void select({bool submit: false}) {
    if (!selected) {
      selectAction();
      _selected = true;
      if (submit) {
        this.submit();
      }
    }
  }

  @override void deselect() {
    if (selected) {
      deselectAction();
      _selected = false;
    }
  }
}

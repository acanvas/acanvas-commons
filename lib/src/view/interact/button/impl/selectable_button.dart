part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

class SelectableButton extends Button with MSelectable {

  SelectableButton() : super() {
    toggleable = true;
    submitCallbackParams = [this];
  }

  SelectableButton clone() => new SelectableButton();

  void select() {
    if (!toggled) {
      toggled = true;
      downAction();
      submit();
    }
  }

  void deselect() {
    if (toggled) {
      toggled = false;
      upAction(null, false);
    }
  }

}

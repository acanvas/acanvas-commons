 part of dart_commons;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class RadioGroupV extends VBox {
		 String _orientation;
		 int _selectedButtonIndex = 0;
	 RadioGroupV([int padding=0]): super(padding)  {
			addEventListener(ToggleButtonEvent.TOGGLE, _onBtnToggle, useCapture: true);
		}


		  void selectButton(int index) {
			(getChildAt(_selectedButtonIndex) as RadioButton).isToggled = false;
			(getChildAt(index) as RadioButton).isToggled = true;
			_selectedButtonIndex = index;
			dispatchEvent(new RadioGroupEvent(RadioGroupEvent.BUTTON_SELECTED, index));
		}


		  void _onBtnToggle(ToggleButtonEvent event) {
			RadioButton btn = event.target as RadioButton;
			if (!btn.isToggled) selectButton(getChildIndex(btn));
		}


		  int get selectedButtonIndex {
			return _selectedButtonIndex;
		}


		@override 
		  void destroy() {
			removeEventListener(ToggleButtonEvent.TOGGLE, _onBtnToggle);
			super.destroy();
		}
	}

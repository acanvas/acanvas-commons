 part of stagexl_commons;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class RadioGroup extends Flow {
		 int _selectedButtonIndex = 0;
		 void set selectedButtonIndex (int index){ _selectedButtonIndex = index; }
		 int get selectedButtonIndex => _selectedButtonIndex;

	 	RadioGroup({FlowOrientation flowOrientation : FlowOrientation.HORIZONTAL, double spacing: 0.0}): super(){
			this.flowOrientation = flowOrientation;
		 this.spacing = spacing;
		}

		 @override
		 void addChildAt(DisplayObject child, int index){
			 if(child is SelectableButton){
				 child.submitCallback = _onBtnSubmit;
			 }
			 else{
				 throw new StateError("Only SelectableButton allowed as children");
			 }
			 super.addChildAt(child, index);
		 }


		  void _onBtnSubmit(SelectableButton button) {
			if (!button.toggled) selectButton(getChildIndex(button));
		}


		  void selectButton(int index) {
			(getChildAt(_selectedButtonIndex) as MSelectable).deselect();
			(getChildAt(index) as MSelectable).select();
			_selectedButtonIndex = index;
		}

	}

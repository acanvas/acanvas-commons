 part of dart_commons;



	
	
	
	
	/**
	 * Type that enables you to keep track of which state (creationComplete, childrenCreated, etc.) a certain component is in. Note that StateManager is a singleton class.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * 
	 * 
	 * edit 2
	 * 
	 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/StateManager/docs/
	 * 
	 */
	 class StateManager {
		
		
		/**
		 * @
		 */
		 static StateManager _instance;
		/**
		 * @
		 */
		 List _items = [];
		/**
		 * @
		 */
		 List _states = [];
		
		
		/**
		 * @
		 */
		 static final List STATES = [BABY, PREINITIALIZE, INITIALIZE, CREATION_COMPLETE, UPDATE_COMPLETE];
		
		
		/**
		 * Indicates that a component has not reached the first state yet.
		 */
		 static final int BABY = -1;
		/**
		 * State indicating that a component has begun with its initialization sequence.
		 */
		 static final int PREINITIALIZE =  0;
		/**
		 * State indicating that a component has finished its construction and has all initialization properties set.
		 */
		 static final int INITIALIZE =  1;
		/**
		 * State indicating that a component has finished its construction, property processing, measuring, layout, and drawing.
		 */
		 static final int CREATION_COMPLETE =  2;
		/**
		 * State indicating that a component has had its commitProperties(), measure(), and updateDisplayList() methods called.
		 */
		 static final int UPDATE_COMPLETE =  3;
		
		
		/**
		 * Constructor.
		 */
		 StateManager() {
			// static class
		}
		
		
		/**
		 * Singleton instance.
		 */
		 static  StateManager get instance {
			if (StateManager._instance == null){
				StateManager._instance = new StateManager();
			}
			return StateManager._instance;
		}
		
		
		/**
		 * Registers the provided UIComponent with this StateManager so that the component its state will be available through the getState method.
		 * 
		 * @param	item	Component to register.
		 * 
		 * @see	StateManager#getState()
		 */
		  void register(SpriteComponent item) {
			// don't register if UIComponent is already registered:
			if (this._items.indexOf(item) != -1){
				return;
			}
			
			// add UIComponent to Lists:
			this._items.add(item);
			this._states.add(StateManager.BABY);
			// add eventlisteners:
			item.addEventListener(ManagedSpriteComponentEvent.INIT_COMPLETE, this.updateState);
			item.addEventListener(ManagedSpriteComponentEvent.INIT_START, this.updateState);
			item.addEventListener(ManagedSpriteComponentEvent.LOAD_COMPLETE, this.updateState);
		}
		
		
		/**
		 * Event-handler for the listeners that watch the state-changes of the registered components.
		 * 
		 * @
		 */
		  void updateState([Event event=null]) {
			SpriteComponent item = this._items[this._items.indexOf(event.target)];
			// set state in List:
			switch (event.type){
				case ManagedSpriteComponentEvent.INIT_COMPLETE: 
					this.setState(item, StateManager.CREATION_COMPLETE);
					break;
//				case FlexEvent.INITIALIZE : 
//					this.setState(item, StateManager.INITIALIZE);
//					break;
				case ManagedSpriteComponentEvent.INIT_START: 
					this.setState(item, StateManager.PREINITIALIZE);
					break;
				case ManagedSpriteComponentEvent.LOAD_COMPLETE: 
					this.setState(item, StateManager.UPDATE_COMPLETE);
					break;
			}
			// remove listeners if last event was broadcasted:
			if (this.getState(item) == StateManager.LAST_STATE){
				item.removeEventListener(ManagedSpriteComponentEvent.INIT_COMPLETE, this.updateState);
				item.removeEventListener(ManagedSpriteComponentEvent.INIT_START, this.updateState);
				item.removeEventListener(ManagedSpriteComponentEvent.LOAD_COMPLETE, this.updateState);
			}
		}
		
		
		/**
		 * Returns a numeric value corresponding to one of the the constants in the StateManager class.
		 * 
		 * @param	item	Component of which to return the current state.
		 * 
		 * @return	Value indicating the current state of the provided UIComponent.
		 */
		  int getState(SpriteComponent item) {
			return this._states[ this._items.indexOf(item)];
		}
		/**
		 * Sets the state of the provided UIComponent.
		 * 
		 * @param	item	Component of which to set the state.
		 * @param	state	Value indicating which state the provided UIComponent is in.
		 * 
		 * @
		 */
		  void setState(SpriteComponent item,int state) {
			this._states[this._items.indexOf(item)] = state;
		}
		
		
		/**
		 * List with all items registered with this class.
		 */
		  List get items {
			return this._items;
		}
		
		
		/**
		 * A reference to the last state (known to the StateManager class) a registered component can be in.
		 */
		 static  int get LAST_STATE {
			return StateManager.STATES[StateManager.STATES.length-1];
		}
		
		
	}
	
	

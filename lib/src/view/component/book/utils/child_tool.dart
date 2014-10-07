 part of stagexl_commons;
	
	
	
	
	/**
	 * All-static class that provides additional functionality for adding and removing children to and from Containers.
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
	 */
	 class ChildTool {
		
		
		/**
		 * Constructor.
		 * @
		 */
		  ChildTool() {}
		
		
		/**
		 * Moves child1 to child2 its place and the other way around.
		 * 
		 * @param	child1	DisplayObject to move to child2's place.
		 * @param	child2	DisplayObject to move to child1's place.
		 * 
		 */
		 static  void swapChildren(DisplayObject child1,DisplayObject child2) {
			DisplayObjectContainer parent1 = child1.parent;
			DisplayObjectContainer parent2 = child2.parent;
			
			int index1 = parent1.getChildIndex(child1);
			int index2 = parent2.getChildIndex(child2);
			
			ChildTool.moveChild(child1, parent2, index2);
			ChildTool.moveChild(child2, parent1, index1);
		}
		
		
		/**
		 * Removes a DisplayObject from its parent and adds it to a new parent at a certain index (if provided).
		 * 
		 * @param	child		DisplayObject to move.
		 * @param	container	New parent for child.
		 * @param	index		Index at which to add child to container.
		 * 
		 */
		 static  void moveChild(DisplayObject child,DisplayObjectContainer container,[int index=-1]) {
			// remove child from old parent:
			child.parent.removeChild(child);
			// add child to new parent:
			if (index == -1){
				container.addChild(child);
			}else{
				container.addChildAt(child, index);
			}
		}
		
		
	}
	
	

part of rockdot_commons;

/**
 * Provides additional functionality for Lists.
 *
 * @author		Ruben Swieringa
 * 				ruben.swieringa@gmail.com
 * 				www.rubenswieringa.com
 * 				www.rubenswieringa.com/blog
 * @version		1.0.0
 * @see			MathTool
 *
 *
 * edit 2
 *
 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
 *
 *
 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/ListTool/docs/
 *
 */
class ListTool {
  /**
   * Constructor.
   * @
   */
  ListTool() {}

  /**
   * Adjusts all values in an List.
   *
   * @param	array		List whose values to adjust
   * @param	value		Value with which to increase, decrease, multiply, or divide a value from array with
   * @param	operator	Indicates how to adjust a value from array (addition, minus, multiplication, or division)
   *
   * @see		MathTool#PLUS
   * @see		MathTool#MINUS
   * @see		MathTool#MULTIPLICATION
   * @see		MathTool#DIVISION
   *
   * @return	List with adjusted values
   */
  static List adjustValues(List array, dynamic value, [String operator = "*"]) {
    List newList = [];

    for (int i = 0; i < array.length; i++) {
      switch (operator) {
        case MathTool.PLUS:
          newList.add(array[i] + value);
          break;
        case MathTool.MINUS:
          newList.add(array[i] - value);
          break;
        case MathTool.MULTIPLICATION:
          newList.add(array[i] * value);
          break;
        case MathTool.DIVISION:
          newList.add(array[i] / value);
          break;
      }
    }

    return newList;
  }

  /**
   * Similar to ListUtil.getItemIndex(), this method searches an List for an Map with a given property that has a certain value. Can also search for nested Maps.<br /><br />
   *
   * @example	The following code returns 2:<br /><br />
   * <code>List array = [ {foo: {bar: 'value1'}}, {foo: {bar: 'value2'}}, {foo: {bar: 'value3'}} ];<br />
   * List propChain = ['foo', 'bar'];<br />
   * String value = 'value3';<br />
   * ListTool.getValueMatchIndex (array, propChain, value); // outputs 2</code>
   *
   * @param	array		List to search.
   * @param	property	Property or property-chain to try every item in the List for. This parameter can either be a String (normal property), List (property-chain), or numeric value (array index).
   * @param	value		Value to be found.
   *
   * @return	Index of the item where the value was found on the end of the property chain.
   */
  static int getValueMatchIndex(List array, dynamic property, dynamic value) {
    // if property param is neither an List nor a String nor a numeric value, try to cast it to a String:
    if (!(property is List) && !(property is String) && !(property is int || property is int || property is num)) {
      property = (property).toString();
    }
    // now make sure that we have a chain of properties (in the form of an List) to loop through:
    List propertyChain;
    if (property is List) {
      propertyChain = property;
    } else {
      propertyChain = [property];
    }

    // loop through source List:
    dynamic path;
    for (int i = 0; i < array.length; i++) {
      path = array[i];
      // loop through property-chain:
      for (int j = 0; j < propertyChain.length; j++) {
        if (path.hasOwnProperty(propertyChain[j])) {
          path = path[propertyChain[j]];
          if (j == propertyChain.length - 1 && path == value) {
            return i;
          }
        } else {
          break;
        }
      }
    }

    // if value was not found:
    return -1;
  }

  /**
   * Returns a shallow copy of an List.
   *
   * @param	source	List to be copied.
   *
   * @param	Copied List.
   *
   * @see	http://livedocs.adobe.com/flex/201/html/10_Lists_of_data_166_5.html
   *
   */
  static List copy(List source) {
    List array = [];
    for (int i = 0; i < source.length; i++) {
      array[i] = source[i];
    }
    return array;
  }
}

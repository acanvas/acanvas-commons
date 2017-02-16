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
  static List<num> adjustValues(List<num> array, num value, [String operator = "*"]) {
    List<num> newList = [];

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
    return source.toList();
  }
}

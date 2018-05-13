/*
 * Copyright 2007-2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of rockdot_commons;

/**
 * Static helper methods for working with the <code>IOrdered</code> abstract class.
 * @author Roland Zwaga
 * @see org.as3commons.lang.IOrdered IOrdered
 */
class OrderedUtils {
  /**
   * The property name that is used to sort objects that implement the <code>IOrdered</code> abstract class.
   */
  static const String ORDERED_PROPERTYNAME = "order";

  /**
   * Helper method to sort an <code>List</code> of object instances, some of which
   * may implement the <code>IOrdered</code> abstract class. All objects that implement
   * <code>IOrdered</code> will be sorted and put at the start a new <code>List</code>, the
   * remaining objects will be concatenated to this and the resulting <code>List</code>
   * is returned.
   * @param source The specified <code>List</code> of object instances.
   * @return The sorted <code>List</code> of object instances.
   * @see org.as3commons.lang.IOrdered IOrdered
  static List sortOrderedList(List source) {
    List<dynamic> ordered = new List<dynamic>();
    List<dynamic> unordered = new List<dynamic>();
    for (Object obj in source) {
      if (obj is IOrdered) {
        ordered[ordered.length] = obj;
      } else {
        unordered[unordered.length] = obj;
      }
    }
    //ordered.sortOn(ORDERED_PROPERTYNAME, List.NUMERIC);
    ordered.sort((dynamic a, dynamic b) {
      if (a > b) return 1;
      if (a < b)
        return -1;
      else
        return 0;
    });
    return ordered..addAll(unordered);
  }
   */

  /**
   *
   * @param itemA
   * @param itemB
   * @return
   */
  static int orderedCompareFunction(dynamic itemA, dynamic itemB) {
    if ((itemA is IOrdered) && (itemB is IOrdered)) {
      int vA = itemA.order;
      int vB = itemB.order;
      if (vA < vB) {
        return -1;
      } else if (vA == vB) {
        return 0;
      } else {
        return 1;
      }
    } else if (itemA is IOrdered) {
      return -1;
    } else if (itemB is IOrdered) {
      return 1;
    } else {
      return 0;
    }
  }
}

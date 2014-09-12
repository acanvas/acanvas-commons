/*
 * Copyright 2009-2010 the original author or authors.
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
part of dart_commons;


/**
	 * Assertion utility Type that assists in validating arguments.
	 * Useful for identifying programmer errors early and clearly at runtime.
	 *
	 * @author Christophe Herreman
	 */
class Assert {

  /**
		 * Asserts a boolean expression to be <code>true</code>.
		 * <pre class="code">Assert.isTrue(value, "The expression must be true");</pre>
		 * @param expression a boolean expression
		 * @param message the error message to use if the assertion fails
		 * @throws org.as3commons.lang.IllegalArgumentError if the expression is not <code>true</code>
		 */
  static void isTrue(bool expression, [String message = ""]) {
    if (!expression) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this expression must be true";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Compares an instance of a Type with an abstract Type definition, if
		 * they are of the exact type, the assertion fails.
		 *
		 * @param instance an instance of a class
		 * @param abstractType an abstract Type definition
		 * @param message the error message to use if the assertion fails
		 * @throws org.as3commons.lang.IllegalArgumentError if the assertion fails
		 */
  static void notAbstract(Object instance, Type abstractClass, [String message = ""]) {
    Type instanceName = reflect(instance).runtimeType;
    //String abstractName = getQualifiedClassName(abstractClass);

    if (instanceName == abstractClass) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - instance is an instance of an abstract class";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Assert that an object is <code>null</code>.
		 * <pre class="code">Assert.isNull(value, "The value must be null");</pre>
		 * @param object the object to check
		 * @param message the error message to use if the assertion fails
		 * @throws org.as3commons.lang.IllegalArgumentError if the object is not <code>null</code>
		 */
  static void notNull(Object object, [String message = ""]) {
    if (object == null) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this argument is required; it must not null";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Assert that an object is an instance of a certain type..
		 * <pre class="code">Assert.instanceOf(value, type, "The value must be an instance of 'type'");</pre>
		 * @param object the object to check
		 * @param message the error message to use if the assertion fails
		 * @throws org.as3commons.lang.IllegalArgumentError if the object is not an instance of the given type
		 */
  static void instanceOf(dynamic object, Type type, [String message = ""]) {
    if(reflect(object).runtimeType == type) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this argument is not of type '" + type.toString() + "'";
      }
      throw new IllegalArgumentError(message);
    }
  }


  /**
		 * Asserts that a Type is a subType of another class.
		 */
  static void subclassOf(Type clazz, Type parentClass, [String message = ""]) {

    if(ClassUtils.isSubclassOf(clazz, parentClass)) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this argument is not a subType of '" + parentClass.toString() + "'";
      }
      throw new IllegalArgumentError(message);
    }

  }

  /**
		 * Assert that an object implements a certain abstract class.
		 */
  static void implementationOf(dynamic object, Type interfaze, [String message = ""]) {
    if(ClassUtils.isImplementationOf(reflect(object).runtimeType, interfaze)) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this argument does not implement the abstract Type '" + interfaze.toString() + "'";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Assert a boolean expression to be true. If false, an IllegalStateError is thrown.
		 * @param expression a boolean expression
		 * @param the error message if the assertion fails
		 */
  static void state(bool expression, [String message = ""]) {
    if (!expression) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this state invariant must be true";
      }
      throw new StateError(message);
    }
  }

  /**
		 * Assert that the given String has valid text content; that is, it must not
		 * be <code>null</code> and must contain at least one non-whitespace character.
		 *
		 * @param text the String to check
		 * @param message the exception message to use if the assertion fails
		 * @see StringUtils#hasText
		 */
  static void hasText(String string, [String message = ""]) {
    if (StringUtils.isBlank(string)) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this String argument must have text; it must not be <code>null</code>, empty, or blank";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Assert that the given Map contains only keys of the given type.
		 */
  static void dictionaryKeysOfType(Map dictionary, Type type, [String message = ""]) {
    for (Object key in dictionary) {
      if (reflect(key).runtimeType != type) {
        if (message == null || message.length == 0) {
          message = "[Assertion failed] - this Map argument must have keys of type '" + type.toString() + "'";
        }
        throw new IllegalArgumentError(message);
      }
    }
  }

  /**
		 * Assert that the array contains the passed in item.
		 */
  static void arrayContains(List array, dynamic item, [String message = ""]) {
    if (array.indexOf(item) == -1) {
      if (message == null || message.length == 0) {
        message = "[Assertion failed] - this List argument does not contain the item '" + item + "'";
      }
      throw new IllegalArgumentError(message);
    }
  }

  /**
		 * Assert that all items in the array are of the given type.
		 *
		 * @param array the array to check
		 * @param type the type of the array items
		 * @param message the error message to use if the assertion fails
		 */
  static void arrayItemsOfType(List array, Type type, [String message = ""]) {
    for (dynamic item in array) {
      if (reflect(item).runtimeType != type) {
        if (message == null || message.length == 0) {
          message = "[Assertion failed] - this List must have items of type '" + type.toString() + "'";
        }
        throw new IllegalArgumentError(message);
      }
    }
  }
}

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
 * Provides utilities for working with <code>Class</code> objects.
 *
 * @author Christophe Herreman
 * @author Erik Westra
 */
class ClassUtils {

  // --------------------------------------------------------------------
  //
  // describeType cache implementation
  //
  // --------------------------------------------------------------------

  /**
	 * The default value for the interval to clear the describe type cache.
	 */
  static const int CLEAR_CACHE_INTERVAL = 60000;

  /**
	 * The interval (in miliseconds) at which the cache will be cleared. Note that this value is only used
	 * on the first call to getFromObject.
	 *
	 * @default 60000 (one minute)
	 */
  static int clearCacheInterval = CLEAR_CACHE_INTERVAL;

  static bool _clearCacheIntervalEnabled = true;

  static bool get clearCacheIntervalEnabled {
    return _clearCacheIntervalEnabled;
  }

  static void set clearCacheIntervalEnabled(bool value) {
    _clearCacheIntervalEnabled = value;

    if (!_clearCacheIntervalEnabled) {
    }
  }


  static const String AS3VEC_SUFFIX = '__AS3__.vec';
  static const String CONSTRUCTOR_FIELD_NAME = "constructor";
  static const String LESS_THAN = '<';
  static const String PACKAGE_CLASS_SEPARATOR = "::";


  static Object _typeDescriptionCache = {};

  static Timer _timer;

  /**
	 * Clears the describe type cache. This method is called automatically at regular intervals
	 * defined by the clearCacheInterval property.
	 */
  static void clearDescribeTypeCache() {
    _typeDescriptionCache = {};

  }


  /**
	 * Returns a <code>Class</code> object that corresponds with the given
	 * instance. If no correspoding class was found, a
	 * <code>ClassNotFoundError</code> will be thrown.
	 *
	 * @param instance the instance from which to return the class
	 * @param applicationDomain the optional applicationdomain where the instance's class resides
	 *
	 * @return the <code>Class</code> that corresponds with the given instance
	 *
	 * @see org.as3commons.lang.ClassNotFoundError
	 */
  static Type forInstance(dynamic instance) {
    return reflect(instance).runtimeType;
  }


  /**
	 * Returns the fully qualified name of the given class.
	 *
	 * @param clazz the class to get the name from
	 * @param replaceColons whether the double colons "::" should be replaced by a dot "."
	 *             the default is false
	 *
	 * @return the fully qualified name of the class
	 */
  static String getFullyQualifiedName(Type clazz, [bool replaceColons = false]) {
    String result = reflectClass(clazz).qualifiedName.toString();
    return result;
  }


  /**
	 * Returns the name of the given class.
	 *
	 * @param clazz the class to get the name from
	 *
	 * @return the name of the class
	 */
  static String getName(Type clazz) {
    return getNameFromFullyQualifiedName(getFullyQualifiedName(clazz));
  }

  /**
	 * Returns the name of the class or abstract class, based on the given fully
	 * qualified class or abstract class name.
	 *
	 * @param fullyQualifiedName the fully qualified name of the class or abstract class
	 *
	 * @return the name of the class or abstract class
	 */
  static String getNameFromFullyQualifiedName(String fullyQualifiedName) {
    int startIndex = fullyQualifiedName.indexOf(PACKAGE_CLASS_SEPARATOR);

    if (startIndex == -1) {
      return fullyQualifiedName;
    } else {
      return fullyQualifiedName.substring(startIndex + PACKAGE_CLASS_SEPARATOR.length, fullyQualifiedName.length);
    }
  }


  /**
	 * Determines if the class or abstract class represented by the clazz1 parameter is either the same as, or is
	 * a superclass or superabstract class of the clazz2 parameter. It returns true if so; otherwise it returns false.
	 *
	 * @return the boolean value indicating whether objects of the type clazz2 can be assigned to objects of clazz1
	 */
  static bool isAssignableFrom(Type clazz1, Type clazz2) {
    return reflectClass(clazz2).isAssignableTo(reflectClass(clazz1));// || clazz2 is clazz1;
  }


  /**
	 * Creates an instance of the given class and passes the arguments to
	 * the constructor.
	 *
	 * TODO find a generic solution for this. Currently we support constructors
	 * with a maximum of 10 arguments.
	 *
	 * @param clazz the class from which an instance will be created
	 * @param args the arguments that need to be passed to the constructor
	 */
  static dynamic newInstance(Type clazz, [List args = null]) {
    dynamic result;
    List a = (args == null) ? [] : args;

    ClassMirror c = reflectClass(clazz);
    print(c.simpleName);
    print(clazz);
    print(clazz.toString());
    InstanceMirror im = c.newInstance(new Symbol(''), a);
    result = im.reflectee;

    return result;
  }

  static bool isImplementationOf(Type clazz, Type interfaze) {

    return reflectClass(clazz).isSubtypeOf(reflectClass(interfaze));

  }

  /**
      * Returns whether the passed in Class object is a subclass of the
      * passed in parent Class. To check if an abstract class extends another abstract class, use the isImplementationOf()
      * method instead.
      */
  static bool isSubclassOf(Type clazz, Type parentClass) {
     return reflectClass(clazz).isSubtypeOf(reflectClass(parentClass));
  }

}

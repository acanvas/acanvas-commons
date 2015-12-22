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
 * This describes an object that is able to release any resources it might hold a reference to.
 * @author Roland Zwaga
 */
abstract class IDisposable {
  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  /**
   * Returns <code>true</code> if the <code>dispose()</code> has already been invoked before.
   */
  bool get isDisposed;

  // --------------------------------------------------------------------
  //
  // Methods
  //
  // --------------------------------------------------------------------

  /**
   * Release any resources that the current object might hold a reference to.
   */
  void dispose();
}

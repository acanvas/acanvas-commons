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
 * Subinterface of <code>IOperation</code> that contains information about the progress of an operation.
 *
 * @author Christophe Herreman
 */
abstract class IProgressOperation extends IOperation {
  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  /**
   * The progress of this operation.
   *
   * @return the progress of this operation
   */
  int get progress;

  /**
   * The total amount of progress this operation should make before being done.
   *
   * @return the total amount of progress this operation should make before being done
   */
  int get total;

  // --------------------------------------------------------------------
  //
  // Methods
  //
  // --------------------------------------------------------------------

  /**
   * Convenience method for adding a listener to the OperationEvent.PROGRESS event.
   *
   * @param listener the event handler function
   */
  void addProgressListener(Function listener,
      [bool useCapture = false, int priority = 0, bool useWeakReference = false]);

  /**
   * Convenience method for removing a listener from the OperationEvent.PROGRESS event.
   *
   * @param listener the event handler function
   */
  void removeProgressListener(Function listener, [bool useCapture = false]);
}

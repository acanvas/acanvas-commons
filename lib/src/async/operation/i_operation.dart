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
part of acanvas_commons;

/**
 * Dispatched when the current <code>IOperation</code> completed successfully.
 * @eventType org.as3commons.async.operation.OperationEvent.COMPLETE OperationEvent.COMPLETE
 */
// [Event(name="operationComplete", type="org.as3commons.async.operation.event.OperationEvent")]

/**
 * Dispatched when the current <code>IOperation</code> encountered an error.
 * @eventType org.as3commons.async.operation.OperationEvent.ERROR OperationEvent.ERROR
 */
// [Event(name="operationError", type="org.as3commons.async.operation.event.OperationEvent")]

/**
 * Dispatched when the current <code>IOperation</code> timed out.
 * @eventType org.as3commons.async.operation.OperationEvent.TIMEOUT OperationEvent.TIMEOUT
 */
// [Event(name="operationTimeout", type="org.as3commons.async.operation.event.OperationEvent")]

/**
 * The IOperation abstract class describes an asynchronous operation. It serves as handle for asynchronous executions
 * to which you can attach listeners in order to know when the operation is done executing or when an error
 * occurred during the execution of the operation.
 *
 * <p>An operation has a <code>result</code> property in case the operation needs to return a result and
 * an <code>error</code> in case an error occurred during the execution of the operation.</p>
 *
 * <p>Convenience methods are provided to add and remove listeners to the events dispatched by an operation.</p>
 *
 * @author Christophe Herreman
 */
abstract class IOperation extends EventDispatcher {
  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  // ----------------------------
  // result
  // ----------------------------

  /**
   * The result of this operation or <code>null</code> if the operation does not have a result.
   *
   * @return the result of the operation or <code>null</code>
   */
  dynamic get result;

  // ----------------------------
  // error
  // ----------------------------

  /**
   * The error of this operation or <code>null</code> if no error occurred during this operation.
   *
   * @return the error of the operation or <code>null</code>
   */
  dynamic get error;

  // --------------------------------------------------------------------
  //
  // Methods
  //
  // --------------------------------------------------------------------

  /**
   * Convenience method for adding a listener to the OperationEvent.COMPLETE event.
   *
   * @param listener the event handler function
   */
  void addCompleteListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false,
      int priority = 0,
      bool useWeakReference = false]);

  /**
   * Convenience method for adding a listener to the OperationEvent.ERROR event.
   *
   * @param listener the event handler function
   */
  void addErrorListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false,
      int priority = 0,
      bool useWeakReference = false]);

  /**
   * Convenience method for adding a listener to the OperationEvent.TIMEOUT event.
   *
   * @param listener the event handler function
   */
  void addTimeoutListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false,
      int priority = 0,
      bool useWeakReference = false]);

  /**
   * Convenience method for removing a listener from the OperationEvent.COMPLETE event.
   *
   * @param listener the event handler function
   */
  void removeCompleteListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false]);

  /**
   * Convenience method for removing a listener from the OperationEvent.ERROR event.
   *
   * @param listener the event handler function
   */
  void removeErrorListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false]);

  /**
   * Convenience method for removing a listener from the OperationEvent.TIMEOUT event.
   *
   * @param listener the event handler function
   */
  void removeTimeoutListener<T extends Event>(EventListener<T> listener,
      [bool useCapture = false]);
}

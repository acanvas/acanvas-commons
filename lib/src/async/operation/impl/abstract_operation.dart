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
part of stagexl_commons;

/**
 * Dispatched when the current <code>AbstractOperation</code> has completed its functionality successfully.
 * @eventType org.as3commons.async.operation.OperationEvent#COMPLETE OperationEvent.COMPLETE
 */
// [Event(name="operationComplete", type="org.as3commons.async.operation.event.OperationEvent")]
/**
 * Dispatched when the current <code>AbstractOperation</code> encountered an error.
 * @eventType org.as3commons.async.operation.OperationEvent#ERROR OperationEvent.ERROR
 */
// [Event(name="operationError", type="org.as3commons.async.operation.event.OperationEvent")]
/**
 * Dispatched when the current <code>AbstractOperation</code> timed out.
 * @eventType org.as3commons.async.operation.OperationEvent#TIMEOUT OperationEvent.TIMEOUT
 */
// [Event(name="operationTimeout", type="org.as3commons.async.operation.event.OperationEvent")]
/**
 * Abstract base class for <code>IOperation</code> implementations.
 * @author Christophe Herreman
 */
class AbstractOperation extends EventDispatcher implements IOperation {
  // --------------------------------------------------------------------
  //
  // Constructor
  //
  // --------------------------------------------------------------------

  /**
   * Creates a new <code>AbstractOperation</code>.
   *
   * @param timeoutInMilliseconds
   * @param autoStartTimeout
   */
  AbstractOperation([int timeoutInMilliseconds = 0, bool autoStartTimeout = true]) {
    m_timeout = timeoutInMilliseconds;
    m_autoStartTimeout = autoStartTimeout;
  }

  // ----------------------------
  // error
  // ----------------------------

  dynamic _error;

  // --------------------------------------------------------------------
  //
  // Public Properties
  //
  // --------------------------------------------------------------------

  // ----------------------------
  // result
  // ----------------------------

  dynamic _result;

  // --------------------------------------------------------------------
  //
  // Private Variables
  //
  // --------------------------------------------------------------------

  bool m_autoStartTimeout = true;

  /** Whether or not this operation timed out. */
  bool m_timedOut = false;

  // ----------------------------
  // timeout
  // ----------------------------

  int m_timeout = 0;

  /** Identifier for the timeout so we can cancel it. */
  int m_timeoutId;

  // --------------------------------------------------------------------
  //
  // Implementation: IOperation: Methods
  //
  // --------------------------------------------------------------------

  /**
   * @inheritDoc
   */
  void addCompleteListener(Function listener,
      [bool useCapture = false, int priority = 0, bool useWeakReference = false]) {
    addEventListener(OperationEvent.COMPLETE, listener /*, useCapture, priority, useWeakReference*/);
  }

  /**
   * @inheritDoc
   */
  void addErrorListener(Function listener, [bool useCapture = false, int priority = 0, bool useWeakReference = false]) {
    addEventListener(OperationEvent.ERROR, listener /*, useCapture, priority, useWeakReference*/);
  }

  /**
   * @inheritDoc
   */
  void addTimeoutListener(Function listener,
      [bool useCapture = false, int priority = 0, bool useWeakReference = false]) {
    addEventListener(OperationEvent.TIMEOUT, listener /*, useCapture, priority, useWeakReference*/);
  }

  // --------------------------------------------------------------------
  //
  // Public Methods
  //
  // --------------------------------------------------------------------

  /**
   * Convenience method for dispatching a <code>OperationEvent.COMPLETE</code> event.
   *
   * @return true if the event was dispatched; false if not
   */
  bool dispatchCompleteEvent([dynamic result = null]) {
    if (m_timedOut) {
      return false;
    }

    if (result != null) {
      this.result = result;
    }
    dispatchEvent(OperationEvent.createCompleteEvent(this));
    return true;
  }

  /**
   * Convenience method for dispatching a <code>OperationEvent.ERROR</code> event.
   *
   * @return true if the event was dispatched; false if not
   */
  bool dispatchErrorEvent([dynamic error = null]) {
    if (m_timedOut) {
      return false;
    }

    if (error != null) {
      this.error = error;
    }
    dispatchEvent(OperationEvent.createErrorEvent(this));
    return true;
  }

  /**
   * Convenience method for dispatching a <code>OperationEvent.TIMEOUT</code> event.
   *
   * @return true if the event was dispatched; false if not
   */
  bool dispatchTimeoutEvent() {
    dispatchEvent(OperationEvent.createTimeoutEvent(this));
    return true;
  }

  // ----------------------------
  // error
  // ----------------------------

  /**
   * @inheritDoc
   */
  dynamic get error {
    return _error;
  }

  /**
   * Sets the error of this operation
   *
   * @param value the error of this operation
   */
  void set error(dynamic value) {
    if (value != error) {
      _error = value;
    }
  }

  /**
   * @inheritDoc
   */
  void removeCompleteListener(Function listener, [bool useCapture = false]) {
    removeEventListener(OperationEvent.COMPLETE, listener);
  }

  /**
   * @inheritDoc
   */
  void removeErrorListener(Function listener, [bool useCapture = false]) {
    removeEventListener(OperationEvent.ERROR, listener);
  }

  /**
   * @inheritDoc
   */
  void removeTimeoutListener(Function listener, [bool useCapture = false]) {
    removeEventListener(OperationEvent.TIMEOUT, listener);
  }

  // --------------------------------------------------------------------
  //
  // Implementation: IOperation: Properties
  //
  // --------------------------------------------------------------------

  // ----------------------------
  // result
  // ----------------------------

  /**
   * @inheritDoc
   */
  dynamic get result {
    return _result;
  }

  /**
   * Sets the result of this operation.
   *
   * @param value the result of this operation
   */
  void set result(dynamic value) {
    if (value != result) {
      _result = value;
    }
  }

  // --------------------------------------------------------------------
  //
  // Protected Methods
  //
  // --------------------------------------------------------------------
  void completeHandler(OperationEvent event) {}

  void errorHandler(OperationEvent event) {}
}

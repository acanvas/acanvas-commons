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
 * An <code>OperationEvent</code> is an <code>Event</code> generated by an <code>IOperation</code> instance.
 * @author Christophe Herreman
 */
class OperationEvent extends Event {
  // --------------------------------------------------------------------
  //
  // Public Static Constants
  //
  // --------------------------------------------------------------------

  /** The type of the <code>OperationEvent</code> dispatched when an <code>IOperation</code> is done/complete. */
  static const String COMPLETE = "operationComplete";

  /** The type of the <code>OperationEvent</code> dispatched when an error occurs during the execution of an <code>IOperation</code> */
  static const String ERROR = "operationError";

  /** The type of the <code>OperationEvent</code> dispatched upon progress of the <code>IProgressOperation</code> */
  static const String PROGRESS = "operationProgress";

  /** The type of the <code>OperationEvent</code> dispatched when an <code>IOperation</code> times out. */
  static const String TIMEOUT = "operationTimeout";

  // --------------------------------------------------------------------
  //
  // Public Static Methods
  //
  // --------------------------------------------------------------------

  static OperationEvent createCompleteEvent(IOperation operation, [bool bubbles = false, bool cancelable = false]) {
    return new OperationEvent(OperationEvent.COMPLETE, operation, bubbles, cancelable);
  }

  static OperationEvent createErrorEvent(IOperation operation, [bool bubbles = false, bool cancelable = false]) {
    return new OperationEvent(OperationEvent.ERROR, operation, bubbles, cancelable);
  }

  static OperationEvent createProgressEvent(IOperation operation, [bool bubbles = false, bool cancelable = false]) {
    return new OperationEvent(OperationEvent.PROGRESS, operation, bubbles, cancelable);
  }

  static OperationEvent createTimeoutEvent(IOperation operation, [bool bubbles = false, bool cancelable = false]) {
    return new OperationEvent(OperationEvent.TIMEOUT, operation, bubbles, cancelable);
  }

  // --------------------------------------------------------------------
  //
  // Constructor
  //
  // --------------------------------------------------------------------

  /**
   * Creates a new <code>OperationEvent</code> instance.
   * @param type The type of the current <code>OperationEvent</code>, can be either <code>OperationEvent.COMPLETE</code>, <code>OperationEvent.ERROR</code> or <code>OperationEvent.PROGRESS</code>.
   * @param operation The <code>IOperation</code> that generated the current <code>OperationEvent</code>.
   */
  OperationEvent(String type, [IOperation operation, bool bubbles = false, bool cancelable = false])
      : super(type, bubbles) {
    this.operation = operation;
  }

  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  // ----------------------------
  // operation
  // ----------------------------

  IOperation _operation;

  /**
   * @return The <code>IOperation</code> that generated the current <code>OperationEvent</code>.
   */
  IOperation get operation {
    return _operation;
  }

  /**
   * @
   */
  void set operation(IOperation value) {
    if (value != _operation) {
      _operation = value;
    }
  }

  // ----------------------------
  // result
  // ----------------------------

  /**
   * @return The result of the <code>IOperation</code> that generated the current <code>OperationEvent</code>.
   */
  dynamic get result {
    return (operation != null ? operation.result : null);
  }

  // ----------------------------
  // error
  // ----------------------------

  /**
   * @return The error of the <code>IOperation</code> that generated the current <code>OperationEvent</code>.
   */
  dynamic get error {
    return (operation != null ? operation.error : null);
  }

  // --------------------------------------------------------------------
  //
  // Overridden Methods
  //
  // --------------------------------------------------------------------

  /**
   * @return An exact copy of the current <code>OperationEvent</code>
   */
  //@override
  Event clone() {
    return new OperationEvent(type, operation, bubbles);
  }
}

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
 * Dispatched when the current <code>AbstractOperation</code> has new progress information to report.
 * @eventType org.as3commons.async.operation.OperationEvent#PROGRESS OperationEvent.PROGRESS
 */
// [Event(name="operationProgress", type="org.as3commons.async.operation.event.OperationEvent")]
/**
 * Abstract base class for <code>IProgressOperation</code> implementations.
 * @author Roland Zwaga
 */
class AbstractProgressOperation extends AbstractOperation implements IProgressOperation {
  // --------------------------------------------------------------------
  //
  // Constructor
  //
  // --------------------------------------------------------------------

  /**
   * Creates a new <code>AbstractProgressOperation</code> instance.
   */
  AbstractProgressOperation([int timeoutInMilliseconds = 0, bool autoStartTimeout = true])
      : super(timeoutInMilliseconds, autoStartTimeout) {
    progress = 0;
  }

  // --------------------------------------------------------------------
  //
  // Implementation: IProgressOperation: Properties
  //
  // --------------------------------------------------------------------

  /**
   * @inheritDoc
   */
  int get progress {
    return _progress;
  }

  /**
   * @inheritDoc
   */
  int get total {
    return _total;
  }

  // --------------------------------------------------------------------
  //
  // Implementation: IProgressOperation: Methods
  //
  // --------------------------------------------------------------------

  /**
   * @inheritDoc
   */
  void addProgressListener(Function listener,
      [bool useCapture = false, int priority = 0, bool useWeakReference = false]) {
    addEventListener(OperationEvent.PROGRESS, listener, useCapture: useCapture, priority: priority);
  }

  /**
   * @inheritDoc
   */
  void removeProgressListener(Function listener, [bool useCapture = false]) {
    removeEventListener(OperationEvent.PROGRESS, listener, useCapture: useCapture);
  }

  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  // ----------------------------
  // progress
  // ----------------------------

  int _progress;

  /**
   * Sets the progress of this operation.
   *
   * @param value the progress of this operation
   */
  void set progress(dynamic value) {
    if (value != progress) {
      _progress = value;
    }
  }

  // ----------------------------
  // total
  // ----------------------------

  int _total = 0;

  /**
   * Sets the total amount of progress this operation should make before being done.
   *
   * @param value the total amount of progress this operation should make before being done
   */
  void set total(dynamic value) {
    if (value != total) {
      _total = value;
    }
  }

  // --------------------------------------------------------------------
  //
  // Protected Methods
  //
  // --------------------------------------------------------------------

  /**
   * Convenience method for dispatching a <code>OperationEvent.PROGRESS</code> event.
   * @return true if the event was dispatched; false if not
   */
  void dispatchProgressEvent() {
    dispatchEvent(OperationEvent.createProgressEvent(this));
  }
}

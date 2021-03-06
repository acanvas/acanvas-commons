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
 *
 * @author Christophe Herreman
 */
class CommandEvent extends Event {
  /**
   * Defines the value of the type property of a <code>CommandEvent.EXECUTE</code> event object.
   * @eventType String
   */
  static const String EXECUTE = "executeCommand";

  ICommand _command;

  /**
   * Creates a new <code>CompositeCommandEvent</code> instance.
   */
  CommandEvent(String type, ICommand command,
      [bool bubbles = false, bool cancelable = false])
      : super(type, bubbles) {
    _command = command;
  }

  ICommand get command {
    return _command;
  }

  /**
   * Returns an exact copy of the current <code>CommandEvent</code> instance.
   */
  Event clone() {
    return new CommandEvent(type, command, bubbles);
  }
}

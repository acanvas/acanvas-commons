/*
* Copyright 2007-2012 the original author or authors.
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
 * Simplified EventBus for Dart
 */
class RdEventBus extends EventDispatcher implements IEventBus {
  static final RdEventBus _singleton = new RdEventBus._internal();
  Logger LOGGER;

  factory RdEventBus() {
    return _singleton;
  }

  RdEventBus._internal() {
    // initialization logic here
    LOGGER = new Logger("DartEventBus");
  }
}

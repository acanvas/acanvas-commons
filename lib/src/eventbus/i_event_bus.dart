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

abstract class IEventBus implements EventDispatcher {
  @override
  StreamSubscription<Event> addEventListener(String eventType, void eventListener(event),
      {bool useCapture: false, int priority: 0});

  @override
  void dispatchEvent(Event event);

  @override
  bool hasEventListener(String eventType, {bool useCapture: false});

  @override
  EventStream<Event> on(String eventType);

  @override
  void removeEventListener(String eventType, void eventListener(event), {bool useCapture: false});

  @override
  void removeEventListeners(String eventType);
}

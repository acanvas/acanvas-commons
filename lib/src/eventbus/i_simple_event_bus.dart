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
 * Describes an object that is used as a publish/subscribe event mechanism that lets objects communicate
 * with eachother in a loosely coupled manner.
 * <p>There are three ways to add listeners to an <code>IEventBus</code>:<br/>
 * <ol>
 * <li>Add a listener for all events that are dispatched by an <code>IEventBus</code>.</li>
 * <li>Add a listener for all events of a certain type that are dispatched by an <code>IEventBus</code>.</li>
 * <li>Add a listener for all events of a <code>Class</code> that are dispatched by an <code>IEventBus</code>.</li>
 * </ol>
 * </p>
 * <p>Further event filtering can be achieved by using topics, which can be registered through all the different event dispatching
 * and listeners registration methods as an optional argument.</p>
 * @author Roland Zwaga
 */
abstract class ISimpleEventBus {
  /**
   * Adds a listener function for events of a specific <code>Class</code>.
   * @param eventClass The specified <code>Class</code>.
   * @param listener The specified listener function.
   */
  // bool addEventClassListener(/*Class*/ eventClass,Function listener,[bool useWeakReference=false, Object topic=null]);

  /**
   * Adds a proxied event handler as a listener for events of a specific <code>Class</code>.
   * @param eventClass The specified <code>Class</code>.
   * @param proxy The specified listener function.
   */
  // bool addEventClassListenerProxy(/*Class*/ eventClass,MethodInvoker proxy,[bool useWeakReference=false, Object topic=null]);

  /**
   * Adds the given listener function as an event handler to the given event eventType.
   * @param eventType the type of event to listen to
   * @param listener the event handler function
   */
  bool addEventListener(String eventType, Function listener,
      [bool useWeakReference = false, Object topic = null]);

  /**
   * Adds a proxied event handler as a listener to the specified event type.
   * @param eventType the type of event to listen to
   * @param proxy a proxy method invoker for the event handler
   */
  //bool addEventListenerProxy(String eventType,MethodInvoker proxy,[bool useWeakReference=false, Object topic=null]);

  /**
   * Adds the given listener object as a listener to all events sent through the event bus.
   */
  bool addListener(IEventBusListener listener,
      [bool useWeakReference = false, Object topic = null]);

  /**
   * Removes all event listeners, interceptors and listener interceptors from the current <code>IEventBus</code> instance.
   */
  void clear();

  /**
   * Convenience method for dispatching an event. This will create an <code>Event</code> instance with the given
   * eventType and call <code>dispatchEvent()</code> on the event bus.
   * @param eventType the type of the event to dispatch.
   */
  bool dispatch(String eventType, [Object topic = null]);

  /**
   * Dispatches the specified <code>Event</code> on the event bus.
   * @param event The specified <code>Event</code>.
   */
  bool dispatchEvent(Event event, [Object topic = null]);

  /**
   * The number of registered event listeners for the specified event eventType, optionally also for the specified topic. Omitting the topic argument will return the number
   * of event listeners that have been registered without a topic, so *not* the entire count.
   * @param eventType The specified event type.
   * @param topic The specified optional topic.
   * @return The specified number of event listeners.
   */
  int getEventListenerCount(String eventType, [Object topic = null]);

  /**
   * The number of registered event listener proxies for the specified event type, optionally also for the specified topic. Omitting the topic argument will return the number
   * of event listener proxies that have been registered without a topic, so *not* the entire count.
   * @param eventType The specified event type.
   * @param topic The specified optional topic.
   * @return The specified number of event listener proxies.
   */
  int getEventListenerProxyCount(String eventType, [Object topic = null]);

  /**
   * The number of registered global event listeners, optionally for the specified topic. Omitting the topic argument will return the number
   * of global listeners that have been registered without a topic, so *not* the entire count.
   * @param topic The specified optional topic.
   * @return The specified number of global listeners.
   */
  int getListenerCount([Object topic = null]);

  /**
   * Removes all types of listeners.
   */
  void removeAllListeners([Object topic = null]);

  /**
   * Removes a proxied event handler as a listener for events of a specific <code>Class</code>.
   * @param eventClass The specified <code>Class</code>.
   * @param proxy The specified listener function.
   */
  //void removeEventClassListenerProxy(/*Class*/ eventClass,MethodInvoker proxy,[Object topic=null]);

  /**
   * Removes the given listener function as an event handler from the given event type.
   * @param eventType
   * @param listener
   */
  void removeEventListener(String eventType, Function listener,
      [Object topic = null]);

  /**
   * Removes a proxied event handler as a listener from the specified event type.
   */
  // void removeEventListenerProxy(String eventType,MethodInvoker proxy,[Object topic=null]);

  /**
   * Removes the given listener from the event bus.
   * @param listener
   */
  void removeListener(IEventBusListener listener, [Object topic = null]);
}

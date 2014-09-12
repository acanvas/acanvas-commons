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
part of dart_commons;


	/**
	 *
	 * @author Christophe Herreman
	 */
	 class CompositeCommandEvent extends Event {

		/**
		 * Defines the value of the type property of a <code>CompositeCommandEvent.COMPLETE</code> event object.
	   * @eventType String
								 */
		 static const String COMPLETE = "compositeCommandComplete";
		/**
		 * Defines the value of the type property of a <code>CompositeCommandEvent.ERROR</code> event object.
	   * @eventType String
								 */
		 static const String ERROR = "compositeCommandError";
		/**
		 * Defines the value of the type property of a <code>CompositeCommandEvent.BEFORE_EXECUTE_COMMAND</code> event object.
	   * @eventType String
								 */
		 static const String BEFORE_EXECUTE_COMMAND = "compositeCommandBeforeExecuteCommand";
		/**
		 * Defines the value of the type property of a <code>CompositeCommandEvent.AFTER_EXECUTE_COMMAND</code> event object.
	   * @eventType String
								 */
		 static const String AFTER_EXECUTE_COMMAND = "compositeCommandAfterExecuteCommand";

		 ICommand _command; 
		ICommand get command {
			return _command;
		}

		/**
		 * Constructs a new CompositeCommandEvent
		 */
	 CompositeCommandEvent(String type,[ICommand command=null,bool bubbles=false,bool cancelable=false]):super(type, bubbles) {
			_command = command;
		}

		/**
		 * Returns an exact copy of the current <code>CompositeCommandEvent</code> instance.
		 */
		Event clone()
		 {
			return new CompositeCommandEvent(this.type, _command, this.bubbles);
		}

	}


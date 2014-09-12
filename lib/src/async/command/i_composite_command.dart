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
	 * Interface that needs to be implemented by command classes that are composed of multiple commands.
	 * @author Roland Zwaga
	 */
abstract class ICompositeCommand extends ICommand {

  /**
		 */
  ICompositeCommand addCommandAt(ICommand command, int index);

  /**
		 * Adds an <code>ICommand</code> to the current <code>ICompositeCommand</code>.
		 * @return The current <code>ICompositeCommand</code>, this way calls to <code>addCommand()</code> can be chained.
		 */
  ICompositeCommand addCommand(ICommand command);

  /**
		 * Adds a <code>Class</code> that is an <code>IOperation</code> implementation along with its optional cosntructor arguments.
		 * Upon execution this class will be instantiated when the current <code>ICompositeCommand</code> requires it in its execution logic.
		 * @param operationClass The specified <code>Class</code>.
		 * @param constructorArgs The optional constructor arguments for the operation <code>Class</code>.
		 * @return The current <code>ICompositeCommand</code>, this way calls to <code>addCommand()</code> can be chained.
		 */
  // ICompositeCommand addOperation(Class operationClass,%# ... constructorArgs%#);
  //ICompositeCommand addOperationAt(Class operationClass,int index,%# ... constructorArgs%#);

  /**
		 * The number of pending commands.
		 */
  int get numCommands;

  /**
		 * Determines the way that the ICompositeCommand instance executes its command collection, either CompositeCommandKind.SEQUENCE or CompositeCommandKind.PARALLEL.
		 */
  String get kind;
}

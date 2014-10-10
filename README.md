## StageXL Commons

StageXL Commons consist of
* Highly customizable, rock solid View Components (Button, Radio, Checkbox, DropDown, Scrollable, List, Pager, Gallery)
* Implementation of Material Design (Polymer Paper Components), see web/paper_buttons.html for a sneak peek.
* Port of [Flexbook](http://www.rubenswieringa.com/code/as3/flex/Book/), see web/stagexl_book.html for a sneak peek.
* Port of [AS3 Commons](http://www.as3commons.org/) projects to Dart/StageXL.

#### Google Material Design
In order to demonstrate the flexibility of UI components, a ull port of Polymer's Paper elements is underway.
What's there so far:
* [Button, Card, Dialog, Fab, Icon, Ripple](http://rockdot.sounddesignz.com/stagexl-commons/paper_buttons.html) ([Original](https://www.polymer-project.org/components/paper-ripple/demo.html)) 
* [Input](http://rockdot.sounddesignz.com/stagexl-commons/paper_input.html) ([Original](https://www.polymer-project.org/components/paper-input/demo.html)) 

#### Async
A library that aims to make working with asynchronous processes easier. 
Providing operation, command, ~~service~~ and ~~task~~ interfaces.
##### No Samples yet

#### EventBus
The EventBus is used as a publish/subscribe event mechanism that lets objects communicate with each other in a loosely coupled way. 
It offers event subscription based on event name, ~~event class~~ or for ~~specific topics~~. 
~~An interception mechanism is in place to block or alter incoming events or event listeners being added.~~

#### Lang
Language utilities and extensions.
* Assertion
* Class
* List Ordering
* String
* Cloneable, Disposable, and Ordered interfaces

#### Logging
An abstraction over Dart Logger implementation, featuring log levels.
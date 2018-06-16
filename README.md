# Acanvas Commons

###Acanvas Commons for Dart 2.0 and StageXL.

*Acanvas Commons* are part of the *[Acanvas Framework](http://acanvas.sounddesignz.com/acanvas-framework/)* layered architecture [(diagram)](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png).

* UI Components, fully customizable and rock solid
  * Button, Radio, Checkbox, DropDown, Scrollable, List, Pager, Gallery
* UI Components implementation of Material Design
* Async Commands and Operations, Queues
* Event and Signal system
* Data interfaces and proxies for pagination and deferred loading of assets


### Examples

#### Material Design

* : [Material Design I](http://acanvas.sounddesignz.com/acanvas-commons/material_buttons.html) 
  * Button, Card, Dialog, Fab, Icon, Ripple
  * just 92 KiB
* [Material Design II](http://acanvas.sounddesignz.com/acanvas-commons/material_radio.html)
  * Tabs, Radio, Checkbox, Toggle, Toast
* [Material Design III](http://acanvas.sounddesignz.com/acanvas-commons/material_input.html)
  * Input
  * Mobile support incomplete, due to inability to activate screen keyboard. Workaround is hard.
* The [Acanvas Framework Demo](http://acanvas.sounddesignz.com/acanvas-framework/) has more Material Design Examples
  * Advertisement: Build your own *Acanvas* project with [Acanvas Generator](https://github.com/acanvas/acanvas-generator) now!


#### Other projects using Acanvas Commons

* [Acanvas Dartbook](http://acanvas.sounddesignz.com/acanvas-dartbook/) - [Source](https://github.com/acanvas/acanvas-dartbook)
* [Acanvas Physics](http://acanvas.sounddesignz.com/acanvas-physics/) - [Source](https://github.com/blockforest/acanvas-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/babylonjs-interop/) - [Source](https://github.com/block-forest/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/threejs-interop/) - [Source](https://github.com/block-forest/threejs-dart-facade/tree/master/example)



## Acanvas Commons Details

#### Async
A library that aims to make working with asynchronous processes easier. 
Providing operation and command interfaces.

#### EventBus
The EventBus is used as a publish/subscribe event mechanism that lets objects communicate with each other in a loosely coupled way. 
It offers event subscription based on event name.

#### Lang
Language utilities and extensions.
* Assertion
* Class
* List Ordering
* String
* Cloneable, Disposable, and Ordered interfaces

#### Logging
An abstraction over Dart Logger implementation, featuring log levels.
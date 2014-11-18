part of stagexl_commons;



class ComponentWithDataProxy extends SpriteComponent {

  IDataProxy _proxy;
  void set listproxy(IDataProxy m) {
    _proxy = m;
  }
  IDataProxy get listproxy {
    return _proxy;
  }

  List _data;
  List get data {
    return _data;
  }
  void set data(List data) {
    _data = data;
  }
  ComponentWithDataProxy() : super() {

  }

}

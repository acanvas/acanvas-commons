part of rockdot_commons;

class BookSampleAssets {
  static const int NUM_PAGES = 12;

  static Bitmap getPage(int i) {
    return new Bitmap(
        _singleton.mgr.getBitmapData("C_" + (i < 10 ? "0$i" : "$i") + "_768x1024Px_Vorschaufenster").clone());
  }

  List assets;
  ResourceManager mgr = new ResourceManager();

  static final BookSampleAssets _singleton = new BookSampleAssets._internal();

  factory BookSampleAssets() {
    return _singleton;
  }

  BookSampleAssets._internal() {
    assets = new List<String>();
    for (int i = 1; i <= NUM_PAGES; i++) {
      assets.add("C_" + (i < 10 ? "0$i" : "$i") + "_768x1024Px_Vorschaufenster");
    }
  }

  static void load(Function cb) {
    _singleton.assets.forEach((String asset) => _singleton.mgr.addBitmapData(asset, 'book/' + asset + '.jpg'));
    _singleton.mgr.load().then<dynamic>((mgr) => cb());
  }
}

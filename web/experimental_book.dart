import 'dart:html' as html;
import 'package:rockdot_commons/rockdot_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
BookView book;

void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
  opts.backgroundColor = 0xFFf9f9f9;
  //opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;
  opts.inputEventMode = Rd.MOBILE ? InputEventMode.TouchOnly : InputEventMode.MouseOnly;
  opts.preventDefaultOnTouch = true;
  opts.preventDefaultOnWheel = true;
  opts.preventDefaultOnKeyboard = false;
  //opts.maxPixelRatio = 1.0;

  stage = new Stage(html.querySelector('#stage') as html.CanvasElement, width: 1020, height: 720, options: opts);

  Rd.STAGE = stage;
  new RenderLoop()..addStage(stage);
  BookSampleAssets.load(start);
}

void start() {
  book = new BookView("book");
  book.span(900, 600);
  book.x = 60;
  book.y = 60;
  book.openAt = 0;
  book.autoFlipDuration = 900;
  book.easing = 0.7;
  book.regionSize = 150;
  book.sideFlip = true;
  book.hardCover = false;
  book.hover = true;
  book.snap = false;
  book.flipOnClick = true;
  stage.addChild(book);

  /* Initialize stuff here. You can use _width and _height. */
  // first page

  Page page;
  for (int i = 1; i < BookSampleAssets.NUM_PAGES; i++) {
    page = new Page(BookSampleAssets.getPage(i));
    if (i == 4) {
      page.tearable = true;
      book.addChild(new MdSamplePage());
    }
    book.addChild(page);
  }

  /*

  addSpriteAsPage(new MdButtons(null));
  addSpriteAsPage(new MdCheckboxes(null));
 // addSpriteAsPage(new MdDialogs(null));
  addSpriteAsPage(new MdFabs(null));
  addSpriteAsPage(new MdIconButtons(null));
  addSpriteAsPage(new MdRadioButtons(null));
  addSpriteAsPage(new MdTexts(null));
  addSpriteAsPage(new MdToasts(null));

  */

  book.addEventListener<LifecycleEvent>(LifecycleEvent.INIT_COMPLETE, onBookInit);
  book.addEventListener<BookEvent>(BookEvent.STATUS_CHANGED, onBookStatusChange);
  book.addEventListener<BookEvent>(BookEvent.PAGE_TURNED, onBookPageTurned);
  book.init();
}

void addSpriteAsPage(Sprite spr) {
  if (spr is Page) {
    book.addChild(spr);
  } else {
    if (spr is BoxSprite) {
      spr.inheritSpan = false;
      spr.spanWidth = 450;
      spr.spanHeight = 600;
    }

    Page p = new Page();
    p.addChild(spr);
    book.addChild(p);
  }
}

void onBookInit(LifecycleEvent event) {
  book.removeEventListener(LifecycleEvent.INIT_COMPLETE, onBookInit);
  // book.nextPage();
}

void onBookStatusChange(BookEvent event) {
   print("NEW STATUS: ${book.status} - pageRx: ${book.pageR.x}");
}

//SUPER EXPERIMENTAL: remove unneeded pages to save bandwidth
void onBookPageTurned(BookEvent event) {
  /*
  -1, 0   --> 0,, 1, 2
  1, 2    --> 0,, 1, 2,, 3, 4
  3, 4    --> 1, 2,, 3, 4,, 5
  5       --> 3, 4,, 5
   */

  print("onBookPageTurned: new page: ${book.currentPage},  old page: ${event.page.index}");

  Page page;

  for (int i = 0; i < book.pages.length; i++) {
    page = book.getPage(i);

    // filter for page range around index of current left page (2 pages before, right page of current page, next 2 pages)
    if (book.currentPage - 2 <= i && i <= book.currentPage + 3) {
/*
*/
      if (!page.initialized) {
        page.init();
        page.refreshFoldGradient(false);
      }
      //filter for current page and the page next to it
      if (book.currentPage - 1 <= i && i <= book.currentPage + 1) {
        if (!page.enabled) {
          page.enable();
        }
      } else {
        if (page.enabled) {
          page.disable();
        }
      }
    } else {
      page.dispose(removeSelf: false);
      page.initialized = false;
    }
  }

  //book.refreshViewStacks();
}

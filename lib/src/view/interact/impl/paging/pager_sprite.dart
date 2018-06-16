part of acanvas_commons;

/**
 * @author nilsdoehring
 */
class PagerSprite extends BehaveSprite with MList, MPager {
  Sprite holder;
  Button btnPrev;
  Button btnNext;

  PagerSprite() : super() {
    disableClick = true;

    holder = new BoxSprite();
    addChild(holder);
  }

  @override
  void refresh() {
    super.refresh();
    _updateControls();
  }

  void setProxyVO(IAcVO vo) {
    _proxy.dataRetrieveCommandVO = vo;
    resetAndLoad();
  }

  void resetAndLoad() {
    disableClick = true;
    loaded = false;
    chunksPlaced = [];
    _proxy.reset();
    _proxy.requestChunk(setData, _getChunkIndex(chunksPlaced), chunkSize);
  }

  void setData(List data) {
    disableClick = false;
    this.data = data;
  }

  void onClickNext([Button button]) {
    if (!hasNext) {
      return;
    }

    disableClick = true;
    pressedNext = true;
//			uiService.lock();

    btnPrev.enabled = false;
    btnNext.enabled = false;

    _proxy.requestChunk(setData, _getChunkIndex(chunksPlaced), chunkSize);
  }

  void onClickPrev([Button button]) {
    if (hasPrev < 1) {
      return;
    }

    disableClick = true;
    pressedNext = false;
//			uiService.lock();

    //yes, 2times
    chunksPlaced.removeLast();
    chunksPlaced.removeLast();

    btnPrev.enabled = true;
    btnNext.enabled = true;
    _proxy.requestChunk(setData, _getChunkIndex(chunksPlaced), chunkSize);
  }

  void _updateControls() {
    if (chunksPlaced.length == 0) {
      return;
    }

    //clone chunk count list
    List<int> chunks = [];
    chunksPlaced.forEach((int c) => chunks.add(c));

    //yes, calling removeLast twice is correct
    chunks.removeLast();
    if (chunks.length > 1) {
      chunks.removeLast();
    }
    hasPrev = 0;

    if (chunks.length > 0) {
      hasPrev = _proxy.hasChunk(_getChunkIndex(chunks), chunkSize);
    }
    hasNext = _proxy.hasChunk(_getChunkIndex(chunksPlaced), chunkSize) > 0;

    if (hasPrev > 0) {
      btnPrev.enabled = true;
    } else {
      btnPrev.enabled = false;
    }
    if (hasNext) {
      btnNext.enabled = true;
    } else {
      btnNext.enabled = false;
    }

//			uiService.unlock();
  }

  int _getChunkIndex(List<int> chunks) {
    int idx = 0;
    for (int num in chunks) {
      idx += num;
    }
    return idx;
  }
}

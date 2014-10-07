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


/**
	 * An <code>IOperation</code> implementation that can load arbitrary data from a specified URL.
	 * @author Roland Zwaga
	 */
class LoadURLOperation extends AbstractProgressOperation {

  /**
		 * Creates a new <code>LoadURLOperation</code> instance.
		 * @param url The specified URL from which the data will be loaded.
		 * @param dataFormat Optional argument that specifies the data format of the expected data. Use the <code>flash.net.URLLoaderDataFormat</code> enumeration for this.
		 * @see flash.net.URLLoaderDataFormat
		 */
  LoadURLOperation(String name, String url, [String dataFormat = null]) : super() {
    (dataFormat != null) ? dataFormat : dataFormat = URLLoaderDataFormat.TEXT_FILE;
    createLoader(name, url, dataFormat);
  }


  /**
		 * Internal <code>URLLoader</code> instance that is used to do the actual loading of the data.
		 */
  ResourceManager resourceManager;

  String _url;
  String _name;
  String _dataFormat;

  String get url {
    return _url;
  }

  void createLoader(String name, String url, String dataFormat) {
    _name = name;
    _url = url;
    _dataFormat = dataFormat;


    resourceManager = new ResourceManager();
    switch (_dataFormat) {
      case URLLoaderDataFormat.TEXT_FILE:
        resourceManager.addTextFile(name, url);
        break;
      case URLLoaderDataFormat.BITMAP_DATA:
        resourceManager.addBitmapData(name, url);
        break;
      case URLLoaderDataFormat.SOUND:
        resourceManager.addSound(name, url);
        break;
      case URLLoaderDataFormat.SOUND_SPRITE:
        resourceManager.addSoundSprite(name, url);
        break;
      case URLLoaderDataFormat.TEXTURE_ATLAS:
        resourceManager.addTextureAtlas(name, url, TextureAtlasFormat.JSON);
        break;
    }

    resourceManager.load().then(urlLoaderCompleteHandler);
  }

  /**
		 * Handles the <code>Event.COMPLETE</code> event of the internally created <code>URLLoader</code>.
		 * @param event The specified <code>Event.COMPLETE</code> event.
		 */
  void urlLoaderCompleteHandler(ResourceManager res) {

    switch (_dataFormat) {
      case URLLoaderDataFormat.TEXT_FILE:
        result = res.getTextFile(_name);
        break;
      case URLLoaderDataFormat.BITMAP_DATA:
        result = res.getBitmapData(_name);
        break;
      case URLLoaderDataFormat.SOUND:
        result = res.getSound(_name);
        break;
      case URLLoaderDataFormat.SOUND_SPRITE:
        result = res.getSoundSprite(_name);
        break;
      case URLLoaderDataFormat.TEXTURE_ATLAS:
        result = res.getTextureAtlas(_name);
        break;
    }

    dispatchCompleteEvent();
  }


  @override
  String toString() {
    return "[LoadURLOperation(url:'" + _url + "')]";
  }

}

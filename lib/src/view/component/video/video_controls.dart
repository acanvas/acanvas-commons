 part of dart_commons;





	/**
	 * Copyright (2011 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author danielhuebschmann
	 * @since 09.06.2011 13:37:14
	 */
	 class VideoControls extends SpriteComponent {

		 Pyro _video;
		
//		 SWC_sprite_AppPreloader _preloader;
		 bool _isVideoCompleted;
		 bool _isVideoFlushed;
		 num _defaultVideoWidth;
		 num _defaultVideoHeight;
	 VideoControls(Pyro video): super()  {
			_video = video;
			_defaultVideoWidth = _video.width;
			_defaultVideoHeight = _video.height;
			_initPreloader();
			
			_video.addEventListener(PyroEvent.NEW_STREAM_INIT, _onNewStreamInit, false, 0, true);
			_video.addEventListener(PyroEvent.STARTED, _onVideoStarted, false, 0, true);
			_video.addEventListener(PyroEvent.STOPPED, _onVideoStopped, false, 0, true);
			_video.addEventListener(PyroEvent.PAUSED, _onVideoPaused, false, 0, true);
			_video.addEventListener(PyroEvent.UNPAUSED, _onVideoUnPaused, false, 0, true);
			_video.addEventListener(PyroEvent.SEEKED, _onVideoSeeked, false, 0, true);
			_video.addEventListener(PyroEvent.VOLUME_UPDATE, _onVideoVolumeUpdate, false, 0, true);
			_video.addEventListener(PyroEvent.BUFFER_EMPTY, _onVideoBufferEmpty, false, 0, true);
			_video.addEventListener(PyroEvent.BUFFER_FLUSH, _onVideoBufferFlush, false, 0, true);
			_video.addEventListener(PyroEvent.BUFFER_FULL, _onVideoBufferFull, false, 0, true);
			_video.addEventListener(PyroEvent.BUFFER_TIME_ADJUSTED, _onVideoBufferTimeAdjusted, false, 0, true);
			_video.addEventListener(PyroEvent.METADATA_RECEIVED, _onVideoMetadataReceived, false, 0, true);	
			_video.addEventListener(PyroEvent.COMPLETED, _onVideoCompleted, false, 0, true);
			_video.addEventListener(PyroEvent.MUTED, _onVideoMuted, false, 0, true);
			_video.addEventListener(PyroEvent.UNMUTED, _onVideoUnMuted, false, 0, true);
			_video.addEventListener(PyroEvent.STARTED, _onVideoUnMuted, false, 0, true);
			
			_video.doubleClickEnabled = true;
			_video.addEventListener(MouseEvent.CLICK, _onVideoClick, false, 0, true);
			_video.addEventListener(MouseEvent.DOUBLE_CLICK, _onVideoDoubleClick, false, 0, true);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyboardDown, false, 0, true);
			stage.addEventListener(Event.FULLSCREEN, _onFullscreen, false, 0, true);
			
		}

		
		/**
		 * 
		 * VIDEO AND PYRO EVENTS
		 * 
		 */
		  void _onNewStreamInit(PyroEvent event) {
//			_log.print("_onNewStreamInit");
		}
		
		  void _onVideoClick(MouseEvent event) {
//			_log.print("_onVideoClick");
			if(_isVideoCompleted) _playAgain();
			else _video.togglePause();
		}
		
		  void _onVideoDoubleClick(MouseEvent event) {
//			_log.print("_onVideoDoubleClick");
			_video.togglePause();
			_video.toggleFullScreen();
		}

		  void _onVideoStarted(PyroEvent event) {
//			_log.print("_onVideoStarted");
			_hidePreloader();
		}

		  void _onVideoStopped(PyroEvent event) {
//			_log.print("_onVideoStopped");
		}

		  void _onVideoPaused(PyroEvent event) {
//			_log.print("_onVideoPaused");
		}

		  void _onVideoUnPaused(PyroEvent event) {
//			_log.print("_onVideoUnPaused");
		}

		  void _onVideoSeeked(PyroEvent event) {
//			_log.print("_onVideoSeeked");
		}

		  void _onVideoVolumeUpdate(PyroEvent event) {
//			_log.print("_onVideoVolumeUpdate");
		}
		
		  void _onVideoMuted(PyroEvent event) {
//			_log.print("_onVideoMuted");
		}

		  void _onVideoUnMuted(PyroEvent event) {
//			_log.print("_onVideoUnMuted");
		}

		  void _onVideoBufferEmpty(PyroEvent event) {
//			_log.print("_onVideoBufferEmpty");
			if(!_isVideoFlushed) _showPreloader();
		}

		  void _onVideoBufferFlush(PyroEvent event) {
//			_log.print("_onVideoBufferFlush");
			_isVideoFlushed = true;
		}

		  void _onVideoBufferFull(PyroEvent event) {
//			_log.print("_onVideoBufferFull");
			_hidePreloader();
		}

		  void _onVideoBufferTimeAdjusted(PyroEvent event) {
//			_log.print("_onVideoBufferTimeAdjusted");
		}

		  void _onVideoMetadataReceived(PyroEvent event) {
//			_log.print("_onVideoMetadataReceived");
			_video.removeEventListener(PyroEvent.METADATA_RECEIVED, _onVideoMetadataReceived);
		}

		  void _onVideoCompleted(PyroEvent event) {
//			_log.print("_onVideoCompleted");
			_isVideoCompleted = true;
		}
		
		  void _playAgain() {
//			_log.print("_playAgain");
			_video.seek(0);
			_isVideoCompleted = false;
			_isVideoFlushed = false;
		}
		
		  void _onKeyboardDown(KeyboardEvent event) {
			if (event.keyCode == Keyboard.SPACE) _video.togglePause();
		}
		
		  void _onFullscreen(Event event) {
			if (stage.displayState == StageDisplayState.NORMAL) {
				_video.resize( _defaultVideoWidth, _defaultVideoHeight );
			} else {
				_video.resize( stage.fullScreenWidth, stage.fullScreenHeight );
			}
		}
		
		
		
		/**
		 * 
		 * PRELOADER
		 * 
		 */
		  void _initPreloader() {
		}
		
		  void _showPreloader() {
		}
		
		  void _hidePreloader() {
		}
		
		
		
		
		
		/**
		 * 
		 * REMMOVE STAGE LISTENERS
		 * 
		 */
		  void killStagetListeners() {
			print("VideoControls killStagetListeners");
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyboardDown);
			stage.removeEventListener(Event.FULLSCREEN, _onFullscreen);
		}
		
	}

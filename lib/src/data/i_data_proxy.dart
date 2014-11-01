part of stagexl_commons;



	/**
	 * @author nilsdoehring
	 */
  abstract class IDataProxy {
		void set dataCache(List dataCache);
		List get dataCache;

		void set dataFilterVO(IXLVO dataFilterVO);
		IXLVO get dataFilterVO;
		
		void set dataTotalSize(int dataTotalSize);
		int get dataTotalSize;

		void set onDataCallback(Function onDataCallback);
		
		void set dataRetrieveCommand(IAsyncCommand dataRetrieveCommand);

		void reset();
		
		int hasChunk(int chunkIndex,int chunkSize);
		
		void requestChunk(Function callBack,[int chunkIndex=-1,int chunkSize=-1]);
		
		void _onData(OperationEvent event);
	}


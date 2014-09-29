part of dart_commons;



	 class ComponentWithDataProxy extends SpriteComponent {
		
	   IDataProxy _proxy; 
		void set listproxy(IDataProxy m) {
			_proxy = m;
		} 
		IDataProxy get listproxy {
			return _proxy;
		}
		
		 dynamic _data; 
		dynamic get data {
			return _data;
		} 
		void set data(dynamic data) {
			_data = data;
		}
	 ComponentWithDataProxy():super() {
			
		}


		
	}


part of stagexl_commons;



	/**
	 * Copyright (2009 as c), Jung von Matt/Neckar
	 *
	 * @author	Thomas Eckhardt
	 * @since	15.06.2009 13:33:27
	 *
	 * Diese Klasse soll als Vorlage für Textfelder dienen.
	 * Sie überschreibt ein paar Default-Werte lässt aber
	 * eine beliebige Konfiguration zu.
	 *
	 * Beispiel: dynamic TextField tf = new CoreTextField( "Hello World", new TextFormat( "Arial", 11, 0x0 ), true, { width:100, embedFonts:false } );
	 *
	 */
	 class Label extends PaperText {
	   
	   List nameList = [];

		/**
		 * Konstruktor
		 *
		 * @param	value		Der Text mit dem das Textfeld gefüllt werden soll
		 * @param	format 		Das Standard Textformat
		 * @param	html		Soll es sich um ein HTML-Textfeld handeln (Default: true)
		 * @param	properties	Ein Objekt das alle Eigenschaften eines Textfelds definieren kann
		 *
		 * @throws	Error		Falls über properties eine Eigenschaft gesetzt wird, die in der Klasse TextField nicht implementiert ist
		 */
	  Label([String value = "",TextFormat format,bool html=true]) : super(value, color: PaperColor.WHITE, size: 24){
		}

	   
	}


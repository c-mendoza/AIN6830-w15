package ain6830
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class GameTextDisplay extends MovieClip
	{
		var textArray:Array = new Array;
		protected var currentTextIndex:uint = 0;
		protected var separator:String = "#";
		protected var nextKey:uint = Keyboard.RIGHT;
		protected var prevKey:uint = Keyboard.LEFT;
		public var nextKeyEnabled:Boolean = true;
		public var prevKeyEnabled:Boolean = true;
		
		public function GameTextDisplay()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		public function addedToStage(e:Event) {
			stage.focus = this;
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		public function removedFromStage(e:Event) {
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.focus = stage
		}
		
		public function keyUp(e:KeyboardEvent) {
			if(e.keyCode == nextKey && nextKeyEnabled) {
				displayNextText();
			} else if (e.keyCode == prevKey && prevKeyEnabled) {
				displayPreviousText();
			}
		}
		
		public function setTextSeparator(separator:String):void {
			this.separator = separator;
		}
		
		public function loadTextFile(url:String) {
			var loader:URLLoader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, loadingComplete);
			try
			{
				loader.load(new URLRequest(url));

			} 
			catch(error:Error) 
			{
				trace(error);
			}
		}
		
		public function loadingComplete(e:Event) {
			textArray = e.target.data.split(separator);
			displayNextText();
		}
		
		public function displayNextText() {
			textField.text = textArray[currentTextIndex];
			currentTextIndex++;
			if(currentTextIndex > textArray.length - 1) {
				currentTextIndex = textArray.length - 1;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function displayPreviousText() {
			if(currentTextIndex > 0) {
				textField.text = textArray[currentTextIndex];
				currentTextIndex--;
			} else {
				currentTextIndex = 0;
				textField.text = textArray[currentTextIndex];
			}
		}
		
		public function displayText(index:uint) {
			if(index < textArray.length && index >= 0) {
				textField.text = textArray[index];
				currentTextIndex = index;
			}
		}
		
		public function getCurrentTextIndex():uint {
			return currentTextIndex;
		}
		
		public function numTexts():uint {
			return textArray.length;
		}
		
		public function setNextKey(key:uint) {
			nextKey = key;
		}
		
		public function setPrevKey(key:uint) {
			prevKey = key;
		}
		
	}
}
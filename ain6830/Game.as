package ain6830 {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Game extends MovieClip {

		public var player:Player = null;
		public var score: Number = 0;
		private var _currentLevel: Level = null;
		private var _gameWidth: Number = 0;
		private var _gameHeight: Number = 0;
		
		//Other things that could go here:
		//lives
		//Things that may have happened already in the game
		//Inventory
		
		protected var gameOptions:Object = new Object;

		public function Game() {
			// constructor code
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event) {
			_gameWidth = stage.stageWidth;
			_gameHeight = stage.stageHeight;
			setup();
		}
		
		/**
		 * The setup() function is called after the game has been added to the stage.
		 * Override it to provide custom game initialization. 
		 * @return 
		 * 
		 */		
		public function setup() {
			
		}
		
		/**
		 * Creates a named game option 
		 * @param name
		 * @param value
		 * @return 
		 * 
		 */		
		public function createOption(name:String, value:Object) {
			if(!gameOptions.hasOwnProperty(name)) {
				gameOptions[name] = value;
			}
			
		}
		
		public function setOption(name:String, value:Object) {
			if(gameOptions.hasOwnProperty(name)) {
				gameOptions[name] = value;
			}
		}
		
		public function getOption(name:String):Object{
			return gameOptions[name];
		}
		
		/**
		 * Convenience function that loads the next level.
		 * @param nextLevel Level to load.
		 * @param playerX sets the x position of the Player in the level to be loaded.
		 * @param playerY sets the y position of the Player in the level to be loaded.
		 * @return nothing.
		 */		
		public function loadNextLevel(nextLevel: Level, playerX: Number, playerY: Number):void {
			if(stage == null) {
				throw new Error("Game must be added to the stage before calling the loadNextLevel function");
				return;
			}
			currentLevel = nextLevel;
			player.setX(playerX);
			player.setY(playerY);
			currentLevel.scrollTo(playerX, playerY);
			
		}
		
		public function get currentLevel(): Level {
			return _currentLevel;
		}

		public function set currentLevel(l: Level) {
			if(player == null) {
				throw new Error("Player cannot be null before loading the next level!");
			}
			if (_currentLevel != null) {
				_currentLevel.removeChild(player);
				removeChild(_currentLevel);
				_currentLevel = l;
				_currentLevel.game = this;				
				addChild(_currentLevel);
				currentLevel.scrollTo(0, 0);
				player.setX(0);
				player.setY(0);
			} else {
				_currentLevel = l;
				_currentLevel.game = this;				
				addChild(_currentLevel);	
				currentLevel.scrollTo(0, 0);
				player.setX(0);
				player.setY(0);
			}
		}

		public function get gameWidth():Number
		{
			return _gameWidth;
		}

		public function get gameHeight():Number
		{
			return _gameHeight;
		}


	}

}
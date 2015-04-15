package ain6830 {
	
	import flash.display.MovieClip;

	public class Game extends MovieClip {

		public var player:Player = null;
		public var score: Number = 0;
		private var _currentLevel: Level = null;
		//Other things that could go here:
		//lives
		//Things that may have happened already in the game
		//Inventory
		
		protected var gameOptions:Object = new Object;

		public function Game() {
			// constructor code
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
			currentLevel = nextLevel;
			currentLevel.scrollTo(playerX, playerY);
			player.setX(playerX);
			player.setY(playerY);
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
			} else {
				_currentLevel = l;
				_currentLevel.game = this;				
				addChild(_currentLevel);		
			}
		}

	}

}
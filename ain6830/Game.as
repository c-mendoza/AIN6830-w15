package ain6830 {
	
	import flash.display.MovieClip;

	public class Game extends MovieClip {

		public var player = null;
		public var score: Number = 0;
		private var _currentLevel: Level = null;
		//Other things that could go here:
		//lives
		//Things that may have happened already in the game
		//Inventory

		public function Game() {
			// constructor code
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
			player.setX(playerX);
			player.setY(playerY);
		}
		
		public function get currentLevel(): Level {
			return _currentLevel;
		}

		public function set currentLevel(l: Level) {
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
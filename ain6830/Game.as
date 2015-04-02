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
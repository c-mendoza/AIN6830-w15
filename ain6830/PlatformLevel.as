package ain6830 {
	
	public class PlatformLevel extends Level {
		
		public var platforms:Array = new Array;
		
		public function PlatformLevel() {
			// constructor code
		}
		
		override public function update() {
			super.update();
			
			game.player.update();
			
			for (var i = 0; i < platforms.length; i++) {
				Collision.playerAndPlatform(game.player as PlatformPlayer, platforms[i]);
			}
			
		}
		
		public function addPlatform(p:Platform) {
			platforms.push(p);
		}

	}
	
}

package ain6830 {
	
	public class PlatformLevel extends Level {
		
		public var platforms:Array = new Array;
		
		public function PlatformLevel() {
			// constructor code
		}
		
		override public function update() {
			super.update();
			
			game.player.update();
			
			game.player.canJump = false;
			game.player.inAir = true;
			
			for (var i = 0; i < platforms.length; i++) {
				Collision.playerAndPlatform(game.player as JumpingPlayer, platforms[i]);
			}
		}
		
		public function addPlatform(p:Platform) {
			platforms.push(p);
		}

	}
	
}

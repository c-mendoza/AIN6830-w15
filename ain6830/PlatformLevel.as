package ain6830 {
	
	public class PlatformLevel extends Level {
		
		public var platforms:Array = new Array;
		
		public function PlatformLevel() {
			// constructor code
		}
		
		override public function update() {
			super.update();
			
			game.player.update();
			//trace(game.player.forceY);
			var onGround = false;
			for (var i = 0; i < platforms.length; i++) {
				var cSide = Collision.playerAndPlatform(game.player as PlatformPlayer, platforms[i]);
				if(cSide == Collision.COLLISION_SIDE_BOTTOM) {
					onGround = true;
				}
			}
			
			if(!onGround) {
				if(Math.abs(game.player.vy) > 2) {
					(game.player as PlatformPlayer).inAir = true;
				}
			}
			
		}
		
		public function addPlatform(p:Platform) {
			platforms.push(p);
		}

	}
	
}

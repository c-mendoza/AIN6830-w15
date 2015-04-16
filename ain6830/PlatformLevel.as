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
		
		/**
		 * Removes a platform from the level.
		 * @param p The platform to remove.
		 * @param removeFromDisplayList If true, the platform is removed from the display list as well. Defaults to false.
		 * @return true if it removed a platorm, false if it did not find the platform.
		 * 
		 */		
		public function removePlatform(p:Platform, removeFromDisplayList = false):Boolean {
			for (var i = 0; i < platforms.length; i++) {
				if(platforms[i] == p) {
					platforms.splice(i, 1);
					if(removeFromDisplayList) {
						removeChild(p);
						return true;
					}
				}
			}
			return false;
		}

	}
	
}

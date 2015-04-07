package  ain6830 {
	
	public class TopDownLevel extends Level {
		
		public var barriers:Array = new Array;
		
		public function TopDownLevel() {
			// constructor code
		}
		
		override public function update() {
			super.update();
			
			game.player.update();
			
			for (var i = 0; i < barriers.length; i++) {
				Collision.block(game.player, barriers[i]);
			}
		}
		
		public function addBarrier(barrier:Barrier) {
			barriers.push(barrier);
		}

	}
	
}

package ain6830
{
	public class MovingPlatform extends Platform
	{
		private var prevX:Number = 0;
		private var prevY:Number = 0;
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public function MovingPlatform()
		{
			super();
		}
		
		public function update() {
			
			vx = x - prevX;
			vy = y - prevY;
			prevX = x;
			prevY = y;
		}
	}
}
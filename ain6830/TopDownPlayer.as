package ain6830
{
	import flash.display.MovieClip;

	public class TopDownPlayer extends Player
	{
		public var animationRight: MovieClip = new MovieClip();
		public var animationUp: MovieClip = new MovieClip();
		public var animationDown: MovieClip = new MovieClip();
		public var animationLeft: MovieClip = new MovieClip();
		public var animationStopRight: MovieClip = new MovieClip();
		public var animationStopLeft: MovieClip = new MovieClip();
		public var animationStopDown: MovieClip = new MovieClip();
		public var animationStopUp: MovieClip = new MovieClip();
		
		public function TopDownPlayer()
		{
//			animationHolder = animationRight;
//			addChild(animationHolder)
			super();
			registerAnimationState(ANIMATION_STATE_STOP_LEFT, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0) {
					if (currentAnimationState == ANIMATION_STATE_LEFT) {
						return true;
					}
				}
				return false;
			}, animateStopLeft);
			registerAnimationState(ANIMATION_STATE_STOP_RIGHT, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0) {
					if (directionX == 1) {
						return true;
					}
				}
				return false;
			}, animateStopRight);
			registerAnimationState(ANIMATION_STATE_STOP_UP, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0) {
					if (directionY == -1) {
						return true;
					}
				}
				return false;
			}, animateStopUp);
			
			registerAnimationState(ANIMATION_STATE_STOP_DOWN, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0) {
					if (directionY == 1) {
						return true;
					}
				}
				return false;
			}, animateStopDown);
			
			
			registerAnimationState(ANIMATION_STATE_RIGHT, function():Boolean {
				if (Math.abs(accelX) > Math.abs(accelY) && accelX > 0) {
					return true;
				} else {
					return false;
				}
			}, animateRight);
			registerAnimationState(ANIMATION_STATE_LEFT, function():Boolean {
				if (Math.abs(accelX) > Math.abs(accelY) && accelX < 0) {
					return true;
				} else {
					return false;
				}
			}, animateLeft);
			registerAnimationState(ANIMATION_STATE_DOWN, function():Boolean {
				if (Math.abs(accelX) < Math.abs(accelY)) {
					if (accelY > 0) {
						return true;
					}
				}
				return false;
			}, animateDown);
			registerAnimationState(ANIMATION_STATE_UP, function():Boolean {
				if (Math.abs(accelX) < Math.abs(accelY)) {
					if (accelY < 0) {
						return true;
					}
				}
				return false;
			}, animateUp);	
		}
		
		override public function animateRight() {
			swapAnimation(animationRight);
			scaleX = baseScale;
		}
		
		override public function animateLeft() {
			swapAnimation(animationRight);
			scaleX = -baseScale;
		}
		
		override public function animateStopRight() {
			swapAnimation(animationStopRight);
			scaleX = baseScale;
		}
		
		override public function animateStopLeft() {
			swapAnimation(animationStopRight);
			scaleX = -baseScale;
		}
		
		override public function animateStopUp() {
			swapAnimation(animationStopUp);
		}
		
		override public function animateStopDown() {
			swapAnimation(animationStopDown);
		}
		
		override public function animateUp() {
			swapAnimation(animationUp);
			scaleX = baseScale;
		}
		
		override public function animateDown() {
			swapAnimation(animationDown);
			scaleX = baseScale;
		}

	}
}
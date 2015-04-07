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
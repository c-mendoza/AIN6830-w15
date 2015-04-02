package ain6830 {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;

	import ain6830.Player;

	public class JumpingPlayer extends Player {

		public var animationRight: MovieClip;
		public var animationUp: MovieClip;
		public var animationDown: MovieClip;
		public var animationStopRight: MovieClip;
		public var animationStopDown: MovieClip;
		public var animationStopUp: MovieClip;

		public var forceX: Number = 0;
		public var forceY: Number = 0;
		public var gravity: Number = 2;
		public var jumpForce: Number = -30;

		var forceYAdd: Number = 0;
		var forceXAdd: Number = 0;

		public var canJump: Boolean = false;
		public var inAir: Boolean = false;

		private var jumpLock: Boolean = false;

		public function JumpingPlayer() {
			// constructor code

			accelerationY = 0;
			animationRight = new LinkAnimationRight;
			animationUp = new LinkAnimationUp;
			animationDown = new LinkAnimationDown;
			animationStopDown = new LinkAnimationStopDown;
			animationStopUp = new LinkAnimationStopUp;
			animationStopRight = new LinkAnimationStopRight;

			animationHolder = animationRight;
			addChild(animationHolder);
		}

		override public function processKeyboard() {
			super.processKeyboard();
			
			//trace(jumpLock, canJump);
			
			if (jumpLock) {
				if (!spacebarDown && !inAir) {
					jumpLock = false;
				}
			} else if (inAir) {
				jumpLock = true;
			}

			if (spacebarDown) {
				if (canJump == true && jumpLock == false) {
					addForceY(jumpForce);
					canJump = false;
					jumpLock = true;
				}
			}
		}

		override public function updatePosition() {

			prevX = xPos;
			prevY = yPos;

			forceX += accelX - (frictionX * vx) + forceXAdd;
			forceY += accelY + gravity + forceYAdd;

			if (Math.abs(forceX) < 0.1) {
				forceX = 0;
			}
			if (Math.abs(forceY) < 0.1) {
				forceY = 0;
			}

			//"Drain" the forceAdds:
			forceXAdd = 0;
			forceYAdd = 0;

			xPos += forceX;
			yPos += forceY;

			vx = xPos - prevX;
			vy = yPos - prevY;

			//trace(forceX, forceY, canJump, vx, vy);
			x = xPos;
			y = yPos;

		}

		public function addForceY(fy: Number) {
			forceYAdd += fy;
		}

		public function addForceX(fx: Number) {
			forceXAdd += fx;
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
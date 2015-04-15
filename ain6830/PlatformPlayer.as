package ain6830 {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	import ain6830.Player;

	public class PlatformPlayer extends Player {

		public var animationRight: MovieClip = new MovieClip();
		public var animationUp: MovieClip = new MovieClip();
		public var animationDown: MovieClip = new MovieClip();
		public var animationStopRight: MovieClip = new MovieClip();
		public var animationStopDown: MovieClip = new MovieClip();
		public var animationStopUp: MovieClip = new MovieClip();
		public var animationJump: MovieClip = new MovieClip();

		public var forceX: Number = 0;
		public var forceY: Number = 0;
		public var gravity: Number = 2;
		public var jumpForce: Number = -30;

		var forceYAdd: Number = 0;
		var forceXAdd: Number = 0;

		public var canJump: Boolean = false;
		public var inAir: Boolean = false;

		private var jumpLock: Boolean = false;
		
		public static const ANIMATION_STATE_JUMP_RIGHT: String = "ANIMATION_STATE_JUMP_RIGHT";
		public static const ANIMATION_STATE_JUMP_LEFT: String = "ANIMATION_STATE_JUMP_LEFT";

		public function PlatformPlayer() {
			// constructor code

			accelerationY = 0;
			registerAnimationState(ANIMATION_STATE_STOP_LEFT, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0 && inAir == false) {
					if (currentAnimationState == ANIMATION_STATE_LEFT || currentAnimationState == ANIMATION_STATE_JUMP_LEFT ) {
						return true;
					}
				}
				return false;
			}, animateStopLeft);
			registerAnimationState(ANIMATION_STATE_STOP_RIGHT, function():Boolean {
				if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0 && inAir == false) {
					if (currentAnimationState == ANIMATION_STATE_RIGHT || currentAnimationState == ANIMATION_STATE_JUMP_RIGHT ) {
						return true;
					}
				}
				return false;
			}, animateStopRight);
			
			registerAnimationState(ANIMATION_STATE_RIGHT, function():Boolean {
				if (Math.abs(accelX) > Math.abs(accelY) && accelX > 0 && inAir == false) {
					return true;
				} else {
					return false;
				}
			}, animateRight);
			registerAnimationState(ANIMATION_STATE_LEFT, function():Boolean {
				if (Math.abs(accelX) > Math.abs(accelY) && accelX < 0 && inAir == false) {
					return true;
				} else {
					return false;
				}
			}, animateLeft);
			
			registerAnimationState(ANIMATION_STATE_JUMP_RIGHT, function():Boolean {
				//trace("inAir in anon", inAir, vy);
				if(inAir == true && directionX == 1) {
					return true;
				}
				return false;
			}, function() {
				swapAnimation(animationJump);
				scaleX = baseScale;
			});
			
			registerAnimationState(ANIMATION_STATE_JUMP_LEFT, function():Boolean {
				//trace("inAir in anon", inAir, vy);
				if(inAir == true && directionX == -1) {
					return true;
				}
				return false;
			}, function() {
				swapAnimation(animationJump);
				scaleX = -baseScale;
			});
			
			unregisterAnimationState(ANIMATION_STATE_DOWN);
			unregisterAnimationState(ANIMATION_STATE_STOP_DOWN);
			unregisterAnimationState(ANIMATION_STATE_UP);
			unregisterAnimationState(ANIMATION_STATE_STOP_UP);
				
			animationHolder = animationRight;
			addChild(animationHolder);
		}
		
//		override public function updateAnimationState():* {
//			super.updateAnimationState();
//			trace(currentAnimationState);
//		}

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
					inAir = true;
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
			if (Math.abs(forceY) < 0.2) {
				forceY = 0;
				inAir = false;
			} /*else if (Math.abs(forceY) > 3){
				inAir = true;
			}*/

			//"Drain" the forceAdds:
			forceXAdd = 0;
			forceYAdd = 0;

			xPos += forceX;
			yPos += forceY;

			vx = xPos - prevX;
			vy = yPos - prevY;

//			trace(forceX, forceY, canJump, vx, vy);
			x = xPos;
			y = yPos;

		}

		public function addForceY(fy: Number) {
			forceYAdd += fy;
		}

		public function addForceX(fx: Number) {
			forceXAdd += fx;
		}
		
		override public function setX(newX:Number):* {
			super.setX(newX);
			forceX = 0;
		}
		
		override public function setY(newY:Number):* {
			super.setY(newY);
			forceY = 0;
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
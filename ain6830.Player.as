package ain6830 {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {

		//Public Properties:

		public var accelerationX: Number = 2;
		public var accelerationY: Number = 0;
		public var frictionX: Number = 0.7;
		public var frictionY: Number = 0.7;
		public var _baseScale: Number = 1.5;


		//Keyboard variables:
		var leftArrowDown: Boolean = false;
		var rightArrowDown: Boolean = false;
		var upArrowDown: Boolean = false;
		var downArrowDown: Boolean = false;
		var spacebarDown: Boolean = false;

		//Public constants:
		public static const ANIMATION_STATE_UP: Number = 1;
		public static const ANIMATION_STATE_RIGHT: Number = 2;
		public static const ANIMATION_STATE_DOWN: Number = 3;
		public static const ANIMATION_STATE_LEFT: Number = 4;
		public static const ANIMATION_STATE_STOP: Number = 5;
		public static const ANIMATION_STATE_STOP_UP: Number = 6;
		public static const ANIMATION_STATE_STOP_DOWN: Number = 7;
		public static const ANIMATION_STATE_STOP_LEFT: Number = 8;
		public static const ANIMATION_STATE_STOP_RIGHT: Number = 9;

		//Protected properties:
		protected var currentAnimationState: Number = -1;
		protected var prevX: Number = 0;
		protected var prevY: Number = 0;
		protected var vx: Number = 0;
		protected var vy: Number = 0;
		protected var accelX: Number = 0;
		protected var accelY: Number = 0;




		public function Player() {
			// constructor code
			setAnimationState(ANIMATION_STATE_STOP_RIGHT);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}

		function addedToStage(e: Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			scaleX = baseScale;
			scaleY = baseScale;
		}

		function removedFromStage(e: Event) {

		}

		//You only need to call this function from the outside
		public function update() {
			updatePosition();
			processKeyboard();
			updateAnimationState();

		}
		
		public function processKeyboard() {
			if (rightArrowDown == true) {
				accelX = accelerationX;
			}

			if (leftArrowDown == true) {
				accelX = -accelerationX;
			}

			if (leftArrowDown == true && rightArrowDown == true) {
				accelX = 0;
			}
			if (leftArrowDown == false && rightArrowDown == false) {
				accelX = 0;
			}

			if (upArrowDown == true) {
				accelY = -accelerationY;
			}

			if (downArrowDown == true) {
				accelY = accelerationY;
			}

			if (upArrowDown == true && downArrowDown == true) {
				accelY = 0;
			}
			if (upArrowDown == false && downArrowDown == false) {
				accelY = 0;
			}
		}

		public function updatePosition() {
			prevX = x;
			prevY = y;

			x = x + accelX + (frictionX * vx);
			y = y + accelY + (frictionY * vy);

			vx = x - prevX;
			vy = y - prevY;

			x = Math.floor(x);
			y = Math.floor(y);

			if (Math.abs(vx) < 0.3) {
				vx = 0;
				accelX = 0;
			}

			if (Math.abs(vy) < 0.3) {
				vy = 0;
				accelY = 0;
			}
		}

		public function updateAnimationState() {
			if (Math.abs(accelX) > Math.abs(accelY)) {
				if (accelX > 0) {
					setAnimationState(ANIMATION_STATE_RIGHT);
				} else if (accelX < 0) {
					setAnimationState(ANIMATION_STATE_LEFT);
				} else {

				}
			} else if (Math.abs(accelX) < Math.abs(accelY)) {
				if (accelY > 0) {
					setAnimationState(ANIMATION_STATE_DOWN);
				} else if (accelY < 0) {
					setAnimationState(ANIMATION_STATE_UP);
				} else {

				}
			} else if (Math.abs(accelX) == 0 && Math.abs(accelY) == 0) {
				if (currentAnimationState == ANIMATION_STATE_LEFT) {
					setAnimationState(ANIMATION_STATE_STOP_LEFT);
				} else if (currentAnimationState == ANIMATION_STATE_RIGHT) {
					setAnimationState(ANIMATION_STATE_STOP_RIGHT);
				}
				if (currentAnimationState == ANIMATION_STATE_UP) {
					setAnimationState(ANIMATION_STATE_STOP_UP);
				} else if (currentAnimationState == ANIMATION_STATE_DOWN) {
					setAnimationState(ANIMATION_STATE_STOP_DOWN);
				}
			}
		}

		public function setAnimationState(animationState: Number) {
			if (animationState != currentAnimationState) {


				if (animationState == ANIMATION_STATE_RIGHT) {
					animateRight();
				} else if (animationState == ANIMATION_STATE_LEFT) {
					animateLeft();
				} else if (animationState == ANIMATION_STATE_STOP_LEFT) {
					animateStopLeft();
				} else if (animationState == ANIMATION_STATE_STOP_RIGHT) {
					animateStopRight();
				} else if (animationState == ANIMATION_STATE_STOP_UP) {
					animateStopUp();
				} else if (animationState == ANIMATION_STATE_STOP_DOWN) {
					animateStopDown();
				} else if (animationState == ANIMATION_STATE_UP) {
					animateUp();
				} else if (animationState == ANIMATION_STATE_DOWN) {
					animateDown();
				}

				currentAnimationState = animationState;
			}
		}

		public function animateRight() {
			gotoAndPlay(2);
			scaleX = baseScale;

		}

		public function animateLeft() {
			gotoAndPlay(2);
			scaleX = -baseScale;
		}

		public function animateStopRight() {
			gotoAndStop(0);
			scaleX = baseScale;
		}

		public function animateStopLeft() {
			gotoAndStop(0);
			scaleX = -baseScale;
		}

		public function animateStopUp() {

		}

		public function animateStopDown() {

		}

		public function animateUp() {

		}

		public function animateDown() {

		}

		public function setX(newX:Number) {
			x = newX;
			prevX = x;
			vx = 0;
			accelX = 0;
		}
		
		public function setY(newY:Number) {
			y = newY;
			prevY = y;
			vy = 0;
			accelY = 0;
		}

		public function keyDownHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = true;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = true;
			}

			if (e.keyCode == Keyboard.UP) {
				upArrowDown = true;
			}

			if (e.keyCode == Keyboard.DOWN) {
				downArrowDown = true;
			}

			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = true;
			}
		}

		public function keyUpHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = false;
			}

			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = false;
			}

			if (e.keyCode == Keyboard.UP) {
				upArrowDown = false;
			}

			if (e.keyCode == Keyboard.DOWN) {
				downArrowDown = false;
			}

			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = false;
			}
		}
		
		public function set baseScale(s:Number) {
			_baseScale = s;
			scaleX = scaleY = _baseScale;
		}
		
		public function get baseScale():Number {
			return _baseScale;
		}

	}

}
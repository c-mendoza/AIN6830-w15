package ain6830 {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {

		//Public Properties:

		public var accelerationX: Number = 0;
		public var accelerationY: Number = 0;
		public var frictionX: Number = 0.7;
		public var frictionY: Number = 0.7;
		public var _baseScale: Number = 1.5;


		//Keyboard variables:
		public var leftArrowDown: Boolean = false;
		public var rightArrowDown: Boolean = false;
		public var upArrowDown: Boolean = false;
		public var downArrowDown: Boolean = false;
		public var spacebarDown: Boolean = false;

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
		public var currentAnimationState: Number = -1;
		public var prevX: Number = 0;
		public var prevY: Number = 0;
		public var vx: Number = 0;
		public var vy: Number = 0;
		public var accelX: Number = 0;
		public var accelY: Number = 0;
		public var xPos: Number = 0;
		public var yPos: Number = 0;

		public var animationHolder: MovieClip;

		public function Player() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}

		function addedToStage(e: Event) {
			setAnimationState(ANIMATION_STATE_STOP_RIGHT);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			scaleX = baseScale;
			scaleY = baseScale;
		}

		function removedFromStage(e: Event) {

		}

		//You only need to call this function from the outside
		public function update() {

			processKeyboard();
			updatePosition();
			updateAnimationState();


		}

		//You'll want to override these functions in your
		//subclass:

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

		///////////INTERNALS
		//In most situations you won't need to call these functions yourself

		//Processes keyboard input
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

		//Updates the player's position
		public function updatePosition() {

			prevX = xPos;
			prevY = yPos;

			xPos = xPos + accelX + (frictionX * vx);
			yPos = yPos + accelY + (frictionY * vy);
			
			vx = xPos - prevX;
			vy = yPos - prevY;
			
			if (Math.abs(vx) < 0.1) {
				vx = 0;
				accelX = 0;
			}

			if (Math.abs(vy) < 0.1) {
				vy = 0;
				accelY = 0;
			}

			x = xPos;
			y = yPos;


			//trace("vx:", vx, "accelX:", accelX, "xpos:", xPos, "prevX:", prevX);


		}

		public function updateAnimationState() {
			if (Math.abs(accelX) > Math.abs(accelY)) {
				if (accelX > 0) {
					setAnimationState(ANIMATION_STATE_RIGHT);
				} else if (accelX < 0) {
					setAnimationState(ANIMATION_STATE_LEFT);
				} 
			} else if (Math.abs(accelX) < Math.abs(accelY)) {
				if (accelY > 0) {
					setAnimationState(ANIMATION_STATE_DOWN);
				} else if (accelY < 0) {
					setAnimationState(ANIMATION_STATE_UP);
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

		//Changes the current state of the character's animation
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

		public function swapAnimation(newAnimation: MovieClip) {
			removeChild(animationHolder);
			animationHolder = newAnimation;
			addChild(animationHolder);
			animationHolder.gotoAndPlay(1);
		}

		public function setX(newX: Number) {
			//prevX = newX + vx;
			prevX = newX;
			xPos = newX;
			vx = 0;
			x = xPos;
		}

		public function setY(newY: Number) {
			//prevY = newY + vy;
			prevY = newY;
			yPos = newY;
			vy = 0;
			y = yPos;
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

		public function set baseScale(s: Number) {
			_baseScale = s;
			scaleX = scaleY = _baseScale;
		}

		public function get baseScale(): Number {
			return _baseScale;
		}

	}

}
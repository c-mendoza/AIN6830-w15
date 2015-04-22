package ain6830 {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.engine.EastAsianJustifier;
	
	import fl.transitions.Transition;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	
	/**
	 * The Level class provides the basic behavior of a level. This class is not meant to be used directly,
	 * rather it is meant to be subclassed by your own levels, or be used by the Level subclasses provided to you in
	 * this package (PlatformLevel and TopDownLevel).
	 * 
	 * Your subclasses will likely override the update() function, which will let you
	 * attach custop behavior to your Level subclasses. update() is called in Level::enterFrame().
	 * The setup() function may be overriden to provide
	 * custom initialization instructions. The setup() function is called when the game is set
	 * While the enterFrame() function is public, you should not need to override it. 
	 * 
	 * Events:
	 * There are three types of events, all related to trigger areas:
	 * TRIGGER_AREA_ENTERED: Event fires when player first enters a trigger area.
	 * TRIGGER_AREA_ACTIVE: Event fires when player is in contact with the bounding box of a trigger area.
	 * TRIGGER_AREA_EXITED: Event fires when player leaves an active trigger area.
	 * 
	 * @author cmendoza
	 * 
	 * 
	 */
	public class Level extends MovieClip {
		public var levelName: String = "default";
		public var levelDescription: String = "none";
		public var scrollEnabled: Boolean = true;
		public var scrollsLeft: Boolean = true;
		public var scrollsRight: Boolean = true;
		public var scrollsUp: Boolean = true;
		public var scrollsDown: Boolean = true;
		public var limitTop: Boolean = true;
		public var limitBottom: Boolean = true;
		public var limitLeft: Boolean = true;
		public var limitRight: Boolean = true;
		public var xScrollTarget: Number = 0.3; //0 to 1. The amount of horizontal screen that the character moves before scrolling
		public var yScrollTarget: Number = 0.5; //0 to 1. The amount of vertical screen that the character moves before scrolling
		public var player: Player = null;
		
		
		public static var TRIGGER_AREA_ENTERED: String = "TRIGGER_AREA_ENTERED";
		public static var TRIGGER_AREA_EXITED: String = "TRIGGER_AREA_EXITED";
		public static var TRIGGER_AREA_ACTIVE: String = "TRIGGER_AREA_ACTIVE";
		private var triggerAreas: Array = new Array;
		private var triggerActions: Array = new Array;
		private var _game: Game = null;
		private var isInit: Boolean = false;
		private var _xScrollMaxSpeed: Number = 2; //Positive numbers only.
		private var _yScrollMaxSpeed: Number = 2; 
		private var playerPosGlobal:Point = new Point(0, 0);
		private var triggerAreasDead:Array = new Array; //Array holding the trigger areas that need to be removed
		private var _isPaused: Boolean = false;
		private var levelWidth:Number = 0;
		private var levelHeight:Number = 0;
		private var isUnloaded:Boolean = false;
		
		
		//add a pause feature
		
		public function Level() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		/**
		 * Event handler. If you want to add your own behaviors to addedToStage you may override it,
		 * but make sure to call the superclass implementation in your own classes. In other words, if
		 * you override this function, call super.addedToStage(e) in your override. 
		 * @param e
		 * @return 
		 * 
		 */		
		public function addedToStage(e: Event) {

			if (!isInit) {
				throw new Error("Level added to stage before setting the Game instance! Set the Game instance via the game property of the Level class. " + e.currentTarget);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
		}
		
		public function removedFromStage(e: Event) {
			isUnloaded = true;
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		/**
		 * Event handler. Override this function to listen to KEY_UP Events.
		 * Default implementation does nothing. 
		 * @param e
		 * @return 
		 * 
		 */		
		public function keyUp(e: KeyboardEvent) {}
		
		/**
		 * Event handler. Override this function to listen to KEY_DOWN Events. 
		 * Default implementation does nothing. 
		 * @param e
		 * @return 
		 * 
		 */		
		public function keyDown(e: KeyboardEvent) {}
		
		
		public function enterFrame(e: Event) {
			if(!isPaused) {
				playerPosGlobal = localToGlobal(new Point(game.player.x, game.player.y));
				
				update();
				updateScroll();
				checkLimits();
				
				var shouldContinue = false;
				
				for (var i = 0; i < triggerAreas.length; i++) {
					shouldContinue = false;
					for (var j = 0; j < triggerAreasDead.length; j++) {
						if(triggerAreas[i] == triggerAreasDead[j]) {
							triggerAreas.splice(i, 1);
							shouldContinue = true;
						}
					}
					
					if(shouldContinue) continue;
					
					if(isUnloaded) return;
					
					if (game.player.hitTestObject(triggerAreas[i])) {
						if(triggerAreas[i].isActive == false) {
							triggerAreas[i].isActive = true;
							triggerAreas[i].dispatchEvent(new Event(TRIGGER_AREA_ENTERED));
							triggerAreas[i].dispatchEvent(new Event(TRIGGER_AREA_ACTIVE));
						} else {
							triggerAreas[i].dispatchEvent(new Event(TRIGGER_AREA_ACTIVE));
						}
					} else {
						if(triggerAreas[i].isActive == true) {
							triggerAreas[i].isActive = false;
							triggerAreas[i].dispatchEvent(new Event(TRIGGER_AREA_EXITED));
						}
					}
				}
				

			}
			
		}
		
		/**
		 * Override this function to provide custom initialization behavior.
		 * This function is called after the game is set, typically via changing the currentLevel in Game.
		 * Default implementation does nothing. 
		 * @return 
		 * 
		 */		
		public function setup() {}
		
		/**
		 * Override this function to provide custom behavior en every frame. 
		 * Default implementation does nothing. 
		 * @return 
		 * 
		 */		
		public function update() {
			//trace("WARNING: Level:update() should be overriden!");
		}
		
//		public function tearDown() {
//			for
//		}
		/**
		 * Updates map scrolling. You should not have to call this function directly. 
		 * @return 
		 * 
		 */		
		public function updateScroll() {
			if(!scrollEnabled) return;
			
			//Player's position relative to the screen:
			//Screen position normalized (position as 0..1)
			var xScreenFraction = playerPosGlobal.x / stage.stageWidth;
			var xDirection = 1;
			var yDirection = 1;
			if (scrollsLeft || scrollsRight) {
				//Only do scrolling calculation if speed is not 0:
				if (Math.abs(game.player.vx) > 0) {
					//If we are going left, then invert the fraction and set the xDirection to -1. That will
					//be used to calculate whether we should invert the shift.
					
					if (game.player.vx < 0) {
						if(scrollsLeft) {
							xScreenFraction = 1 - xScreenFraction;
							xDirection = -1;
						} else { //If we are not scrolling in this direction, set the fraction to 0 to inhibit scrolling
							xScreenFraction = 0;
						}
					} else {
						if(!scrollsRight) {
							xScreenFraction = 0;
						}
					}
					
					//Limit scrolling to the "extents" of the level movie clip
					if (x <= 0 && x >= -levelWidth + stage.stageWidth) {
						//If the screen fraction is greater than the target, then we need to scroll
						if (xScreenFraction > xScrollTarget) {
							//This calculates the amount of scrolling we need to do. Since the fraction and the target are both 
							//"normalized", all we need to do is multiply their difference by stageWidth to get the amount of scrolling:
							var xShiftAmt = (xScreenFraction - xScrollTarget) * stage.stageWidth;
							//
							if (xShiftAmt > Math.abs(game.player.vx) + _xScrollMaxSpeed) xShiftAmt = Math.abs(game.player.vx) + _xScrollMaxSpeed;
							x -= xShiftAmt * xDirection;
							if (x > 0) x = 0;
							if (x < -levelWidth + stage.stageWidth) x = -levelWidth + stage.stageWidth;
						}
					}
				}
				
			}
			
			var yScreenFraction = playerPosGlobal.y / stage.stageHeight;
			
			if (scrollsUp||scrollsDown) {
				if (Math.abs(game.player.vy) > 0) {
					if (game.player.vy < 0) {
						if(scrollsUp) {
							yScreenFraction = 1 - yScreenFraction;
							yDirection = -1;
						} else {
							yScreenFraction = 0;
						}
					} else {
						if (!scrollsDown) {
							yScreenFraction = 0;
						}
					}
					
					if (y <= 0 && y >= -levelHeight + stage.stageHeight) {
						if (yScreenFraction > yScrollTarget) {
							var yShiftAmt = (yScreenFraction - yScrollTarget) * stage.stageHeight;
							if (yShiftAmt > Math.abs(game.player.vy) + _yScrollMaxSpeed) yShiftAmt = Math.abs(game.player.vy) + _yScrollMaxSpeed;
							y -= yShiftAmt * yDirection;
							if (y > 0) y = 0;
							if (y < -levelHeight + stage.stageHeight) y = -levelHeight + stage.stageHeight;
						}
					}
				}
				
			}
		}
		
		/**
		 * Moves the scrolling view to a particular x y coordinate of the Level.  
		 * @param xx The x-coordinate of the Level that you want to scroll to.
		 * @param yy The y-coordinate of the Level that you want to scroll to.
		 * @param animate Optional parameter. If true, performs an animation via the Tween class instead of immediately jumping to the coordinate.
		 * @param animationFunction The tweening animation to use.
		 * @param duration The animation duration, in seconds.
		 * @param animationCallback An optional function that will be called when the animation completes. The function should have no parameters and return nothing.
		 * <br><br>
		 * The scrolling will be limited to the width and height of the Level, so there shouldn't be a danger of
		 * placing the view somewhere unreachable.
		 * If <strong>animate</strong> is true, the Level's isPaused property will be set to true. Once the animation completes, isPaused reverts to false.
		 */
		public function scrollTo(xx:Number, yy:Number, animate:Boolean = false, animationFunction:Function = null, duration:Number = 1, animationCallback:Function = null):void {
			var toGlobalPos:Point = this.localToGlobal(new Point(xx, yy));
			
//			var toX = x + (-xx - x);
//			var toY = y + (-yy - y);
			
//			toX = Math.min(Math.max(-levelWidth + stage.stageWidth, toX), 0);
//			toY = Math.min(Math.max(-levelHeight + stage.stageHeight, toY), 0);
			
			var toX = x - (toGlobalPos.x - (game.gameWidth/2));
			var toY = y - (toGlobalPos.y -(game.gameHeight/2));
			
			toX = Math.min(Math.max(-levelWidth + game.gameWidth, toX), 0);
			toY = Math.min(Math.max(-levelHeight + game.gameHeight, toY), 0);
			
			if(animate) {
				if (animationFunction == null) animationFunction = Regular.easeOut;
				isPaused = true;
				var xTween:Tween = new Tween(this, "x", animationFunction, x, toX, duration, true);
				var yTween:Tween = new Tween(this, "y", animationFunction, y, toY, duration, true);
				
				xTween.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {
					isPaused = false;
					trace("end");
					if(animationCallback != null) {
						animationCallback();
					}
				});
					
			} else {
				x = toX;
				y = toY;
			}
		}

		/**
		 * Sets the scrolling capabilities of a level. 
		 * @param up Boolean. If true, scroll is enabled when player moves up.
		 * @param down Boolean. If true, scroll is enabled when player moves down.
		 * @param left Boolean. If true, scroll is enabled when player moves left.
		 * @param right Boolean. If true, scroll is enabled when player moves right.
		 * 
		 * You can change these capabilities during game play. For instance, upon reaching a "boss scene"
		 * you might want to turn scrolling off. Together with Level::setScreenLimitsPlayerMovement you'll
		 * be able to "trap" the player in the appropriate part of the map.
		 * 
		 */		
		public function setScrolling(up:Boolean, down:Boolean, left:Boolean, right:Boolean):void {
			scrollsDown = down;
			scrollsUp = up;
			scrollsLeft = left;
			scrollsRight = right;
		}
		
		/**
		 * Sets the behavior of the level if the player reaches the edge of the screen. 
		 * @param top If true, player is not allowed to move past top edge of the screen.
		 * @param bottom If true, player is not allowed to move past bottom edge of the screen.
		 * @param left If true, player is not allowed to move past left edge of the screen.
		 * @param right If true, player is not allowed to move past right edge of the screen.
		 * 
		 */		
		public function setScreenLimitsPlayerMovement(top:Boolean, bottom:Boolean, left:Boolean, right:Boolean):void {
			limitTop = top;
			limitBottom = bottom;
			limitLeft = left;
			limitRight = right;
		}
		
		/**
		 * Adds a trigger area to the Level. A trigger area is a DisplayObject that calls a function when the Player
		 * comes into contact with it. Trigger areas can be used to create hazards, exits, powerups, etc. 
		 * @param triggerArea
		 * @param action
		 * @return 
		 * 
		 */		
		public function addTriggerArea(triggerArea: DisplayObject) {
			triggerAreas.push(triggerArea);
			(triggerArea as Object).isActive = false; //Totally cheeky cast to avoid having to create a trigger area object 
		}
		
		/**
		 * Removes a trigger area from this Level. If the optional parameter removeFromDisplayList is true, it
		 * also removes the trigger area from the display list.
		 * @param triggerArea: The trigger area to remove.
		 * @param removeFromDisplayList If true, the trigger area is also removed from the display list.
		 * @return true if a trigger area was found and removed.
		 * 
		 */		
		public function removeTriggerArea(triggerArea: DisplayObject, removeFromDisplayList:Boolean = false):Boolean {
			for (var i = 0; i < triggerAreas.length; i++) {
				if(triggerAreas[i] == triggerArea) {
					triggerAreasDead.push(triggerArea);
					if(removeFromDisplayList) {
						removeChild(triggerArea);
					}
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Convenience function that loads the next level.
		 * @param nextLevel Level to load.
		 * @param playerX sets the x position of the Player in the level to be loaded.
		 * @param playerY sets the y position of the Player in the level to be loaded.
		 * @return nothing.
		 * 
		 */		
		public function loadNextLevel(nextLevel: Level, playerX: Number, playerY: Number):void {
			game.loadNextLevel(nextLevel, playerX, playerY);
		}
				
		/**
		 * Sets the current Game for the Level.
		 * Adds the Player as a child to this Level.
		 * Calls the Level's setup() function. 
		 */
		public function set game(g: Game) {
			_game = g;
			levelWidth = width;
			levelHeight = height;
			addChild(g.player);
			if(g.player.x > levelWidth) {
				g.player.setX(levelWidth - g.player.width);
			}
			if(g.player.y > levelHeight) {
				g.player.setX(levelHeight - g.player.height);
			}
			
			isInit = true;
			setup();
		}
		
		public function get game(): Game {
			return _game;
		}
		
		public function get yScrollMaxSpeed():Number
		{
			return _yScrollMaxSpeed;
		}
		
		/**
		 * Sets the maximum y-axis scroll speed. Positive numbers only.
		 */
		public function set yScrollMaxSpeed(value:Number):void
		{
			_yScrollMaxSpeed = Math.abs(value);
		}
		
		public function get xScrollMaxSpeed():Number
		{
			return _xScrollMaxSpeed;
		}
		/**
		 * Sets the maximum x-axis scroll speed. Positive numbers only.
		 */
		public function set xScrollMaxSpeed(value:Number):void
		{
			_xScrollMaxSpeed = Math.abs(value);
		}
		
		public function get isPaused():Boolean
		{
			return _isPaused;
		}
		
		public function set isPaused(value:Boolean):void
		{
			_isPaused = value;
			if(_isPaused) {
				game.player.animationHolder.stop();
			}
		}
		
		/////////////////////INTERNALS
		protected function checkLimits() {
			var hw:Number = game.player.width/2;
			var hh:Number = game.player.height/2;
			if(limitLeft) {
				if(playerPosGlobal.x < hw) {
					var dx = hw - playerPosGlobal.x;
					game.player.setX(game.player.x + dx);
				}
			}
			
			if(limitRight) {
				if(playerPosGlobal.x > stage.stageWidth - hw) {
					game.player.setX(game.player.x - ( playerPosGlobal.x-(stage.stageWidth-hw)));
				}
			}
			
			if(limitTop) {
				if(playerPosGlobal.y < hh) {
					var dy = hh - playerPosGlobal.y;
					game.player.setY(game.player.y + dy);
				}
			}
			
			if(limitBottom) {
				if(playerPosGlobal.y > stage.stageHeight - hh) {
					game.player.setY(game.player.y - ( playerPosGlobal.y-(stage.stageHeight - hh)));
				}
			}
		}
		
		
		
	}
}
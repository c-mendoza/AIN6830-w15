package ain6830 {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var levelName: String = "default";
		public var levelDescription: String = "none";
		public var xScrollEnabled: Boolean = true;
		public var yScrollEnabled: Boolean = true;
		public var xScrollTarget: Number = 0.3; //0 to 1. The amount of horizontal screen that the character moves before scrolling
		public var yScrollTarget: Number = 0.5; //0 to 1. The amount of vertical screen that the character moves before scrolling
		private var triggerAreas: Array = new Array;
		private var triggerActions: Array = new Array;
		public var player: Player = null;
		private var _game: Game = null;
		private var isInit: Boolean = false;
		private var _xScrollMaxSpeed: Number = 2; //Positive numbers only.
		private var _yScrollMaxSpeed: Number = 2; 
		
		public static var TRIGGER_AREA_ENTERED: String = "TRIGGER_AREA_ENTERED";
		
		
		public var isPaused: Boolean = false;

		//add a pause feature

		public function Level() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}

		public function addedToStage(e: Event) {
			if (!isInit) {
				throw new Error("Level added to stage before setting the Game instance! Set the Game instance via the game property of the Level class. " + e.currentTarget);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);

		}

		public function removedFromStage(e: Event) {
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}

		public function keyUp(e: KeyboardEvent) {}
		public function keyDown(e: KeyboardEvent) {}

		public function enterFrame(e: Event) {
			if(!isPaused) {
				update();
				updateScroll();
				for (var i = 0; i < triggerAreas.length; i++) {
					if (game.player.hitTestObject(triggerAreas[i])) {
						triggerAreas[i].dispatchEvent(new Event(TRIGGER_AREA_ENTERED));
						//triggerActions[i]();
					}
				}
			}

		}

		public function setup() {}

		/**
		 * Override this function to provide custom behavior en every frame. 
		 * @return 
		 * 
		 */		
		public function update() {
			//trace("WARNING: Level:update() should be overriden!");
		}

		public function updateScroll() {
			//Player's position relative to the screen:
			var playerPosGlobal: Point = localToGlobal(new Point(game.player.x, game.player.y));
			
			//Screen position normalized (position as 0..1)
			var xScreenFraction = playerPosGlobal.x / stage.stageWidth;
			var xDirection = 1;
			var yDirection = 1;
			if (xScrollEnabled) {
				//Only do scrolling calculation if speed is not 0:
				if (Math.abs(game.player.vx) > 0) {
					//If we are going left, then invert the fraction and set the xDirection to -1. That will
					//be used to calculate whether we should invert the shift
					if (game.player.vx < 0) {
						xScreenFraction = 1 - xScreenFraction;
						xDirection = -1;
					}
					//Limit scrolling to the "extents" of the level movie clip
					if (x <= 0 && x >= -width + stage.stageWidth) {
						//If the screen fraction is greater than the target, then we need to scroll
						if (xScreenFraction > xScrollTarget) {
							//This calculates the amount of scrolling we need to do. Since the fraction and the target are both 
							//"normalized", all we need to do is multiply their difference by stageWidth to get the amount of scrolling:
							var xShiftAmt = (xScreenFraction - xScrollTarget) * stage.stageWidth;
							//
							if (xShiftAmt > Math.abs(game.player.vx) + _xScrollMaxSpeed) xShiftAmt = Math.abs(game.player.vx) + _xScrollMaxSpeed;
							x -= xShiftAmt * xDirection;
							if (x > 0) x = 0;
							if (x < -width + stage.stageWidth) x = -width + stage.stageWidth;
						}
					}
				}

			}

			var yScreenFraction = playerPosGlobal.y / stage.stageHeight;
			
			if (yScrollEnabled) {
				if (Math.abs(game.player.vy) > 0) {
					if (game.player.vy < 0) {
						yScreenFraction = 1 - yScreenFraction;
						yDirection = -1;
					}

					if (y <= 0 && y >= -height + stage.stageHeight) {
						if (yScreenFraction > yScrollTarget) {
							var yShiftAmt = (yScreenFraction - yScrollTarget) * stage.stageHeight;
							if (yShiftAmt > Math.abs(game.player.vy) + _yScrollMaxSpeed) yShiftAmt = Math.abs(game.player.vy) + _yScrollMaxSpeed;
							y -= yShiftAmt * yDirection;
							if (y > 0) y = 0;
							if (y < -height + stage.stageHeight) y = -height + stage.stageHeight;
						}
					}
				}

			}
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
//			triggerArea.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event) {
//				//removeTriggerArea(triggerArea, false);
//			});

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
					triggerAreas.splice(i, 1);
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
			game.currentLevel = nextLevel;
			game.player.setX(playerX);
			game.player.setY(playerY);
		}
		
		////////GETTERS AND SETTERS
		
		/**
		 * Sets the current Game for the Level.
		 * Adds the Player as a child to this Level.
		 * Calls the Level's setup() function. 
		 */
		public function set game(g: Game) {
			_game = g;
			addChild(g.player);
			setup();
			isInit = true;
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
		


	}
}
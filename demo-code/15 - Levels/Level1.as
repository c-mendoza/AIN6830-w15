package {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import ain6830.GameTextDisplay;
	import ain6830.Level;
	import ain6830.PlatformLevel;
	
	import fl.motion.MotionEvent;
	import fl.motion.easing.Sine;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	import fl.transitions.easing.Strong;

	public class Level1 extends PlatformLevel {


		public function Level1() {
			// constructor code
			trace("Level 1 Constructor");
			
		}
		
		override public function keyUp(e:KeyboardEvent) {
			if(e.keyCode == Keyboard.P) {
				isPaused = !isPaused;
			}
		}

		override public function setup() {
			isPaused = true;
			xScrollTarget = 0.4;
			setScrolling(true, true, true, true);
			setScreenLimitsPlayerMovement(true, true, true, true);		

			
			game.createOption("HasLevel2DoorKey", false);
			game.createOption("FirstRun", true);

			
			if(game.getOption("HasLevel2DoorKey") == false) {
				addTriggerArea(key);
				key.addEventListener(Level.TRIGGER_AREA_ENTERED, keyHit);
			} else {
				key.visible = false;
			}
			
			addTriggerArea(exit);
			addTriggerArea(bla);
			bla.addEventListener(Level.TRIGGER_AREA_ENTERED, function(e:Event) {
				removePlatform(bla, true);
			});
			exit.addEventListener(Level.TRIGGER_AREA_ENTERED, exitHit);
			
			movePlatform();
			
			if(game.getOption("FirstRun") == true) {
				//Text Display:
				var textDisplay:GameTextDisplay = new TextDisplay;
				textDisplay.setTextSeparator("#");
				textDisplay.loadTextFile("texty.txt");	
				
				textDisplay.addEventListener(Event.COMPLETE, textDone);
				textDisplay.closeButton.addEventListener(MouseEvent.CLICK, closeClicked);
				game.addChild(textDisplay);
				
				textDisplay.x = game.gameWidth / 2;
				textDisplay.y = game.gameHeight / 2;
				
				game.setOption("FirstRun", false);
			} else {
				isPaused = false;
			}
			
		}
		
		function textDone(e:Event) {
			game.removeChild(e.currentTarget as DisplayObject);
			isPaused = false;
		}
		
		function closeClicked(e:MouseEvent) {
			game.removeChild(e.currentTarget.parent as DisplayObject);
			isPaused = false;
		}
		
		function movePlatform() {
			var t:Tween = new Tween(mover, "x", Sine.easeInOut, mover.x, mover.x + 100, 1, true);
			
			t.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {
				 var tt = new Tween(mover, "x", Sine.easeInOut, mover.x, mover.x - 100, 1, true);
//				 trace(mover);
				 tt.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {
					 movePlatform();
				 });
			});
		}
		
		override public function addedToStage(e:Event) { 
			super.addedToStage(e);
			this.addEventListener(MouseEvent.CLICK, mouseClicked);
			
		}
		
		function keyHit(e:Event) {
			game.setOption("HasLevel2DoorKey", true);
			//setScreenLimitsPlayerMovement(false, false, false, false);
			scrollTo(exit.x, exit.y, true, Regular.easeInOut, 2, animationEndHandler);
			key.visible = false;
			removeTriggerArea(key);
		}
		
		
		function animationEndHandler() {
			scrollTo(game.player.x - 100, game.player.y, true, Regular.easeInOut, 1);
			game.player.setX(game.player.x);
			game.player.setY(game.player.y);
		}
		
		function exitHit(e:Event) {
			loadNextLevel(new Level2, 82, 545);
		}
		
		function mouseClicked(e:MouseEvent) {
			var mc = new RedPlatform();
			var p:Point = this.globalToLocal(new Point(e.stageX, e.stageY));
			mc.width = 100;
			mc.height = 30;
			mc.x = p.x;
			mc.y = p.y;
			addChild(mc);
		}
	}

}
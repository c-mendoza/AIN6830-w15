﻿package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ain6830.Level;
	import ain6830.PlatformLevel;
	
	import fl.transitions.easing.*;

	public class Level1 extends PlatformLevel {


		public function Level1() {
			// constructor code
			trace("Level 1 Constructor");
			xScrollTarget = 0.4;
			isPaused = false;
			setScrolling(true, true, true, true);
			setScreenLimitsPlayerMovement(true, true, true, true);			
		}

		override public function setup() {
			game.createOption("HasLevel2DoorKey", false);

			
			if(game.getOption("HasLevel2DoorKey") == false) {
				addTriggerArea(key);
				key.addEventListener(Level.TRIGGER_AREA_ENTERED, keyHit);
			} else {
				key.visible = false;
			}
			
			addTriggerArea(exit);
			exit.addEventListener(Level.TRIGGER_AREA_ENTERED, exitHit);
			
			game.player.setX(800);
			game.player.setY(900);
		}
		
		override public function addedToStage(e:Event) { 
			super.addedToStage(e);
			this.addEventListener(MouseEvent.CLICK, mouseClicked);
			scrollTo(800, 900);
		}
		
		function keyHit(e:Event) {
			trace(e.type);
			game.setOption("HasLevel2DoorKey", true);
			//setScreenLimitsPlayerMovement(false, false, false, false);
			scrollTo(exit.x, exit.y, true, Regular.easeInOut, 2, animationEndHandler);
			
			key.visible = false;
			removeTriggerArea(key);
		}
		
		
		function animationEndHandler() {
			scrollTo(game.player.x - 100, game.player.y, true, Regular.easeInOut, 1);
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
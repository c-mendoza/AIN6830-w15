package {
	
	import flash.display.MovieClip;
	import flash.text.TextDisplayMode;
	import flash.ui.Keyboard;
	
	import ain6830.Game;
	import ain6830.GameTextDisplay;
	import ain6830.Level;
	import ain6830.PlatformPlayer;
	import ain6830.TopDownPlayer;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	public class DemoGame extends Game {
		
		
		
		public function DemoGame() {

			
		}
		
		override public function setup() {
			
			stage.focus = stage;
			
			var platformDemo = true;
			
			if(platformDemo) {
				var myPlayer:PlatformPlayer = new PlatformPlayer;
				myPlayer.animationRight = new LinkAnimationRight;
				myPlayer.animationUp = new LinkAnimationUp;
				myPlayer.animationDown = new LinkAnimationDown;
				myPlayer.animationStopDown = new LinkAnimationStopDown;
				myPlayer.animationStopUp = new LinkAnimationStopUp;
				myPlayer.animationStopRight = new LinkAnimationStopRight;
				myPlayer.animationJump = new LinkAnimationJump;
				
				
				myPlayer.baseScale = 2;
				myPlayer.frictionX = 0.1;
				myPlayer.accelerationX =  1.2;
				myPlayer.accelerationY = 1.2;
				myPlayer.jumpForce = -22;
				myPlayer.gravity = 0.7;
				
				player = myPlayer;
				
				loadNextLevel(new Level1, 200, 600);
			} else {
				var tdPlayer:TopDownPlayer = new TopDownPlayer;
				tdPlayer.animationRight = new LinkAnimationRight;
				tdPlayer.animationUp = new LinkAnimationUp;
				tdPlayer.animationDown = new LinkAnimationDown;
				tdPlayer.animationStopDown = new LinkAnimationStopDown;
				tdPlayer.animationStopUp = new LinkAnimationStopUp;
				tdPlayer.animationStopRight = new LinkAnimationStopRight;
				
				tdPlayer.baseScale = 2;
				tdPlayer.frictionX = 0.5;
				tdPlayer.accelerationX = tdPlayer.accelerationY =  1.2;
				tdPlayer.setX(200);
				tdPlayer.setY(200);
				
				player = tdPlayer;
				
				loadNextLevel(new Level0, 40, 40);
				
			}
		}
		
	}
	
}
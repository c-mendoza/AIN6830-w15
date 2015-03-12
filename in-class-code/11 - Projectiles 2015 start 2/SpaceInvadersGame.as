package {
	import flash.display.*;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	public class SpaceInvadersGame extends MovieClip {
		var player: MovieClip;
		var playerAccel: Number = 1; //Player acceleration
		var playerVx: Number; //Player x velocity

		var enemyVx: Number = 10;

		var enemyTimer: Timer;

		var enemies: Array = new Array;

		var leftArrowDown: Boolean = false;
		var rightArrowDown: Boolean = false;
		var spacebarDown: Boolean = false;
		
		var playerMissiles: Array = new Array;


		public function SpaceInvadersGame() { // constructor code 

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		function addedToStage(e: Event) {

			player = new Player();
			addChild(player);
			player.x = stage.stageWidth / 2;
			player.y = 340;
			playerVx = 0;


			for (var yCount = 0; yCount < 5; yCount++) {

				for (var xCount = 0; xCount < 10; xCount++) {
					var enemy;

					if (yCount % 2 == 0) {
						enemy = new Invader1;
					} else {
						enemy = new Invader2;
					}

					enemies.push(enemy);

					addChild(enemy);
					enemy.scaleX = 3;
					enemy.scaleY = 3;

					enemy.stop();

					var rowOffset = (stage.stageWidth - ((enemy.width + 10) * 10)) / 2;
					enemy.x = rowOffset + ((enemy.width + 10) * xCount);
					enemy.y = 30 + ((enemy.height + 20) * yCount);


				}


			}

			enemyTimer = new Timer(500);

			enemyTimer.addEventListener(TimerEvent.TIMER, enemyTimerFired);

			enemyTimer.start();

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);

			stage.focus = stage;

		}

		function enemyTimerFired(e: TimerEvent) {
			trace("timer!");

			var shouldChangeSpeeds: Boolean = false;

			for (var count = 0; count < enemies.length; count++) {
				var thisEnemy = enemies[count];
				thisEnemy.x += enemyVx;
				if (thisEnemy.x > (stage.stageWidth - thisEnemy.width) || thisEnemy.x < 0) {
					shouldChangeSpeeds = true;
				}

				if (thisEnemy.currentFrame == thisEnemy.totalFrames) {
					thisEnemy.gotoAndStop(1);
				} else {
					thisEnemy.gotoAndStop(thisEnemy.currentFrame + 1);
				}
				
			}

			if (shouldChangeSpeeds == true) {
				enemyVx *= -1;
				for (count = 0; count < enemies.length; count++) {
					thisEnemy = enemies[count];
					thisEnemy.y += 20;
				}
			}

		}

		//Function that handles firing a missile.
		function fireMissile() {
			var myProjectile:Projectile = new Projectile;
			
			addChild(myProjectile);
			
			myProjectile.x = player.x;
			myProjectile.y = player.y;
			
			playerMissiles.push(myProjectile);
		}


		function enterFrameHandler(e: Event) {


			//////////////////////////////////////////////
			//Update missiles and enemies //
			
			for (var i = 0; i < playerMissiles.length; i++) {
				
				var currentMissile:Projectile = playerMissiles[i]
				
				currentMissile.update();
				
				if (currentMissile
				
				
			}
			


			//////////////////////////////////////////////
			//Update timer //

			//??


			//////////////////////////////////////////////
			// Firing missiles //

			if (spacebarDown) {
				fireMissile();
			}

			//////////////////////////////////////////////
			// Player motion //

			if (rightArrowDown == true) {
				playerVx += playerAccel;
			}

			if (leftArrowDown == true) {
				playerVx -= playerAccel;
			}

			player.x += playerVx;
			player.x = Math.round(player.x);

			playerVx = playerVx * 0.5; //"Friction"

			if (Math.abs(playerVx) < 0.3) {
				playerVx = 0;
			}

			var pw2 = player.width / 2;
			if (player.x < pw2) {
				player.x = pw2;
			} else if (player.x > stage.stageWidth - pw2) {
				player.x = stage.stageWidth - pw2;
			}
		}


		function keyDownHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = true;
			}
			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = true;
			}
			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = true;
			}
		}

		function keyUpHandler(e: KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				leftArrowDown = false;
			}
			if (e.keyCode == Keyboard.RIGHT) {
				rightArrowDown = false;
			}
			if (e.keyCode == Keyboard.SPACE) {
				spacebarDown = false;
			}
		}
	}
}
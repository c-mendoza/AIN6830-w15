package {
	import flash.display.*;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import com.friendsofed.gameElements.effects.Explosion;

	public class SpaceInvadersGame extends MovieClip {
		var player: MovieClip;
		var playerAccel: Number = 1; //Player acceleration
		var playerVx: Number; //Player x velocity
		var playerMissiles: Array = new Array;
		var enemyVx: Number = 10;
		var enemies: Array = new Array;
		var enemyMissiles: Array = new Array;
		var maxEnemyMissiles: Number = 2;
		var enemyFireTimer: Timer = new Timer(500); //Let's make it interesting...
		var enemyMoveTimer: Timer = new Timer(500);

		//Keyboard-related variables:
		var leftArrowDown: Boolean = false;
		var rightArrowDown: Boolean = false;
		var spacebarDown: Boolean = false;

		public function SpaceInvadersGame() { // constructor code 
			//Just this:
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		//This will essentially be our "setup" function.
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
					enemy.scaleX = 2.5;
					enemy.scaleY = 2.5;
					enemy.stop();

					var spacing = 40;

					var rowOffset = (stage.stageWidth - (spacing * 10)) / 2;
					enemy.x = rowOffset + (spacing * xCount);
					enemy.y = 30 + (30 * yCount);
				}
			}

			enemyMoveTimer.addEventListener(TimerEvent.TIMER, enemyMoveTimerFired);
			enemyMoveTimer.start();

			enemyFireTimer.addEventListener(TimerEvent.TIMER, enemyFireTimerFired);
			enemyFireTimer.start();

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.focus = stage;
		}

		//Handler for the timer that tells us when the enemies should move
		function enemyMoveTimerFired(e: TimerEvent) {

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

		//Handler for the timer that tells us when the enemies shoot!
		function enemyFireTimerFired(e: TimerEvent) {

			//If there are less missiles than the max, then add more:
			if (enemyMissiles.length < maxEnemyMissiles) {
				//This gets us a random number between 0 and up to 1 - enemies.length
				var index = Math.floor(Math.random() * enemies.length);

				var enMissile: Projectile = new Projectile;
				enMissile.vy = 3;
				enMissile.x = enemies[index].x + enemies[index].width / 2;
				enMissile.y = enemies[index].y + enemies[index].height / 2;
				addChild(enMissile);
				enemyMissiles.push(enMissile);
			}
		}

		//Function that handles firing a missile.
		function fireMissile() {

			if (playerMissiles.length < 2) {
				var myProjectile: Projectile = new Projectile;

				addChild(myProjectile);

				myProjectile.x = player.x;
				myProjectile.y = player.y;

				playerMissiles.push(myProjectile);
			}
		}


		function enterFrameHandler(e: Event) {


			//////////////////////////////////////////////
			//Update player missiles and enemies //

			for (var i = 0; i < playerMissiles.length; i++) {

				var currentMissile: Projectile = playerMissiles[i];
				currentMissile.update();

				if (currentMissile.y < -currentMissile.height / 2) {

					removeChild(currentMissile);
					playerMissiles.splice(i, 1);

				} else {

					for (var j = 0; j < enemies.length; j++) {

						var currentEnemy: MovieClip = enemies[j];

						if (currentMissile.hitTestObject(currentEnemy) == true) {

							removeChild(currentMissile);
							removeChild(currentEnemy);
							playerMissiles.splice(i, 1);
							enemies.splice(j, 1);

							var exp: Explosion = new Explosion;
							exp.x = currentEnemy.x + (currentEnemy.width / 2);
							exp.y = currentEnemy.y + (currentEnemy.height / 2);
							exp.scaleX = exp.scaleY = 1.5;
							addChild(exp);
						}
					}
				}
			}

			//////////////////////////////////////////////
			//Update enemy missiles //

			for (i = 0; i < enemyMissiles.length; i++) {

				currentMissile = enemyMissiles[i];
				currentMissile.update();

				if (currentMissile.y > stage.stageHeight + (currentMissile.height / 2)) {
					removeChild(currentMissile);
					enemyMissiles.splice(i, 1);

				} else {

					if (currentMissile.hitTestObject(player)) {
						trace("PLAYER HIT!");   //perhaps you should do something about this...
						removeChild(currentMissile);
						enemyMissiles.splice(i, 1);
					}
				}
			}




			//////////////////////////////////////////////
			//Update timer //

			//Can you make the enemies speed up as their numbers dwindle?


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
				fireMissile();
			}
		}
	}
}
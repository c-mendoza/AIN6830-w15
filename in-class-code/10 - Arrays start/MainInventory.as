package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;


	public class MainInventory extends MovieClip {

		var inventory: Array = new Array;
		var inventoryX: Number;
		var inventoryY: Number;

		var vx;
		var vy;
		var accel: Number = 1.5;

		var leftArrowDown: Boolean;
		var rightArrowDown: Boolean;
		var upArrowDown: Boolean;
		var downArrowDown: Boolean;

		var fruitToCheck: Array = new Array;

		public function MainInventory() {
			trace("MainInventory");

			trace(theBanana);

			inventoryX = 115;
			inventoryY = 35;

			vx = 0;
			vy = 0;

			leftArrowDown = false;
			rightArrowDown = false;
			upArrowDown = false;
			downArrowDown = false;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);



		}

		function enterFrameHandler(e: Event) {

			//Check if the player collides with
			//the fruit in fruitToCheck
			for (var i = 0; i < fruitToCheck.length; i++) {
				if (fruitToCheck[i].hitTestObject(player)) {
					trace("boom");
					addToInventory(fruitToCheck[i]);
					fruitToCheck.splice(i, 1);
					i--;
				}
			}


			//Update the velocity depending on whether an arrow is pressed:
			if (rightArrowDown == true) {
				vx += accel;
			}

			if (leftArrowDown == true) {
				vx -= accel;
			}

			if (upArrowDown) {
				vy -= accel;
			}

			if (downArrowDown) {
				vy += accel;
			}

			player.x += vx;
			player.y += vy;
			vx *= 0.9;
			vy *= 0.9;

			if (player.x < 0) {
				player.x = 0;
			} else if (player.x > stage.stageWidth) {
				player.x = stage.stageWidth;

			}
		}

		function addFruitToCheck(item: MovieClip) {
			fruitToCheck.push(item);
		}

		public function addToInventory(item: MovieClip) {
			//1: Calculate the x coordinate by adding all of the widths
			//of every item in the inventory

			var sumWidths = 0;

			for (var counter = 0; counter < inventory.length; counter++) {
				var currentItem: MovieClip = inventory[counter];
				sumWidths = sumWidths + currentItem.width;
			}

			item.x = inventoryX + sumWidths;
			item.y = inventoryY;

			item.isInInventory = true;

			inventory.push(item);


		}

		public function removeFromInventory(item: MovieClip) {

			for (var i = 0; i < inventory.length; i++) {

				if (inventory[i] == item) {
					trace("found it at index", i);
					break;
				}

			}


			trace(inventory);

			inventory.splice(i, 1);

			trace(inventory);

			item.x = Math.random() * stage.stageWidth;

			item.y = inventoryY + (Math.random() * (stage.stageHeight - inventoryY));

			item.isInInventory = false;

			for (var j = i; j < inventory.length; j++) {
				var thisItem: MovieClip = inventory[j];
				thisItem.x = thisItem.x - item.width;
			}

			fruitToCheck.push(item);

		}

		function keyDownHandler(e: KeyboardEvent) {

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
		}


		function keyUpHandler(e: KeyboardEvent) {


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

		}
	}

}
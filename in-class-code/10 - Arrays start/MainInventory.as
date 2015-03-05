package  {
	
	import flash.display.MovieClip;
	
	
	public class MainInventory extends MovieClip {
		
		var inventory: Array;
		var inventoryX: Number;
		var inventoryY: Number;
			
		
		public function MainInventory() {
			trace("MainInventory");
			inventory = new Array;
			
			trace(theBanana);
			
			inventoryX = 115;
			inventoryY = 35;
			
			addToInventory(theBanana);
			addToInventory(otherCherry);
			addToInventory(theCherry);
			addToInventory(greenLemon);
			addToInventory(yellowLime);
			
			removeFromInventory(theCherry);
			
			
		}
		
		public function addToInventory(item:MovieClip) {
			//1: Calculate the x coordinate by adding all of the widths
			//of every item in the inventory
				
			var sumWidths = 0;
			
			for (var counter = 0; counter < inventory.length; counter++) {
				var currentItem:MovieClip = inventory[counter]; 
				sumWidths = sumWidths + currentItem.width;
			}
			
			item.x = inventoryX + sumWidths;
			item.y = inventoryY;
			
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
			
			
			for(var j = i; j < inventory.length; j++) {
				var thisItem:MovieClip = inventory[j];
				thisItem.x = thisItem.x - item.width;
			}
			
			
		}
	}
	
}

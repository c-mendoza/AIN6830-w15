package  {
	
	import flash.display.MovieClip;
	
	
	public class MainInventory extends MovieClip {
		
		var inventory:Array;
		var inventoryX;
		var inventoryY;
		
		public function MainInventory() {
			// constructor code
			
			inventory = new Array();
			inventoryX = 110;
			inventoryY = 33;
		}
		
		function addInventoryItem(item:InventoryItem) {
			
			
			var theX = inventoryX;
			
			for (var count = 0; count < inventory.length; count++) {
				theX = theX + inventory[count].width;
			}
			inventory.push(item);
			item.x = theX + (item.width / 2);
			item.y = inventoryY;
			
		}
		
		function removeInventoryItem(item:InventoryItem) {
				
			var theIndex = -1;
			
			for (var count = 0; count < inventory.length; count++) {
				if (inventory[count] == item) {
					theIndex = count;
					break;
				}
			}
			
			if(theIndex < 0) {
				trace("I couldn't find that item!");
				return;
			}
			
			inventory.splice(theIndex, 1);
			trace(inventory);
			
			for (count = theIndex; count < inventory.length; count++) {
				inventory[count].x = inventory[count].x - item.width;
			}
		}
		
		function inventoryItemClicked(item:InventoryItem) {
			
			if(item.inInventory == false) {
				item.xBefore = item.x;
				item.yBefore = item.y;
				addInventoryItem(item);
				item.inInventory = true;
			} else {
				removeInventoryItem(item);
				item.inInventory = false;
				item.x = item.xBefore;
				item.y = item.yBefore;
			}
		}
	}
	
}

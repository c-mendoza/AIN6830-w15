package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class InventoryItem extends MovieClip {
		
		var isInInventory:Boolean = false;
		
		public function InventoryItem() {
			// constructor code
			
			addEventListener(MouseEvent.CLICK, onClicked);
		}
		
		public function onClicked(e:MouseEvent) {
			trace("Clicked!");
			
			var mainInventory:MainInventory = parent as MainInventory;			
			
			if(isInInventory == false) {
				mainInventory.addToInventory(this);
			} else {
				mainInventory.removeFromInventory(this);
			}
			
			
		}
	}
	
}

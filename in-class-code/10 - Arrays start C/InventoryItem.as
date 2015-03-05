package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class InventoryItem extends MovieClip {
		
		var inInventory:Boolean;
		var xBefore:Number;
		var yBefore:Number;
		
		public function InventoryItem() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			inInventory = false;
		}
		
		function addedToStage(e:Event) {
			addEventListener(MouseEvent.CLICK, clicked);
		}
		
		function clicked(e:MouseEvent) {

			var inventory =  this.parent as MainInventory;

			inventory.inventoryItemClicked(this);
		}
	}
	
}

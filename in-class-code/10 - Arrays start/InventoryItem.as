package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class InventoryItem extends MovieClip {

		var isInInventory: Boolean = false;

		public function InventoryItem() {
			// constructor code

			addEventListener(MouseEvent.CLICK, onClicked);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		function addedToStage(e: Event) {
			trace("added to stage", parent);
			var mainInventory: MainInventory = parent as MainInventory;
			mainInventory.addFruitToCheck(this);
		}
		
		public function onClicked(e: MouseEvent) {
			trace("Clicked!");

			var mainInventory: MainInventory = parent as MainInventory;

			if (isInInventory == false) {
				mainInventory.addToInventory(this);
			} else {
				mainInventory.removeFromInventory(this);
			}


		}
	}

}
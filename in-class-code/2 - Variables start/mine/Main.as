package mine {

	import flash.display.MovieClip;
	import flash.events.*;

	public class Main extends MovieClip {

		var myMoney = 100;
		var sandwichCost = 6;
		var megaSandwichCost = 17;
		public function Main() {
			// constructor code
			trace("Sandwiches RULE!");
			sandwichButton.addEventListener(MouseEvent.CLICK, sandwichButtonHandler);
			
			megaButton.addEventListener(MouseEvent.CLICK, function(e) {
				trace("megaSandwich Button clicked!");
				myMoney = myMoney - megaSandwichCost;
				trace("I have $" + myMoney);
			});

		}

		function sandwichButtonHandler(e) {
			trace("Sandwich Button clicked!");
			trace("I have $" + myMoney);
		}
	}

}
package  {
	
	import flash.display.MovieClip;
	
	
	public class MainDemoVariables extends MovieClip {
		
		
		public function MainDemoVariables() {
			// constructor code
			trace("Demo Variables");
			
			/*var myFirstVariable;
			
			myFirstVariable = 5;
			
			trace(myFirstVariable);
			
			myFirstVariable = 8;
			
			trace(myFirstVariable);*/
			
			var myMoney = 22;
			var sandwichCost = 1;
			var nFriends = 20;
			
			trace("I have $" + myMoney);
			
			trace("I bought a sandwich that cost me $" + sandwichCost);
			
			myMoney = myMoney - sandwichCost;
			
			trace("I have $" + myMoney);
			
			//I now buy sandwiches for my friends
				
			trace("I bought " + nFriends + " sandwiches for my friends");
			
			myMoney = myMoney - (sandwichCost * nFriends);
			
			trace("I have $" + myMoney);
		}
	}
	
}







package  {
	
	import flash.display.MovieClip;
	
	
	public class MainArrays extends MovieClip {

		var myArray: Array;

		
		public function MainArrays() {
			// constructor code
			
			myArray = new Array;
			
			myArray.push("Pear"); //0
			
			trace(myArray);
			
			myArray.push("Apple"); //1
			myArray.push("Banana"); //2
			myArray.push("Strawberry");
			myArray.push("Orange");
			trace(myArray);
			
			
		
			trace(myArray[2]);
			
			myArray[2] = "Plantain";
			
			trace(myArray);
			trace(myArray.length);
			
			myArray.push("Watermelon");
			trace(myArray);
			trace(myArray.length);
			
			for(var counter = 0; counter < myArray.length; counter++) {
				trace("In item", counter, "we have:", myArray[counter]);
			}
			
			myArray.splice(2, 0, "Raspberry", "Kiwi");
			
			trace(myArray);
			
			
		}
	}
	
}

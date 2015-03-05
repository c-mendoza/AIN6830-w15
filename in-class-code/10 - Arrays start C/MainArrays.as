package {

	import flash.display.MovieClip;


	public class MainArrays extends MovieClip {

		var myArray: Array;

		public function MainArrays() {
			// constructor code

			myArray = new Array;


			myArray.push("Banana");
			myArray.push("Orange");
			myArray.push("Strawberry");
			myArray.push("Raspberry");


			trace(myArray[4]);
			
			for(var count = 0; count < myArray.length; count++) {
				trace("In cell", count, "we have", myArray[count]);
			}


		}
	}

}
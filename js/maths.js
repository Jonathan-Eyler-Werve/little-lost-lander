// A tiny library of math functions useful in 2D games. 

// WORK IN PROGRESS, NEEDS TEST COVERAGE 

function toRadians(degrees){
  return degrees * (Math.PI / 180)
};

function toDegrees(radians){
  return radians / (Math.PI / 180)
};

function toI(number){
	return Math.round(number)
}

function updateRandom(collection, propertyNameAsString)
	console.log("Updating random factors for collection", collection, "on property", propertyNameAsString)
	for (var i = 0; i < collection.length; i++) {
    if (collection[i] != undefined) {
      collection[i][propertyNameAsString] = toI( (Math.random() * 10) + 1 );
   };  
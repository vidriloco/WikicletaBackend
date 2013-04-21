/**
  *  Some common variables and functions
 **/
var parentDom = '#contents-area ';
var Routing = {};

var rootSelected = function() {
	$('.activities .actions li#home').addClass('active');
}
var drawSelectedItems = function(objects, url_function) {
	map.resetMarkersList();
	for(idx = 0 ; idx<objects.length ; idx++) {
		var lat = parseFloat($(objects[idx]).attr('data-lat'));
		var lon = parseFloat($(objects[idx]).attr('data-lon'));
		var kind = $(objects[idx]).attr('data-kind');
		var idD = $(objects[idx]).attr('id');

		map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(urlID) {
			url_function($(parentDom+'.listing-view #'+urlID), urlID);
		});
	}
}

var initializeMap = function() {
	if($.isDefined('#map')) {
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
	}
}
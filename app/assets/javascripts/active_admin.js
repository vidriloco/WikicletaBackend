//= require active_admin/base
//= require view_components/map.view


$(document).ready(function() {	
	var map = null;
	
	if($.isDefined('#map')) {
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {coordinatesDom: "#sticker"});
		
		if($('#map').hasClass('edit')) {
			map.setEditable(true);
			map.setCoordinatesFromDom("#sticker");
		}
		
		if($('#map').hasClass('show-only')) {
			map.simulatePinPoint($('#sticker').attr('lat'), $('#sticker').attr('lon'), 18);
		}
	} 
});
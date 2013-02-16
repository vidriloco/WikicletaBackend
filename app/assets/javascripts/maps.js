//= require common/base
//= require map_component
//= require geoposition

var map = null;
$(document).ready(function(){
	if($.isDefined('#map')) {
		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {coordinatesDom: "#property"});
		
		$('.bar-activator').bind('click', function() {
			$('.bar-activator').parent().removeClass('active');
			$(this).parent().addClass('active');
			$('.section-view').hide();
			
			if($(this).hasClass('map')) {
				$('div.map').fadeIn();
			} else if($(this).hasClass('layers')) {
				$('div.layers').fadeIn();
			}
		});
	}
	
	// Attempt to center map on location
	
	if (geoPosition.init()) {
	  geoPosition.getCurrentPosition(function(p) {
			var lat = p.coords.latitude;
			var lon = p.coords.longitude;
			map.addMarkerYourLocation({ lat: lat, lon: lon });
			map.placeViewportAt({ lat: lat, lon: lon, zoom: defaultMiddleZoom });

			}, null);
	}
});
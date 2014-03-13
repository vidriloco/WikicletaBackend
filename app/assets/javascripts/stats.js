var map = null;
var infowindow = null;

$(document).ready(function() {

	if($.isDefined('.stats')) {		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});

		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
			registerTrackWith('On Locate-me selected');
			if (geoPosition.init()) {
				$('.spinner').fadeIn();
			  geoPosition.getCurrentPosition(function(p) {
					var lat = p.coords.latitude;
					var lon = p.coords.longitude;
					map.addMarkerYourLocation({ lat: lat, lon: lon });
					map.placeViewportAt({ lat: lat, lon: lon-0.01, zoom: defaultMiddleZoom });
					$('.spinner').hide();
				}, null);
			}
		});
		
		$('.minimize-view').click(function() {
			$('.inner-panel').fadeOut();
			$('.maximize-view').fadeIn();
			$('.minimize-view').hide();
			$('.activity').show();
		});

		$('.maximize-view').click(function() {
			$('.inner-panel').fadeIn();
			$('.minimize-view').fadeIn();
			$('.maximize-view').hide();
			$('.activity').hide();
		});

		$('.maximize-view').click();
	}
});
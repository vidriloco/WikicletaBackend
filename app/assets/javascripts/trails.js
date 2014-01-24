var map = null;
var infowindow = null;

$(document).ready(function() {

	if($.isDefined('.trails')) {		
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
		
		var trails = $('#trail-list div.trail');
		
		var coords = [];
		var markers = [];
		
		for(var idx in trails) {
			if(idx == trails.length-1) {
				break;
			}
			var trailId = $(trails[idx]).attr('id');
			if($.isDefined('#'+trailId)) {
				var trail = $('#'+trailId);
				
				var lat = parseFloat($(trail).attr('data-lat'));
				var lng = parseFloat($(trail).attr('data-lon'));
				coords.push(new google.maps.LatLng(lat, lng));
				marker = map.addCoordinatesAsMarkerToList({ lat: lat, lon: lng, iconName: 'timing-marker', resourceUrl: '#'+trailId }, function(opts) {
					var contentString = $(opts.resourceUrl).html();
					if(infowindow != null) {
						infowindow.close();
					}
				  infowindow = new google.maps.InfoWindow({
				      content: contentString
				  });
					
					infowindow.open(map.gMap, opts.marker);
				});
				markers.push(marker);
				
			}
		}
		
		var path = new google.maps.Polyline({
		    path: coords,
		    strokeColor: '#29c505',
		    strokeWeight: 4
		  });
		path.setMap(map.gMap);
		map.placeViewportAt({ lat: parseFloat(coords[0].lat()), lon: parseFloat(coords[0].lng()), zoom: 17 });
	}
	
});
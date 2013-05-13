//= require common/base
//= require view_components/map.view
//= require geoposition

var map = null;
var activeInfoWindow = null;

$(document).ready(function() {
	if($.isDefined('#map')) {

		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
		
		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
			if (geoPosition.init()) {
			  geoPosition.getCurrentPosition(function(p) {
					var lat = p.coords.latitude;
					var lon = p.coords.longitude;
					map.addMarkerYourLocation({ lat: lat, lon: lon });
					map.placeViewportAt({ lat: lat, lon: lon, zoom: defaultMiddleZoom });
				}, null);
			}
		});


		if($.isDefined('.trip-paths')) {
			var segments = $('.trip-paths').children();
			var firstCoord = null;
		
			for(var segmentIdx = 0 ; segmentIdx < segments.length ; segmentIdx++) {
				var colour = $(segments[segmentIdx]).attr('data-colour');
				var points = $(segments[segmentIdx]).attr('data-path').split(' ');
				
				var coordinates = [];
				for(var pointIdx = 0; pointIdx < points.length ; pointIdx++) {
					var coords = points[pointIdx].split('|');
					var lat = coords[0];
					var lon = coords[1];
				
					if(firstCoord == null) {
						firstCoord = [lat, lon];
					}
				
					coordinates.push(new google.maps.LatLng(lat, lon));
				}
			
				var path = new google.maps.Polyline({
				    path: coordinates,
				    strokeColor: colour,
				    strokeOpacity: 0.7,
				    strokeWeight: 3
				  });
				path.setMap(map.gMap);
			
			}
			map.placeViewportAt({ lat: parseFloat(firstCoord[0]), lon: parseFloat(firstCoord[1]), zoom: 17 });
		}
		
		var connectInfoWindow = function(marker, title, details) {
			google.maps.event.addListener(marker, 'click', function() {
				var contentString = null;
				
				if(details != null) {
					contentString = '<div><p class="title">'+title+'</p><p class="details">'+details+'</p></div>';
				} else {
					contentString = '<div><p class="title">'+title+'</p></div>';
				}

				if(activeInfoWindow != null) {
					activeInfoWindow.close();
				}
				
				activeInfoWindow = new google.maps.InfoWindow({
				    content: contentString,
				    maxWidth: 200
				});
				
			  activeInfoWindow.open(map.gMap,marker);
			});
		}
		
		if($.isDefined('.trip-pois')) {
			
			$('#start').bind('click', function() {
				var start = $('.trip-pois').children('.start_flag')[0];
				map.placeViewportAt({ lat: $(start).attr('data-lat'), lon: $(start).attr('data-lon'), zoom: 20 });
			});
			
			$('#finish').bind('click', function() {
				var finish = $('.trip-pois').children('.finish_flag')[0];
				map.placeViewportAt({ lat: $(finish).attr('data-lat'), lon: $(finish).attr('data-lon'), zoom: 20 });
			});
			
			var pois = $('.trip-pois').children('.trip-poi');
			for(var poiIdx = 0 ; poiIdx < pois.length ; poiIdx++) {
				var poi = pois[poiIdx];
				var kind = $(poi).attr('class').split(' ')[0];
				
				if(kind=="transport_connection") {
					kind = $(poi).attr('data-icon');
				}
				
				var coords = new google.maps.LatLng($(poi).attr('data-lat'), $(poi).attr('data-lon'));
				var details = $(poi).attr('data-details');
				var title = $(poi).attr('data-title');
				
				var marker = new google.maps.Marker({
					position: coords,
					map: map.gMap,
					icon: $.assetsURL() + kind + '.png',
					title: title
				});
				
				connectInfoWindow(marker, title, details);
			}

		}
	}
});
//= require common/base
//= require view_components/map.view
//= require geoposition
//= require polyline.edit

var map = null;
var sectionValue = null;
var routeTraced = false;

$(document).ready(function() {			
	if($.isDefined('#map')) {
		mapOptions = {
			center: new google.maps.LatLng(parseFloat(defaultLat), parseFloat(defaultLon)),
			zoom: defaultZoom,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			streetViewControl: true,
			mapTypeControl: false,
			navigationControl: true,
			panControl: false,
			overviewMapControl: false,
			streetViewControlOptions: {
				position: google.maps.ControlPosition.TOP_RIGHT
			},
			zoomControlOptions: { position: google.maps.ControlPosition.TOP_RIGHT, style: google.maps.ZoomControlStyle.SMALL }
		};

		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
		
		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
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
		
		var initializePath = function(coordinates, firstCoord) {
			var path = new google.maps.Polyline({
			    path: coordinates,
			    strokeColor: 'black',
			    strokeWeight: 3
			  });
			path.setMap(map.gMap);

			map.placeViewportAt({ lat: parseFloat(firstCoord[0]), lon: parseFloat(firstCoord[1]), zoom: 17 });
			
			if($.isDefined('.edit-mode')) {
				path.edit();
			}
			
			var updatePathField = function(index, position) {
				var newPoints = path.getPath();
				var pointsList = "";
				var coords = [];
				var polylineLength = 0;
				
				for(var pointIdx = 0; pointIdx < newPoints.length ; pointIdx++) {
					var lat = newPoints.getAt(pointIdx).lat();
					var lng = newPoints.getAt(pointIdx).lng();
					var pointPath = new google.maps.LatLng(lat,lng);
					pointsList+=lng+" "+lat+",";
					
				  coords.push(pointPath);
				  if (pointIdx > 0) polylineLength += google.maps.geometry.spherical.computeDistanceBetween(coords[pointIdx], coords[pointIdx-1]);
				}
				
				$('#route_kilometers').val(polylineLength*0.001);
				$('#path').val(pointsList.substring(0, pointsList.length-1));
			}
			
			google.maps.event.addListener(path, 'update_at', updatePathField);
			google.maps.event.addListener(path, 'insert_at', updatePathField);
			google.maps.event.addListener(path, 'remove_at', updatePathField);
			
			updatePathField(null, null);
		}
		
		var coordinates = [];
		var firstCoord = null;
		
		if($.isDefined('.path') && $('.path').attr('data-path') != '') {
			var points = $('.path').attr('data-path').split(' ');

			for(var pointIdx = 0; pointIdx < points.length ; pointIdx++) {
				var coords = points[pointIdx].split('|');
				var lat = coords[0];
				var lon = coords[1];

				if(firstCoord == null) {
					firstCoord = [lat, lon];
				}

				coordinates.push(new google.maps.LatLng(lat, lon));
			}
			initializePath(coordinates, firstCoord);
		} 
		
		google.maps.event.addListener(map.gMap, 'click', function(event) {
			if($('#path').val() == '') {
				coordinates.push(event.latLng);
				coordinates.push(new google.maps.LatLng(event.latLng.lat()+0.0002, event.latLng.lng()+0.0002));
				initializePath(coordinates, [event.latLng.lat(), event.latLng.lng()]);
			}
			return false;
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
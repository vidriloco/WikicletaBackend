//= require common/base
//= require view_components/map.view
//= require geoposition
//= require polyline.edit

var map = null;
var sectionValue = null;

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

		if($.isDefined('.path')) {
			var points = $('.path').attr('data-path').split(' ');
			var firstCoord = null;

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
			    strokeColor: 'black',
			    strokeWeight: 3
			  });
			path.setMap(map.gMap);

			map.placeViewportAt({ lat: parseFloat(firstCoord[0]), lon: parseFloat(firstCoord[1]), zoom: 17 });
			
			if($.isDefined('.edit-mode')) {
				$('.maximize-view').fadeOut();
				$('.activity').hide();
				path.edit();
			}
			
			var updatePathField = function(index, position) {
				var newPoints = path.getPath();
				var pointsList = "";
				for(var pointIdx = 0; pointIdx < newPoints.length ; pointIdx++) {
					pointsList+=newPoints.getAt(pointIdx).lng()+" "+newPoints.getAt(pointIdx).lat()+",";
				}
				
				$('#path').val(pointsList.substring(0, pointsList.length-1));
			}
			
			google.maps.event.addListener(path, 'update_at', updatePathField);
			google.maps.event.addListener(path, 'insert_at', updatePathField);
			google.maps.event.addListener(path, 'remove_at', updatePathField);
		}
		
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
		
	}
});
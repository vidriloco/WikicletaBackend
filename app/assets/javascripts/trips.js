$(document).ready(function() {
	Trips = function() {
		var activeInfoWindow = null;
		var thisInstance = null;
		var paths = null;
		var markersOnPath = null;
		
		var initialize = function() {
			thisInstance = this;
			map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});
			return this;
		}

		this.onIndex = function() {
			currentlyOnIndex = true;
			$('.call-to-action').addClass('hidden');
			$('.trip-wrap').fadeIn();
			clearPath();				
			clearPOIs();	
			$('.listing-actions').hide();
			loadTripsOnMap();
		}

		this.onTripSelected = function() {
			var item = this.params['item'];
			var instance = thisInstance;
			
			$('.call-to-action').removeClass('hidden');
			$('.trip-wrap').fadeOut();
			$('#'+item).fadeIn();
			$('#'+item+' .extras').fadeIn();
			$('#'+item).addClass('with-focus');
			loadTripDetails(item);

			var location = new google.maps.LatLng(parseFloat($('#'+item).attr('data-lat')), parseFloat($('#'+item).attr('data-lon')));
			map.gMap.setZoom(14);
			currentlyOnIndex = false;
		}
		
		var drawSelectedItems = function(markers) {
			map.resetMarkersList();
			for(idx = 0 ; idx<markers.length ; idx++) {
				var lat = parseFloat($(markers[idx]).attr('data-lat'));
				var lon = parseFloat($(markers[idx]).attr('data-lon'));
				var kind = $(markers[idx]).attr('data-kind');
				var idD = $(markers[idx]).attr('id');

				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(opts) {
					itemUrlSwitch($('.listing-view #'+opts["resourceUrl"]), opts["resourceUrl"]);
				});
			}
		}

		var loadTripDetails = function(item) {
			map.resetMarkersList();
			loadPath(item);
			loadPOIs(item);
		}

		var loadTripsOnMap = function() {
			var items = $('.listing-view').children();
			if(items.length > 0) {
				drawSelectedItems(items);
			}
		}

		var clearPath = function() {
			if(paths != null) {
				for(var i = 0 ; i < paths.length ; i++) {
					paths[i].setMap(null);
				}
			}
			paths = new Array();
		}

		var clearPOIs = function() {
			if(markersOnPath != null && markersOnPath.length > 0) {
				for(var i = 0 ; i < markersOnPath.length ; i++) {
					markersOnPath[i].setMap(null);
				}
			}
			markersOnPath = new Array();
		}

		var loadPOIs = function(item) {
			clearPOIs();

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


			/*$('#start').bind('click', function() {
				var start = $('.trip-pois').children('.start_flag')[0];
				map.placeViewportAt({ lat: $(start).attr('data-lat'), lon: $(start).attr('data-lon'), zoom: 20 });
			});

			$('#finish').bind('click', function() {
				var finish = $('.trip-pois').children('.finish_flag')[0];
				map.placeViewportAt({ lat: $(finish).attr('data-lat'), lon: $(finish).attr('data-lon'), zoom: 20 });
			});*/

			var pois = $('#'+item+' .trip-pois').children('.trip-poi');
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

				markersOnPath.push(marker);
				connectInfoWindow(marker, title, details);
			}
		}

		var loadPath = function(item) {	
			clearPath();

			var segments = $('#'+item+' .trip-paths').children();
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

				path = new google.maps.Polyline({
				    path: coordinates,
				    strokeColor: colour,
				    strokeOpacity: 0.7,
				    strokeWeight: 3
				  });
				path.setMap(map.gMap);

				paths.push(path);
			}
			map.placeViewportAt({ lat: parseFloat(firstCoord[0]), lon: parseFloat(firstCoord[1]), zoom: 17 });
		}

		initialize();
	}
		
	if($.isDefined('.trips')) {		
		var trips = new Trips();
		Path.map("#/").to(trips.onIndex);
		Path.map("#/:item").to(trips.onTripSelected);
		Path.root("#/");
		Path.listen();
	}
	
});
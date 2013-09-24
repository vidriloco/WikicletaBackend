$(document).ready(function() {
	if($.isDefined('#trips-section')) {
		sectionValue = $('#trips-section').attr('data-url');

		Discover = function() {

			var thisInstance = null;
			var paths = null;
			var markersOnPath = null;
			
			var initialize = function() {
				thisInstance = this;
				
				map.eventsForMapIdle('#map', function() {
					if(sectionValue && currentlyOnIndex) {
						loadTripsOnMap();
					}
				});
				
				return this;
			}

			this.onIndex = function() {
				currentlyOnIndex = true;		
				
				$('.listing-view div').removeClass('with-focus');
				clearPath();				
				clearPOIs();	
				$('.listing-actions').hide();
				loadTripsOnMap();
				
				google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
					offsetCenter(map.gMap.getCenter(), 200, -50);
				});
				
			}

			this.onDetailsFor = function() {
				var item = this.params['item'];
				var instance = thisInstance;
				$('.spinner').fadeIn();
				
				fetchSectionPartial(item, function() {
					$('#'+item+' .extras').fadeIn();
					$('#'+item).addClass('with-focus');
					loadTripDetails(item);

					var location = new google.maps.LatLng(parseFloat($('#'+item).attr('data-lat')), parseFloat($('#'+item).attr('data-lon')));
					map.gMap.setZoom(14);

					$('.listing-actions').fadeIn();

					google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
						offsetCenter(location, 200, -50);
					});
					$('.spinner').hide();
				});

				currentlyOnIndex = false;
			}

			var loadTripDetails = function(item) {
				map.resetMarkersList();
				loadPath(item);
				loadPOIs(item);
			}

			var loadTripsOnMap = function() {
				$('.spinner').fadeIn();
				fetchSectionPartial(undefined, function() {
					var items = $('.listing-view').children();
					if(items.length > 0) {
						drawSelectedItems(items);
					}
					$('.spinner').hide();
				});
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

	}
	
});
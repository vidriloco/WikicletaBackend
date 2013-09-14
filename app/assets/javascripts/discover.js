//= require common/base
//= require view_components/map.view
//= require geoposition
//= require cycling_groups

var map = null;
var activeInfoWindow = null;
var currentlyOnIndex = false;
var sectionValue = null;

$(document).ready(function() {
	if($.isDefined('#section')) {
		sectionValue = $('#section').attr('data-url');
	}
	
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
		
		// Fetch data from server
		var fetchSectionPartial = function(extra, callback) {
			var params = null;
			if(extra != undefined) {
				params = {extra: extra , viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }};
			} else {
				params = {viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }}
			}
			
			$.get(sectionValue, params).done(function() {
				// Responds to clicks on incidents
				$('.listing-view .trip-wrapper').on('click', function() {
					itemUrlSwitch($(this), $(this).attr('id'));
				});
				if(callback != undefined) {
					callback();
				}
			});
		}
		
		Discover = function() {
			
			var thisInstance = null;
			var paths = null;
			var markersOnPath = null;
			
			var initialize = function() {
				
				map.eventsForMapIdle('#map', function() {
					if(sectionValue && currentlyOnIndex) {
						loadTripsOnMap();
					}
				});
				
				thisInstance = this;
				return this;
			}
			
			this.onIndex = function() {
				$('.listing-view div').removeClass('with-focus');
				currentlyOnIndex = true;		
				loadTripsOnMap();
				clearPath();				
				clearPOIs();	
				$('.listing-actions').hide();
				
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
					loadTripDetails();
					
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
			
			var loadTripDetails = function() {
				map.resetMarkersList();
				loadPath();
				loadPOIs();
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
			
			var loadPOIs = function() {
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
					
					markersOnPath.push(marker);
					connectInfoWindow(marker, title, details);
				}
			}
			
			var loadPath = function() {	
				clearPath();
				
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
			
			var offsetCenter = function(latlng,offsetx,offsety) {

				var scale = Math.pow(2, map.gMap.getZoom());
				var nw = new google.maps.LatLng(
				    map.gMap.getBounds().getNorthEast().lat(),
				    map.gMap.getBounds().getSouthWest().lng()
				);

				var worldCoordinateCenter = map.gMap.getProjection().fromLatLngToPoint(latlng);
				var pixelOffset = new google.maps.Point((offsetx/scale) || 0,(offsety/scale) ||0)

				var worldCoordinateNewCenter = new google.maps.Point(
				    worldCoordinateCenter.x - pixelOffset.x,
				    worldCoordinateCenter.y + pixelOffset.y
				);

				var newCenter = map.gMap.getProjection().fromPointToLatLng(worldCoordinateNewCenter);

				map.gMap.setCenter(newCenter);

			}
			
			initialize();
		}
		
		var discover = new Discover();
		Path.map("#/:item").to(discover.onDetailsFor);
		Path.map("#/").to(discover.onIndex);
		Path.root("#/");
		Path.listen();
		
		// Routes sub-urls depending on the selection status
		var itemUrlSwitch = function(domElement, id) {
			if(domElement.hasClass('with-focus')) {
				window.location.hash="#/";
			} else {
				window.location.hash="#/"+id;			
			}
		}
		
		var drawSelectedItems = function(markers) {
			map.resetMarkersList();
			for(idx = 0 ; idx<markers.length ; idx++) {
				var lat = parseFloat($(markers[idx]).attr('data-lat'));
				var lon = parseFloat($(markers[idx]).attr('data-lon'));
				var kind = $(markers[idx]).attr('data-kind');
				var idD = $(markers[idx]).attr('id');
				
				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(urlID) {
					itemUrlSwitch($('.listing-view #'+urlID), urlID);
				});
			}
		}
		
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
		

		var centerMapFromUserCity = function(callback) {
			if($.isDefined('#selected-city')) {
				var lat = $('#selected-city').attr('data-default-lat');
				var lon = $('#selected-city').attr('data-default-lon');
				map.placeViewportAt({ lat: parseFloat(lat), lon: parseFloat(lon), zoom: defaultZoom });
			} else {
				if(callback != undefined) {
					callback();
				}
			}
		}

		var fetchPartial = function() {
			$.get('/maps/'+$('#listing-contents').attr('data-suburl'), {viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }})
			.done(itemsRoutes.viewChangesOnIndex);
		}
	}
});
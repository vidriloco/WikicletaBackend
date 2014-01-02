//= require common/base
//= require view_components/map.view
//= require geoposition

var detailedZoomLevel = 18;

var zoomLevel = null;
var overlaysOnMap = [];

$(document).ready(function() {
	

	Discover = function() {

		var domList = '#pois';
		var thisInstance = null;
		var markers = null;
		var paths = null;
		
		var currentState = {};
		var map = null;
		
		var initialize = function() {
			thisInstance = this;
			
			map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});
			$.cookie('date', $.stringifiedCurrentDate());
			//map.gMap.set('scrollwheel', false);
			map.eventsForMapCenterChanged('#map', function() {
				currentState.lastZoom = map.gMap.getZoom();
			});
			
			$('#reload-control').click(loadPOIsForLayer);
			
			$('#locate-me-control').click(function() {
				if (geoPosition.init()) {
					$('#locate-me-control img').attr('data-repeating', "true");
					$.fadeInOut('#locate-me-control img');
				  geoPosition.getCurrentPosition(function(p) {
						var lat = p.coords.latitude;
						var lon = p.coords.longitude;
						map.addMarkerYourLocation({ lat: lat, lon: lon });
						map.placeViewportAt({ lat: lat, lon: lon, zoom: defaultMiddleZoom });
						$('#locate-me-control img').attr('data-repeating', "false");
					}, null);
				}
			});
			
			$(document).on("click", '.toggle-header-details-box', function() {
				if($('.toggable').is(':visible')) {
					$('.toggable').fadeOut();
					$('.toggle-header-details-box.minimize').hide();
					$('.toggle-header-details-box.maximize').show();
				} else {
					showItemBlocks();
				}
			});

			return this;
		}

		this.onIndex = function() {
			currentState = {};		
			clearItemSelected();
		}
		
		this.deselectItem = function() {
			map.placeViewportAt({"zoom" : currentState.lastZoom});
			clearItemSelected();
			window.location.hash='#/'+currentState.layer;
		}

		this.layerSelected = function() {
			clearItemSelected();
			currentState.layer = this.params['layer'];
			updateLayerControl();
			$('#reload-control').trigger('click');
		}
		
		// Marks the icon associated with the selected layer as selected
		updateLayerControl = function() {
			$('.layer').removeClass('selected');
			$('#'+currentState.layer+'-layer').addClass('selected');
		}
		
		clearItemSelected = function() {
			$('.panel').fadeOut();
			clearOverlays();
		}
		
		clearOverlays = function() {
			for(var idx in overlaysOnMap) {
				overlaysOnMap[idx].setMap(null);
			}
			overlaysOnMap = [];
		}
		
		showItemBlocks = function() {
			$('.toggable').fadeIn();
			$('.toggle-header-details-box.maximize').hide();
			$('.toggle-header-details-box.minimize').show();
		}
		
		this.itemSelected = function() {
			showItemBlocks();
			clearOverlays();
			currentState = { layer: this.params['layer'], item: this.params['item'] }
			updateLayerControl();
			loadPOIsForLayer(afterFetchedPOIs);
		}
		
		var afterFetchedPOIs = function() {
			
			$('.panel').fadeIn();
			var element = $('#'+currentState.layer+'-'+currentState.item);
			
			map.placeViewportAt({"lat" : element.attr('data-lat'), "lon" : element.attr('data-lon'), "zoom" : detailedZoomLevel});
			var itemContent = element.clone();
			var dataKind = element.attr('data-kind');
			$('#host-container').html(itemContent);

			if(currentState.layer == 'workshops' || currentState.layer == 'routes') {
				$('#header-container').html($(element.siblings('.head')[0]).html());
				
				// Draw a path for routes only
				if(currentState.layer == 'routes') {
					overlaysOnMap.push($.drawPath($(element).attr('data-path'), map.gMap));
					overlaysOnMap.push(new google.maps.Marker({
					 	position: new google.maps.LatLng(element.attr('data-end-lat'), element.attr('data-end-lon')),
					  map: map.gMap,
						icon: $.assetsURL()+'finish_flag-marker.png'
					}));
				}
			} else if(currentState.layer != 'cycling_groups') {
				// Parkings , Tips and CyclingGroups
				var elementClass = $(element).attr('data-kind').split('-')[0];
				$('#header-container').html(element.siblings('.'+elementClass+'-head').html());				
			} else {
				// Cycling Groups
				var logo = $($('#'+element.attr('id')+' .logo-container')[0]).detach();
				$('#header-container').html(logo);
			}
		}
		
		var loadPOIsForLayer = function(callback_function) {
			$('#indicator').removeClass('hidden');
			$('#reload-control').addClass('hidden');
			
			fetchPOIs('/'+currentState.layer+'.js', undefined, function() {
				drawSelectedItems($('.discover #listed').children());
				$('#indicator').addClass('hidden');
				$('#reload-control').removeClass('hidden');
				
				if(typeof callback_function == 'function') {
					callback_function();
				}
			});
		}
		
		var drawSelectedItems = function(markers) {
			map.resetMarkersList();
			for(idx = 0 ; idx<markers.length ; idx++) {
				var lat = parseFloat($(markers[idx]).attr('data-lat'));
				var lon = parseFloat($(markers[idx]).attr('data-lon'));
				var kind = $(markers[idx]).attr('data-kind');
				var idD = $(markers[idx]).attr('id');

				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(opts) {
					registerTrackWith("Marker clicked with: " + opts["iconName"] + " " + opts["resourceUrl"]);
					window.location.hash='#/'+opts["resourceUrl"].replace('-', '/');
				});
			}
		}
		
		var fetchPOIs = function(url, extra, callback) {
			var params = null;
			if(extra != undefined) {
				params = {extra: extra , viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }};
			} else {
				params = {viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }}
			}

			$.get(url, params).done(function() {
				if(callback != undefined) {
					callback();
				}
			});
		}
		
		var afterHTMLUpdated = function() {
			// Stop spinner
			$('.spinner').fadeOut();
			// Always display listing actions
			$('.listing-actions').show();
			$('#back-to-listing').hide();
			
			var items = $('.listing-view').children();
			if(items.length > 0) {
				drawSelectedItems(items);
			}
		}
		
		var zoomToItem = function(item) {
			previousZoom = map.gMap.getZoom();
			// Center map to marker 
			var location = new google.maps.LatLng(parseFloat($('#'+item).attr('data-lat')), parseFloat($('#'+item).attr('data-lon')));
			map.gMap.setZoom(19);
			return location;
		}
		
		initialize();
	}

	
	if($.isDefined('.discover')) {		
		var discover = new Discover();
		Path.map('#/deselect').to(discover.deselectItem);
		Path.map("#/:layer").to(discover.layerSelected);
		Path.map("#/:layer/:item").to(discover.itemSelected);
		Path.map("#/").to(discover.onIndex);
		Path.root("#/");
		Path.listen();
	}
});
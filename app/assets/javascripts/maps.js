//= require common/base
//= require view_components/map.view
//= require geoposition
//= require view_components/counter.view
//= require view_components/form.validator

var map = null;
var currentlyOnIndex = false;
var itemsRoutes = null;
$(document).ready(function(){
	
	if($.isDefined('#map')) {
		
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
		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
		
		map.eventsForMapIdle('#map', function() {
			if(currentlyOnIndex) {
				fetchPartial();
			}
		});
	}
		
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
	
	// JS Subroutes for listing views
	if($.isDefined('.listing-view')) {
		
		// Turns off the filtering allowing all the incidents to become visible
		$('.actions .filtering-enabled .turn-off-filtering').bind('click', function() {
			window.location.hash = "#/";
		});
		
		// Routes sub-urls depending on the selection status
		var itemUrlSwitch = function(domElement, id) {
			if(domElement.hasClass('with-focus')) {
				window.location.hash="#/";
			} else {
				window.location.hash="#/details/"+id;			
			}
		}
		// Responds to clicks on incidents
		$('.item-on-list').live('click', function() {
			itemUrlSwitch($(this), $(this).attr('id'));
		});
		
		ItemsOnMap = function() {
			
			var thisInstance = null;
			
			var obj = {
				initialize: function() {
					thisInstance = this;
					return this;
				},

				onIndex : function() {
					currentlyOnIndex = true;
					
					thisInstance.viewChangesOnIndex();
					
					centerMapFromUserCity(function() {
						map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
					});
					
					// insert map at top of the listing
					$('#map').insertBefore('.listing-view .first');
					$.scrollToTop();
				},
				
				onFilter : function() {
					currentlyOnIndex = false;
					
					var aspect = this.params['aspect'].slice(0,-1);
					// Deactivate filter if location hash is on filter aspect
					$('.item-on-list').fadeOut();
					$('.'+aspect).fadeIn();
					$('.stats .box').removeClass('active');
					$('.stats .'+aspect).addClass('active');
					$('.stats .action-link').fadeIn();
					$('.actions .filtering-enabled').fadeIn();
					$('.actions .filtering-enabled .turn-off-filtering').fadeIn();
					thisInstance.drawSelectedItems($('.listing-view .'+aspect));
					thisInstance.showEmptyLegendFor('.'+aspect);
				},
				
				viewChangesOnIndex : function() {
					$('.item-on-list').fadeIn();
					$('.stats .box').addClass('active');
					$('.actions .filtering-enabled .turn-off-filtering').fadeOut();
					
					$('.stats .action-link').hide();
					thisInstance.showEmptyLegendFor('.item-on-list');
					thisInstance.drawSelectedItems($('.listing-view .item-on-list'));
					
					$('.listing-view .item-on-list').removeClass('with-focus');
				},
				
				details : function() {
					currentlyOnIndex = false;
					
					var id = this.params['id'];
					var domElement = '.listing-view #'+id;
										
					// Show map if not visible
					if($('.layers').is(':visible')) {
						$('.section-switcher .map').click();
					}
					
					$('.item-on-list').removeClass('with-focus');
					$(domElement).addClass('with-focus');
					thisInstance.drawSelectedItems([domElement]);
					map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
					
					// dom element for incident
					var domElement = '.listing-view #'+id;
					// move map above incident
					$('#map').insertBefore(domElement);
					$.scrollFromMapToDom(domElement, 40);
				},
				
				drawSelectedItems : function(incidents) {
					map.resetMarkersList();
					for(idx = 0 ; idx<incidents.length ; idx++) {
						var lat = parseFloat($(incidents[idx]).attr('data-lat'));
						var lon = parseFloat($(incidents[idx]).attr('data-lon'));
						var kind = $(incidents[idx]).attr('data-kind');
						var idD = $(incidents[idx]).attr('id');
						
						map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(urlID) {
							itemUrlSwitch($('.listing-view #'+urlID), urlID);
						});
					}
				},
				
				showEmptyLegendFor : function(domElement) {
					if($('.listing-view').children(domElement).length == 0) {
						$('.listing-view .empty').removeClass('hidden');
					} else {
						$('.listing-view .empty').addClass('hidden');
					}
				}
			
			}
			return obj.initialize();
		}
		
		itemsRoutes = new ItemsOnMap();
		Path.map("#/").to(itemsRoutes.onIndex);
		Path.map("#/filter/:aspect").to(itemsRoutes.onFilter);
		Path.map('#/details/:id').to(itemsRoutes.details);
		Path.root("#/");
		Path.listen();
	}
	
});
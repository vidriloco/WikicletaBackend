//= require common/base
//= require view_components/map.view
//= require geoposition
//= require view_components/counter.view
//= require view_components/form.validator

var map = null;
$(document).ready(function(){
	if($.isDefined('#map')) {
		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
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
		$('.item-on-list').bind('click', function() {
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
					$('.item-on-list').fadeIn();
					$('.stats .box').addClass('active');
					$('.actions .filtering-enabled .turn-off-filtering').fadeOut();
					
					$('.stats .action-link').fadeOut();
					thisInstance.showEmptyLegendFor('.item-on-list');
					thisInstance.drawSelectedItems($('.listing-view .item-on-list'));
					
					$('.listing-view .item-on-list').removeClass('with-focus');
					map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
					
					// insert map at top of the listing
					$('#map').insertBefore('.listing-view .first');
					$.scrollToTop();
				},
				
				onFilter : function() {
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
				
				details : function() {
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
		
		var itemsRoutes = new ItemsOnMap();
		Path.map("#/").to(itemsRoutes.onIndex);
		Path.map("#/filter/:aspect").to(itemsRoutes.onFilter);
		Path.map('#/details/:id').to(itemsRoutes.details);
		Path.root("#/");
		Path.listen();
	}
	
	// JS Subroutes for new and edit views
	if($.isDefined('.altering-view')) {
		
		$('.delete-incident').bind('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/maps/incidents/'+$(this).attr('data-id'));
			return false;
		});
		
		var Incidents = {};
		Incidents.Routes = function() {
			
			var thisInstance = null;
			
			var obj = {
				initialize: function() {
					thisInstance = this;
					return this;
				},

				onIndex : function() {
					$('.current-incident').html($('.incident-selector').attr('data-text'));
					var kindId = parseInt($('#active-form #incident_kind').val());
					if(kindId > 0) {
						var incidentType = $('.incident-types #'+kindId).attr('data-subroute');
						window.location.hash = '#/'+incidentType;
					} 
				},
			
				onAccidents : function() {
					thisInstance.mountFieldsFor('accident');
					map.setCoordinatesFromDom('#coordinates', 16);
					thisInstance.toggleAlert('#bike-required-alert', false);
				},
				
				onThefts : function() {
					thisInstance.mountFieldsFor('theft');
					map.setCoordinatesFromDom('#coordinates', 16);
					thisInstance.toggleAlert('#bike-required-alert', true);
				},
				
				onAssaults : function() {
					thisInstance.mountFieldsFor('assault');
					map.setCoordinatesFromDom('#coordinates', 16);
					thisInstance.toggleAlert('#bike-required-alert', false);
				},
				
				onBreakDown : function() {
					thisInstance.mountFieldsFor('breakdown');
					map.setCoordinatesFromDom('#coordinates', 16);
					thisInstance.toggleAlert('#bike-required-alert', true);
				},
				
				toggleAlert : function(dom, show) {
					if(!$.isDefined(dom)) {
						return false;
					}
					
					if(show) {
						$(dom).removeClass('hidden');
					} else {
						$(dom).addClass('hidden');
					}
				},
				
				onEmpty : function() {
					$('#active-form').empty();
					map.reset();
					window.location.hash = '#/';
				},
				
				mountFieldsFor : function(kind) {
					$('.current-incident').html($('.'+kind+'-selector').attr('data-text'));
					$('#active-form').html($('.'+kind+'-form').html());
					$('#active-form #incident_kind').val($('.'+kind+'-selector').attr('id'));
					$('#active-form').fadeIn();
					
					// Setup constraints and validations for fields
					ViewComponents.Counter.forDomElement('#incident_description', 250);
					
					var conditions = [{id: '#incident_kind', condition: 'not_empty' }, 
						{id: '#incident_description', condition: 'min', value: 60 },
						{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' }];
						
					// Add extra validations if incident is not a breakdown
					if(kind != "breakdown") {
						conditions.push({id: '#incident_start_hour', respect: '#incident_final_hour', condition: 'before_than', special: true });
						conditions.push({id: '#incident_vehicle_identifier', condition: 'regexp', regexp: /^[^-]([A-Z0-9\-]){3,}[^-]$/ });
					} 
					
					ViewComponents.ValidForm.set('#active-form form', conditions, {
							before: function() {
								map.setCoordinatesFromDom('#coordinates', 16);
							}
					});
				}
			}
			return obj.initialize();
		}
		
		var incidentsRoutes = new Incidents.Routes();
		Path.map("#/").to(incidentsRoutes.onIndex);
		Path.map("#/accident").to(incidentsRoutes.onAccidents);
		Path.map("#/theft").to(incidentsRoutes.onThefts);
		Path.map("#/assault").to(incidentsRoutes.onAssaults);
		Path.map("#/breakdown").to(incidentsRoutes.onBreakDown);
		Path.map("#/none").to(incidentsRoutes.onEmpty);
		
		Path.root("#/");
		Path.listen();
	}
});
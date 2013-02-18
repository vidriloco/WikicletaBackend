//= require common/base
//= require map_component
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
		
		// Switch left-bar content
		$('.bar-activator').bind('click', function() {
			$('.bar-activator').parent().removeClass('active');
			$(this).parent().addClass('active');
			$('.section-view').hide();
			
			if($(this).hasClass('map')) {
				$('div.map').fadeIn();
				$('.locate-me').fadeIn();
			} else if($(this).hasClass('layers')) {
				$('div.layers').fadeIn();
				$('.locate-me').hide();
			}
		});
		
		// Toggle actions list from title
		$('.section-actions a.main-title').bind('click', function() {
			if($('.section-actions .contents').is(':visible')) {
				$('.section-actions .contents').hide();
				$('.icon-chevron-down').hide();
				$('.icon-chevron-up').show();
				
			} else {
				$('.section-actions .contents').show();
				$('.icon-chevron-down').show();
				$('.icon-chevron-up').hide();
			}
		});
	}
	
	$('.dropdown-toggle').dropdown();
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
		
		// Responds to clicks on incidents
		$('.incident').bind('click', function() {
			if($(this).hasClass('with-focus')) {
				$(this).removeClass('with-focus');
				map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
			} else {
				// Show map if not visible
				if($('.layers').is(':visible')) {
					$('.section-switcher .map').click();
				}
				$('.incident').removeClass('with-focus');
				$(this).addClass('with-focus');
				map.placeViewportAt({ lat: $(this).attr('data-lat'), lon: $(this).attr('data-lon'), zoom: defaultMiddleZoom });
			}			
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
					$('.incident').fadeIn();
					$('.stats .box').addClass('active');
					$('.actions .filtering-enabled .turn-off-filtering').fadeOut();
					
					thisInstance.drawSelectedIncidents($('.listing-view .incident'));
				},
				
				onFilter : function() {
					var aspect = this.params['aspect'].slice(0,-1);
					// Deactivate filter if location hash is on filter aspect
					$('.incident').fadeOut();
					$('.'+aspect).fadeIn();
					$('.stats .box').removeClass('active');
					$('.stats .'+aspect).addClass('active');
					$('.actions .filtering-enabled').fadeIn();
					$('.actions .filtering-enabled .turn-off-filtering').fadeIn();

					$('.actions .filtering-enabled .turn-off-filtering').bind('click', function() {
						window.location.hash = "#/";
					});
					thisInstance.drawSelectedIncidents($('.listing-view .'+aspect));
				},
				
				drawSelectedIncidents : function(incidents) {
					map.resetMarkersList();
					for(var idx in incidents) {
						var lat = parseFloat($(incidents[idx]).attr('data-lat'));
						var lon = parseFloat($(incidents[idx]).attr('data-lon'));
						var kind = $(incidents[idx]).attr('data-kind');
						var idD = $(incidents[idx]).attr('id');
						map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(id) {
							$('.listing-view #'+id).click();
						});
					}
				}
			
			}
			return obj.initialize();
		}
		
		var incidentsRoutes = new Incidents.Routes();
		Path.map("#/").to(incidentsRoutes.onIndex);
		Path.map("#/filter/:aspect").to(incidentsRoutes.onFilter);
		
		Path.root("#/");
		Path.listen();
	}
	
	// JS Subroutes for new and edit views
	if($.isDefined('.altering-view')) {
		
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
				},
				
				onThefts : function() {
					thisInstance.mountFieldsFor('theft');
					map.setCoordinatesFromDom('#coordinates', 16);
				},
				
				onAssaults : function() {
					thisInstance.mountFieldsFor('assault');
					map.setCoordinatesFromDom('#coordinates', 16);
				},
				
				onBreakDown : function() {
					thisInstance.mountFieldsFor('breakdown');
					map.setCoordinatesFromDom('#coordinates', 16);
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
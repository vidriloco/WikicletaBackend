//= require common/base
//= require view_components/map.view
//= require geoposition
//= require view_components/counter.view
//= require view_components/form.validator
//= require jquery.masonry.min

var map;
$(document).ready(function() {
	

	// Map for incidents
	mapOptions.streetViewControl = false;
	
	var initializeMap = function() {
		if($.isDefined('#map')) {
			map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
				coordinatesDom: "#coordinates", 
				isEditable: $('#map').hasClass('editable')
			});
		}
	}
	// Common actions for incidents and tips
	initializeMap();

	if($.isDefined('.altering-view')) {
		
		map.setCoordinatesFromDom('#coordinates', 16);
		// Attempt to get my location
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
		
		// JS Subroutes for new and edit views
		if($.isDefined('.altering-incident')) {
			// Actions for incidents

			var Routes = {};
			Routes.Incidents = function() {

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

			var incidentsRoutes = new Routes.Incidents();
			Path.map("#/").to(incidentsRoutes.onIndex);
			Path.map("#/accident").to(incidentsRoutes.onAccidents);
			Path.map("#/theft").to(incidentsRoutes.onThefts);
			Path.map("#/assault").to(incidentsRoutes.onAssaults);
			Path.map("#/breakdown").to(incidentsRoutes.onBreakDown);
			Path.map("#/none").to(incidentsRoutes.onEmpty);

			Path.root("#/");
			Path.listen();
		} else if($.isDefined('.altering-workshop')) {
			// Actions for workshops
			
			// Setup constraints and validations for fields
			ViewComponents.Counter.forDomElement('#workshop_details', 250);
			var conditions = [{id: '#workshop_name', condition: 'not_empty' },
				{id: '#workshop_details', condition: 'min', value: 60 },
				{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' }];
			ViewComponents.ValidForm.set('#workshops-form form', conditions, {
					before: function() {
						map.setCoordinatesFromDom('#coordinates', 16);
					}
			});
			
		} else {
			// Actions for tips 
			
			// Setup constraints and validations for fields
			ViewComponents.Counter.forDomElement('#tip_content', 250);

			var conditions = [{id: '#tip_category', condition: 'not_empty' }, 
				{id: '#tip_content', condition: 'min', value: 60 },
				{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' }];
			ViewComponents.ValidForm.set('#tips-form form', conditions, {
					before: function() {
						map.setCoordinatesFromDom('#coordinates', 16);
					}
			});
		}
	
	} else {
		
		// for user bikes listing 
		$('#masonry').masonry({
	    itemSelector : '.bike',
			isAnimated: false,
			isFitWidth: true
	  });


		// Tipsy for navsubbar elements
		$('.profile .activities a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
		$('.profile .activities .stats a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
		
		// Behaviours when clicking on navbar sections items
		$('.actions li').bind('click', function() {
			if($(this).attr('id') == 'incidents-section') {
				if($(this).hasClass('active')) {
					$.visit('#/');
				} else {
					$.visit('#/incidents');
				}
				return false;
			} else if($(this).attr('id') == 'tips-section') {
				if($(this).hasClass('active')) {
					$.visit('#/');
				} else {
					$.visit('#/tips');
				}
				return false;
			}	else if($(this).attr('id') == 'places-section') {
				if($(this).hasClass('active')) {
					$.visit('#/');
				} else {
					$.visit('#/places');
				}
				return false;
			}
		});

		/**
		  *  Some common variables and functions
		 **/
		var parentDom = '#contents-area ';

		var rootSelected = function() {
			$(parentDom).empty();
		}

		/*   
		 *  ==== Methods for incidents begin =====
		 */

		$('.delete-incident').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/incidents/'+$(this).attr('data-id'));
			return false;
		});

		// Routes sub-urls depending on the selection status
		var incidentUrlSwitch = function(domElement, id) {
			if(domElement.hasClass('with-focus')) {
				$.visit('#/incidents');
			} else {
				$.visit('#/incidents/'+id);
			}
		}
		// Responds to clicks on incidents
		$('.incident').live('click', function() {
			incidentUrlSwitch($(this), $(this).attr('id'));
		});

		var drawSelectedItems = function(objects, url_function) {
			map.resetMarkersList();
			for(idx = 0 ; idx<objects.length ; idx++) {
				var lat = parseFloat($(objects[idx]).attr('data-lat'));
				var lon = parseFloat($(objects[idx]).attr('data-lon'));
				var kind = $(objects[idx]).attr('data-kind');
				var idD = $(objects[idx]).attr('id');

				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(urlID) {
					url_function($(parentDom+'.listing-view #'+urlID), urlID);
				});
			}
		}


		/*   
		 *  Routing for incidents at #/incidents
		 *  TODO: Change to function closures as a method hidding mechanism
		 */
		var Routing = {};
		Routing.Incidents = function() {

			var thisInstance = null;

			var obj = {
				initialize: function() {
					thisInstance = this;
					return this;
				},

				onIndex : function() {	
					var afterViewFetchedActions = function() {
						thisInstance.commonLoading();
						// draw all available incidents on a map
						drawSelectedItems($('.listing-view .incident'), incidentUrlSwitch);
						// insert map at top of the listing
						$(parentDom+'#map').insertBefore('.listing-view .first');
						// unmark all marked incidents
						$(parentDom+'.listing-view .incident').removeClass('with-focus');
						map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
						$.scrollToTop();
					}

					thisInstance.fetchView(afterViewFetchedActions, null);
				},

				onItem : function() {
					var id = this.params['id'];

					var afterViewFetchedActions = function() {
						// dom element for incident
						var domElement = parentDom+'.listing-view #'+id;

						thisInstance.commonLoading();
						// move map above incident
						$(parentDom+'#map').insertBefore(domElement);
						// unmark any previously marked incident
						$(parentDom+'.incident').removeClass('with-focus');
						// mark the incident
						$(domElement).addClass('with-focus');
						// draw selected incidents on map
						drawSelectedItems([domElement], incidentUrlSwitch);
						map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
						$.scrollFromMapToDom(domElement, 40);
					}

					thisInstance.fetchView(afterViewFetchedActions, null);
				},

				fetchView: function(success_callback, failure_callback) {
					if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'incidents') {
						$.get('/profiles/incidents', {username : $(parentDom).attr('data-username') })
						.done(success_callback).fail(failure_callback);
					} else {
						success_callback();
					}
				},

				commonLoading: function() {	
					// load map if not loaded yet
					initializeMap();
					// show section marked
					$('.actions li').removeClass('active');
					$('#incidents-section').addClass('active');
				}

			}
			return obj.initialize();
		}
		
		/*   
		 *  ==== Methods for incidents end =====
		 *  ==== Methods for tips begin =====
		 */
		
		$('.delete-tip').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/tips/'+$(this).attr('data-id'));
			return false;
		});
		
		// Routes sub-urls depending on the selection status
		var tipUrlSwitch = function(domElement, id) {
			if(domElement.hasClass('with-focus')) {
				$.visit('#/tips');
			} else {
				$.visit('#/tips/'+id);
			}
		}
		// Responds to clicks on tips
		$('.tip').live('click', function() {
			tipUrlSwitch($(this), $(this).attr('id'));
		});
		
		Routing.Tips = function() {
			var thisInstance = this;
			var initialize = function() {

				return thisInstance;
			}

			this.onIndex = function() {
				var afterViewFetchedActions = function() {
					commonLoading();
					drawSelectedItems($('.listing-view .tip'), tipUrlSwitch);
					// insert map at top of the listing
					$(parentDom+'#map').insertBefore('.listing-view .first');
					// unmark all marked incidents
					$(parentDom+'.listing-view .tip').removeClass('with-focus');
					map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
					$.scrollToTop();
				}

				fetchView(afterViewFetchedActions, null);
			}

			this.onItem = function() {
				var id = this.params['id'];

				var afterViewFetchedActions = function() {
					// dom element for incident
					var domElement = parentDom+'.listing-view #'+id;

					commonLoading();
					// move map above incident
					$(parentDom+'#map').insertBefore(domElement);
					// unmark any previously marked incident
					$(parentDom+'.tip').removeClass('with-focus');
					// mark the incident
					$(domElement).addClass('with-focus');
					// draw selected incidents on map
					drawSelectedItems([domElement], tipUrlSwitch);
					map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
					$.scrollFromMapToDom(domElement, 40);
				}

				fetchView(afterViewFetchedActions, null);
			}

			var commonLoading = function() {	
				// load map if not loaded yet
				initializeMap();
				// show section marked
				$('.actions li').removeClass('active');
				$('#tips-section').addClass('active');
			}

			var fetchView = function(success_callback, failure_callback) {
				if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'tips') {
					$.get('/profiles/tips', {username : $(parentDom).attr('data-username') })
					.done(success_callback).fail(failure_callback);
				} else {
					success_callback();
				}
			}

			initialize();
		}
		/*   
		 *  ==== Methods for tips end =====
		 *  ==== Methods for places start =====
		 */
		
		$('.delete-workshop').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/workshops/'+$(this).attr('data-id'));
			return false;
		});

		// Routes sub-urls depending on the selection status
		var placesUrlSwitch = function(domElement, id) {
			if(domElement.hasClass('with-focus')) {
				$.visit('#/places');
			} else {
				if(domElement.hasClass('workshop')) {
					$.visit('#/places/workshops/'+id);
					
				} else if(domElement.hasClass('parking')) {
					$.visit('#/places/parkings/'+id);
					
				}
			}
		}
		// Responds to clicks on tips
		$('.place').live('click', function() {
			placesUrlSwitch($(this), $(this).attr('id'));
		});

		Routing.Places = function() {
			var thisInstance = this;
			var initialize = function() {

				return thisInstance;
			}

			this.onIndex = function() {
				var afterViewFetchedActions = function() {
					commonLoading();
					drawSelectedItems($('.listing-view .place'), placesUrlSwitch);
					// insert map at top of the listing
					$(parentDom+'#map').insertBefore('.listing-view .first');
					// unmark all marked incidents
					$(parentDom+'.listing-view .place').removeClass('with-focus');
					map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
					$.scrollToTop();
				}

				fetchView(afterViewFetchedActions, null);
			}
			
			this.onSection = function() {
				var kind = this.params['kind'].slice(0,-1);
				
				var afterViewFetchedActions = function() {
					commonLoading();
					
					// Hide places
					$('.listing-view .place').fadeOut();
					// Show items of kind
					$('.listing-view .'+kind).fadeIn();
					
					drawSelectedItems($('.listing-view .'+kind), placesUrlSwitch);
					
					// insert map at top of the listing
					$(parentDom+'#map').insertBefore('.listing-view .first');
					// unmark all marked incidents
					$(parentDom+'.listing-view .place').removeClass('with-focus');
					map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
					$.scrollToTop();
				}
				fetchView(afterViewFetchedActions, null);
			}

			this.onItem = function() {
				var id = this.params['id'];
				var kind = this.params['kind'].slice(0,-1);
				
				var afterViewFetchedActions = function() {
					// dom element for item list kind
					var domElement = parentDom+'.listing-view .'+kind+'-list #'+id;

					commonLoading();
					// move map above incident
					$(parentDom+'#map').insertBefore(domElement);
					// unmark any previously marked incident
					$(parentDom+'.'+kind).removeClass('with-focus');
					// mark the incident
					$(domElement).addClass('with-focus');
					// draw selected incidents on map
					drawSelectedItems([domElement], placesUrlSwitch);
					map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
					$.scrollFromMapToDom(domElement, 40);
				}

				fetchView(afterViewFetchedActions, null);
			}

			var commonLoading = function() {	
				// load map if not loaded yet
				initializeMap();
				// show section marked
				$('.actions li').removeClass('active');
				$('#places-section').addClass('active');
			}

			var fetchView = function(success_callback, failure_callback) {
				if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'places') {
					$.get('/profiles/places', {username : $(parentDom).attr('data-username') })
					.done(success_callback).fail(failure_callback);
				} else {
					success_callback();
				}
			}

			initialize();
		}
		/*   
		 *  ==== Methods for places end =====
		 */
		
		// Setup and sub-routing wiring
		var incidentsURLs = new Routing.Incidents();
		var tipsURLs = new Routing.Tips();
		var placesURLs = new Routing.Places();

		// Action to call on root subsection
		Path.map('#/').to(function() {
			$('.actions li').removeClass('active');
			rootSelected();
		});
		// Routes for incidents
		Path.map("#/incidents").to(incidentsURLs.onIndex);
		Path.map('#/incidents/:id').to(incidentsURLs.onItem);
		// Routes for tips
		Path.map("#/tips").to(tipsURLs.onIndex);
		Path.map("#/tips/:id").to(tipsURLs.onItem);
		// Routes for places
		Path.map("#/places").to(placesURLs.onIndex);
		Path.map('#/places/:kind').to(placesURLs.onSection);
		Path.map("#/places/:kind/:id").to(placesURLs.onItem);
	}

	
	Path.root("#/");
	Path.listen();
});

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
		if($('#map').length > 0) {
			map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
				coordinatesDom: "#coordinates", 
				isEditable: $('#map').hasClass('editable')
			});
		}
	}


	if($.isDefined('.altering-view')) {
		initializeMap();
		map.setCoordinatesFromDom('#coordinates', 16);
		
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
			$('#dialog .dialog-yes').attr('href', '/maps/incidents/'+$(this).attr('data-id'));
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
		 */
		
		// Setup and sub-routing wiring
		var incidentsURLs = new Routing.Incidents();
		var tipsURLs = new Routing.Tips();

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
	}

	
	Path.root("#/");
	Path.listen();
});

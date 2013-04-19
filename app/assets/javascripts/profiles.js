//= require common/base
//= require view_components/map.view
//= require geoposition
//= require view_components/counter.view
//= require view_components/form.validator
//= require jquery.masonry.min

//= require profiles/commons
//= require profiles/incidents
//= require profiles/tips
//= require profiles/places

var map;
$(document).ready(function() {
	
	// Map for incidents
	mapOptions.streetViewControl = false;
	
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
		
		if($.isDefined('.altering-workshop')) {
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
			
		} else if($.isDefined('.altering-tip')) {
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
		} else if($.isDefined('.altering-parking')) {
			// Actions for parkings 
			
			var conditions = [{id: '#parking_kind', condition: 'not_empty' }, 
				{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' }];
			ViewComponents.ValidForm.set('#parkings-form form', conditions, {
					before: function() {
						map.setCoordinatesFromDom('#coordinates', 16);
					}
			});
		} else if($.isDefined('.altering-incident')) {
			var incidentsURLs = new Routing.Incidents();
			
			// Routes for incidents on edit
			Path.map("#/").to(incidentsURLs.onIndex);
			Path.map("#/accident").to(incidentsURLs.onAccidents);
			Path.map("#/theft").to(incidentsURLs.onThefts);
			Path.map("#/assault").to(incidentsURLs.onAssaults);
			Path.map("#/breakdown").to(incidentsURLs.onBreakDown);
			Path.map("#/none").to(incidentsURLs.onEmpty);
		}
	
	} else {
		$('.avatar-img').bind('mouseenter', function() {
			$('.avatar-img i').removeClass('icon-user');
			$('.avatar-img i').addClass('icon-plus');
		});
		
		$('.avatar-img').bind('mouseleave', function() {
			$('.avatar-img i').addClass('icon-user');
			$('.avatar-img i').removeClass('icon-plus');
		});
		
		var imageURL = $('#profile-image').attr('data-image-url');
		$('#profile-image').css('background-image', 'url(' + imageURL + ')');
		
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

		/*   
		 *  ==== Methods for incidents begin =====
		 */

		$('.delete-incident').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/incidents/'+$(this).attr('data-id'));
			return false;
		});

		// Responds to clicks on incidents
		$('.incident').live('click', function() {
			incidentUrlSwitch($(this), $(this).attr('id'));
		});
		
		/*   
		 *  ==== Methods for incidents end =====
		 *  ==== Methods for tips begin =====
		 */
		
		$('.delete-tip').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/tips/'+$(this).attr('data-id'));
			return false;
		});
		
		// Responds to clicks on tips
		$('.tip').live('click', function() {
			tipUrlSwitch($(this), $(this).attr('id'));
		});
		
		/*   
		 *  ==== Methods for tips end =====
		 *  ==== Methods for places start =====
		 */
		
		$('.delete-workshop').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/workshops/'+$(this).attr('data-id'));
			return false;
		});

		
		// Responds to clicks on tips
		$('.place').live('click', function() {
			placesUrlSwitch($(this), $(this).attr('id'));
		});

		/*   
		 *  ==== Methods for places end =====
		 *  ==== Methods for parkings start =====
		 */
		
		$('.delete-parking').live('click', function() {
			$('#dialog').modal();
			$('#dialog .dialog-yes').attr('href', '/profiles/parkings/'+$(this).attr('data-id'));
			return false;
		});
		
		/*   
		 *  ==== Methods for parkings end =====
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

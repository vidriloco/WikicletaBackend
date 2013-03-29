//= require common/base
//= require view_components/map.view
//= require jquery.masonry.min

var map;
$(document).ready(function() {
	
	// for user bikes listing 
	$('#masonry').masonry({
    itemSelector : '.bike',
		isAnimated: false,
		isFitWidth: true
  });
	
	
	// Tipsy for navsubbar elements
	$('.profile .activities a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
	$('.profile .activities .stats a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
	
	// Map for incidents
	mapOptions.streetViewControl = false;
	
	var initializeMap = function() {

		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
	}
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

	$('.delete-incident').bind('click', function() {
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
					thisInstance.drawSelectedIncidents($('.listing-view .incident'));
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
					thisInstance.drawSelectedIncidents([domElement]);
					map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
					$.scrollFromMapToDom(domElement, 40);
				}
				
				thisInstance.fetchView(afterViewFetchedActions, null);
			},
			
			fetchView: function(success_callback, failure_callback) {
				if($(parentDom).is(':empty')) {
					$.get('/profiles/incidents', {username : $(parentDom).data('username') })
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
			},
			
			drawSelectedIncidents : function(incidents) {
				map.resetMarkersList();
				for(idx = 0 ; idx<incidents.length ; idx++) {
					var lat = parseFloat($(incidents[idx]).attr('data-lat'));
					var lon = parseFloat($(incidents[idx]).attr('data-lon'));
					var kind = $(incidents[idx]).attr('data-kind');
					var idD = $(incidents[idx]).attr('id');
					
					map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(urlID) {
						incidentUrlSwitch($(parentDom+'.listing-view #'+urlID), urlID);
					});
				}
			}
		
		}
		return obj.initialize();
	}
	
	/*   
	 *  ==== Methods for incidents end =====
	 *  ==== Methods for tips begin =====
	 */
	Routing.Tips = function() {
		var thisInstance = this;
		var initialize = function() {
			
			return thisInstance;
		}
		
		this.onIndex = function() {
			var afterViewFetchedActions = function() {
				//thisInstance.commonLoading();
				alert(1);
			}
			
			fetchView(afterViewFetchedActions, null);
		}
		
		this.onItem = function() {
			
		}
		
		var fetchView = function(success_callback, failure_callback) {
			if($(parentDom).is(':empty')) {
				$.get('/profiles/tips', {username : $(parentDom).data('username') })
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
	
	Path.root("#/");
	Path.listen();
});

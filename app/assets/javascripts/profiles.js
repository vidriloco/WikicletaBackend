//= require common/base
//= require view_components/map.view
//= require jquery.masonry.min

var map;
$(document).ready(function() {
	// Tipsy for navsubbar elements
	$('.profile .activities a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
	$('.profile .activities .stats a').tipsy({gravity: 'n', live: true, fade: true, delayIn: 900, delayOut: 0 });
	
	// Map for incidents
	mapOptions.streetViewControl = false;
	
	var initializeMap = function() {
		if(map != null) {
			return false;
		}
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
	}

	// Events for incidents
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
	$('.incident').bind('click', function() {
		incidentUrlSwitch($(this), $(this).attr('id'));
	});
	
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
	
	var Incidents = {};
	Incidents.Routes = function() {
		
		var thisInstance = null;
		var parentDom = '#incidents ';
		
		var obj = {
			initialize: function() {
				thisInstance = this;
				return this;
			},
			
			onRootSelected : function() {
				$(parentDom).hide();
			},

			onIndex : function() {				
				thisInstance.commonLoading();
				// draw all available incidents on a map
				thisInstance.drawSelectedIncidents($('.listing-view .incident'));
				// insert map at top of the listing
				$(parentDom+'#map').insertBefore('.listing-view .first');
				// unmark all marked incidents
				$(parentDom+'.listing-view .incident').removeClass('with-focus');
				map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
				$.scrollToTop();
			},
			
			details : function() {
				var id = this.params['id'];
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
			},
			
			commonLoading: function() {	
				// load map if not loaded yet
				initializeMap();
				// show section contents
				$(parentDom).show();
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
	
	$('#masonry').masonry({
    itemSelector : '.bike',
		isAnimated: false,
		isFitWidth: true
  });
	
	var incidentsRoutes = new Incidents.Routes();
	// Action to call on root subsection
	Path.map('#/').to(function() {
		$('.actions li').removeClass('active');
		incidentsRoutes.onRootSelected();
	});
	Path.map("#/incidents").to(incidentsRoutes.onIndex);
	Path.map('#/incidents/:id').to(incidentsRoutes.details);
	Path.root("#/");
	Path.listen();
});

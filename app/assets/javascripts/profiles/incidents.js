/*   
 *  Routing for incidents at #/incidents
 *  TODO: Change to function closures as a method hidding mechanism
 */

// Routes sub-urls depending on the selection status
var incidentUrlSwitch = function(domElement, id) {
	if(domElement.hasClass('with-focus')) {
		$.visit('#/incidents');
	} else {
		$.visit('#/incidents/'+id);
	}
}
	
$(document).ready(function() {
	
	// JS Subroutes for new and edit views
	if($.isDefined('.altering-incident')) {
		Routing.Incidents = function() {
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
	} else {
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
						$.scrollFromMapToDom('#map', 60);
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
					$('.solved-status .trigger').on('click', function() {
						$(this.parent).html("<p><b>Cambiando ...</b></p>");
					});
				}

			}
			return obj.initialize();
		}
	}
});

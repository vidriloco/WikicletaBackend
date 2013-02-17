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
			} else if($(this).hasClass('layers')) {
				$('div.layers').fadeIn();
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
	
	if($.isDefined('.altering-action')) {
		
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
				},
				
				onThefts : function() {
					thisInstance.mountFieldsFor('theft');
				},
				
				onAssaults : function() {
					thisInstance.mountFieldsFor('assault');
				},
				
				onBreakDown : function() {
					thisInstance.mountFieldsFor('breakdown');
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
					
					ViewComponents.ValidForm.set('#active-form form', [
						{id: '#incident_kind', condition: 'not_empty' }, 
						{id: '#incident_start_hour', respect: '#incident_final_hour', condition: 'before_than', special: true }, 
						{id: '#incident_description', condition: 'min', value: 60 },
						{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' }, 
						{id: '#incident_vehicle_identifier', condition: 'regexp', regexp: /^[^-]([A-Z0-9\-]){3,}[^-]$/ }], {
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
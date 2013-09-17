//= require common/base
//= require view_components/map.view
//= require geoposition
//= require cycling_groups
//= require discover/base
//= require discover/trips
//= require discover/cycling_groups

$(document).ready(function() {	
	if($.isDefined('#cycling-groups-section .listing') || $.isDefined('#trips-section .listing')) {
		var discover = new Discover();
		Path.map("#/:item").to(discover.onDetailsFor);
		Path.map("#/").to(discover.onIndex);
		Path.root("#/");
		Path.listen();
	} else {		
		$('.popover-trigger').popover();
		map.gMap.setZoom(14);
		google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
			offsetCenter(map.gMap.getCenter(), 200, -50);
		});
		
		// Setup constraints and validations for fields
		ViewComponents.Counter.forDomElement('#cycling_group_details', 250);
		var conditions = [{id: '#cycling_group_name', condition: 'not_empty' },
			{id: '#cycling_group_details', condition: 'not_empty' },
			{id: '#cycling_group_meeting_time_hour', condition: 'not_empty' },
			{id: '#cycling_group_meeting_time_minute', condition: 'not_empty' },
			{id: '#cycling_group_departing_time_hour', condition: 'not_empty' },
			{id: '#cycling_group_departing_time_minute', condition: 'not_empty' },
			{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' },
			{id: '#cycling_group_twitter_account', condition: 'regexp', regexp: /^@?(\w){1,15}$/ }];
		ViewComponents.ValidForm.set('#cycling_groups-form form', conditions, {
				before: function() {
					map.setCoordinatesFromDom('#coordinates', 16);
				}
		});
		
		if($.isDefined('#cycling_groups-form .edit')) {
			map.simulatePinPoint($('#coordinates_lat').val(), $('#coordinates_lon').val(), 18);
		}
		
	}
});
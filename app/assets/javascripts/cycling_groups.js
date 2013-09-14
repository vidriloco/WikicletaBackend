//= require view_components/counter.view
//= require view_components/form.validator
var map;
$(document).ready(function() {
	if($.isDefined('.altering-cycling_group')) {
		// Actions for workshops
		
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
		
	}
});
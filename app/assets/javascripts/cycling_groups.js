//= require view_components/counter.view
//= require view_components/form.validator

$(document).ready(function() {
	$.cookie('date', $.stringifiedCurrentDate());
	if($.isDefined('#cycling-groups')) {
		registerTrackWith("On cycling group form");
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
			{id: '#cycling_group_facebook_url', condition: 'regexp', 
				regexp: /(^$|(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/ },
			{id: '#cycling_group_website_url', condition: 'regexp', 
				regexp: /(^$|(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/ },
			{id: '#coordinates_lat', anotherId: '#coordinates_lon', condition: 'both' },
			{id: '#cycling_group_twitter_account', condition: 'regexp', regexp: /^(\w){1,15}$/ }];
		ViewComponents.ValidForm.set('#cycling_groups-form form', conditions, {
				before: function() {
					map.setCoordinatesFromDom('#coordinates', 16);
				},
				after: function() {
					$('#cycling_groups-form form .submitter').hide();
					$('#cycling_groups-form form .spinner').fadeIn();
				}
		});

		if($.isDefined('#cycling_groups-form .edit')) {
			map.simulatePinPoint($('#coordinates_lat').val(), $('#coordinates_lon').val(), 18);
		}
	}
});
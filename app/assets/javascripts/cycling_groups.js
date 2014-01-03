//= require view_components/counter.view
//= require view_components/form.validator

$(document).ready(function() {
	$.cookie('date', $.stringifiedCurrentDate());
	if($.isDefined('.cycling-groups')) {
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
		
		$('.maximize-view').fadeOut();
		$('.minimize-view').click(function() {
			$('.inner-panel').fadeOut();
			$('.maximize-view').fadeIn();
			$('.minimize-view').hide();
			$('.activity').show();
		});

		$('.maximize-view').click(function() {
			$('.inner-panel').fadeIn();
			$('.minimize-view').fadeIn();
			$('.maximize-view').hide();
			$('.activity').hide();
		});
		
		registerTrackWith("On cycling group form");
		$('.popover-trigger').popover();
		map.gMap.setZoom(14);

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
			{id: '#cycling_group_twitter_account', condition: 'regexp', regexp: /^(\w){1,19}$/ }];
		ViewComponents.ValidForm.set('form', conditions, {
				before: function() {
					map.setCoordinatesFromDom('#coordinates', 16);
				},
				after: function() {
					$('form .submit-button').hide();
					$('form .spinner').fadeIn();
				}
		});

		if($.isDefined('.editing-cycling-group')) {
			map.simulatePinPoint($('#coordinates_lat').val(), $('#coordinates_lon').val(), 18);
		}
	}
});
var reloadRestEvent = function() {
	$('#reset-number').bind('click', function() {
		$.ajax({
		  url: '/profile/'+$('#tracking-placeholder').attr('data-user-id')+'/reset_code.js',
		  type: 'PUT',
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
		});
	});
}

$(document).ready(function() {
	
	if($.isDefined('.profile')) {
		
		var hideAllTogglers = function() {
			$('.sections-togglers li').removeClass('selected');
		}
		
		var hideAllContainers = function() {
			$('.box .content').fadeOut();
		}
		
		reloadRestEvent();
		
		Path.map('#/cycling-groups').to(function() {
			hideAllTogglers();
			$('#cycling-groups-status').addClass('selected');
			hideAllContainers();
			$('#cycling-groups-container').fadeIn();
		});

		Path.map("#/routes").to(function() {
			hideAllTogglers();
			$('#routes-status').addClass('selected');
			hideAllContainers();
			$('#routes-container').fadeIn();
		});
		
		Path.map("#/others").to(function() {
			hideAllTogglers();
			$('#others-status').addClass('selected');
			hideAllContainers();
			$('#others-container').fadeIn();
		});

		Path.map("#/").to(function() {
			hideAllTogglers();
		});

		Path.root("#/");
		Path.listen();		
	}

});
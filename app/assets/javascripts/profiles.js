$(document).ready(function() {
	
	if($.isDefined('.profile')) {
		Path.map('#/cycling-groups').to(function() {
			$('.sections-togglers li').removeClass('selected');
			$('#cycling-groups-status').addClass('selected');
			$('#routes-container').fadeOut();
			$('#cycling-groups-container').fadeIn();
		});

		Path.map("#/routes").to(function() {
			$('.sections-togglers li').removeClass('selected');
			$('#routes-status').addClass('selected');
			$('#routes-container').fadeIn();
			$('#cycling-groups-container').fadeOut();
		});

		Path.map("#/").to(function() {
			$('.sections-togglers li').removeClass('selected');
		});

		Path.root("#/");
		Path.listen();		
	}

});
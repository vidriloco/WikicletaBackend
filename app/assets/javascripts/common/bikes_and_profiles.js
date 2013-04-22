$(document).ready(function() {
	$('.heart').live('click', function() {
		$('.tipsy').fadeOut();
		if($(this).hasClass('requires_login')) {
			return false;
		}
		var id = $(this).attr('id');
		
		var type = "POST";
		if($(this).hasClass('strong')) {
			type = "DELETE";
		}
		
		$.ajax({
		  type: type,
		  url: "/"+$(this).attr('data-group')+"/"+id+"/like",
		  data: { format : "js" }
		});
	});
	$('.heart').tipsy({gravity: 'n', live: true, fade: true, delayIn: 100, delayOut: 500 });
});
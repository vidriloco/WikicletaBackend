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
		
		var selectedHeart = $(this);
		$.ajax({
		  type: type,
		  url: "/"+$(this).attr('data-group')+"/"+id+"/like",
		  data: { format : "js" },
			beforeSend: function ( xhr ) {
				selectedHeart.hide();
				$(selectedHeart.parent().prev().children()[0]).fadeIn();
			}
		});
	});
	$('.heart').tipsy({gravity: 'n', live: true, fade: true, delayIn: 100, delayOut: 500 });
});
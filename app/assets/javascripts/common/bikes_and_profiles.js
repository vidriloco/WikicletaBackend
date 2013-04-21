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
	
	// Move this code to a common area for maps and profiles
	$('.avatar-img').bind('mouseenter', function() {
		$('.avatar-img i').removeClass('icon-user');
		$('.avatar-img i').addClass('icon-plus');
	});
	
	$('.avatar-img').bind('mouseleave', function() {
		$('.avatar-img i').addClass('icon-user');
		$('.avatar-img i').removeClass('icon-plus');
	});
	
	var imageURL = $('#profile-image').attr('data-image-url');
	$('#profile-image').css('background-image', 'url(' + imageURL + ')');
});
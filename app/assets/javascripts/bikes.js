//= require common/base
//= require modernizr-transitions
//= require jquery.masonry.min
//= require view_components/counter.view
//= require view_components/form.validator
//= require comments
//= require jquery.popover
//= require quickpager.jquery.js
// For pictures
//= require common/pictures_base
//= require sections/pictures

$(document).ready(function() {
	
	Path.map("#/").to(Sections.Pictures.indexPage);
	Path.map("#/pictures/uploads").to(Sections.Pictures.manageUploads);
	Path.map("#/pictures/uploaded").to(Sections.Pictures.manageUploaded);
	Path.root("#/");
	Path.listen();
	
	// TODO: Make it work with pathjs
	/*var hashId = 'bike-'+window.location.hash.split("#")[1];
	if ( $.isDefined("#"+hashId) ) {
		document.getElementById(hashId).scrollIntoView();
	}*/
	
  $('#container').masonry({
    itemSelector : '.bike',
    columnWidth : 160,
		isAnimated: true,
	  animationOptions: {
	    duration: 750,
	    easing: 'linear',
	    queue: false
	  }
  });
	
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
		  url: "/bikes/"+id+"/like",
		  data: { format : "js" }
		});
	});
	
	$('.reveals-share').live('click', function(e) {
		e.preventDefault();
		$('#share-modal').reveal();
	});
	
	$('.reveals-rent').live('click', function(e) {
		e.preventDefault();
		$('#rent-modal').reveal();
	});
	
	$('.reveals-sell').live('click', function(e) {
		e.preventDefault();
		$('#sell-modal').reveal();
	});
	
	$('.bike_statuses_availability').live('change', function() {
		var element = $(this).parent().children('.dependent-fields')[0];
		
		if($(this).val() == "1") {
			$(element).fadeIn();
		} else  {
			$(element).fadeOut();
			$(element).children('input:checkbox').attr('checked', false);
			$(element).children('input:text').val('');
		}
	}); 

	// over photo bike info and photo links
	$('.bike-photos').hover(function() {
		$('.bike-photos .info').fadeIn('slow');
	}, function() {
		$('.bike-photos .info').fadeOut('slow');
	});
	
	// tipsy hovers
	$('.heart').tipsy({gravity: 'n', live: true, fade: true, delayIn: 100, delayOut: 500 });
	$('.contact').tipsy({gravity: 's', live: true, fade: true, delayIn: 100, delayOut: 60 });
	$('.value').tipsy({gravity: 'n', live: true, fade: true, delayIn: 100, delayOut: 60 });
	
	if($.isDefined('.bike-upload')) {
		ViewComponents.Counter.forDomElement('#bike_name', 25);
		ViewComponents.Counter.forDomElement('#bike_description');
		// Validation for new and edit bike form
		var validateFields = [
			{id: '#bike_name', condition: 'not_empty' },
			{id: '#bike_description', condition: 'not_empty' },
			{id: "#bike_weight", condition: "regexp", regexp: /^\d{1,2}(\.*\d+)?$/ },
			{id: '#bike_kind', condition: 'not_empty' },
			{id: '#bike_bike_brand_id', condition: 'not_empty' }];

		ViewComponents.ValidForm.set('.bike-upload', validateFields);
	}
});
//= require common/base
//= require modernizr-transitions
//= require jquery.masonry.min
//= require view_components/counter.view
//= require view_components/form.validator
//= require comments
//= require quickpager.jquery.js
// For pictures
//= require common/pictures_base
//= require common/bikes_and_profiles
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
	
  $('#masonry').masonry({
    itemSelector : '.item-bikly',
		isAnimated: false,
		isFitWidth: true
  });
	
	$('.reveals-share').live('click', function(e) {
		e.preventDefault();
		$('#share-modal').modal();
	});
	
	$('.reveals-rent').live('click', function(e) {
		e.preventDefault();
		$('#rent-modal').modal();
	});
	
	$('.reveals-sell').live('click', function(e) {
		e.preventDefault();
		$('#sell-modal').modal();
	});
	
	$('.bike_statuses_availability').live('change', function() {
		var element = $(this).parent().parent().parent().children('.dependent-fields')[0];
		if($(this).val() == "1") {
			$(element).removeClass('hidden');
		} else  {
			$(element).addClass('hidden');
			$(element).children('input:checkbox').attr('checked', false);
			$(element).children('input:text').val('');
		}
	}); 

	if($.isDefined('.carousel')) {
		$('.carousel').carousel({
    	interval: 3000,
			pause: "hover"
    });
	}

	// over photo bike info and photo links
	$('.bike .photos').hover(function() {
		$('.bike .photos .info').fadeIn('slow');
	}, function() {
		$('.bike .photos .info').fadeOut('slow');
	});
	
	// tipsy hovers
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
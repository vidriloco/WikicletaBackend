//= require jquery
//= require jquery_ujs
//= require jquery.tipsy
//= require jquery.reveal
//= require jquery.editable.min
//= require path
//= require twitter/bootstrap

// Following are some functions used over the application
$.fn.clearForm = function() {
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    if (tag == 'form')
      return $(':input',this).clearForm();
    if (type == 'text' || type == 'password' || tag == 'textarea')
      this.value = '';
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    else if (tag == 'select')
      this.selectedIndex = -1;
  });
};

$.extend({
	isDefined: function(dom) {
		return $(dom).length;
	},
	
	currentSectionIs: function(dom) {
		return $.isDefined("#section-"+dom);
	},
	
	visit: function(hashedUrl) {
		window.location.hash = hashedUrl;
	},
	
	scrollFromMapToDom: function(dom, offset) {
		$('html,body').animate({scrollTop: $(dom).offset().top-offset}, 'slow');
	},
	
	scrollToTop: function() {
		$('html,body').animate({scrollTop: $('#top-container').offset()}, 'slow');
	},
	
	buildUrlFrom: function(section, id) {
		if(id === undefined) {
			return "#"+section;
		}
		return "#"+section+"/"+id;
	},
	// For google maps icons
	assetsURL: 'http://50.56.30.227/assets/'
});

$(document).ready(function() {
	
	if($.isDefined('.top-message')) {
		//ViewComponents.Notification.append($('.top-message'));
	}
	
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
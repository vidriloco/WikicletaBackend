//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.tipsy
//= require jquery.reveal
//= require jquery.editable.min
//= require path
//= require jquery.cookies
//= require bootstrap-fileupload.min
//= require owl-carrousel
//= require trackings

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
	
	fadeInOut: function (div) {
    var $element = $(div);
    function fadeInOutCore () {
        $element.fadeIn(1000, function () {
            $element.fadeOut(1500, function () {
                $element.fadeIn(1500, function () {
										if($(div).attr('data-repeating') == "true") {
	                    setTimeout(fadeInOutCore, 500);
										} 
                });
            });
        });
    }

    fadeInOutCore();
	},
	
	isDefined: function(dom) {
		return $(dom).length;
	},
	
	stringifiedCurrentDate: function() {
		var dateObj = new Date();
		var month = dateObj.getMonth()+1;
		var day = dateObj.getDate();
		var year = dateObj.getFullYear();
		
		return day+"-"+month+"-"+year;
	},
	
	currentSectionIs: function(dom) {
		return $.isDefined("#section-"+dom);
	},
	
	visit: function(hashedUrl) {
		window.location.hash = hashedUrl;
	},
	
	scrollFromTo: function(dom, offset) {
		if(offset == undefined) {
			offset = 0;
		}
		scrollFromMapToDom(dom, offset);
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
	
	drawPath: function(element, map_) {
		var points = element.split(' ');
		var coordinates = [];
		
		for(var pointIdx = 0; pointIdx < points.length ; pointIdx++) {
			var coords = points[pointIdx].split('|');
			var lat = coords[0];
			var lon = coords[1];

			coordinates.push(new google.maps.LatLng(lat, lon));
		}
		
		var path = new google.maps.Polyline({
		    path: coordinates,
		    strokeColor: 'black',
		    strokeWeight: 3
		  });
		path.setMap(map_);
		return path;
	}
});

$(document).ready(function() {
	
	if($.isDefined('.top-message')) {
		//ViewComponents.Notification.append($('.top-message'));
	}
});
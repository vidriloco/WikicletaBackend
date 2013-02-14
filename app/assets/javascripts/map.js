//= require common/base
//= require view_components/geo/map

var zoomForDetails = 16;
var defaultZoom=13;
var mapAtDom="map";
var searchCoords={lat:19.435672, lon: -99.133100 };
var mapOptions = {
	center: new google.maps.LatLng(parseFloat(19.434780), parseFloat(-99.133072)),
	zoom: zoomForDetails,
	mapTypeId: google.maps.MapTypeId.ROADMAP,
	streetViewControl: true,
	mapTypeControl: false,
	navigationControl: false,
	navigationControlOptions: {
		position: google.maps.ControlPosition.TOP_RIGHT
	},
	zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }
};

$(document).ready(function() {
		
	var width=$(window).width()-270;
	$('body').append('<div style="width:'+width+'px"><div style="margin-left:270px; width:'+width+'px; height:100%;" id="map" class="<%= yield :classes_for_map %> displays-points"></div></div>');
	
	window.onresize = function(){
		$('#map').css('width', $(window).width()-270);
	}
});
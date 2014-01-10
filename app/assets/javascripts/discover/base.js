var map = null;
var activeInfoWindow = null;
var currentlyOnIndex = false;
var sectionValue = null;
var previousZoom = defaultZoom;

// Global functions

// Fetch data from server
var fetchSectionPartial = function(extra, callback) {
	var params = null;
	if(extra != undefined) {
		params = {extra: extra , viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }};
	} else {
		params = {viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }}
	}
	
	$.get(sectionValue, params).done(function() {
		// Responds to clicks on incidents
		$('.listing-view .item-wrapper').on('click', function() {
			itemUrlSwitch($(this), $(this).attr('id'));
		});
		if(callback != undefined) {
			callback();
		}
		twttr.widgets.load();
		
		setTimeout(function() { $('.share-media').animate({opacity:1}, 800); }, 2500);

	});
}

var offsetCenter = function(latlng,offsetx,offsety) {

	var scale = Math.pow(2, map.gMap.getZoom());
	var nw = new google.maps.LatLng(
	    map.gMap.getBounds().getNorthEast().lat(),
	    map.gMap.getBounds().getSouthWest().lng()
	);

	var worldCoordinateCenter = map.gMap.getProjection().fromLatLngToPoint(latlng);
	var pixelOffset = new google.maps.Point((offsetx/scale) || 0,(offsety/scale) ||0)

	var worldCoordinateNewCenter = new google.maps.Point(
	    worldCoordinateCenter.x - pixelOffset.x,
	    worldCoordinateCenter.y + pixelOffset.y
	);

	var newCenter = map.gMap.getProjection().fromPointToLatLng(worldCoordinateNewCenter);

	map.gMap.setCenter(newCenter);

}

// Routes sub-urls depending on the selection status
var itemUrlSwitch = function(domElement, id) {
	if(domElement.hasClass('with-focus')) {
		window.location.hash="#/";
	} else {
		window.location.hash="#/"+id;			
	}
}

var drawSelectedItems = function(markers) {
	map.resetMarkersList();
	for(idx = 0 ; idx<markers.length ; idx++) {
		var lat = parseFloat($(markers[idx]).attr('data-lat'));
		var lon = parseFloat($(markers[idx]).attr('data-lon'));
		var kind = $(markers[idx]).attr('data-kind');
		var idD = $(markers[idx]).attr('id');
		
		map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(opts) {
			itemUrlSwitch($('.listing-view #'+opts["resourceUrl"]), opts["resourceUrl"]);
		});
	}
}

var centerMapFromUserCity = function() {
	var lat = $('#selected-city a').attr('data-lat');
	var lon = $('#selected-city a').attr('data-lon');
	$.cookie('city_id', $('#selected-city a').attr('id'));
	
	map.placeViewportAt({ lat: parseFloat(lat), lon: parseFloat(lon)-0.1, zoom: 12 });
}

$(document).ready(function() {	
	$.cookie('date', $.stringifiedCurrentDate());
	
	if($.isDefined('#map')) {
		mapOptions = {
			center: new google.maps.LatLng(parseFloat(defaultLat), parseFloat(defaultLon)),
			zoom: defaultZoom,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			streetViewControl: true,
			mapTypeControl: false,
			navigationControl: true,
			panControl: false,
			overviewMapControl: false,
			streetViewControlOptions: {
				position: google.maps.ControlPosition.TOP_RIGHT
			},
			zoomControlOptions: { position: google.maps.ControlPosition.TOP_RIGHT, style: google.maps.ZoomControlStyle.SMALL }
		};

		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: "#coordinates", 
			isEditable: $('#map').hasClass('editable')
		});
		
		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
			if (geoPosition.init()) {
				$('.spinner').fadeIn();
			  geoPosition.getCurrentPosition(function(p) {
					var lat = p.coords.latitude;
					var lon = p.coords.longitude;
					map.addMarkerYourLocation({ lat: lat, lon: lon });
					map.placeViewportAt({ lat: lat, lon: lon-0.01, zoom: defaultMiddleZoom });
					$('.spinner').hide();
				}, null);
			}
		});
		
		if($.isDefined('#selected-city')) {
			centerMapFromUserCity();
		}
		
		$(document).on('click', '#unselected-cities li a', function() {
			var selectedCityHtml = $('#selected-city').html();
			var unselectedCityHtml = $($(this).parent()).html();
			$($(this).parent()).html(selectedCityHtml);
			$('#selected-city').html(unselectedCityHtml);
			centerMapFromUserCity();
		});
		
		$(document).on('click', '#back-to-listing', function() {
			map.gMap.setZoom(previousZoom);
		});
	}
});

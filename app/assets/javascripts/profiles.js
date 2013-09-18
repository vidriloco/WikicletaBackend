//= require common/base
//= require view_components/map.view
//= require geoposition

var map = null;
var sectionValue = null;

$(document).ready(function() {			
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
		
		if($.isDefined('#user-profile .city')) {
			map.placeViewportAt({"lat": $('#user-profile .city').attr('data-lat'), "lon": $('#user-profile .city').attr('data-lon'), "zoom": 13});
		}
		
		$('#show-activity-trigger a').bind('click', function() {
			$('.activity-container').fadeIn();
			$($(this).parent()).addClass('hidden');
			$('#hide-activity-trigger').removeClass('hidden');
		});
		
		$('#hide-activity-trigger a').bind('click', function() {
			$('.activity-container').fadeOut();
			$($(this).parent()).addClass('hidden');
			$('#show-activity-trigger').removeClass('hidden');
			$('#action-selected').html("");
		});
		
		if($.isDefined('#user-profile')) {
			sectionValue = $('#user-profile').attr('data-url');	
			map.eventsForMapIdle('#map', function() {
				if(sectionValue) {
					fetchSectionPartial();
				}
			});
		}
		
		var fetchSectionPartial = function(extra, callback) {
			var params = {viewport: {sw : $('#map').attr('sw'), ne: $('#map').attr('ne') }};

			$.get(sectionValue, params).done(function() {
				drawSelectedItems($('#tmp-contents').children());
				if(callback != undefined) {
					callback();
				}
			});
		}
		
		var drawSelectedItems = function(markers) {
			map.resetMarkersList();
			for(idx = 0 ; idx<markers.length ; idx++) {
				var lat = parseFloat($(markers[idx]).attr('data-lat'));
				var lon = parseFloat($(markers[idx]).attr('data-lon'));
				var kind = $(markers[idx]).attr('data-kind');
				var idD = $(markers[idx]).attr('id');
				
				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: idD }, function(opts) {
					$('#action-selected').html($('#'+opts["resourceUrl"]).html());
					$('#show-activity-trigger a').click();
					map.placeViewportAt({"lat": opts["lat"]+0.0025, "lon": opts["lon"], "zoom": 17});
				});
			}
		}
		
		if($.isDefined('#edit-profile')) {
			$('form .submitter').bind('click', function() {
				$(this).hide();
				$(this).siblings('.spinner').fadeIn();
			});
		}

	}
});
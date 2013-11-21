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
		
		// Loading of markers on user profile
		if($.isDefined('.markers')) {
			var markersRoute = $('.items .item');
			for(var i = 0 ; i < markersRoute.length ; i++) {
				var lat = parseFloat($(markersRoute[i]).attr('data-origin-lat'));
				var lon = parseFloat($(markersRoute[i]).attr('data-origin-lon'));
				var kind = $(markersRoute[i]).attr('data-kind');
				var url = $(markersRoute[i]).attr('data-url');
				var id = $(markersRoute[i]).attr('id');
				map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: kind, resourceUrl: url, id: id }, function(opts) {
					$.visit(opts.resourceUrl);					
				});
			}
			
			Path.map("#/").to(function() {
				$('.selected-item').html('');
				$('.selected-item').addClass('hidden');
				$('.activities').removeClass('hidden');
			});
			
			Path.map("#/route-preview/:id").to(function() {
				var id = this.params['id'];
				var dom = $('#route-'+id);
				var lat = parseFloat(dom.attr('data-origin-lat'));
				var lon = parseFloat(dom.attr('data-origin-lon'));
				map.placeViewportAt({"lat": lat+0.0025, "lon": lon, "zoom": 17});
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.activities').addClass('hidden');
				
			});
			
			Path.map("#/cycling-group-preview/:id").to(function() {
				var id = this.params['id'];
				var dom = $('#'+id);
				var lat = parseFloat(dom.attr('data-origin-lat'));
				var lon = parseFloat(dom.attr('data-origin-lon'));
				map.placeViewportAt({"lat": lat+0.0025, "lon": lon, "zoom": 17});
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.activities').addClass('hidden');
				
			});
			
			Path.root("#/");
			Path.listen();
		}
		
		// Loading of route path on route details
		if($.isDefined('#route-details')) {
			var coordinates = $.loadPath($('#route-details').attr('data-path'));
			
			var path = new google.maps.Polyline({
			    path: coordinates,
			    strokeColor: 'black',
			    strokeWeight: 3
			  });
			path.setMap(map.gMap);
			
			var dom = $('#route-details');
			var latO = parseFloat(dom.attr('data-origin-lat'));
			var lonO = parseFloat(dom.attr('data-origin-lon'));
			
			var latF = parseFloat(dom.attr('data-end-lat'));
			var lonF = parseFloat(dom.attr('data-end-lon'));
			
			map.placeViewportAt({"lat": latO+0.0025, "lon": lonO, "zoom": 15});
			
			
			new google.maps.Marker({
				position: new google.maps.LatLng(latO, lonO),
				map: map.gMap,
				icon: $.assetsURL() + 'start_flag.png',
				title: 'Inicio'
			});
			
			new google.maps.Marker({
				position: new google.maps.LatLng(latF, lonF),
				map: map.gMap,
				icon: $.assetsURL() + 'finish_flag.png',
				title: 'Final'
			});
		}

		$('.show-extra').bind("click", function() {
			$('.hide-extra').removeClass('hidden');
			$(this).addClass('hidden');
			$('.actions').removeClass('hidden');
		});
		
		$('.hide-extra').bind("click", function() {
			$('.show-extra').removeClass('hidden');
			$(this).addClass('hidden');
			$('.actions').addClass('hidden');
		});
	}
});
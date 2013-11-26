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
		if($.isDefined('#user-profile')) {
			var selectedEndMarker = null;
			
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
			
			Path.map("#/route-preview/:id").to(function() {
				var id = this.params['id'];
				var dom = $('#route-'+id);
				var lat = parseFloat(dom.attr('data-origin-lat'));
				var lon = parseFloat(dom.attr('data-origin-lon'));
				map.placeViewportAt({"lat": lat+0.0025, "lon": lon, "zoom": 17});
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.individual').fadeIn();
				$('.grupal').hide();
				$('#routes-status').addClass('selected');
			});
			
			Path.map("#/cycling-group-preview/:id").to(function() {
				var id = this.params['id'];
				var dom = $('#'+id);
				var lat = parseFloat(dom.attr('data-origin-lat'));
				var lon = parseFloat(dom.attr('data-origin-lon'));
				map.placeViewportAt({"lat": lat+0.0025, "lon": lon, "zoom": 17});
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.individual').fadeIn();
				$('.grupal').hide();
				$('#cycling-groups-status').addClass('selected');
			});
			
			Path.map("#/cycling-groups").to(function() {
				var dom = $('#cycling-groups');
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.grupal').fadeIn();
				$('.individual').hide();
				
				$('#routes-status').removeClass('selected');
				$('#cycling-groups-status').addClass('selected');
			});
			
			Path.map("#/routes").to(function() {
				var dom = $('#routes');
				$('.selected-item').html(dom.clone());
				$('.selected-item').removeClass('hidden');
				$('.grupal').fadeIn();
				$('.individual').hide();
				
				$('#cycling-groups-status').removeClass('selected');
				$('#routes-status').addClass('selected');
			});
			
			Path.map("#/clear").to(function() {
				$('.selected-item').html('');
				$('.selected-item').addClass('hidden');
				$('#routes-status').removeClass('selected');
				$('#cycling-groups-status').removeClass('selected');
				
				$.visit('#/');
			});
			
			Path.root("#/");
			Path.listen();
		} else if($.isDefined('#route-details')) {
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

		Path.map("#/timings").to(function() {
			$('.show-extra').removeClass('hidden');
			$('.hide-extra').addClass('hidden');
			$('.temporal-container').html($('#timings').html());
			$('.temporal-container').removeClass('hidden');
		});


		Path.map("#/actions").to(function() {
			$('.hide-extra').removeClass('hidden');
			$('.show-extra').addClass('hidden');
			$('.temporal-container').html($('#actions').html());
			$('.temporal-container').removeClass('hidden');
		});
		
		Path.map("#/").to(function() {
			$('.show-extra').removeClass('hidden');
			$('.hide-extra').addClass('hidden');
			$('.temporal-container').addClass('hidden');
		});
		
		Path.root("#/");
		Path.listen();
	}
});
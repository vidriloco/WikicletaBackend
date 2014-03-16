var map = null;
var tracking = null;
var currentCode = null;
var REGEX = /^\w{6}$/;
$(document).ready(function() {
	
	if($.isDefined('.tracking')) {
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});

		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
			registerTrackWith('On Locate-me selected');
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
		
		$('.minimize-view').click(function() {
			$('.inner-panel').fadeOut();
			$('.maximize-view').fadeIn();
			$('.minimize-view').hide();
			$('.activity').show();
		});

		$('.maximize-view').click(function() {
			$('.inner-panel').fadeIn();
			$('.minimize-view').fadeIn();
			$('.maximize-view').hide();
			$('.activity').hide();
		});

		$('.maximize-view').click();
		
		TrackingCore = function() {
			var initialize = function() {
				
			}
			
			this.onIndex = function() {
				$('.loading').addClass('hidden');
				$('#replaceable-content').html('');
				$('#replaceable-content').html($('.seek').clone());
				$('#replaceable-content .seek').removeClass('hidden');
				map.resetMarkersList();
				$('#profile-link').hide();
				
				$('#find-location').bind('click', function() {
					var code = $('#code-input').val();
					if(REGEX.test(code)) {
						window.location = 'tracking#/'+code;
					}
				});
				
				var adjustInput = function(code) {
					if(REGEX.test(code)) {
						$('#find-location').css('opacity', 1.0);
					} else {
						$('#find-location').css('opacity', 0.3);
					}
				}
				
				adjustInput($('#code-input').val());
				$('#code-input').mousedown(function() {
					adjustInput($(this).val());
				});
				$('#code-input').keyup(function() {
					adjustInput($(this).val());
				});

			}
			
			this.onSelected = function() {
				currentCode = this.params['code'];
				fetchLastInstantFor(currentCode);
			}
			
			var fetchLastInstantFor = function(code) {
				$.get('/api/tracking/'+code).done(function(data) {
					if(data.success) {
						var username = data.tracking.user['username'];
						var picUrl = data.tracking.user['image'];
						
						var lat = data.tracking.instant['lat'];
						var lon = data.tracking.instant['lon'];
						var speed = data.tracking.instant['speed_at'];
						var createdAt = data.tracking.instant['str_created_at'];
						
						$('.loading').addClass('hidden');
						$('#replaceable-content').html('');
						$('#replaceable-content').html($('.instant-info').clone());
						$('#replaceable-content .instant-info').removeClass('hidden');
						$('#replaceable-content .instant-info .speed .value').html(parseFloat(speed).toFixed(2));
						$('#replaceable-content .instant-info .title').html(username);
						$('#replaceable-content .instant-info .time .value').html(createdAt);
						
						$('#replaceable-content .instant-info .pic-area img').attr('src', picUrl);
						
						$('#profile-link').attr('href', '/profiles/'+username);
						
						map.addCoordinatesAsMarkerToList({ lat: lat, lon: lon, iconName: 'timing-marker', resourceUrl: null }, null);
						map.placeViewportAt({lat: lat, lon: lon, zoom: defaultMiddleZoom});
						$('#profile-link').fadeIn();
						
						$('.reloader').mouseover(function() {
							$(this).tooltip('show');
						});

						$('.reloader').mouseout(function() {
							$(this).tooltip('hide');
						});
						
						$('.reloader').click(function() {
							$('.loading').removeClass('hidden');
							$('#replaceable-content').html('');
							fetchLastInstantFor(currentCode);
						});
					} else {
						$('.loading').addClass('hidden');
						$('#replaceable-content').html('');
						$('#replaceable-content').html($('.not-found').clone());
						$('#replaceable-content .not-found').removeClass('hidden');
					}
				});
			}
			
			initialize();
		};
		
		
		tracking = new TrackingCore();
		Path.map("#/").to(tracking.onIndex);
		Path.map("#/:code").to(tracking.onSelected);
		Path.root("#/");
		Path.listen();
	}

});
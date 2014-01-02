//= require jquery.fancybox.pack
//= require jquery.fancybox-media

$(document).ready(function() {
	
	if($.isDefined('.landing')) {
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});
		var marker = null;
		 $("#pois-owl").owlCarousel({
			navigation : false,
			pagination: false,
			slideSpeed : 700,
			paginationSpeed : 800,
			singleItem:true,
			autoPlay: 8000,
			navigationText: ['Anterior', 'Siguiente'],
			afterAction: function(element) {
				if(marker != null) {
					marker.setMap(null);
				}
				var item = this.currentItem;
				var lng = $('#poi-'+item).attr('data-lng');
				var lat = $('#poi-'+item).attr('data-lat');
				
				var coordinate = new google.maps.LatLng(lat, lng);
				map.gMap.setZoom(15);
				map.gMap.setCenter(coordinate);
				
				marker = new google.maps.Marker({
			      position: coordinate,
			      map: map.gMap,
						icon: "assets/"+$('#poi-'+item).attr('data-marker')
				});
				
			}
		});
		
		setInterval(function() {
			var first = $($('.group-hidden')[0]);
			first.addClass('group').removeClass('group-hidden');		
			first.remove();
			$('#c-groups').append(first);

			$($('.group')[0]).addClass('group-hidden').removeClass('group');
		}, 8000);

		$('.fancybox').fancybox({
			openEffect: 'elastic',
	    helpers: {
	        media: {}
	    }
	  });
		
		map.gMap.set('scrollwheel', false);
		google.maps.event.addDomListener(window, "resize", function() {
		 var center = map.gMap.getCenter();
		 google.maps.event.trigger(map.gMap, "resize");
		 map.gMap.setCenter(center); 
		});
		$(window).trigger('resize');
	}
	
	var mobileOS;    // will either be iOS, Android or unknown
	var mobileOSver; // this is a string, use Number(mobileOSver) to convert

	function getOS()
	{
	  var ua = navigator.userAgent;
	  var uaindex;

	  // determine OS
	  if ( ua.match(/iPad/i) || ua.match(/iPhone/i) )
	  {
	    mobileOS = 'iOS';
	    uaindex  = ua.indexOf( 'OS ' );
	  }
	  else if ( ua.match(/Android/i) )
	  {
	    mobileOS = 'Android';
	    uaindex  = ua.indexOf( 'Android ' );
	  }
	  else
	  {
	    mobileOS = 'unknown';
	  }

	  // determine version
	  if ( mobileOS === 'iOS'  &&  uaindex > -1 )
	  {
	    mobileOSver = ua.substr( uaindex + 3, 3 ).replace( '_', '.' );
	  }
	  else if ( mobileOS === 'Android'  &&  uaindex > -1 )
	  {
	    mobileOSver = ua.substr( uaindex + 8, 3 );
	  }
	  else
	  {
	    mobileOSver = 'unknown';
	  }
	}
	
	getOS();
	if(mobileOS == 'iOS') {
		$('.android').fadeOut();
	} else if(mobileOS == 'Android') {
		$('.ios').fadeOut();
	}
	
});
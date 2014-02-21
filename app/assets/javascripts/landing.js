//= require jquery.fancybox.pack
//= require jquery.fancybox-media

$(document).ready(function() {	
	if($.isDefined('.landing')) {
		$.fn.fullpage({
			css3: true,
			navigation: true,
			resize : true,
			anchors:['main', 'video', 'discover', 'pedal-punch', 'routes', 'events', 'friends'], 
			afterLoad: function(anchorLink, index){
	       //using index
	       if(index == '2'){
						loadMap();
	       }
       }
		});

		$("#owl-demo").owlCarousel({
			navigation : false, // Show next and prev buttons
			slideSpeed : 300,
			paginationSpeed : 400,
			singleItem:true,
			transitionStyle : "fade",
			autoPlay: 3000
		});
		
		$("#owl-routes").owlCarousel({
			navigation : false, // Show next and prev buttons
			slideSpeed : 300,
			paginationSpeed : 400,
			singleItem:true,
			transitionStyle : "fade",
			autoPlay: 3000
		});
		
		$("#owl-pedal-punch").owlCarousel({
			navigation : false, // Show next and prev buttons
			slideSpeed : 300,
			paginationSpeed : 400,
			singleItem:true,
			transitionStyle : "fade",
			autoPlay: 3000
		});
		
		var loadMap = function() {
			if(map == null) {
				map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});
				var marker = null;
				$('#map').removeClass('hidden').fadeIn();
				
				
				var idx = 0;
				var traverse = function() {
					$('#poi-details').html($('#poi-'+idx).clone());
					$('#poi-details .poi').fadeIn();
					
					var lng = $('#poi-'+idx).attr('data-lng');
					var lat = $('#poi-'+idx).attr('data-lat');
					var coordinate = new google.maps.LatLng(lat, lng);
					map.gMap.setZoom(15);
					map.gMap.setCenter(coordinate);

					if(marker != null) {
						marker.setMap(null);
					}
					
					marker = new google.maps.Marker({
				      position: coordinate,
				      map: map.gMap,
							icon: "assets/"+$('#poi-'+idx).attr('data-marker')
					});
					
					if($('.poi-list').children('.poi').length-1 == idx) {
						idx = 0;
					} else {
						idx++;
					}
					setTimeout(traverse, 8000);
				}
				traverse();
			}
		}
	}

});
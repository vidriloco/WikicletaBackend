$(document).ready(function() {
	if($.isDefined('#cycling-groups-section')) {
		sectionValue = $('#cycling-groups-section').attr('data-url');
		
		Discover = function() {

			var thisInstance = null;
			var paths = null;
			var markersOnPath = null;
			var previousZoom = defaultZoom;
			
			var initialize = function() {
				thisInstance = this;
				
				map.eventsForMapIdle('#map', function() {
					if(sectionValue && currentlyOnIndex) {
						loadCyclingGroupsOnMap();
					}
				});
				
				return this;
			}

			this.onIndex = function() {
				currentlyOnIndex = true;
				google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
					offsetCenter(map.gMap.getCenter(), 200, -50);
				});
				loadCyclingGroupsOnMap();
				$('.listing-view .item-wrapper').removeClass('with-focus');
				map.gMap.setZoom(previousZoom);
			}

			this.onDetailsFor = function() {
				var item = this.params['item'];
				
				if(!$.isDefined('#'+item)) {
					$('.spinner').fadeIn();
					
					fetchSectionPartial(item, function() {
						$('#'+item).addClass('with-focus');
						
						// Actions after html update
						afterHTMLUpdated();
						// Show back button 
						$('#back-to-listing').fadeIn();
						
						// Center map to marker 
						var location = zoomToItem(item);

						google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
							offsetCenter(location, 200, -50);
						});
						
						$('.item-wrapper').hide();
						$('#'+item).fadeIn();
						
					});
				} else {
					// Center map to marker 
					var location = zoomToItem(item);
					google.maps.event.addListenerOnce(map.gMap, 'idle', function(){
						offsetCenter(location, 200, -50);
					});
					
					$('#'+item).addClass('with-focus');
					$('.item-wrapper').hide();
					$('#'+item).fadeIn();
					$('#back-to-listing').fadeIn();
				}
				currentlyOnIndex = false;
			}
			
			var loadCyclingGroupsOnMap = function() {
				$('.spinner').fadeIn();
				fetchSectionPartial(undefined, function() {
					// Actions after html update
					afterHTMLUpdated();
				});
			}
			
			var afterHTMLUpdated = function() {
				// Stop spinner
				$('.spinner').fadeOut();
				// Always display listing actions
				$('.listing-actions').show();
				$('#back-to-listing').hide();
				
				var items = $('.listing-view').children();
				if(items.length > 0) {
					drawSelectedItems(items);
				}
			}
			
			var zoomToItem = function(item) {
				previousZoom = map.gMap.getZoom();
				// Center map to marker 
				var location = new google.maps.LatLng(parseFloat($('#'+item).attr('data-lat')), parseFloat($('#'+item).attr('data-lon')));
				map.gMap.setZoom(19);
				return location;
			}
			
			initialize();
		}
	}
});
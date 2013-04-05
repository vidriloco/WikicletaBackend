// Routes sub-urls depending on the selection status
var placesUrlSwitch = function(domElement, id) {
	if(domElement.hasClass('with-focus')) {
		$.visit('#/places');
	} else {
		if(domElement.hasClass('workshop')) {
			$.visit('#/places/workshops/'+id);
			
		} else if(domElement.hasClass('parking')) {
			$.visit('#/places/parkings/'+id);
			
		}
	}
}

/*   
 *  Routing for places at #/places
 */
Routing.Places = function() {
	var thisInstance = this;
	var initialize = function() {

		return thisInstance;
	}

	this.onIndex = function() {
		var afterViewFetchedActions = function() {
			commonLoading();
			drawSelectedItems($('.listing-view .place'), placesUrlSwitch);
			// insert map at top of the listing
			$(parentDom+'#map').insertBefore('.listing-view .first');
			// unmark all marked incidents
			$(parentDom+'.listing-view .place').removeClass('with-focus');
			map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
			$.scrollToTop();
		}

		fetchView(afterViewFetchedActions, null);
	}
	
	this.onSection = function() {
		var kind = this.params['kind'].slice(0,-1);
		
		var afterViewFetchedActions = function() {
			commonLoading();
			
			// Hide places
			$('.listing-view .place').fadeOut();
			// Show items of kind
			$('.listing-view .'+kind).fadeIn();
			
			drawSelectedItems($('.listing-view .'+kind), placesUrlSwitch);
			
			// insert map at top of the listing
			$(parentDom+'#map').insertBefore('.listing-view .first');
			// unmark all marked incidents
			$(parentDom+'.listing-view .place').removeClass('with-focus');
			map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
			$.scrollToTop();
		}
		fetchView(afterViewFetchedActions, null);
	}

	this.onItem = function() {
		var id = this.params['id'];
		var kind = this.params['kind'].slice(0,-1);
		
		var afterViewFetchedActions = function() {
			// dom element for item list kind
			var domElement = parentDom+'.listing-view .'+kind+'-list #'+id;

			commonLoading();
			// move map above incident
			$(parentDom+'#map').insertBefore(domElement);
			// unmark any previously marked incident
			$(parentDom+'.'+kind).removeClass('with-focus');
			// mark the incident
			$(domElement).addClass('with-focus');
			// draw selected incidents on map
			drawSelectedItems([domElement], placesUrlSwitch);
			map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
			$.scrollFromMapToDom(domElement, 40);
		}

		fetchView(afterViewFetchedActions, null);
	}

	var commonLoading = function() {	
		// load map if not loaded yet
		initializeMap();
		// show section marked
		$('.actions li').removeClass('active');
		$('#places-section').addClass('active');
	}

	var fetchView = function(success_callback, failure_callback) {
		if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'places') {
			$.get('/profiles/places', {username : $(parentDom).attr('data-username') })
			.done(success_callback).fail(failure_callback);
		} else {
			success_callback();
		}
	}

	initialize();
}
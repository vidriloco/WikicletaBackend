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
			// unmark all marked incidents and make them visible
			$(parentDom+'.listing-view .place').removeClass('with-focus');
			$(parentDom+'.listing-view .place').fadeIn();
			map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
			$.scrollToTop();
		}

		fetchView(afterViewFetchedActions, null);
	}
	
	this.onSection = function() {
		loadSection(this.params['kind'].slice(0,-1));
	}

	this.onItem = function() {
		var id = this.params['id'];
		var kind = this.params['kind'].slice(0,-1);
		var domElement = parentDom+'.listing-view .'+kind+'-list #'+id;
		
		var onItemActions = function() {
			$(parentDom+'#map').insertBefore(domElement);
			// unmark any previously marked incident
			$(parentDom+'.'+kind).removeClass('with-focus');
			// mark the incident
			$(domElement).addClass('with-focus');
			$.scrollFromMapToDom('#map', 60);
			drawSelectedItems($(domElement), placesUrlSwitch);
		}
		
		loadSection(kind, onItemActions);
	}
	
	var loadSection = function(kind, callback) {

		var afterViewFetchedActions = function() {
			$('.nav li').removeClass('active');
			$('li.'+kind).addClass('active');
			
			commonLoading();
			
			// Hide places and remove focus
			$('.listing-view .place').fadeOut();
			$(parentDom+'.listing-view .place').removeClass('with-focus');
			
			// Show items of kind
			$('.listing-view .'+kind).fadeIn();
			
			if(callback != undefined) {
				callback();
			} else {
				drawSelectedItems($('.listing-view .'+kind), placesUrlSwitch);
				// insert map at top of the listing
				$(parentDom+'#map').insertBefore('.listing-view .'+kind+'-list');
			}

			// unmark all marked incidents
			map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
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
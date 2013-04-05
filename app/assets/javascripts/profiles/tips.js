/*   
 *  Routing for tips at #/tips
 */

// Routes sub-urls depending on the selection status
var tipUrlSwitch = function(domElement, id) {
	if(domElement.hasClass('with-focus')) {
		$.visit('#/tips');
	} else {
		$.visit('#/tips/'+id);
	}
}
	
Routing.Tips = function() {
	var thisInstance = this;
	var initialize = function() {

		return thisInstance;
	}

	this.onIndex = function() {
		var afterViewFetchedActions = function() {
			commonLoading();
			drawSelectedItems($('.listing-view .tip'), tipUrlSwitch);
			// insert map at top of the listing
			$(parentDom+'#map').insertBefore('.listing-view .first');
			// unmark all marked incidents
			$(parentDom+'.listing-view .tip').removeClass('with-focus');
			map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
			$.scrollToTop();
		}

		fetchView(afterViewFetchedActions, null);
	}

	this.onItem = function() {
		var id = this.params['id'];

		var afterViewFetchedActions = function() {
			// dom element for incident
			var domElement = parentDom+'.listing-view #'+id;

			commonLoading();
			// move map above incident
			$(parentDom+'#map').insertBefore(domElement);
			// unmark any previously marked incident
			$(parentDom+'.tip').removeClass('with-focus');
			// mark the incident
			$(domElement).addClass('with-focus');
			// draw selected incidents on map
			drawSelectedItems([domElement], tipUrlSwitch);
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
		$('#tips-section').addClass('active');
	}

	var fetchView = function(success_callback, failure_callback) {
		if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'tips') {
			$.get('/profiles/tips', {username : $(parentDom).attr('data-username') })
			.done(success_callback).fail(failure_callback);
		} else {
			success_callback();
		}
	}

	initialize();
}
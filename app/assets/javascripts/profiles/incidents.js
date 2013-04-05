/*   
 *  Routing for incidents at #/incidents
 *  TODO: Change to function closures as a method hidding mechanism
 */

// Routes sub-urls depending on the selection status
var incidentUrlSwitch = function(domElement, id) {
	if(domElement.hasClass('with-focus')) {
		$.visit('#/incidents');
	} else {
		$.visit('#/incidents/'+id);
	}
}
	
var Routing = {};
Routing.Incidents = function() {

	var thisInstance = null;

	var obj = {
		initialize: function() {
			thisInstance = this;
			return this;
		},

		onIndex : function() {	
			var afterViewFetchedActions = function() {
				thisInstance.commonLoading();
				// draw all available incidents on a map
				drawSelectedItems($('.listing-view .incident'), incidentUrlSwitch);
				// insert map at top of the listing
				$(parentDom+'#map').insertBefore('.listing-view .first');
				// unmark all marked incidents
				$(parentDom+'.listing-view .incident').removeClass('with-focus');
				map.placeViewportAt({ lat: defaultLat, lon: defaultLon, zoom: defaultZoom });
				$.scrollToTop();
			}

			thisInstance.fetchView(afterViewFetchedActions, null);
		},

		onItem : function() {
			var id = this.params['id'];

			var afterViewFetchedActions = function() {
				// dom element for incident
				var domElement = parentDom+'.listing-view #'+id;

				thisInstance.commonLoading();
				// move map above incident
				$(parentDom+'#map').insertBefore(domElement);
				// unmark any previously marked incident
				$(parentDom+'.incident').removeClass('with-focus');
				// mark the incident
				$(domElement).addClass('with-focus');
				// draw selected incidents on map
				drawSelectedItems([domElement], incidentUrlSwitch);
				map.placeViewportAt({ lat: $(domElement).attr('data-lat'), lon: $(domElement).attr('data-lon'), zoom: defaultMiddleZoom });
				$.scrollFromMapToDom(domElement, 40);
			}

			thisInstance.fetchView(afterViewFetchedActions, null);
		},

		fetchView: function(success_callback, failure_callback) {
			if($(parentDom).is(':empty') || $(parentDom).attr('data-section-enabled') != 'incidents') {
				$.get('/profiles/incidents', {username : $(parentDom).attr('data-username') })
				.done(success_callback).fail(failure_callback);
			} else {
				success_callback();
			}
		},

		commonLoading: function() {	
			// load map if not loaded yet
			initializeMap();
			// show section marked
			$('.actions li').removeClass('active');
			$('#incidents-section').addClass('active');
		}

	}
	return obj.initialize();
}
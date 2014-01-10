var registerDomForTrackWith = function(dom, message) {
	if($.isDefined(dom)) {
		$(dom).bind('click', function() {
			mixpanel.track(message);
		});
	}
} 

var registerTrackWith = function(message) {
	mixpanel.track(message);
}

$(document).ready(function() {
	registerDomForTrackWith('#enter-wikicleta', 'Clicked on Enter Wikicleta');
	registerDomForTrackWith('#download-wikicleta', 'Clicked on Download Wikicleta');
	registerDomForTrackWith('#explore-wikicleta', 'Clicked on Explore Wikicleta');
	registerDomForTrackWith('#twitter-wikicleta', 'Clicked on Twitter Wikicleta');
	registerDomForTrackWith('#facebook-wikicleta', 'Clicked on Facebook Wikicleta');
	registerDomForTrackWith('#video-wikicleta', 'Clicked on Video Wikicleta');
	registerDomForTrackWith('#allies-wikicleta', 'Clicked on Allies Wikicleta');
	registerDomForTrackWith('#join-wikicleta', 'Clicked on Join Wikicleta (in Downloads Section)');
	
});
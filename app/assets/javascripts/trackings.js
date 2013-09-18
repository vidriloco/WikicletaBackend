$(document).ready(function() {
	
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
	
	registerDomForTrackWith('#show-activity-trigger a', 'Profile: Activity display');
	registerDomForTrackWith('.new-cycling-group-profile', 'Profile: Register new cycling group');
	registerDomForTrackWith('.new-cycling-group', 'Discover: Register new cycling group');
	
	registerDomForTrackWith('#unselected-cities a', 'Discover: City changed');
	registerDomForTrackWith('.locate-me', 'Location Requested');
	
	registerDomForTrackWith('.discover-section-cycling-groups', 'Discover: Section cycling groups');
	registerDomForTrackWith('.discover-section-cycling-trips', 'Discover: Section trips');
	
	registerDomForTrackWith('.cycling-group .name a', 'Discover: Clicked on cycling group');
	registerDomForTrackWith('.cycling-group .pic img', 'Discover: Clicked on cycling group image');
	registerDomForTrackWith('.cycling-group', 'Discover: Clicked on cycling group (not link)');

	registerDomForTrackWith('.trip .event-name a', 'Discover: Clicked on trip');
	registerDomForTrackWith('.trip .pic img', 'Discover: Clicked on trip image');
	registerDomForTrackWith('.trip', 'Discover: Clicked on trip (not link)');
	
	registerDomForTrackWith('#back-to-listing', 'Discover: Returned to listing');
	registerDomForTrackWith('#navigation-bar a.discover', 'Landed on discover');
	
	registerDomForTrackWith('#back-to-listing', 'Discover: Returned to listing');
	registerDomForTrackWith('#navigation-bar a.discover', 'Landed on discover');
	
	registerDomForTrackWith('.details-for-group-from-profile', 'Profile: Details for cycling group');
	registerDomForTrackWith('.edit-group-from-profile', 'Profile: Edit cycling group');
	
	registerDomForTrackWith('.edit-cycling-group', 'Discover: Edit cycling group');
	
	
});
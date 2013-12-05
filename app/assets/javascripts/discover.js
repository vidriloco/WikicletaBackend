//= require common/base
//= require view_components/map.view
//= require geoposition
//= require cycling_groups
//= require discover/base
//= require discover/trips
//= require discover/cycling_groups

$(document).ready(function() {	
	
	if($.isDefined('#cycling-groups-section .listing')) {
		Path.map("#/:item").to(function() {
			registerTrackWith("Details for cycling group: " + this.params['item']);
		});
	} else {
		Path.map("#/:item").to(function() {
			registerTrackWith("Details for trip: " + this.params['item']);
		});
	}
	
	if($.isDefined('#cycling-groups-section .listing') || $.isDefined('#trips-section .listing')) {
		var discover = new Discover();
		Path.map("#/:item").to(discover.onDetailsFor);
		Path.map("#/").to(discover.onIndex);
		Path.root("#/");
		Path.listen();
	} 
});
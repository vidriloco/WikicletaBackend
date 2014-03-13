var map = null;
var infowindow = null;

var markers = [];
var trails = [];
var firstLocation = null;
var coords = [];

var instants = {};
var firstLoad = true;

var drawGraph = function(dataSpeed, dataDistance) {
	$('#user-stats').html('');
	var graph = new Rickshaw.Graph( {
		element: document.querySelector("#user-stats"),
		renderer: 'area',
		stroke: true,
		height: 150,
		series: [ {
			data: dataSpeed,
			color: 'steelblue'
		}, {
			data: dataDistance,
			color: 'lightblue'
		} ]
	} );
	
	
	var hoverDetail = new Rickshaw.Graph.HoverDetail( {
		graph: graph,
		formatter: function(series, x, y) {
			var date = '<span class="date">' + series.data[x].date + '</span>';
			var swatch = '<span class="detail_swatch" style="background-color: ' + series.color + '"></span><br/>';
			var kind = series.data[x].kind;
			
			return swatch + $('#translations').attr('data-'+kind+'-text') + ": " + parseFloat(y).toFixed(2) + ' ' + $('#translations').attr('data-'+kind+'-unit') + '<br/>' + date;
		}
	} );
	graph.render();
	
}

var fetchInstantsFor = function(startDate, endDate) {
	$('.loading').removeClass('hidden');
	$('#replaceable-content').hide();
	$.get('/api/instants/'+$('#user-data').attr('data-uid'), {start_date: startDate, end_date: endDate}).done(function(data) {
		$('#replaceable-content').html("");
		$('#stats > div').clone().appendTo('#replaceable-content');
		
		$('#replaceable-content .performance .speed .number').html(parseFloat(data.stats.speed).toFixed(2));
		$('#replaceable-content .performance .distance .number').html(parseFloat(data.stats.distance).toFixed(2));

		if(trails.length > 0) {
			for(var i = 0; i < trails.length ; i++) {
				trails[i].setMap(null);
			}
			trails = [];
		}
		
		map.resetMarkersList();
		
		var buildLine = function() {
			var path = new google.maps.Polyline({
			    path: coords,
			    strokeColor: '#29c505',
			    strokeWeight: 4
			  });
			path.setMap(map.gMap);

			trails.push(path);
			coords = [];
		}
		
		var tmpInstants = data.instants;
		for(var i = 0 ; i < tmpInstants.length ; i++) {
			var latitude = parseFloat(tmpInstants[i].lat);
			var longitude = parseFloat(tmpInstants[i].lon);
			var speed = parseFloat(tmpInstants[i].speed_at);
			var distance = parseFloat(tmpInstants[i].distance_at);
			var timing = parseFloat(tmpInstants[i].elapsed_time);
			var instantId = parseInt(tmpInstants[i].id);
			
			instants[instantId] = { speed : speed, distance : distance, timing : timing }
			
			if(timing > 1000) {
				buildLine();
			}
			
			var location = new google.maps.LatLng(latitude, longitude);
			if(firstLocation == null) {
				firstLocation = location;
			}
			
			coords.push(location);
			map.addCoordinatesAsMarkerToList({ lat: latitude, lon: longitude, iconName: 'timing-marker', resourceUrl: instantId }, function(opts) {
				$('#stats-at-point .speed').html(instants[opts.resourceUrl].speed);
				$('#stats-at-point .distance').html(instants[opts.resourceUrl].distance);
				$('#stats-at-point .timing').html((instants[opts.resourceUrl].timing/60).toFixed(2));
				
				var statsForPoint = $('#stats-at-point div').clone();
				
				if(infowindow != null) {
					infowindow.close();
				}
			  infowindow = new google.maps.InfoWindow({
			      content: statsForPoint.html()
			  });
				
				infowindow.open(map.gMap, opts.marker);
			});
		}
		
		if(coords.length > 0) {
			buildLine();
		}
		$('.loading').addClass('hidden');
		$('#replaceable-content').fadeIn();
		
		$.get('/api/instants/'+$('#user-data').attr('data-uid')+'/stats', {date: endDate, range: 7 }).done(function(data) {
			var speed = [];
			var distance = [];
			var idx = 0;
			for(var date in data) {
				speed.push({kind: 'speed', date: date, x: idx, y: parseFloat(data[date].speed) });
				distance.push({kind: 'distance', date: date, x: idx, y: parseFloat(data[date].distance) });
				
				idx++;
			}
			drawGraph(speed, distance);
		});
	});
};

$(document).ready(function() {

	if($.isDefined('.trails')) {		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {});

		// Attempt to center map on location
		$('.locate-me').bind('click', function() {
			registerTrackWith('On Locate-me selected');
			if (geoPosition.init()) {
				$('.spinner').fadeIn();
			  geoPosition.getCurrentPosition(function(p) {
					var lat = p.coords.latitude;
					var lon = p.coords.longitude;
					map.addMarkerYourLocation({ lat: lat, lon: lon });
					map.placeViewportAt({ lat: lat, lon: lon-0.01, zoom: defaultMiddleZoom });
					$('.spinner').hide();
				}, null);
			}
		});
		
		$('.minimize-view').click(function() {
			$('.inner-panel').fadeOut();
			$('.maximize-view').fadeIn();
			$('.minimize-view').hide();
			$('.activity').show();
		});

		$('.maximize-view').click(function() {
			$('.inner-panel').fadeIn();
			$('.minimize-view').fadeIn();
			$('.maximize-view').hide();
			$('.activity').hide();
		});

		$('.maximize-view').click();
		
		var formatForDate = function(date) {
			return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
		}
		
		var yesterday = new Date();
		yesterday.setDate(new Date().getDate()-1);
		fetchInstantsFor(formatForDate(yesterday), formatForDate(new Date()));
		
		$('#sandbox-date input').datepicker({
    	language: "es",
    	autoclose: true,
			format: 'mm/dd/yyyy'
    }).on('changeDate', function(e){
			if(!firstLoad) {
				var yesterday = new Date();
				yesterday.setDate(e.date.getDate()-1);
				fetchInstantsFor(formatForDate(yesterday), formatForDate(e.date));
			}
			firstLoad = false;
		});
		$('#sandbox-date input').datepicker('setDate', new Date());
	}
	
});
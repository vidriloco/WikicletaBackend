//= require common/base

$(document).ready(function() {
	
	$('#slider img:gt(0)').hide();
	    setInterval(function(){
	      $('#slider img:first-child').fadeOut(0)
	         .next('img').fadeIn(0)
	         .end().appendTo('#slider');}, 2000);

	LandingRoutes = function() {
		this.home = function() {
			$('.nav li').removeClass('active');
			$.scrollFromMapToDom('.logo-container', 0);
		}
		
		this.whatIs = function() {
			$('.nav li').removeClass('active');
			$('.nav li.what-is').addClass('active');
			$.scrollFromMapToDom('#description', 20);
		}
		
		this.register = function() {
			$('.nav li').removeClass('active');
			$('.nav li.register').addClass('active');
			$.scrollFromMapToDom('#register', 70);
		}
		
		this.allies = function() {
			$('.nav li').removeClass('active');
			$('.nav li.allies').addClass('active');
			$.scrollFromMapToDom('#allies', 70);
		}
		
		this.media_ = function() {
			$('.nav li').removeClass('active');
			$('.nav li.media_').addClass('active');
			$.scrollFromMapToDom('#media', 70);
		}
	}

	var landingRoutes = new LandingRoutes();
	Path.map("#/").to(landingRoutes.home);
	Path.map("#/what-is").to(landingRoutes.whatIs);
	Path.map('#/register').to(landingRoutes.register);
	Path.map('#/allies').to(landingRoutes.allies);
	Path.map('#/media').to(landingRoutes.media_);
	
	Path.root("#/");
	Path.listen();
});
//= require common/base

$(document).ready(function() {
	
	$('#sign-up').bind('click', function() {
		mixpanel.track("Landing :: Registration Button");
	});
	
	LandingRoutes = function() {
		this.home = function() {
			$('.nav li').removeClass('active');
			$('html,body').animate({scrollTop: $('body').offset().top}, 'slow');
		}
		
		this.whatIs = function() {
			$('.nav li').removeClass('active');
			$('.nav li.what-is').addClass('active');
			$('html,body').animate({scrollTop: $('#what-is').offset().top-70}, 'slow');
			mixpanel.track("Landing :: On What Is Section");
		}
		
		this.register = function() {
			$('.nav li').removeClass('active');
			$('.nav li.register').addClass('active');
			$('html,body').animate({scrollTop: $('#register').offset().top-70}, 'slow');
			mixpanel.track("Landing :: On Registration Section");
		}
		
		this.allies = function() {
			$('.nav li').removeClass('active');
			$('.nav li.allies').addClass('active');
			$('html,body').animate({scrollTop: $('#allies').offset().top-70}, 'slow');
			mixpanel.track("Landing :: On Allies Section");
		}
		
		this.media_ = function() {
			$('.nav li').removeClass('active');
			$('.nav li.media_').addClass('active');
			$('html,body').animate({scrollTop: $('#media').offset().top-70}, 'slow');
			mixpanel.track("Landing :: On Media Section");
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
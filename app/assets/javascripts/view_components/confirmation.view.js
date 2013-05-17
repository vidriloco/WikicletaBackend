//= require view_components/base.view

$.extend(ViewComponents, {
    Confirmation: {
			initWith: function(trigger, optionsDiv, opts) {
				$(trigger).on('click', function() {
					$(optionsDiv).fadeIn();
					$($(this).parent()).hide();
					if(opts && opts.onTrigger != undefined) {
						opts.onTrigger();
					}
				});
				
				$(optionsDiv + " .declines").on('click', function() {
					$(optionsDiv).hide();
					$($(trigger).parent()).fadeIn();
				});
				
				if(opts && opts.onAccept != undefined) {
					$(optionsDiv + " .accepts").on('click', function() {
						opts.onAccept(optionsDiv);
					});
				}
				
			}
		}
});
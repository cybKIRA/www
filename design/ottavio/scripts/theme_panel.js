$(window).load(function() {
	jQuery('#themes_panel').animate({
		opacity : 1
	}, 400);
});

$.cookie = function(name, value, options) {
	if ( typeof value !== 'undefined') {
		options = options || {};
		if (value === null) {
			value = '';
			options.expires = -1;
		}
		var expires = '';
		if (options.expires && ( typeof options.expires === 'number' || options.expires.toUTCString)) {
			var date;
			if ( typeof options.expires === 'number') {
				date = new Date();
				date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
			} else {
				date = options.expires;
			}
			expires = '; expires=' + date.toUTCString();
		}
		var path = options.path ? '; path=' + (options.path) : '';
		var domain = options.domain ? '; domain=' + (options.domain) : '';
		var secure = options.secure ? '; secure' : '';
		document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
	} else {
		var cookieValue = null;
		if (document.cookie && document.cookie !== '') {
			var cookies = document.cookie.split(';');
			for (var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				if (cookie.substring(0, name.length + 1) === (name + '=')) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	}
};

jQuery(function() {

	/* Show or hide themes panel
	 ----------------------------------------------------------*/
	var
		themesPanel = jQuery('#themes_panel'),
		themesPanelWidth = jQuery('#themes_menu').outerWidth();
	themesPanel.css('left', 0);
	themesPanel.animate({
		left : -themesPanelWidth
	}, 400);

	var closePanel = function(){
		themesPanel.animate({
			left : parseInt(themesPanel.css('left'), 10) === 0 ? -themesPanelWidth : 0
		}, 400);
	};

	jQuery('#toggle_button').click(function() {
		closePanel();
		return false;
	});

	/* If cookie exists, apply classes from cookie
	 ----------------------------------------------------------*/
	if ($.cookie('skin') !== null) {
		$.cookie('skin', $.cookie('skin'), {
			expires : 0,
			path : '/'
		});
		jQuery('#primary_color_scheme').attr('href', 'design/ottavio/styles/themes/theme_' + $.cookie('skin') + '.css');
	}
	if ($.cookie('layout') !== null) {
		var value = $.cookie('layout');
		$.cookie('layout', value, {
			expires : 0,
			path : '/'
		});
		if (value === 'boxed'){
			jQuery('body').addClass('boxed-layout');
		} else {
			jQuery('body').removeClass('boxed-layout');
		}
		jQuery('#themes_panel .layout-switcher').val(value);
		window.Ottavio.refresh();
	}
	if ($.cookie('menu') !== null) {
		var mSkin = $.cookie('menu');
		$.cookie('menu', mSkin, {
			expires : 0,
			path : '/'
		});
		jQuery('#main-navigation').removeClass('navbar-primary navbar-light navbar-semidark navbar-dark navbar-standard').addClass('navbar-' + mSkin);
		jQuery('#themes_panel .menu-switcher').val(mSkin);
	}
	if ($.cookie('footer') !== null) {
		var vFooter = $.cookie('footer');
		$.cookie('footer', vFooter, {
			expires : 0,
			path : '/'
		});
		jQuery('#footer .demo-footer').addClass('hidden');
		jQuery('#demo-footer-' + vFooter).removeClass('hidden');
		jQuery('#themes_panel .footer-switcher').val(vFooter);
	}
	if ($.cookie('bg') !== null) {
		var bg = $.cookie('bg');
		$.cookie('bg', bg, {
			expires : 0,
			path : '/'
		});
		if ( jQuery('body').hasClass('boxed-layout') )
			jQuery('body').removeAttr('class').addClass('boxed-layout ' + bg);
		else 
			jQuery('body').removeAttr('class').addClass(bg);
	}
	
	/* Change Theme Colors on click and set cookie
	 ----------------------------------------------------------*/
	jQuery('#themes_panel ul.theme.cookie_colors li a').click(function() {
		var cSkin = jQuery(this).attr('title');
		$.cookie('skin', cSkin, {
			expires : 0,
			path : '/'
		});
		jQuery('#primary_color_scheme').attr('href', 'design/ottavio/styles/themes/theme_' + cSkin + '.css');
		//closePanel();
		return false;
	});

	/* Change layout style and set cookie
	 ----------------------------------------------------------*/
	jQuery('#themes_panel .layout-switcher').change(function() {
		var _this = $(this), value = _this.val();
		if (value === 'boxed'){
			jQuery('body').addClass('boxed-layout');
		} else {
			jQuery('body').removeClass('boxed-layout');
		}
		$.cookie('layout', value, {
			expires : 0,
			path : '/'
		});
		window.Ottavio.refresh();
	});
	
	/* Change top menu style and set cookie
	 ----------------------------------------------------------*/
	jQuery('#themes_panel .menu-switcher').change(function() {
		var mSkin = jQuery(this).val();
		$.cookie('menu', mSkin, {
			expires : 0,
			path : '/'
		});
		jQuery('#main-navigation').removeClass('navbar-primary navbar-light navbar-semidark navbar-dark navbar-standard').addClass('navbar-' + mSkin);
		return false;
	});
	
	/* Change footer style and set cookie
	 ----------------------------------------------------------*/
	jQuery('#themes_panel .footer-switcher').change(function() {
		var vFooter = jQuery(this).val();
		$.cookie('footer', vFooter, {
			expires : 0,
			path : '/'
		});
		jQuery('#footer .demo-footer').addClass('hidden');
		jQuery('#demo-footer-' + vFooter).removeClass('hidden');
		return false;
	});
	
	/* Change background and set cookie
	 ----------------------------------------------------------*/
	jQuery('#themes_panel ul.theme.cookie_bg li a').click(function() {
		var bg = jQuery(this).attr('class');
		$.cookie('bg', bg, {
			expires : 0,
			path : '/'
		});

		jQuery('body').attr('class', 'boxed-layout ' + bg);
		$.cookie('layout', 'boxed', {
			expires : 0,
			path : '/'
		});
		jQuery('#themes_panel .layout-switcher').val('boxed');
		window.Ottavio.refresh();
		return false;
	});
});
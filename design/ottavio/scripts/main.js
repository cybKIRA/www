'use strict';

//  core module
var Ottavio = (function(){
    var
        events = [],
        isMobile = { //  mobile detection utility
            Android: function() {
                return navigator.userAgent.match(/Android/i);
            },
            BlackBerry: function() {
                return navigator.userAgent.match(/BlackBerry/i);
            },
            iOS: function() {
                return navigator.userAgent.match(/iPhone|iPad|iPod/i);
            },
            Opera: function() {
                return navigator.userAgent.match(/Opera Mini/i);
            },
            Windows: function() {
                return navigator.userAgent.match(/IEMobile/i);
            },
            any: function() {
                return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
            }
        },
        init = function() {
            for (var e in events){
                events[e]();
            }
        },
        refresh = function() {
           $(window).trigger('debouncedresize.slitslider').trigger('resize');
        };
    return {
        events: events,
        isMobile: isMobile,
        init: init,
        refresh: refresh
    };
})();
// end core module


// slitslider module
Ottavio.slider = (function(){
    var $navArrows = $('#nav-arrows'),
        $nav = $('#nav-dots > span'),
        $obj  = $('#slider'),
        slitslider = $obj.slitslider({
            onBeforeChange: function(slide, pos) {
                $nav.removeClass('nav-dot-current');
                $nav.eq(pos).addClass('nav-dot-current');
            }
        }),
        init = function() {
            initEvents();
        },
        initEvents = function() {
            // add navigation events
            $navArrows.children(':last').on('click', function() {
                slitslider.next();
                return false;
            });
            $navArrows.children(':first').on('click', function() {
                slitslider.previous();
                return false;
            });
            $nav.each(function(i) {
                $(this).on('click', function() {
                    var $dot = $(this);
                    if (!slitslider.isActive()) {
                        $nav.removeClass('nav-dot-current');
                        $dot.addClass('nav-dot-current');
                    }
                    slitslider.jump(i + 1);
                    return false;
                });
            });
            // everything ready, show the container
            $obj.show();
        },
        refresh = function() {
           $(window).trigger('debouncedresize.slitslider').trigger('resize');
        };
    return {
        init: init,
        refresh: refresh
    };
})();
Ottavio.events.push(Ottavio.slider.init);
// end slitslider module


// search bar module
Ottavio.searchButton = function() {
    var h = '54px';
    if ($('.search_button').length) {
        $('.search_button').click(function(a) {
            a.preventDefault();
            if (0 === $('.h_search_form').height()) {
                $('.h_search_form input[type="text"]').focus();
                $('.h_search_form').stop().animate({
                    height: h
                }, 150);
            } else {
                $('.h_search_form').stop().animate({
                    height: '0'
                }, 150);
            }
            $(window).scroll(function() {
                if (0 !== $('.h_search_form').height()) {
                    $('.h_search_form').stop().animate({
                        height: '0'
                    }, 150);
                }
            });
            $('.h_search_close').click(function(a) {
                a.preventDefault();
                $('.h_search_form').stop().animate({
                    height: '0'
                }, 150);
            });
        });
    }
};
Ottavio.events.push(Ottavio.searchButton);
// end search bar module


// pie chart module
Ottavio.pieChart = function(obj){
    var time = 1500;
    $(obj).fadeIn('slow').easyPieChart({
        //barColor: '#1abc9c',
        barColor: $('.bg-primary').css('backgroundColor'),
        trackColor: false,
        scaleColor: false,
        scaleLength: 0,
        lineCap: 'square',
        lineWidth: 5,
        size: 160,
        animate: { duration: time, enabled: true },
        onStart: function(){
            $(obj).find('.counter').countTo({
                speed: time
            });
        }
    });
};
Ottavio.events.push(Ottavio.pieChart);
// end pie chart module


// price range slider control module
var f_currentMinPrice = parseInt( $('#f_currentMinPrice').val() );
var f_currentMaxPrice = parseInt( $('#f_currentMaxPrice').val() );

Ottavio.sliderControl = function(){
    var $obj = $('.filter_price');
    if ($obj.length > 0) {
		$("#min_price").val( f_currentMinPrice );
		$("#max_price").val( f_currentMaxPrice );
        var $display = $obj.parent().find('.price_current');
        $obj.slider({
            tooltip:'hide'
        }).on('slide', function(slideEvt) {
			$("#min_price").val( slideEvt.value[ 0 ] );
			$("#max_price").val( slideEvt.value[ 1 ] );
            $display.text( slideEvt.value.join(' - ') );
        });
    }
};
Ottavio.events.push(Ottavio.sliderControl);
// end price range slider control module


// accordion icons module
Ottavio.accordionIcon = function(){
    var
        $target = $('div.panel-collapse'),
        toggleIcon = function(e){
            $(e.target)
                .prev('.accordion-heading')
                .find('.accordion-icon')
                .toggleClass('fa-minus fa-plus');
            };
    $target
        .on('hidden.bs.collapse', toggleIcon)
        .on('shown.bs.collapse', toggleIcon);
};
Ottavio.events.push(Ottavio.accordionIcon);
// end accordion icons module


// scroll effects module
Ottavio.scrollController = function() {
    var
        controller = new ScrollMagic(),
        windowHeight = $(window).innerHeight(),
        $mainNavigation = $('#main-navigation'),
        $onePageMenu = $('#one-page-menu'),
        $backToTop = $('#back_to_top'),
        $parallax = $('.parallax'),
        $fadingTitle = $('.fading-title'),
        $charts = $('#charts-wrapper'),
        $timer = $('#timer-wrapper');

    function getWindowHeight() {
        return windowHeight;
    }

    controller.scrollTo(function (newpos) {
        TweenMax.to(window, 0.8, {scrollTo: {y: newpos, autoKill:false}});
    });

    // adds 'opaque' class to navigation when scrolling down
    if ($mainNavigation.length > 0) {
        new ScrollScene({ offset: $mainNavigation.height() })
            .setClassToggle($mainNavigation, 'opaque')
            .addTo(controller);
    }

    // handles 'back to top' button
    if ($backToTop.length > 0) {
        var h = getWindowHeight();
        new ScrollScene({ offset: h })
            .addTo(controller)
            .on('enter', function() {
                $backToTop.fadeIn('fast');
            })
            .on('leave', function() {
                $backToTop.fadeOut('slow');
            });
        $backToTop.click(function(e){
            e.preventDefault();
            controller.scrollTo(0);
        });
    }

    // navigation behaviour on one page layout
    if ($onePageMenu.length > 0) {
        $onePageMenu.find('a[href^=#]').each(function(){
            var
                _this = $(this),
                _target = _this.attr('href'),
                _duration = $(_target).outerHeight();

            // highlights the proper navigation link when the relevant area is in the viewport
            new ScrollScene({triggerElement: _target, triggerHook: 'onCenter', duration:_duration })
                .setClassToggle(_this.parent(), 'active')
                .addTo(controller);

            _this.click(function(e){
                if (_target.length > 0) {
                    e.preventDefault();

                    // smooth scrolling
                    controller.scrollTo(_target);

                    // if supported by the browser, handles the Back button
                    if (window.history && window.history.pushState) {
                        history.pushState('', document.title, _target);
                    }
                }
            });
        });
    }

    // parallax background
    if ($parallax.length > 0) {
        var testMobile = Ottavio.isMobile.any();
        if (testMobile === null) {
            $parallax.each(function(){
                var
                    _this = $(this),
                    _duration = _this.outerHeight() + getWindowHeight();
                    //bgPosMovement = 'center ' + (-Math.abs(_duration*0.35)) + 'px';
                //_this.css({ backgroundSize:'100%'});
                new ScrollScene( {triggerElement: _this, duration: _duration, triggerHook: 'onEnter'} )
                    .setTween( TweenMax.to(_this, 1, {backgroundPosition:'100% 50%', ease: Linear.easeNone}) )
                    .addTo( controller );
            });
        }
    }

    // fades and shifts page title when scrolling down
    if ($fadingTitle.length > 0){
        $fadingTitle.each(function(){
            var
                _this = $(this),
                _element = _this.find('.section-title').first(),
                _duration = _this.outerHeight() + getWindowHeight(),
                offset = _duration*0.35,
                alpha = 1 / (_duration);

            new ScrollScene( {triggerElement: _this, duration: _duration, triggerHook: 'onLeave'} )
                .setTween( TweenMax.to(_element, 1, {marginTop: offset+'px', marginBottom: -Math.abs(offset)+'px', opacity:alpha}) )
                .addTo( controller );
        });
    }

    // start charts plotting when scrolled into view
    if ($charts.length > 0) {
        new ScrollScene( {triggerElement: $charts} )
            .addTo( controller )
            .on('enter', function() {
                Ottavio.pieChart('.chart');
            });
    }

    // start charts plotting when scrolled into view
    if ($timer.length > 0) {
        new ScrollScene( {triggerElement: $timer} )
            .addTo( controller )
            .on('enter', function() {
                $('.timer').countTo();
            });
    }

    // updates windowHeight on resize
    $(window).on('resize', function () {
        windowHeight = $(window).innerHeight();
    });
};
Ottavio.events.push(Ottavio.scrollController);
// end scroll effects module


// isotope module
Ottavio.isotope = function(){
  var
    $container = $('#isotope'),
    $filter = $('#filters'),
    instance = null,
	filter_value = $filter.find('.btn-primary').data('filter'),
    options = {
        itemSelector: '.item',
        layoutMode: 'masonry',
        masonry: null,
		filter: filter_value
    },
    calculateColumns = function(width) {
        var boxed = isBoxedLayout(),
            factor = 1;
        if (width > 435 && width < 723) {
            factor = 2;
        } else if(width > 722 && width < 1155) {
            factor = 3;
        } else if(width > 1154) {
            factor =  boxed ? 3 : 4;
        }
        //console.log(width+'/'+factor);
        return width/factor;
    },
    isBoxedLayout = function(){
        return $('body').hasClass('boxed-layout');
    },
    doFilter = function() {
        var
            _this  = $(this),
            _group = _this.parent(),
            value  = _this.attr('data-filter');
        instance.isotope({
            filter: value
        });
        _group.find('.btn-primary').removeClass('btn-primary');
        _this.addClass('btn-primary');
    };

    if ($container.length > 0) {
        if ($container.hasClass('portfolio-full')) {
            options.itemSelector = '.item-full';
            options.layoutMode = 'vertical';
        } else {
            options.masonry = {
                columnWidth: calculateColumns( $container.width() )
            };
        }
        if ($.fn.isotope !== undefined) {
            instance = $container.isotope(options);

            // layout Isotope again after all images have loaded
            instance.imagesLoaded( function() {
              instance.isotope('layout');
            });

            // bind filter button click
            if ($filter.length > 0){
                $filter.on('click', 'button', doFilter);
            }
            // re-arrange on window resize
            $(window).resize(function(){
                instance.isotope({
                    masonry: {
                        columnWidth: calculateColumns($container.width())
                    }
                });
            });
        } else {
            console.error('Isotope not available!');
        }
    }
};
Ottavio.events.push(Ottavio.isotope);
// end isotope module


// google maps module
/*
Ottavio.gmaps = function(){
    var
        $elem = $('#map-canvas'),
        options = window.mapOptions || {},
        apiLoad = function() {
            $.getScript('https://maps.googleapis.com/maps/api/js?v=3.exp&callback=Ottavio.gmaps')
                //.done(function (script, textStatus) { })
                .fail(function (jqxhr) {
                    console.error('Could not load Google Maps: ' + jqxhr);
                });
        },
        initMap = function(){
            if ($.fn.gMap !== undefined) {
                $elem.gMap(options);
            } else {
                console.error('jQuery.gMap not available!');
            }
        };

    if (window.google && google.maps) {
        initMap();
    } else {
        apiLoad();
    }
    return {
        init: initMap
    };
};
Ottavio.events.push(Ottavio.gmaps);
*/
// end google maps module


// Ajax portfolio module
Ottavio.portfolio = function(){
    var
        obj               = '#portfolio-gallery',
        $obj              = $(obj),
        hash              = '',
        url               = '',
        page              = '',
        wrapperHeight     = '',
        ajaxLoading       = false,
        pageRefresh       = true,
        content           = false,
        current           = '',
        next              = '',
        prev              = '',
        target            = '',
        scrollPosition    = '',
        projectIndex      = '',
        projectLength     = '',
        loadingError      = '<div class="alert alert-warning">content not available.</div>',
        portfolioGrid     = $('.portfolio', $obj),
        loader            = $('.loader', $obj),
        projectContainer  = $('.ajax-content-inner', $obj),
        messageContainer  = $('.status-message', $obj),
        exitProject       = $('.closeProject', $obj),
        nextLink          = $('.nextProject', $obj),
        prevLink          = $('.prevProject', $obj),
        projectNav        = $('.project-navigation', $obj),
        easing            = 'easeOutExpo',
        folderName        = $obj.data('folder');

    $(window).bind( 'hashchange', function() {
        hash = $(window.location).attr('hash');
        var root = '#!'+ folderName +'/';
        var rootLength = root.length;

        if (hash.substr(0, rootLength) !== root){
            return;

        } else {
            var
                correction = 50,
                headerH = $('nav').outerHeight() + correction;

            hash = $(window.location).attr('hash');
            url = hash.replace(/[#\!]/g, '' );

            portfolioGrid.find('.item.current').removeClass('current' );

            /* url pasted in address bar (or page refresh) */
            if (pageRefresh === true && hash.substr(0, rootLength) === root) {
                $('html, body').stop().animate({ scrollTop: (projectContainer.offset().top-20)+'px'}, 800, easing, function(){
                    loadProject();
                });

                /* click on portfolio grid or project navigation */
            } else if(pageRefresh === false && hash.substr(0,rootLength) === root) {
                $('html,body').stop().animate({scrollTop: (projectContainer.offset().top-headerH)+'px'}, 800, easing, function(){
                    if (content === false) {
                        loadProject();
                    } else {
                        projectContainer.animate({opacity:0, height:wrapperHeight}, loadProject );
                    }
                    projectNav.fadeOut('100');
                    exitProject.fadeOut('100');
                });

                /* click on browser back button (no refresh)  */
            } else if (hash === '' && pageRefresh === false || hash.substr(0,rootLength) !== root && pageRefresh === false || hash.substr(0,rootLength) !== root && pageRefresh === true) {
                scrollPosition = hash;
                $('html, body').stop().animate({scrollTop: scrollPosition+'px'}, 1000, deleteProject );
            }

            /* add active class to selected project  */
            portfolioGrid.find('.item a[href="#!' + url + '"]' ).parents('li').addClass( 'current' );
        }
        return false;
    });

    function loadProject(){
        loader.fadeIn();
        messageContainer.animate({
            opacity:0,
            height:'0px'
        }).empty();
        if (!ajaxLoading) {
            ajaxLoading = true;
            projectContainer.load( url + ' .ajaxpage', function(xhr, statusText){
            if (statusText === 'success') {
                page =  $('.ajaxpage', obj);

                $('.ajaxpage', obj).waitForImages(function() {
                    hideLoader();
                    ajaxLoading = false;
                });
                $('.owl-carousel', $obj).owlCarousel();
                projectNav.fadeIn();
            }

                if (statusText === 'error') {
                    projectContainer
                        .animate({
                            opacity:0,
                            height:'0px'
                        })
                        .empty();
                    messageContainer
                        .html( loadingError )
                        .animate( {
                            opacity: 1,
                            height: (messageContainer.find('.alert').outerHeight(true)+'px')
                        });
                    hideLoader();
                    ajaxLoading = false;
                }
            });
        }
    }

    function hideLoader(){
        loader.fadeOut('fast', function(){
            showProject();
        });
    }

    function showProject(){
        if (content === false){
            wrapperHeight = projectContainer.children('.ajaxpage').outerHeight() + 'px';
            projectContainer.animate({opacity:1, height:wrapperHeight}, function(){
                scrollPosition = $('html, body').scrollTop();
                exitProject.fadeIn();
                content = true;
            });
        } else {
            wrapperHeight = projectContainer.children('.ajaxpage').outerHeight() + 'px';
            projectContainer.animate({opacity:1, height:wrapperHeight}, function(){
                scrollPosition = $('html, body').scrollTop();
                exitProject.fadeIn();
            });
        }

        projectIndex = portfolioGrid.find('.item.current').index();
        projectLength = $('.item', obj).length-1;

        if (projectIndex === projectLength) {
            nextLink.addClass('disabled');
            prevLink.removeClass('disabled');

        } else if (projectIndex === 0){
            nextLink.addClass('disabled');
            prevLink.removeClass('disabled');

        } else {
            nextLink.removeClass('disabled');
            prevLink.removeClass('disabled');
        }
    }

    function deleteProject(closeURL){
        projectNav.fadeOut(100);
        exitProject.fadeOut(100);
        projectContainer.animate({opacity:0, height:'0px'}).empty();
        messageContainer.animate({opacity:0, height:'0px'}).empty();

        if (typeof closeURL !== 'undefined' && closeURL !== '') {
            location = '#_';
        }
        portfolioGrid.find('.item.current').removeClass('current' );
    }

    /* link to next project */
    nextLink.on('click',function () {
        current = portfolioGrid.find('.item.current');
        next = current.next('.item');
        target = $(next).find('a.ajax_load').attr('href');
        $(this).attr('href', target);
        if (next.length === 0) {
            return false;
        }
        current.removeClass('current');
        next.addClass('current');
    });

    /* link to previous project */
    prevLink.on('click',function () {
        current = portfolioGrid.find('.item.current');
        prev = current.prev('.item');
        target = $(prev).find('a.ajax_load').attr('href');
        $(this).attr('href', target);
        if (prev.length === 0) {
            return false;
        }
        current.removeClass('current');
        prev.addClass('current');
    });

    /* close project */
    exitProject.on('click',function () {
        deleteProject( $(this).find('a').attr('href') );
        loader.fadeOut();
        return false;
    });

    // if passed in by the url, load the required portfolio detail
    $(window).trigger( 'hashchange' );

    pageRefresh = false;
};
Ottavio.events.push(Ottavio.portfolio);
// end Ajax portfolio module

// Contacts form module
/*
Ottavio.contactForm = function(){
    var
        $form = $('#contactForm'),
        $msgSuccess = $('#successMessage'),
        $msgFailure = $('#failureMessage'),
        $msgIncomplete = $('#incompleteMessage'),
        messageDelay = 2000;

    $form.validate({
        invalidHandler: function(event, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                $msgIncomplete.show();
            } else {
                $msgIncomplete.fadeOut();
            }
        },
        submitHandler: function(form) {
            var
                _form = $(form),
                data = _form.serialize(),
                action = _form.attr('action');

            data += '&ajax=true';
            $msgIncomplete.fadeOut();
            _form.fadeOut();

            $.post(action, data)
                .done(function(response){
                    if (response === 'success'){
                        $msgSuccess.fadeIn().delay(messageDelay).fadeOut();
                        _form.trigger('reset');
                    } else {
                        $msgFailure.fadeIn().delay(messageDelay).fadeOut();
                    }
                })
                .fail(function() {
                    $msgFailure.fadeIn().delay(messageDelay).fadeOut();

                })
                .always(function(){
                    _form.delay(messageDelay+500).fadeIn();
                });
            return false;
        }
    });
};
Ottavio.events.push(Ottavio.contactForm);
*/
// end Contacts form module
$(document).ready(function() {
    // loading overlay
	/*
    $('body').queryLoader2({
        //barColor: '#222',
        backgroundColor: '#fff',
        percentage: false,
        barHeight: 3,
		//minimumTime: 6000

    });
	*/
	
    $('.slider_slick').slick({
			slidesToShow: 4,
			slidesToScroll: 4
	  });
	
    $('#load').fadeOut().remove();
	
    $('.dropdown-menu').click(function(e) {
        e.stopPropagation();
    });

    $('input, textarea').placeholder();

    // Start TouchSpin function
    $('input.qty').TouchSpin({
		min: 1
	});

    // Start FitVids function
    $('body').fitVids();
    $('.background-video video').fillparent();

    // Swiper function
    $('.swiper-container').swiper({
        slidesPerView: 'auto'
    });

    // Start OwlCarousel
    $('.owl-carousel').owlCarousel({
      autoPlay : false
    });

	// Magnific Popup
	$('.mfp-gallery').magnificPopup({
		delegate: 'a',
        type: 'image',
        gallery: {
			enabled:true
        },
		mainClass: 'mfp-fade',
		fixedContentPos: false,
		fixedBgPos: true,
		overflowY: 'auto',
		closeBtnInside: true,
		midClick: true,
		removalDelay: 300,
		callbacks: {
			open: function() {
				$('.mfp-wrap').on({
					'mousewheel': function(e) {
						//if (e.target.id == 'el') return;
						e.preventDefault();
					}
				})
			}
		}
	});

	// Activate comments tab on product page
	var hash = window.location.hash;
	hash && $('ul.nav a[href="' + hash + '-tab"]').tab('show');

    // Start WOW animations
    if (!Ottavio.isMobile.iOS()) {
        new WOW().init();
    }

	// Scroll to comment in post page
	$('.scroll-to-comments').on('click', function(e){
		e.preventDefault();
		
		var target = this.hash;
		var $target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		}, 900, 'swing', function () {
			window.location.hash = target;
		});
	})
	
	// Scroll to comment in product page
	$('.scroll-to-product-comments').on('click', function(e){
		e.preventDefault();
		
		var target = this.hash;
		var $target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		}, 900, 'swing', function () {
			window.location.hash = target;
		});
		
		$('ul.nav a[href="' + target + '-tab"]').tab('show');
	})
	
    // init Theme functions
    Ottavio.init();

}).on('click','.navbar-toggle',function() {
    // toggle navigation
    $('.navbar-collapse').toggleClass('in');

}).on('click','.navbar-collapse.in',function(e) {
    // close navigation on click
    if( $(e.target).is('a') ) {
        $('.navbar-collapse').toggleClass('in');
    }
});

// Change product price
$('select[name=variant]').on('change', function() {
	var price = $(this).find('option:selected').data('price');
	var compare = '';
	if( typeof $(this).find('option:selected').data('compare') == 'string' ) {
		var compare = $(this).find('option:selected').data('compare');
	}
	$('#product-price').html(price)
	$('#product-compare').html(compare)
	return false;	
});


// Add product in cart
var hide_notify = setTimeout(function () {
	$('#cart_informer_notify').removeClass('showed');
}, 2500);

$('form.variants').on('submit', function(e) {
	var name = $(this).data('name')
	var v_name = '';
	console.log(typeof $(this).find('option:selected').data('name'))
	if( typeof $(this).find('option:selected').data('name') == 'string' )
		var v_name = ', ' + $(this).find('option:selected').data('name')
		
	var button = $(this).find('button[type="submit"]');
	var button_add = $(this).find('#button_add');
	var amount_add = $(this).find('#amount_add');
	
	if($(this).find('input[name=variant]:checked').size()>0)
		var variant = $(this).find('input[name=variant]:checked').val();
	if($(this).find('select[name=variant]').size()>0)
		var variant = $(this).find('select').val();
		
	var amount = $(this).find('input[name=amount]').val();		
	
	$.ajax({
		url: "ajax/ottavio_cart.php",
		data: {variant: variant, amount: amount},
		dataType: 'json',
		success: function(data){
			$('#dropdownMenuCart').html('<i class="fa fa-shopping-cart fa-lg"></i>&nbsp;<span class="badge">' + data.count + '</span>');
			$('#cart_informer').html(data.products);
			console.log('"<strong>' + name + '</strong>' + v_name + '" добавлен в корзину.');
			$('#cart_informer_notify .notify-content').html('"<strong>' + name + '</strong>' + v_name + '" добавлен в корзину.').parent().addClass('showed');

			clearTimeout(hide_notify);
			hide_notify = setTimeout(function () {
				$('#cart_informer_notify').removeClass('showed');
			}, 2500);

			button.html('<i class="fa fa-shopping-cart"></i> Добавлено')
			button_add.html('<span class="btn btn-success btn-lg"><a href="/cart">Перейти в корзину</a></span>');
			amount_add.html('<div class="added_cart">Добавлено!</div>');
		}
	});

	return false;
});

// Login top menu
$("#loginForm").submit(function() {
	$.ajax({
		type: "POST",
		url: "ajax/ottavio_login.php",
		data: $("#loginForm").serialize(),
		success: function(data) {
			switch (data) {
				case 'correct' :
					location.reload();
					break;
				case 'user_disabled' :
					$('#loginResult').html('<div class="alert alert-danger in fade">Ваш аккаунт еще не активирован</div>')
					break;
				case 'login_incorrect' :
					$('#loginResult').html('<div class="alert alert-danger in fade">Неверный логин или пароль</div>')
					break;
			}
		},
		error: function(data){
			alert('Произошла ошибка, повторите попытку позже.')
		}
	});

	return false;
});

// Login popup on product page
$("#modalLoginForm").submit(function() {
	$.ajax({
		type: "POST",
		url: "ajax/ottavio_login.php",
		data: $("#modalLoginForm").serialize(),
		success: function(data) {
			switch (data) {
				case 'correct' :
					location.reload();
					break;
				case 'user_disabled' :
					$('#modalLoginResult').html('<div class="alert alert-danger in fade">Ваш аккаунт еще не активирован</div>')
					break;
				case 'login_incorrect' :
					$('#modalLoginResult').html('<div class="alert alert-danger in fade">Неверный логин или пароль</div>')
					break;
			}
		},
		error: function(data){
			alert('Произошла ошибка, повторите попытку позже.')
		}
	});

	return false;
});

// Feedback form on feedback page
$("#contactForm").submit(function() {
	$.ajax({
		type: "POST",
		url: "ajax/ottavio_feedback.php",
		data: $("#contactForm").serialize(),
		success: function(data) {
			if(data.status == 'success') {
				$('#contactForm').html('<div class="alert alert-success in fade"><strong>' + data.data + '</strong>,&nbsp;ваше сообщение отправлено.</div>')
				$('html, body').animate({
					scrollTop: $("#contactSection").offset().top
				}, 1000);
			} else {
				$('#contactResult').html('<div class="alert alert-danger in fade" style="margin-bottom: 30px">' + data.data + '</div>')
			}
		},
		error: function(data){
			alert('Произошла ошибка, повторите попытку позже.')
		}
	});

	return false;
});

// Feedback form on footer
$("#contactFormFooter").submit(function() {
	$.ajax({
		type: "POST",
		url: "ajax/ottavio_feedback.php",
		data: $("#contactFormFooter").serialize(),
		success: function(data) {
			if(data.status == 'success') {
				$('#contactFormFooter').html('<div class="alert alert-success in fade small"><strong>' + data.data + '</strong>,&nbsp;ваше сообщение отправлено.</div>')
			} else {
				$('#contactFormFooterResult').html('<div class="alert alert-danger in fade small" style="margin-bottom: 30px">' + data.data + '</div>')
			}
		},
		error: function(data){
			alert('Произошла ошибка, повторите попытку позже.')
		}
	});

	return false;
});
// Feedback form
$("#commentProductForm").submit(function() {
	$('#commentResult').html('<img src="/design/ottavio/images/loader.gif" >');
	var formData = new FormData($('#commentProductForm')[0]);
	$.ajax({
		type: "POST",
		url: "ajax/ottavio_comment.php",
		processData: false,
		contentType: false,
		data: formData, //$("#commentProductForm").serialize(),
		success: function(data) {
			if(data.status == 'success') {
				$('#commentProductForm').html('<div class="alert alert-success in fade"><strong>' + data.data + '</strong>,&nbsp;комментарий отправлен на модерацию.</div>')
				$('html, body').animate({
					scrollTop: $("#comment-form").offset().top
				}, 1000);
			} else {
				$('#commentResult').html('<div class="alert alert-danger in fade" style="margin-bottom: 30px">' + data.data + '</div>')
			}
		},
		error: function(data){
			alert('Произошла ошибка, повторите попытку позже.')
		}
	});
	
	
	return false;
	
});

// Products Sort
$('#products_sort').change(function() {
	window.location = $(':selected',this).val()
});

$('#purchases')	.delegate('.qty', 'change', function( ev ){
					ev.preventDefault();
					update_cart( $(this).data('id'), $(this).val() );
				})
				.delegate('.remove-button ', 'click', function( ev ){
					ev.preventDefault();
					remove_item_cart( $(this).data('id') );
				})

$('#cart_informer').delegate('.delete', 'click', function( ev ){
					ev.preventDefault();
					remove_item_cart( $(this).data('id') );
				})
				
// Применение купона
//----------------------------------------//
$("input[name='coupon_code']").keypress(function(ev){
	if(ev.keyCode == 13){
		ev.preventDefault();
		apply_coupon();
	}
});

$('#coupon_apply').click(function(ev){
	ev.preventDefault();
	apply_coupon();
})

function apply_coupon(){
	var delivery_id = $('#deliveries').find('input:checked').val();
	var coupon_code = $("#coupon_code").val();
	
	$.ajax({
		url: "ajax/ottavio_cart_update.php",
		data: { 'coupon_code':coupon_code, 'delivery_id': delivery_id },
		success: function(data){
			if(data){
				$('#cart_coupon').html(data.cart_coupon);
				$('#cart_total').html(data.cart_total);
				$('#coupon_result').html(data.coupon_result);
				if ( data.coupon_status == 'success' ) {
					$('#coupon_result').removeAttr('class');
					$('#coupon_result').addClass('alert  alert-success');
					$('#cart_coupon').parent().removeAttr('class');
				} else if ( data.coupon_status == 'empty' ) {
				    $('#coupon_result').removeAttr('class');
					$('#coupon_result').addClass('alert alert-danger');
					$('#coupon_result').html('Введите код купона');
				} else {
					$('#coupon_result').removeAttr('class');
					$('#coupon_result').addClass('alert alert-danger');
					$('#cart_coupon').parent().addClass('hidden')
				}
			}
			console.log(data)
		}
	});
}


// Обновление корзины
//----------------------------------------//
function update_cart(variant_id,amount){
	var delivery_id = $('#deliveries').find('input:checked').val();
	var coupon_code = $("#coupon_code").val();
	
	$.ajax({
		url: "ajax/ottavio_cart_update.php",
		data: { 'variant_id':variant_id, 'amount':amount, 'delivery_id': delivery_id, 'coupon_code':coupon_code},
		success: function(data){
			if(data){
				$('#cart_title').html(data.cart_title);
				$('#dropdownMenuCart').html('<i class="fa fa-shopping-cart fa-lg"></i>&nbsp;<span class="badge">' + data.incart + '</span>');
				$('#cart_informer').html(data.cart_informer);
				if ( data.incart == 0 ) {
					$('#dropdownMenuCart').html('<i class="fa fa-shopping-cart fa-lg"></i>');
					$('#purchases').after('<div class="container sep-bottom-5x"><div class="row"><div class="col-md-12"><div role="alert" class="alert alert-info alert-dismissible">В корзине нет товаров.</div></div></div></div>').remove();
				} else {
					$('#cart_item_total_'+variant_id).html(data.cart_item_total);
					$('#cart_items_total').html(data.cart_items_total);
					$('#cart_total').html(data.cart_total);
					$('#deliveries').html(data.deliveries);
					$('#delivery_cost').html(data.delivery_cost);
					$('#cart_coupon').html(data.cart_coupon);
					$('#coupon_result').html(data.coupon_result);
					if ( data.coupon_status == 'success' ) {
						$('#cart_coupon').parent().removeAttr('class')
					} else {
						$('#cart_coupon').parent().addClass('hidden')
					}
				}
			}
			//console.log(data)
		}
	});
}



// Удалиене из корзины
//----------------------------------------//
function remove_item_cart(remove_id){
	var delivery_id = $('#deliveries').find('input:checked').val();
	var coupon_code = $("#coupon_code").val();
	$.ajax({
		url: "ajax/ottavio_cart_update.php",
		data: { 'remove_id':remove_id, 'delivery_id': delivery_id, 'coupon_code':coupon_code},
		success: function(data){
			if(data){
				$('#cart_title').html(data.cart_title);
				$('#dropdownMenuCart').html('<i class="fa fa-shopping-cart fa-lg"></i>&nbsp;<span class="badge">' + data.incart + '</span>');
				$('#cart_informer').html(data.cart_informer);
				if ( data.incart == 0 ) {
					$('#dropdownMenuCart').html('<i class="fa fa-shopping-cart fa-lg"></i>');
					$('#purchases').after('<div class="container sep-bottom-5x"><div class="row"><div class="col-md-12"><div role="alert" class="alert alert-info alert-dismissible">В корзине нет товаров.</div></div></div></div>').remove();
				} else {
					$('#cart_item_'+remove_id).remove();
					$('#cart_items_total').html(data.cart_items_total);
					$('#cart_total').html(data.cart_total);
					$('#deliveries').html(data.deliveries);
					$('#delivery_cost').html(data.delivery_cost);
					$('#cart_coupon').html(data.cart_coupon);
					$('#coupon_result').html(data.coupon_result);
					if ( data.coupon_status == 'success' ) {
						$('#cart_coupon').parent().removeAttr('class')
					} else {
						$('#cart_coupon').parent().addClass('hidden')
					}
				}
			}
		}
	});
}

// Delivery
//----------------------------------------//
$('#deliveries').delegate('input[type=radio]', 'change', function(){ 
	var delivery_id = $('#deliveries').find('input:checked').val();
	var coupon_code = $('#coupon_code').val();
	$.ajax({
		url: "ajax/ottavio_cart_update.php",
		data: { 'delivery_id': delivery_id, 'coupon_code':coupon_code},
		success: function(data){
			if(data){
				$('#cart_title').html(data.cart_title);
				$('#cart_informer').html(data.cart_informer);
				if ( data.incart == 0 ) {
					$('#purchases').after('<div class="container sep-bottom-5x"><div class="row"><div class="col-md-12"><div role="alert" class="alert alert-info alert-dismissible">В корзине нет товаров.</div></div></div></div>').remove();
				} else {
					$('#delivery_cost').html(data.delivery_cost);
					$('#cart_total').html(data.cart_total);
					$('#coupon td').html(data.cart_coupon);
					$('#coupon_result').html(data.coupon_result);
					if ( data.coupon_status == 'success' ) {
						$('#coupon').removeAttr('class')
					} else {
						$('#coupon').addClass('hidden')
					}
				}
			}
		}
	});
});
// Deliveries accordion
var $deliveries = $('#deliveries');

$deliveries.delegate('label', 'click', function(e) {
	if( $(this).next().is(':hidden') ) {
		$deliveries.find('label.active').removeClass('active').next().slideUp(300);
		$(this).addClass('active').next().slideDown(300);
	}
});

// Payment accordion
var $payment_methods = $('#payment_methods');

$payment_methods.delegate('label', 'click', function(e) {
	if( $(this).next().is(':hidden') ) {
		$payment_methods.find('label.active').removeClass('active').next().slideUp(300);
		$(this).addClass('active').next().slideDown(300);
	}
});

$(window).resize(function () {
    if ($(window).width() > 768) {
        //$('.collapse').removeClass('in');
    }
});


	$(function(){
		var a_text_hide = true;
		var a_text_height = '';
		
		$('#a_text').click(function() {
			if( a_text_hide ){
				a_text_height = $('.text-main').css("height");
				$('.text-main').css("height","auto");
				$('#a_text').text("Показать кратко");
				a_text_hide = false;
			} else {
				$('.text-main').css("height",a_text_height);
				$('#a_text').text("Показать текст полностью");
				a_text_hide = true;
			}

			
		});
	});
	
	




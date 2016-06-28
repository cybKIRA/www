$(window).load(function() {

	// McBronx 10.06.16 Модифицируем для учета едениц и цен
	// Плюс и минус
	$('.minus').click(function () {
		var $inputW = $(this).parent().find('input[name=weight]');
		var $step = $(this).parent().find('.amount_step');
		var $input = $(this).parent().find('input[name=amount]');
		var $price = $(this).parent().parent().find('.one_price');
		var $stepPrice = $(this).parent().parent().find('.step_price');
		var $comparePrice = $(this).parent().parent().find('.one_compare_price');
		var $stepComparePrice = $(this).parent().parent().find('.step_compare_price');
		
		var count = parseInt($input.val()) - 1;
		if (count > 0) {
			$inputW.val(parseFloat($inputW.val()) - parseFloat($step.html()));
			$price.html(count * parseInt($stepPrice.html()));
			$comparePrice.html(count * parseInt($stepComparePrice.html()));
		}
		count = count < 1 ? 1 : count;
		$input.val(count);
		$input.change();
		return false;
	});
	
	$('.plus').click(function () {
		var $inputW = $(this).parent().find('input[name=weight]');
		var $step = $(this).parent().find('.amount_step');
		var $input = $(this).parent().find('input[name=amount]');
		var $price = $(this).parent().parent().find('.one_price');
		var $stepPrice = $(this).parent().parent().find('.step_price');
		var $comparePrice = $(this).parent().parent().find('.one_compare_price');
		var $stepComparePrice = $(this).parent().parent().find('.step_compare_price');
		
		var count = parseInt($input.val()) + 1;

		$input.val(count );
		$price.html(count * parseInt($stepPrice.html()));
		$comparePrice.html(count * parseInt($stepComparePrice.html()));
		$inputW.val(parseFloat($inputW.val()) + parseFloat($step.html()));
		$input.change();
		return false;
	});


	// корзина
	$('form.variants').live('submit', function(e) {

		e.preventDefault();
		button = $(this).find('input[type="submit"]');
		var $span = $(this).parent().find('.card_btn');

		if($(this).find('input[name=variant]:checked').size()>0)
			variant = $(this).find('input[name=variant]:checked').val();
		if($(this).find('select[name=variant]').size()>0)
			variant = $(this).find('select').val();
		$.ajax({
			url: "ajax/cart.php",
			data: {variant: $(this).find('select').val(), amount: $(this).find('input[name="amount"]').val(), variant: variant},
			dataType: 'json',
			success: function(data){
				$('#cart_informer').html(data);
				if(button.attr('data-result-text'))
					button.val(button.attr('data-result-text'));
				//<button class="btn-primary btn action to-cart" type="submit"><i class="i-basket"></i> Купить</button>
				$span.html('<span class="btn btn-default action to-cart"><a href="/cart">В корзине</a></span>');

				/*
				$.fancybox({ padding: 0,href: '#cart_popup', //title: 'Корзина покупок',
					'onStart': function() { $("#cart_popup").css("display","block"); },
					'onClosed': function() { $("#cart_popup").css("display","none"); }
				});*/
			}
		});
		// var o1 = $(this).offset();
		// var o2 = $('#cart_informer').offset();
		// var dx = o1.left - o2.left;
		// var dy = o1.top - o2.top;
		// var distance = Math.sqrt(dx * dx + dy * dy);
		// $(this).closest('.product').find('.image img').effect("transfer", { to: $("#cart_informer"), className: "transfer_class" }, distance);
		// $('.transfer_class').html($(this).closest('.product').find('.image').html());
		// $('.transfer_class').find('img').css('height', '100%');
		return false;
	});


	$('select[name=variant]').change(function() {
		price = $(this).find('option:selected').attr('price');
		compare_price = '';
		if(typeof $(this).find('option:selected').attr('compare_price') == 'string')
			compare_price = $(this).find('option:selected').attr('compare_price');
		$(this).find('option:selected').attr('compare_price');
		$(this).closest('form').find('.price > span').html(price);
		$(this).closest('form').find('strike').html(compare_price);
		return false;
	});


	//  Автозаполнитель поиска
	$(".input_search").autocomplete({
		serviceUrl:'ajax/search_products.php',
		minChars:1,
		noCache: false,
		onSelect:
			function(suggestion){
				 $(".input_search").closest('form').submit();
			},
		formatResult:
			function(suggestion, currentValue){
				var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
				var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
				return (suggestion.data.image?"<div class='image text-center pull-left grayscale'><img align=absmiddle src='"+suggestion.data.image+"'></div> ":'') + suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
			}
	});

	// preloader
	jQuery(".status").fadeOut();
	jQuery(".preloader").delay(150).fadeOut("slow");

	$('select').selectric();


	/* WOW */
    var wow = new WOW({
        mobile: false
    });
    wow.init();

});


$(document).ready(function($) {

    // эффект наведения на фото товара - баловство
	/*$(".image img").fadeTo("slow", 0.9);	// при открытии страницы
    $(".image img").hover(function(){
        $(this).fadeTo(33, 0.4);			// При наведении
        $(this).fadeTo(111, 0.8);
        $(this).fadeTo(122, 0.65);
        $(this).fadeTo(300, 1.0);
    },function(){
        $(this).fadeTo("slow", 1);			// после mouseout
    });*/

	// OWL random function
	function random(owlSelector){
	owlSelector.children().sort(function(){
		return Math.round(Math.random()) - 0.5;
	}).each(function(){
	  $(this).appendTo(owlSelector);
	});
	}

	$('.slider-carousel').owlCarousel({
		autoplay: true,
		autoplayTimeout: 2000,
		autoplayHoverPause: false,
		autoplaySpeed: 1100,
		navText: [
		  "<i class='i-left-open'></i>",
		  "<i class='i-right-open'></i>"
		],
		smartSpeed: 1150,
		fluidSpeed: false,
		dragEndSpeed: false,

		animateIn: 'fadeIn',
		animateOut: 'fadeOut',
		items:1,

		margin:0,
		stagePadding:0,
		nav: false,
		navRewind: true,
		dots: true,
		loop: true,
		center: true,
		stopOnHover: false

	});
	
    $('.slider-header1').owlCarousel({
		autoPlay : 2000,
		stopOnHover : true,
		navigation:true,
		paginationSpeed : 1000,
		goToFirstSpeed : 2000,
		singleItem : true,
		autoHeight : false,
		transitionStyle:"fade",
		navigationText : ["<",">"],

	});

	$('.slider-brands').owlCarousel({
		autoplay: true,
		autoplayHoverPause: true,
		autoplayTimeout: 1000,
		autoplaySpeed: 900,
		nav: true,
		dots: false,
		navText: [
		  "<i class='i-left-open'></i>",
		  "<i class='i-right-open'></i>"
		],
		margin:15,
		responsive:{
			0:{items:2},
			600:{items:4},
			1000:{items:6}
		},
		loop: true
	});

	$('.slider-products').owlCarousel({
	    autoplay: true,
		autoplayHoverPause: true,
		autoplayTimeout: 3000,
		autoplaySpeed: 2000,
		responsive:{
			0:{items:1},
			485:{items:2},
			640:{items:2},
			990:{items:3},
			1200:{items:3}
		},
		margin:0
	});

	$('.slider-products-sidebar').owlCarousel({
		autoplay: true,
		autoplayHoverPause: true,
		autoplayTimeout: 3000,
		autoplaySpeed: 900,
		responsive:{
			0:{items:1},
			// 485:{items:2},
			// 640:{items:3},
			// 990:{items:4},
			// 1200:{items:5}
		},
		margin:0
	});


	 $('.pwstabs').pwstabs({
		effect: 'slidedown',              // scale / slideleft / slideright / slidetop / slidedown / none
		defaultTab: 1,
		containerWidth: '100%',
		tabsPosition: 'horizontal',   // Tabs position: horizontal / vertical
		horizontalPosition: 'top',    // Tabs horizontal position: top / bottom
		verticalPosition: 'left',     // Tabs vertical position: left / right
		responsive: true,             // Make tabs container responsive: true / false - boolean
		theme: 'dark',
		rtl: false                    // Right to left support: true/ false
	 });



});


(function($) {
	"use strict";

    // inpage SCROLL
    $('a[href^="#"].inpage-scroll, .inpage-scroll a[href^="#"]').on('click', function(e) {
        e.preventDefault();

        var target = this.hash,
            $target = $(target);
        $('.main-navigation a[href="' + target + '"]').addClass('active');
        $('.main-navigation a:not([href="' + target + '"])').removeClass('active');
        $('html, body').stop().animate({
            'scrollTop': ($target.offset()) ? $target.offset().top : 0
        }, 900, 'swing', function() {
            window.location.hash = target;
        });
    });

	// внешние ссылки всегда в новом окне
	$('a').each(function() {
	   var a = new RegExp('/' + window.location.host + '/');
	   if (!a.test(this.href)) {
		  $(this).attr("target","_blank");
	   }
	});


	// замена битых
	$("img").error(function () {$(this).unbind("error").attr("src", "/design/loading.gif");});
	$("img").error(function () {$(this).attr("src", "/design/loading.gif");});

})(jQuery);



jQuery(function($){

	// var scrolled = false;
	// $(window).scroll(function(){

		// if ($(window).scrollTop() > $('header').height()+180) {
			// $('.header-nav').addClass("sticky-header");
			// $('.header-nav').removeClass("hide-header");


		// } else if ($(window).scrollTop() < $('header').height()+180 && $(window).scrollTop() > $('header').height()) {
			// $('.header-nav').addClass("hide-header");
			// $('.header-nav').removeClass("sticky-header");

		// } else {
			// $('.header-nav').removeClass("hide-header");
			// $('.header-nav').removeClass("sticky-header");
		// }
	// });

});


// рейтинг
$.fn.rater = function(e) {
    var t = $.extend({}, $.fn.rater.defaults, e);
    return this.each(function() {
        var e = $(this);
        var n = e.find(".rater-starsOn");
        var r = e.find(".rater-starsOff");
        t.size = n.height();
        if (t.rating == undefined)
            t.rating = n.width() / t.size;
        r.mousemove(function(e) {
            var i = e.clientX - r.offset().left;
            var s = r.width() - (r.width() - i);
            s = Math.ceil(s / (t.size / t.step)) * t.size / t.step;
            n.width(s)
        }
        ).hover(function(e) {
            n.addClass("rater-starsHover")
        }
        , function(e) {
            n.removeClass("rater-starsHover");
            n.width(t.rating * t.size)
        }
        ).click(function(i) {
            var s = Math.round(n.width() / r.width() * t.units * t.step) / t.step;
            r.unbind("click").unbind("mousemove").unbind("mouseenter").unbind("mouseleave");
            r.css("cursor", "default");
            n.css("cursor", "default");
            $.fn.rater.rate(e, t, s)
        }
        ).css("cursor", "pointer");
        n.css("cursor", "pointer")
    }
    )
}

$.fn.rater.rate = function(e, t, n) {
    var r = e.find(".rater-starsOn");
    var i = e.find(".rater-starsOff");
    i.fadeTo(600, .4, function() {
        $.ajax({
            url: "ajax/rating.php",
            data: {
                id: e.attr("rel"),
                rating: n
            },
            dataType: "json",
            complete: function(n) {
                if (n.status == 200) {
                    t.rating = parseFloat(n.responseText);
                    if (t.rating > 0) {
                        t.rating = parseFloat(n.responseText);
                        i.fadeTo(600, .1, function() {
                            r.removeClass("rater-starsHover").width(t.rating * t.size);
                            var n = e.find(".rater-rateCount");
                            n.text(parseInt(n.text()) + 1);
                            e.find(".rater-rating").text(t.rating.toFixed(1));
                            i.fadeTo(600, 1)
                        }
                        );
                        //alert("Спасибо! Ваш голос учтен.")
                    } else if (t.rating == -1)
                        alert("Вы уже голосовали за данный товар!");
                    else
                        alert("Неверные параметры запроса!")
                } else {
                    alert(n.responseText);
                    r.removeClass("rater-starsHover").width(t.rating * t.size);
                    e.rater(t);
                    i.fadeTo(2200, 1)
                }
            }
        })
    }
    )
}
$(document).ready(function() {
    $('.rating').rater({
        units: 5,
        step: 1
    });
}
);


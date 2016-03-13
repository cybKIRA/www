<!DOCTYPE html>
<html class="no-js">
<head>
	<base href="{$config->root_url}/"/>
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>{$meta_title|escape} {if $brand and !$product}{$brand->name|escape}{/if}</title>

	{* Метатеги *}
	<meta name="description" content="{$meta_description|escape}" />
	<meta name="keywords"    content="{$meta_keywords|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	{* Канонический адрес страницы *}
	{if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}
	
	<!-- Place favicon.ico and apple-touch-icon.png in the root directory-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=PT+Sans+Caption:400,700%7COpen+Sans:400italic,300,400,600,700">
	<link rel="stylesheet" href="design/{$settings->theme}/styles/font-awesome.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/owl.carousel.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/owl.theme.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/slit-slider-style.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/slit-slider-custom.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/idangerous.swiper.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/yamm.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/animate.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/prettyPhoto.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/bootstrap-slider.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/device-mockups2.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/bootstrap.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/main.css">
    <link rel="stylesheet" href="design/{$settings->theme}/styles/main-responsive.css">
    <link rel="stylesheet" href="design/{$settings->theme}/scripts/magnific-popup/magnific-popup.css">

    <link rel="stylesheet" href="design/{$settings->theme}/styles/themes/theme_tangerine.css">
    
    <noscript>
		<link rel="stylesheet" href="design/{$settings->theme}/styles/styleNoJs.css">
    </noscript>

	<link href="design/{$settings->theme}/images/favicon.ico" rel="icon"          type="image/x-icon"/>
	<link href="design/{$settings->theme}/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	
	<script src="design/{$settings->theme}/scripts/vendor/modernizr.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.js"></script>
</head>

<body class="bg22">
	<div id="load"></div><!--[if lt IE 9]>
    <p class="browsehappy">You are using an strong outdated browser. <br>Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
	
	<div class="page">
		{include file = 'm_header.tpl'}
		
		{$content}
		
		{include file = 'm_footer_1.tpl'}

		<div id="back_to_top"><a href="#" class="fa fa-arrow-up fa-lg"></a></div>		
    </div>

	

</body>
	<script src="design/{$settings->theme}/scripts/vendor/queryloader2.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/owl.carousel.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.ba-cond.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.slitslider.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/idangerous.swiper.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.fitvids.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.countTo.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/TweenMax.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/ScrollToPlugin.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.scrollmagic.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.easypiechart.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.validate.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/wow.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.placeholder.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.easing.1.3.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.waitforimages.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.prettyPhoto.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/imagesloaded.pkgd.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/isotope.pkgd.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.fillparent.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/raphael-min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/bootstrap.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/jquery.bootstrap-touchspin.min.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/bootstrap-slider.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/bootstrap-rating-input.js"></script>
	<script src="design/{$settings->theme}/scripts/vendor/bootstrap-hover-dropdown.min.js"></script>
	<script src="design/{$settings->theme}/scripts/jquery.gmap.min.js"></script>
	<script src="design/{$settings->theme}/scripts/circle_diagram.js"></script>
	<script src="design/{$settings->theme}/scripts/magnific-popup/magnific-popup.js"></script>

	<script src="design/{$settings->theme}/scripts/main.js"></script>
	<script src="design/{$settings->theme}/scripts/smoothscroll.js"></script>

	<!-- Chatra {literal} -->
<script>
    ChatraID = 'JXyzZcKDnST7noHgb';
    (function(d, w, c) {
        var n = d.getElementsByTagName('script')[0],
            s = d.createElement('script');
        w[c] = w[c] || function() {
            (w[c].q = w[c].q || []).push(arguments);
        };
        s.async = true;
        s.src = (d.location.protocol === 'https:' ? 'https:': 'http:')
            + '//call.chatra.io/chatra.js';
        n.parentNode.insertBefore(s, n);
    })(document, window, 'Chatra');
</script>
<!-- /Chatra {/literal} -->

<script src="/js/googleAnalytics.js"></script>
	
<!-- Yandex.Metrika counter --><script type="text/javascript"> (function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter34397840 = new Ya.Metrika({ id:34397840, clickmap:true, trackLinks:true, accurateTrackBounce:true, webvisor:true }); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = "https://mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");</script><noscript><div><img src="https://mc.yandex.ru/watch/34397840" style="position:absolute; left:-9999px;" alt="" /></div></noscript><!-- /Yandex.Metrika counter -->
<script>var l="b7ad3fd41d8cd9245190358";</script>
 
</html>
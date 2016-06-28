<!DOCTYPE html>
{*
	Общий вид страницы
	Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html>
<head>
	<base href="{$config->root_url}/"/>
	<title>{$meta_title|escape}</title>

	{* Метатеги *}
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="description" content="{$meta_description|escape}" />
	<meta name="keywords"    content="{$meta_keywords|escape}" />
	<meta name="robots" content="index,follow"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	{* Страница товара / Явно указание изображения для соцсетей, какое изображение брать при like *}
	{if $meta_img}
	<meta property="og:image" content="{$meta_img}" />
	<link rel="image_src" href="{$meta_img}" />
	{/if}

	{* Канонический адрес страницы *}
	{if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}

	{* Стили *}
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/bootstrap.css"/>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/style.css?ver=2.0"/>

	{* Иконка сайта *}
	<link href="design/{$settings->theme|escape}/images/favicon/favicon.ico" rel="icon"          type="image/x-icon"/>
	<link href="design/{$settings->theme|escape}/images/favicon/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="design/{$settings->theme|escape}/images/favicon/favicon-120.png">
	{* JQuery *}
	<script src="design/{$settings->theme|escape}/js/jquery-1.11.2.min.js"></script>
	<script src="design/{$settings->theme|escape}/js/jquery-migrate-1.2.1.min.js"></script>

</head>
<body class="page {$module} mp-pusher" id="mp-pusher"><div class="preloader"><div class="status"></div></div>
{literal}
<!-- Yandex.Metrika counter -->
{/literal}


<div class="wrapper">
	{* Наполнение откытой страницы / разделов	 *}
	<main class='content-over'>

		<header class="header-container">

			{* Наполнение шапки *}
			<div class="header-content p-t-20 p-b-10">
				<div class="container">
					<div style="" class="row">
	
						<div style=""  class="col-xs-12 header-menu text-center">
							<ul class="list-inline">
								<li class=""><a href="/"> Главная</a></li>
								{foreach $pages as $p}
									{if $p->menu_id == 1 && $p->url != ''}
									<li>
										<a {if $page && $page->id == $p->id}class="selected"{/if} data-page="{$p->id}" href="/{$p->url}">{$p->name|escape}</a> &nbsp;
									</li>
									{/if}
								{/foreach}
								{if $user}
									<li class=""><a href="/user"> Личный кабинет</a></li>
									<li><a href="/user/logout">Выход</a></li>
								{else}
									<li><a href="/user/login"></i>Вход</a></li>
									<li><a href="/user/register">Регистрация</a></li>
								{/if}
							</ul>
							
							{*
							<br>
							
							<form class="search text-right" name="search" action="products">
							<input type="text" class="transition1 form-control input_search" name="keyword" value="{$keyword|escape}" placeholder="Поиск в каталоге">
							<button type="submit" class="btn-primary"><i class="i-search-2"></i></button>
							</form>
							*}
						</div>
						
						{if $module=='MainView'}
						<div class=row>
							<div class="col-xs-12 text-center">
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 owl-carousel  p-0 m-0 slider-header slider-carousel">
									<div class="step_img step1"></div>
									<div class="step_img step2"></div>
									<div class="step_img step3"></div>
								</div>
								<div class="slider-carousel-header">
									<div>
										<a href="/"><img src="design/fresh/images/Logo-Royal.png" alt="" /></a>
										<div class=slider-message>
											<h1>доставка свежих продуктов с рынка</h1>
											<br>
											Выбираем лучшее.
											Упаковываем бережно. 
											Доставляем быстро - от 2 часов и 300 рублей. 
										</div>
									</div>
									
								</div>
							</div>
						</div>
						{/if}
					</div>
				</div>
			</div>

			{* Меню основное в шапке *}
			<div class="transition header-nav">
				<div class="container">
					<div class="row row-menu">
						<div class="col-xs-12 col-sm-10 col-md-11">
							<div class="list-inline header-nav-catalog text-center">
								{foreach $categories as $c}
									{if $c->visible}
										<span>										
											<a {if $category->id == $c->id}class="selected"{/if} href="catalog/{$c->url}" data-category="{$c->id}">{$c->name|escape}</a>
										</span>
									{/if}
								{/foreach}
							
							
							</div>
						</div>
						<div class="col-xs-12 col-sm-2 col-md-1" id="cart_informer" onclick="location.href='/cart';">
							{include file='cart_informer.tpl'}
						</div>
					</div>
				</div>
			</div>
			
		</header>

		<div class="clearfix"></div>
		<div id=index-backgr >
			<div class="container content-container">
				{include file='x_patch.tpl'}
				{if $module!='ProductsView'}
					{$content}
				{else}
					<div class="row">
						{*<div class="col-md-3 sidebar sidebar-left">{include file='x_sidebar.tpl'}</div>*}
						<div class="col-md-12 content-main">{$content}</div>
					</div>
				{/if}
			</div>
		</div>

		{* Бренды *}
		{if $smarty.get.module != 'CartView' && $smarty.get.module != 'OrderView' && $smarty.get.module != 'ProductsView'}
		{get_brands var=all_brands}
		{if $all_brands}
			<section class="hidden-xs brandsCarousel">
				<div class="container m-t-50 m-b-50">
					<div class="title-header text-center textLine m-t-20">
						<div class="h2"><span>Торговые марки</span> нашего каталога</div>
						<div class="dark-line"></div>
						<div class="sub-heading">предложения популярных брендов</div>
					</div>
					<div class="slider-brands animated">
						{foreach $all_brands as $b}
							<div class="item image" data-brand="{$b->id}">
							{if $b->image}	<a href="/brands/{$b->url}" title='{$b->name|escape}'><img src="{$config->brands_images_dir}{$b->image}" alt=""/></a>
							{else}			<p><a href="/brands/{$b->url}">{$b->name|escape}</a></p>{/if}
							</div>
						{/foreach}
					</div>
				</div>
			</section>
		{/if}
		{/if}
		
		
		{* Подвал *}
		<footer class="footer-container">

			{if $module!='BlogView'}
			<div class="hidden-xs hidden-sm footer-top text-sm">
				<div class="container">
					<div class="row m-0">
						{* Новости: Выбираем в переменную $last_posts последние записи *}
						<div class="col-md-3 col-lg-3 l-d-r">
							{get_posts var=last_posts limit=1}
							{if $last_posts}
								<div class="h3">Наши <span>новости</span></div>
								<ul class="list-unstyled blogView">
									{foreach $last_posts as $post}
										<li class='post{$post@iteration} m-t-10 m-b-20 p-b-10'>
											<p class="label label-success white-text text-xxs">{$post->date|date}</p>
											<p class='h4'><a class="color text-underline" href="/blog/{$post->url}" data-post="{$post->id}">{$post->name|escape}</a></p>
											<p class="text-sm">{$post->annotation|strip_tags|truncate:110:'...'}</p>
										</li>
									{/foreach}
									<a class='text-sm text-underline dark-link' href="/blog">Показать все <i class="i-angle-double-right"></i></a>
								</ul>
							{/if}
						</div>

						<div class="col-md-3 col-lg-3 l-d-r">
							<div class="h3">Меню</div>
							<ul class="list-unstyled">
								{foreach $pages as $p}
									{if $p->menu_id == 1 && $p->url != ''}
									<li><i class="i-angle-double-right"></i><a class="text-underline {if $page && $page->id == $p->id}selected{/if}" data-page="{$p->id}" href="{$p->url}">{$p->name|escape}</a></li>
									{/if}
								{/foreach}
								<li><i class="i-angle-double-right"></i><a class="text-underline" href="http://rfresh.ru/contact">Контакты</a></li>
							</ul>
						</div>

						<div class="hidden-md col-md-3 col-lg-3">
							<div class="h3"><span>Личный</span> кабинет</div>
							<ul class="list-unstyled">
								{if $user}
									<li style='margin-bottom:5px'><b class='color'>Добро пожаловать, {$user->name}</b>{if $group->discount>0}<br />Ваша персональная скидка {$group->discount}%{/if}</li>
									<li class='grey-link text-underline'><a href="/user">Личный кабинет</a></li>
									<li class='grey-link text-underline'><a href="/user/logout">Выход</a></li>

								{else}
									<li><a class="text-underline" href="/user/register"><i class="i-user-add"></i> Регистрация</a></li>
									<li><a class="text-underline" href="/user/login"><i class="i-user"></i> Мой кабинет</a></li>
								{/if}
							</ul>
						</div>
						<div class="col-md-3 col-lg-3 l-d-r text-right">
							
						</div>
					</div>
				</div>
			</div>
			{/if}

		</footer>

	{include file='x_menu.tpl'}
	</main>
</div>



<link rel="stylesheet" href="design/{$settings->theme|escape}/css/animate.min.css">

<link rel="stylesheet" href="js/baloon/css/baloon.css">
<script src="js/baloon/js/baloon.js"></script>

<script src="design/{$settings->theme|escape}/js/custom.js?ver=1.6"></script>
<script src="js/autocomplete/jquery.autocomplete-min.js"></script>
<script src="js/ctrlnavigate.js"></script>

<script src="js/fancybox/jquery.fancybox.pack.js"></script>
<link rel="stylesheet" href="js/fancybox/jquery.fancybox.css">
<link rel="stylesheet" href="design/{$settings->theme|escape}/fontello/css/fontello.css">

{*
<link rel="stylesheet" href="design/{$settings->theme|escape}/js/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="design/{$settings->theme|escape}/js/owl-carousel/owl.theme.css">
<link rel="stylesheet" href="design/{$settings->theme|escape}/js/owl-carousel/owl.transitions.css">
*}

{*<script src="design/{$settings->theme|escape}/js/owl-carousel/owl.carousel.min.js"></script>*}
<script src="design/{$settings->theme|escape}/js/owl.carousel.min.js"></script>
<script src="design/{$settings->theme|escape}/js/wow.min.js"></script>
<script src="design/{$settings->theme|escape}/js/jquery.selectric.min.js"></script>
<script src="design/{$settings->theme|escape}/js/jquery.pwstabs-1.2.1.min.js"></script>
<script src="js/headhesive/headhesive.min.js"></script>

<!-- Yandex.Metrika counter --> <script type="text/javascript"> (function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter37925960 = new Ya.Metrika({ id:37925960, clickmap:true, trackLinks:true, accurateTrackBounce:true, webvisor:true, trackHash:true }); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = "https://mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks"); </script> <noscript><div><img src="https://mc.yandex.ru/watch/37925960" style="position:absolute; left:-9999px;" alt="" /></div></noscript> <!-- /Yandex.Metrika counter -->

{if $smarty.session.admin != 'admin'}
	{literal}
	<script>
	//$(document).ready(function(){$(document).bind("contextmenu",function(e){return false;});});
	</script>
	{/literal}
{else}
	<script src ="js/admintooltip/admintooltip.js"></script>
	<link href="js/admintooltip/css/admintooltip.css" rel="stylesheet">
{/if}


<script type="text/javascript">
var options = {
  offset: 700
}
// Create a new instance of Headhesive
var header = new Headhesive('.header-nav',options);
</script>

</body>
</html>
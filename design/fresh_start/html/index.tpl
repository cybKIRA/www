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
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/style.css"/>

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
			{* Верхнее меню *}
			<div class="l-d-b header-top">
				<div class="container">
					<div class="row">
						<div class="col-sm-4 col-lg-4">
							<ul class="list-inline menu">
								{if $user}
									<li class="white-link"><a href="/user"><b><i class="i-login"></i> Личный кабинет</b></a></li>
									<li><a href="/user/logout">Выход</a></li>
								{else}
									<li><a class="text-underline" href="/user/login"><i class="i-user sm m-0"></i> Вход</a></li>
									<li><a class="text-underline" href="/user/register"><i class="i-user-add sm"></i> Регистрация</a></li>
								{/if}
							</ul>

							{if $currencies|count>1}
							<ul class="currencies list-inline menu">
									{foreach $currencies as $c}
									{if $c->enabled}
									<li><a class="text-xxs text-capitalize {if $c->id==$currency->id}disabled color{/if}" href="{url currency_id=$c->id}">{$c->code}</a></li>
									{/if}
									{/foreach}
							</ul>
							{/if}
						</div>
						<div class="col-sm-8 col-lg-8 text-right">
							<ul class="row list-inline menu">
								{foreach $pages as $p}
									{if $p->menu_id == 1 && $p->url != ''}
									<li><a {if $page && $page->id == $p->id}class="selected"{/if} data-page="{$p->id}" href="/{$p->url}">{$p->name|escape}</a></li>
									{/if}
								{/foreach}
							</ul>
						</div>
					</div>
				</div>
			</div>

			{* Наполнение шапки *}
			<div class="header-content p-t-20 p-b-10">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-4 col-lg-3">
						<a href="/"><img src="design/{$settings->theme|escape}/images/logo.png" title="{$settings->site_name|escape}" alt="{$settings->site_name|escape}"/></a>
						</div>

						<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3 header-conacts">
							<ul class="list-unstyled">
								<li class="phone"><a href="tel:+7-095-111-2233"><span>+7(095)</span> 111-22-33</a></li>
								<li class="phone"><a href="tel:+7-495-111-2233"><span>+7(495)</span> 111-22-33</a></li>
								<li class="small grey-text p-5">пн-пт: с 10:00 до 18:00, сб-вс: Выходной</li>
							</ul>
						</div>

						<div class="hidden-xs col-xs-12 col-sm-3 col-md-4 col-lg-2 header-message">
							Наши <span class="color">цены ниже</span>,<br />доставка быстрее!
						</div>

						<div class="col-xs-12 col-sm-12 col-lg-4">
							<form class="search" name="search" action="products">
							<input type="text" class="transition1 form-control input_search" name="keyword" value="{$keyword|escape}" placeholder="Поиск в каталоге">
							<button type="submit" class="btn-primary"><i class="i-search-2"></i></button>
							</form>
						</div>
					</div>
				</div>
			</div>

			{* Меню основное в шапке *}
			<div class="transition1 header-nav">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-10 col-md-11">
							<ul class="list-inline header-nav-catalog">
							<li><a href="#" id="trigger" class="menu-trigger"><i class="i-th-list-1"></i> Каталог</a></li>
							<li><a href="hits"><i class="i-thumbs-up"></i> Рекомендуем</a></li>
							<li><a href="sale"><i class="i-bookmark"></i> Скидки</a></li>
							<li class="hidden-xs hidden-sm"><a href=""><i class="i-truck"></i> Доставка и оплата</a></li>
							</ul>
						</div>
						<div class="col-xs-12 col-sm-2 col-md-1" id="cart_informer" onclick="location.href='/cart';">
							{include file='cart_informer.tpl'}
						</div>
					</div>
				</div>
			</div>
		</header>

		<div class="clearfix"></div>

		<div class="container content-container">
			{include file='x_patch.tpl'}
			{if $module!='ProductsView'}
				{$content}
			{else}
				<div class="row">
					<div class="col-md-3 sidebar sidebar-left">{include file='x_sidebar.tpl'}</div>
					<div class="col-md-9 content-main">{$content}</div>
				</div>
			{/if}
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
						<div class="col-md-4 col-lg-3 l-d-r">
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

						<div class="col-md-4 col-lg-3 l-d-r">
							<div class="h3">Информация <span>о магазине</span></div>
							<ul class="list-unstyled">
								{foreach $pages as $p}
									{if $p->menu_id == 1 && $p->url != ''}
									<li><i class="i-angle-double-right"></i><a class="text-underline {if $page && $page->id == $p->id}selected{/if}" data-page="{$p->id}" href="{$p->url}">{$p->name|escape}</a></li>
									{/if}
								{/foreach}
							</ul>
						</div>

						<div class="col-md-4 col-lg-3 l-d-r">
							<div class="h3">Консультация</div>
							<ul class="list-unstyled">
								<li class=""><i class="i-skype"></i><a href="skype:echo123">echo123</a></li>
								<li class=""><i class="i-mail"></i><a href="mailto:admin@earth.space">admin@earth.space</a></li>
								<li class=""><i class="i-phone-squared"></i><a href="tel:+7-095-111-2233">+7 (095) 111 2233</a></li>
								<li class=""><i class="i-phone"></i><a href="tel:+7-495-111-2233">+7 (495) 111 2233</a></li>
								<li class=""><i class="i-location"></i>Москва, шоссе Энтузиастов 11/12</li>
							</ul>
						</div>

						<div class="hidden-md col-md-4 col-lg-3">
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
					</div>
				</div>
			</div>
			{/if}
			<noindex>
			<div class="hidden-xs footer-center">
				<div class="container">
					<div class="row">
						<div class="hidden-sm col-md-3 col-lg-3">&nbsp;</div>
						<div class="col-xs-12 col-sm-6 hidden-md col-md-3 col-lg-3">
							<i class="i-stopwatch-1"></i>
							<div class="h4 white-text">Консультации опытных менеджеров</div>
							<div class="text-sm">Согласно режиму рабочего дня</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-5 col-lg-3">
							<i class="i-truck"></i>
							<div class="h4 white-text">Бесплатная доставка по городу в день заказа</div>
							<div class="text-sm">Для заказаов от 5000руб.</div>
						</div>
						<div class="col-xs-12 col-md-4 col-lg-3">
							<i class="i-dropbox"></i>
							<div class="h4 white-text">Доступна доставка заказов в регионы</div>
							<div class="text-sm">Товары проверяются до отправки</div>
						</div>
					</div>
				</div>
			</div>

			<div class="footer-bottom">
				<div class="container">
					<div class="row">
						<div class="hidden-xs hidden-sm col-md-3 col-lg-3 color-bg white-text text-sm bg-success">
							<p><b>Интернет-магазин «{$settings->site_name}»</b> - это всегда актуальные товары, выгодные цены и отличное качество. Нам дорог каждый клиент, поэтому мы постоянно расширяем ассортимент товаров.</p>
							<p>Наличие и стоимость товаров уточняйте по телефону. Производители оставляют за собой право изменять технические характеристики и внешний вид товаров без предварительного уведомления.</p>
						</div>
						<div class="col-xs-12 col-md-9 col-lg-9 text-center">
							<div class="hidden-xs">
								<div class="h4 white-text m-b-10">Подпишитесь на наши новости</div>
								<div class="text-sm">Информация о скидках, акциях и специальных программах.</div>
								<div class="input-group">
									<input class="form-control text-sm email" type="text" placeholder="Укажите email..." size="18" name="email">
									<span class="input-group-btn">
										<button class="btn color" type="submit" name="submitNewsletter">Подписаться</button>
									</span>
								</div>

								<hr class="sm text-transparent">
							</div>

							<div class="h4 white-text text-left">Мы принимаем оплату во всех популярных сервисах</div>
							<img class="pull-left" src="design/{$settings->theme|escape}/images/payment.png" title="{$settings->site_name|escape}" alt="{$settings->site_name|escape}"/>
						</div>
					</div>
				</div>
			</div>

			<div class="footer-ps">
				<div class="text-xxs container">
					<div class="row">
						<div class="col-xs-12 col-sm-9 col-md-9 col-lg-10">
							Данный сайт носит исключительно информационный характер и ни при каких обстоятельствах не является публичной офертой. Точные данные по ценам и возможности приобретения необходимо узнавать у менеджера посредством телефонного звонка, письма через форму обратной связи или оформления заказа. Представленная на сайте информация является объектами авторского права «{$settings->site_name}». Любое использование информации должно быть согласовано с администрацией магазина.
						</div>
						<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2 p-t-15">
							<!-- это просто пример изображения счетчика /--><img src="http://Simpla-Template.ru/a_public_files/counters2.png" alt=""/>
						</div>
					</div>

				</div>
			</div>
			</noindex>
		</footer>

	{include file='x_menu.tpl'}
	</main>
</div>



<link rel="stylesheet" href="design/{$settings->theme|escape}/css/animate.min.css">

<link rel="stylesheet" href="js/baloon/css/baloon.css">
<script src="js/baloon/js/baloon.js"></script>
<script src="design/{$settings->theme|escape}/js/custom.js"></script>
<script src="js/autocomplete/jquery.autocomplete-min.js"></script>
<script src="js/ctrlnavigate.js"></script>

<script src="js/fancybox/jquery.fancybox.pack.js"></script>
<link rel="stylesheet" href="js/fancybox/jquery.fancybox.css">
<link rel="stylesheet" href="design/{$settings->theme|escape}/fontello/css/fontello.css">

<script src="design/{$settings->theme|escape}/js/owl.carousel.min.js"></script>
<script src="design/{$settings->theme|escape}/js/wow.min.js"></script>
<script src="design/{$settings->theme|escape}/js/jquery.selectric.min.js"></script>
<script src="design/{$settings->theme|escape}/js/jquery.pwstabs-1.2.1.min.js"></script>




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
</body>
</html>
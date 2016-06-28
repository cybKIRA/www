{* Главная страница магазина *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}

{* Канонический адрес страницы *}
{$canonical="/" scope=parent}

{* Рекламные блоки / slider *}
<div class="hidden-xs row slider-container">

	<div class="hidden-sm col-xs-12 col-md-3 col-lg-3 p-0 m-0">
		<div class=""><img src="design/{$settings->theme|escape}/images/banner71.jpg" alt="" /></div>
	</div>

	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 owl-carousel slider-carousel p-0 m-0">
		<div><img src="design/{$settings->theme|escape}/images/slide71.jpg" alt="" /></div>
		<div><img src="design/{$settings->theme|escape}/images/slide72.jpg" alt="" /></div>
		<div><img src="design/{$settings->theme|escape}/images/slide71.jpg" alt="" /></div>
		<div><img src="design/{$settings->theme|escape}/images/slide72.jpg" alt="" /></div>
	</div>

	<div class="hidden-sm col-xs-12 col-md-3 col-lg-3 p-0 m-0">
		<div class=""><img src="design/{$settings->theme|escape}/images/banner72.jpg" alt="" /></div>
	</div>
</div>


{* Рекомендуемые товары *}
{get_featured_products var=featured_products limit=10 order='RAND()'}
{if $featured_products}
	<!-- Список товаров-->
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-center textLine m-t-20">
			<div class="h2"><span>Рекомендуемые товары</span> нашего каталога</div>
			<div class="dark-line"></div>
			<div class="sub-heading text-underline"><a href='/hits'>показать все</a></div>
		</div>
		{foreach $featured_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		<li class="col-xs-12 col-sm-4 col-md-3"><div class="product wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
	</ul>
{/if}


<article class="p-30">
	{* Заголовок и текст главной страницы *}
	<h1>{$page->header}</h1>
	{$page->body}
</article>


{* Акционные товары / Прокрутка  *}
{get_discounted_products var=discounted_products limit=10 order='RAND()'}
{if $discounted_products}
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-center textLine m-t-20">
			<div class="h2"><span>Товары по акции</span> и скидки!</div>
			<div class="dark-line"></div>
			<div class="sub-heading text-underline"><a href='/sale'>показать все</a></div>
		</div>	
		<div class="slider-products">
		{foreach $discounted_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		<li class="wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
		</div>
	</ul>
{/if}


{* Последние новинки *}
{get_new_products var=new_products limit=5}
{if $new_products}
	<!-- Список товаров-->
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-left textLine m-t-20">
			<div class="h2"><span>Последние</span>  поступления</div>
			<div class="dark-line"></div>
		</div>
		{foreach $new_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		<li class="col-xs-12 col-sm-4 col-md-3"><div class="product wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
	</ul>
{/if}


<script>
	$(document).ready(function(){
	   Height = '';
	   maxHeight = 0;
	   $(".gridBlock .product").each(function(){
		 if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
		 Height = maxHeight;
	   });
	   $(".gridBlock .product").height(Height);
	});
</script>
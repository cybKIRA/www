{* Главная страница магазина *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}

{* Канонический адрес страницы *}
{$canonical="/" scope=parent}



{* Рекомендуемые товары *}
{get_featured_products var=featured_products limit=10 order='RAND()'}
{if $featured_products}
	<!-- Список товаров-->
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-center textLine m-t-20">
			<div class="h2"><span>Рекомендуемые</span></div>
			<div class="dark-line"></div>

		</div>
		<div class="slider-products">
		{foreach $featured_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		{*<li class="col-xs-6 col-sm-4 col-md-3"><div class="product wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s">{include file='x_producBlock.tpl'}</div></li>*}
		<li class="wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
		</div>
	</ul>
{/if}



{* Акционные товары / Прокрутка  *}
{get_discounted_products var=discounted_products limit=10 order='RAND()'}
{if $discounted_products}
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-center textLine m-t-20">
			<div class="h2"><span>Акции</span> и скидки!</div>
			<div class="dark-line"></div>
		</div>	
		<div class="slider-products">
		{foreach $discounted_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		<li class="wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
		</div>
	</ul>
{/if}


{* Последние новинки
{get_new_products var=new_products limit=5}
{if $new_products}
	<!-- Список товаров-->
	<ul id='products' class="row list-inline gridBlock">
		<div class="title-header text-center  textLine m-t-20">
			<div class="h2"><span>Последние</span>  поступления</div>
			<div class="dark-line"></div>
		</div>
		<div class="slider-products">
		{foreach $new_products as $product}
		{$delay1=0.1 + $product@iteration / 12}
		<li class="wow fadeIn" data-wow-duration="0.5s" data-wow-delay="{$delay1}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
		</div>
	</ul>
{/if}
 *}

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
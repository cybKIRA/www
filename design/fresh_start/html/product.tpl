{* Страница товара / Карточка предложения *}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}
{$openId = $product->id scope=parent}


<div class="{$smarty.get.module} row product">
	<!-- Logo бренда товара, если оно есть -->
	{if $brand->image}
	<div class="hidden-xs brandImage image">
		<a href="/catalog/{$category->url}/{$brand->url}"><img class="tooltip-show" src="{$config->brands_images_dir}{$brand->image}" alt="" data-placement="left"  title="Показать все предложения от '{$brand->name}' в разделе '{$category->name|escape}'"/></a>
	</div>
	{/if}

	<div class='col-md-5 col-lg-4 wow fadeIn' data-wow-duration="1.2s" data-wow-delay=".1s">
		{* Большое фото *}
		<div class="image">
		{if $product->image}<a href="{$product->image->filename|resize:800:600:w}" class="zoom" rel="group"><img src="{$product->image->filename|resize:300:300}" alt="{$product->product->name|escape}" /></a>
		{else}<i class="i-camera-3"></i>{/if}
		</div>

		{* Дополнительные фото продукта *}
		{if $product->images|count>1}
		<ul class="list-inline">
			{* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
			{foreach $product->images|cut as $i=>$image}
			<li class="col-xs-3 col-sm-2 col-md-4 col-lg-3">
				<div class="images line">
				<a href="{$image->filename|resize:800:600:w}" class="zoom" rel="group"><img src="{$image->filename|resize:60:60}" alt="{$product->name|escape}" /></a>
				</div>
			</li>
			{/foreach}
		</ul>
		{/if}
	</div>


	{* Описание товара *}
	<div class='col-md-7 col-lg-8 p-t-20 description wow fadeIn' data-wow-duration="1.2s" data-wow-delay=".5s">

		{* Краткое описание *}
		{if $product->annotation}<p class='text-sm'>{$product->annotation|strip_tags|truncate:350:'...'}</p>{/if}

		{* Рейтинг *}
		<div class="rating text-sm grey-text" rel="{$product->id}">
			<span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span>
			<span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'оценка':'оценок':'оценки'})
		</div>

		{* Артикул *}
		{if $product->variant->sku}<p class="text-xs grey-text">Код:{$product->variant->sku|truncate:35:'...'}</p>{/if}

		<div class="row m-t-20">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-7">
				{* Стоимость и заказ *}
				<form class="form variants" action="/cart">
					{if $product->variants|count > 0 && $product->variant->price >0}

						{* Статус
						<p><b class="text-sm text-success"><i class="i-ok-1 sm"></i> В наличии</b></p> *}

						<div class="price m-b-10">
							<span>{$product->variant->price|convert}</span>&nbsp;&nbsp;<i>{$currency->sign|escape}, {if $product->variant->unit}{$product->variant->unit}{else}{$settings->units}{/if}</i>
							{if $product->variant->compare_price > 0}<strike>{$product->variant->compare_price|convert}</strike>{/if}
						</div>

						<div {if $product->variants|count==1}style='display:none;'{/if}>
							<i class="text-xs grey-text text-transparent">Выберите вариант из списка</i>
							<select class="form-control" name="variant" {if $product->variants|count==1}style='display:none;'{/if}>
								{foreach $product->variants as $v}
									<option value="{$v->id}" {if $v->compare_price > 0}compare_price="{$v->compare_price|convert}"{/if} {if $v->price>0}price="{$v->price|convert}"{else}disabled{/if}>
									{if $v->price==0}(Под заказ){/if} {if $v->name}{$v->name}{else}Без названия{/if}, {if $v->unit}{$v->unit}{else}{$settings->units}{/if}
									</option>
								{/foreach}
							</select>
						</div>

						<div class="amount">
							<span class="clickable minus">-</span>
							<input class="text-center" type="text" name="amount" value="1">
							<span class="clickable plus">+</span>
							<button class="btn-primary btn action to-cart" type="submit"><i class="i-basket"></i> Купить</button>
						</div>

					{elseif $product->variants|count == 0}
						<p class='text-bold text-md text-danger'>Нет на складе</p>
						<p class='text-xs'><b>К сожалению, этого товара нет в наличии</b>. Вы можете связаться с нашим консультантом и оставить предварительную заявку. Мы обязательно постараемся Вам помочь.</p><br />
						<a class="btn-primary btn" href="/contact/"><i class="i-pencil"></i> Задать вопрос</a>

					{elseif $product->variant->price == 0}
						<p class='text-bold text-md text-danger'>Под заказ (нет цены)</p>
						<p class='text-xs'><b>Не назначена действующая цена.</b> Уточните стоимость и наличие у консультанта</p><br />
						<a class="btn-primary btn" href="/contact/"><i class="i-pencil"></i> Задать вопрос</a>
					{/if}
					<div class="clearfix"></div>
				</form>
			</div>

			{* Статический текст для примечаний к товару. *}
			<div class="hidden-xs well col-xs-12 col-sm-12 col-md-12 col-lg-5 p-15 text-sm">
				<ul class="list-unstyled ul-list-02 text-xs grey-text">
				<li class="">Купить в кредит? По всем вопросам оформления кредитов обращайтесь по телефону горячей линии 8 (800) 000-00-00</li>
				<li class="">Специальные условия оптовых заказчиков</li>
				<li class="">Гарантия производителя</li>
				</ul>
			</div>
		</div>

		<div class="clearfix"></div>
		<div class="">
			{$meta_img ="{$product->image->filename|resize:800:600:w}" scope=parent}
			{*
			{$meta_img ="/files/originals/{$product->image->filename}" scope=parent}
			{$meta_img}
			*}
			
			{literal}
			<script type="text/javascript">(function() {
			  if (window.pluso)if (typeof window.pluso.start == "function") return;
			  if (window.ifpluso==undefined) { window.ifpluso = 1;
				var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
				s.type = 'text/javascript'; s.charset='UTF-8'; s.async = true;
				s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
				var h=d[g]('body')[0];
				h.appendChild(s);
			  }})();</script>
			<div class="pluso" data-background="transparent" data-options="medium,square,line,horizontal,counter,theme=05" data-services="vkontakte,odnoklassniki,google,facebook,twitter"></div>			{/literal}
		</div>
	</div>
	<!-- Описание товара (The End)-->

</div>

<hr class='sm' id=comments>

{* Вкладки *}
<div class="pwstabs">

	{* Описание полное товара *}
	{if $product->body}
	<div class='content-text' data-pws-tab="tab1" data-pws-tab-name="Описание" data-pws-tab-icon="i-doc-text-1">
		<article>
		<h2 data-product="{$product->id}">{$product->name|escape}</h2>
		{$product->body}
		</article>
	</div>
	{/if}

	{* Характеристики товара *}
	{if $product->features}
	<div class="itemFeatures" data-pws-tab="tab2" data-pws-tab-name="Характеристики" data-pws-tab-icon="i-doc-add">
			{foreach $product->features as $key=>$f}
			<div class="col-xs-4 col-lg-3">
				<div class="item">
					<p class="name grey-text text-xs">{$f->name}</p>
					<p>
					{if $f->in_filter}
					<a class='tooltip-show' title="Найти другие предложения с этой характеристикой в разделе '{$category->name}'" href="/catalog/{$category->url}?{$f->feature_id}={$f->value}"><b>{$f->value}</b><i class="i-search-2"></i></a>
					{else}{$f->value}{/if}
					</p>
				</div>
			</div>
			{/foreach}
		<div class="clearfix"></div>
		<p class="text-xs p-15 text-transparent">* Технические характеристики и комплектация товара могут быть изменены производителем без уведомления.</p>
	</div>
	{/if}

	{* Комментарии *}
	<div class='content-text' data-pws-tab="tab3" data-pws-tab-name="{if $comments|@count>0}Отзывы ({$comments|@count}){else}Ждём отзыв{/if}" data-pws-tab-icon="i-comment-1">
	{include file='x_comments.tpl'}
	</div>

	{* Почему мы *}
	<div class='content-text' data-pws-tab="tab4" data-pws-tab-name="Почему мы" data-pws-tab-icon="i-ok-1">
		<p><b>Интернет-магазин «{$settings->site_name}»</b> - это всегда актуальные товары, выгодные цены и отличное качество. Нам дорог каждый клиент, поэтому мы постоянно расширяем ассортимент товаров.</p>
		<p>Наличие и стоимость товаров уточняйте по телефону. Производители оставляют за собой право изменять технические характеристики и внешний вид товаров без предварительного уведомления.</p>
	</div>
</div>

<!-- Соседние товары /-->
{if $prev_product || $next_product}
	<hr class="sm">
	<ul class="list-inline pager">
	{if $prev_product}<li class='col-xs-12 col-sm-6 col-md-6 text-left m-b-10 p-15 text-sm'><a href="/products/{$prev_product->url}"><i class="i-left-open"></i> {$prev_product->name|escape}</a></li>{/if}
	{if $next_product}<li class='col-xs-12 col-sm-6 col-md-6 text-right m-b-10 p-15 text-sm pull-right'><a href="/products/{$next_product->url}">{$next_product->name|escape} <i class="i-right-open"></i></a></li>{/if}
	</ul>
	<hr class="sm">
{/if}

{* Связанные товары *}
{if $related_products}{*if $related_products && $related_products|@count >3*}
	<ul id='products' class="row list-inline p-30 gridBlock">
		<div class="title-header text-left textLine m-t-40">
			<div class="h2"><span>Рекомендуем </span> (С этим товаром покупают)</div>
			<div class="dark-line"></div>
			<div class="sub-heading">Сопутствующие предложения</div>
		</div>
		<div class="slider-products">
		{foreach $related_products as $product}
		{$delay1=0.4 + $product@iteration / 12}
		<li class="wow fadeIn" data-wow-duration="1.2s" data-wow-delay="{$delay1}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
		</div>
	</ul>
{/if}


{literal}
<script>
$(function() {
	// Раскраска строк характеристик
	$(".features li:even").addClass('even');

	// Зум картинок
	$("a.zoom").fancybox({
		prevEffect	: 'fade',
		nextEffect	: 'fade'});
	});

</script>
{/literal}
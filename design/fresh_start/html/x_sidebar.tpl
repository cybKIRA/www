{*

Этот шаблон отвечает за вид бокового блока. Вынесен в отдельный файл - так можно в шаблоне БЫСТРО сменить расположение (показывать слева/справа)
и НАЗНАЧИТЬ показ блоков для разных разделов сайта.

*}

	{if $category->brands || $features}
	<ul class="row list-unstyled text-left text-sm filterGroup">
		<div class="h5"><span>Фильтр</span> предложений</div>
		{* Фильтр по брендам *}
		{if $category->brands}
		<li class="col-xs-12 col-sm-6 col-md-12 p-5 {if $b->name == $brand}{else}selected{/if}">
			<span>Торговая марка:</span>
			<select onchange="location = this.value;">
				<option value="catalog/{$category->url}" {if $b->name == $brand} selected{/if}>Все варианты</option>
				{foreach $category->brands as $b}
				<option brand_id="{$b->id}" value="catalog/{$category->url}/{$b->url}" {if $b->name == $brand->name} selected{/if}>{$b->name|escape}</option>
				{/foreach}
			</select>
		</li>
		<!-- <div class="clearfix"></div><br /> -->
		{/if}

		{* Фильтр по свойствам *}
		{if $features}
			{foreach $features as $key=>$f}
			<li class="col-xs-12 col-sm-6 col-md-12 p-5 text-left {if !$smarty.get.$key}{else}selected{/if}">
				<span data-feature="{$f->id}">{$f->name}:</span>
				<select onchange="location = this.value;"{if $smarty.get.$f@key} class='selected'{/if}>
					<option value="{url params=[$f->id=>null]}" {if !$smarty.get.$f@key} selected{/if}>Все варианты</option>
					{foreach $f->options as $o}
					<option value="{url params=[$f->id=>$o->value, page=>null]}" {if $smarty.get.$key == $o->value} selected{/if}>{$o->value|escape}</option>
					{/foreach}
				</select>
			</li>
			{/foreach}
		{/if}
		{if $smarty.server.REQUEST_URI|regex_replace:"/\?.*/":"" == $smarty.server.REQUEST_URI && !$brand}{else}
			<div class="clearfix"></div>
			<li class="col-xs-12"><a class="btn-primary btn btn-sm text-white" href="/catalog/{$category->url}">Сбросить выбор</a></li>
		{/if}
	</ul>
	{/if}



{if $smarty.get.module=='ProductsView' && $products}

	{* выбор подкатегорий показать ТОЛЬКО ЕСЛИ не выбраны характеристики в фильтрах *}
	{if $smarty.server.REQUEST_URI|regex_replace:"/\?.*/":"" == $smarty.server.REQUEST_URI && !$brand}

		{* ЕСЛИ в выбранном разделе есть подкатегории - показать *}
		{if $category->subcategories && $current_page_num==1}
			<div class="h5"><span>Уточнить</span> направление</div>
			<ul class="list-unstyled text-left text-sm subcategories">
			{foreach name=subcategories from=$category->subcategories item=c}
				{if $c->visible}
				<li class="col-xs-12 col-sm-6 col-md-12 {if $c->products_count==0}disabled text-transparent grey-link{else}dark-link{/if}"><i class="i-folder"></i><a title='Купить {$c->name}' href="catalog/{$c->url}">
				{$c->name|truncate:40:'...'} <span class='text-xs'>({$c->products_count})</span></a></li>
				{/if}
			{/foreach}
			</ul>
			<hr class="sm">
		{/if}
	{/if}
{/if}



<div class="hidden-xs">
	{* Просмотренные товары *}
	{get_browsed_products var=browsed_products limit=6}
	{if $browsed_products}
		<div class="h5 p-5">Вы уже <span>смотрели</span></div>
		<ul class="list-unstyled text-left browsed_products">
		{foreach $browsed_products as $product}
			<li class="col-xs-4 col-sm-2 col-md-4">
				<div class="image">
				{if $product->image}<a href="/products/{$product->url}"><img src="{$product->image->filename|resize:70:70}" alt="{$product->name}"/></a>
				{else}<i class="i-picture"></i>{/if}
				</div>
			</li>
		{/foreach}
		</ul>
		<hr class="">
	{/if}
</div>

<div class="hidden-xs hidden-sm">
	{* Акционные товары / Прокрутка  *}
	{get_discounted_products var=discounted_products limit=5 order='RAND()'}
	{if $discounted_products && !$page}
		<div class="h5 p-5 text-uppercase text-center"><span>Специальная цена</span> и скидки!</div>
		<ul class="row list-inline slider-products-sidebar p-b-30 m-auto">
			{foreach $discounted_products as $product}
			<li class="product text-center">
				<div class="image m-auto">
				{if $product->image}<a href="/products/{$product->url}"><img src="{$product->image->filename|resize:120:150}" alt="{$product->name}"/></a>
				{else}<i class="i-picture"></i>{/if}
				</div>
				{* Рейтинг *}
				<div class="rating text-xs grey-text" rel="{$product->id}" title='{$product->rating|string_format:"%.1f"}'>
				<span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span>
				</div>
				<h3 data-product="{$product->id}"><a href="/products/{$product->url}" title='{$product->name|escape}'>{$product->name|escape|truncate:50:'...'}</a></h3>
				<a class="btn-primary btn action to-cart" href="/products/{$product->url}"><i class="i-newspaper"></i> Подробнее</a>
			</li>
			{/foreach}
		</ul>
		<hr class="">
	{/if}

</div>
















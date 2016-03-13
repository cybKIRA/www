{* Список товаров *}

{* Канонический адрес страницы *}
{if $category && $brand}
{$canonical="/catalog/{$category->url}/{$brand->url}" scope=parent}
{elseif $category}
{$canonical="/catalog/{$category->url}" scope=parent}
{elseif $brand}
{$canonical="/brands/{$brand->url}" scope=parent}
{elseif $keyword}
{$canonical="/products?keyword={$keyword|escape}" scope=parent}
{else}
{$canonical="/products" scope=parent}
{/if}

<section {if $category->image}style="background-image: url('{$config->categories_images_dir}{$category->image}');"{/if} class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					{*<li><a href="products">Каталог</a></li>*}
					
					{if $category}
						{foreach from=$category->path item=cat}
						{if !$cat@last}<li><a href="catalog/{$cat->url}">{$cat->name|escape}</a></li>{/if}
						{/foreach}	
					{elseif $keyword}
						<li>Поиск</li>
					{/if}
				</ol>
				
				<h2 class="small-space">
					{if $keyword}
						Поиск {$keyword|escape}
					{elseif $page}
						{$page->name|escape}
					{else}
						{$category->name|escape} {$brand->name|escape} {$keyword|escape}
					{/if}
				</h2>
			</div>
		</div>
	</div>
</section>
	
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-{if ($category && $minprice) || $keyword}9 col-md-push-3 sep-bottom-lg{else}12 sep-bottom-5x{/if} sep-top-lg">
				{if $page->body}
					<div class="sep-bottom-md">{$page->body}</div>
					<hr class="sep-bottom-xs">
				{/if}


				{if $products}			
					<div class=" filter-prod">
						{* Сортировка *}
						{*if $product->variants|count > 0*}
						<div class="form-group pull-left sep-bottom-md">
							<select id="products_sort" class="form-control input-lg rounded">
								<option {if $sort=='position'}	selected="selected"{/if} value="{url sort=position page=null}">Сортировать по новинкам</option>
								<option {if $sort=='price'} 	selected="selected"{/if} value="{url sort=price page=null}">Сортировать по цене</option>
								<option {if $sort=='name'}		selected="selected"{/if} value="{url sort=name page=null}">Сортировать по названию</option>
							</select>
						</div>
						{*/if*}
						<br>
						{include file='pagination_counter.tpl'}
					</div>

					<div class="row">
						{foreach $products as $product}
						{if $product->visible}
							{if $category || $keyword}
								<div class="col-sm-4 sep-bottom-lg">{include file='product_item.tpl'}</div>
								{if $product@iteration is div by 2}<div class="clearfix visible-xs"></div>{/if}
								{if $product@iteration is div by 3}<div class="clearfix hidden-xs"></div>{/if}
							{else}
								<div class="col-md-3 col-sm-4 sep-bottom-lg">{include file='product_item.tpl'}</div>
								{if $product@iteration is div by 2}<div class="clearfix visible-xs"></div>{/if}
								{if $product@iteration is div by 3}<div class="clearfix visible-sm"></div>{/if}
								{if $product@iteration is div by 4}<div class="clearfix hidden-xs hidden-sm"></div>{/if}
							{/if}
						{/if}
						{/foreach}
					</div>
					
					<div class="sep-top-sm">
						{include file='pagination_circle.tpl'}
					</div>
				{else}
					<div role="alert" class="alert alert-warning alert-dismissible">
						Товары не найдены.
					</div>
				{/if}
				<br>
				<hr class="sep-top-xs">
				
				{if $brand->description && $current_page_num == 1}
					<div class="sep-bottom-md">{$brand->description}</div>
					<hr class="sep-bottom-xs">
				{else}
				{*
					<div class="sep-bottom-xs">{$category->description}</div>
					<hr class="sep-bottom-xs">
				*}
				{/if}
				
				{* тут выводился дескриптион, теперь он выше
				{if $category->description && $current_page_num == 1}
					
				{/if}
				*}
				
			</div>

			{if ($category && $minprice) || $keyword}
			<div class="col-md-3 col-md-pull-9 sep-top-lg">
				{if $category->subcategories}
				{$sub_count = 0}
				{foreach $category->subcategories as $c}
				    {if $c->visible}
						{$sub_count = $sub_count+1}
				    {/if}
				{/foreach}

					{if  $sub_count > 0}

					<h5 class="widget-title sep-bottom-xs">Категория </h5>
					{/if}
					
					<ul class="widget widget-cat sep-bottom-lg">
						{foreach $category->subcategories as $c}
							{if $c->visible}
								<li class="cat-item"><a href="catalog/{$c->url}" data-category="{$c->id}">{$c->name}</a></li>
							{/if}
						{/foreach}
					</ul>
				{/if}
				
				{if $category->brands}
					<h5 class="widget-title sep-bottom-xs">Бренд</h5>
					
					<ul class="widget widget-cat sep-bottom-md">
						<li class="cat-item">
							{if !$brand->id}
								<a href="catalog/{$category->url}"><span class="text-primary">Все бренды</span></a>
							{else}
								<a href="catalog/{$category->url}">Все бренды</a>
							{/if}
						</li>

						{foreach name=brands item=b from=$category->brands}
							<li class="cat-item">
								{if $b->id == $brand->id}
									<a data-brand="{$b->id}" href="catalog/{$category->url}/{$b->url}"><span class="text-primary">{$b->name|escape}</span></a>
								{else}
									<a data-brand="{$b->id}" href="catalog/{$category->url}/{$b->url}">{$b->name|escape}</a>
								{/if}
							</li>
						{/foreach}
					</ul>
				{/if}

				{if $features}
					{foreach $features as $key=>$f}
						<div class="panel panel-naked sep-bottom-xs">
							<div class="panel-heading">
								<h5 class="widget-title ">
									<a data-feature="{$f->id}" data-toggle="collapse" href="#feature_group_{$f->id}" {if !$smarty.get.$key}class="collapsed"{/if}>{$f->name}</a>
								</h5>
							</div>

							<div class="panel-collapse collapse {if $smarty.get.$key} in{/if}" id="feature_group_{$f->id}">
								<div class="panel-body">
									<ul class="widget widget-cat sep-bottom-xs">
										<li class="cat-item">
										{if !$smarty.get.$key}
											<a href="{url params=[$f->id=>null, page=>null]}"><span class="text-primary">Все</span></a>
										{else}
											<a href="{url params=[$f->id=>null, page=>null]}">Все</a>
										{/if}
										</li>
										
										{foreach $f->options as $o}
										<li class="cat-item">
											{if $smarty.get.$key == $o->value}
												<a href="{url params=[$f->id=>$o->value, page=>null]}"><span class="text-primary">{$o->value|escape}</span></a>
											{else}
												<a href="{url params=[$f->id=>$o->value, page=>null]}">{$o->value|escape}</a>
											{/if}
										</li>
										{/foreach}
									</ul>
								</div>
							</div>
						</div>
					{/foreach}
				{/if}

				{if $minprice != 0 && $maxprice != 0}
				<h5 class="widget-title sep-bottom-xs">Цена</h5>
				
				<input type="hidden" value="{$current_minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor}" id="f_currentMinPrice">
				<input type="hidden" value="{$current_maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}" id="f_currentMaxPrice">

				<div class="sep-bottom-lg">
					<div class="filter_content">
						<form method="post" class="validate">
							<input type="hidden" name="min_price" id="min_price"/>
							<input type="hidden" name="max_price" id="max_price"/>
							<input type="hidden" name="rate_from" id="rate_from" value="{$currency->rate_from}"/>
							<input type="hidden" name="rate_to" id="rate_to" value="{$currency->rate_to}"/>

							<div class="filter_price_content">
								<input type="text" value="" 
									data-slider-min="{$minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor}" 
									data-slider-max="{$maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}" 
									data-slider-step="10{if $currency->code == 'RUR'}0{/if}" 
									data-slider-value="[{$current_minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor},{$current_maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}]" 
									class="filter_price">
								
								<h6 class="text-center sep-top-xs">
									{if $currency->code != 'RUR'}$&nbsp;{/if}
									<span class="price_current">{$current_minprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|floor} - {$current_maxprice|convert|regex_replace:'/[ ]/':''|regex_replace:'/[,]/':'.'|ceil}</span>
									{if $currency->code == 'RUR'}&nbsp;{$currency->sign}{/if}
								</h6>
								
								
								{if $category}
									{assign var="clear_link" value="catalog/{$category->url}"}
								{elseif $keyword}
									{assign var="clear_link" value="products?keyword={$keyword}"}
								{/if}
								
								<div class="sep-top-xs text-center">
									<a href="{$clear_link}" class="btn btn-default btn-bordered btn-xs upper hidden-md">Сбросить</a>
									<button type="submit" class="btn btn-primary btn-xs filter-button upper">Применить</button>
								</div>
								
								<div class="sep-top-xs text-center visible-md">
									<a href="{$clear_link}" class="btn btn-default btn-bordered btn-xs upper">Сбросить</a>
								</div>
							</div>
						</form>
					</div>
				</div>
				{/if}
			</div>
			{/if}
		</div>
	</div>
</section>

{*include file = 'm_call_to_action.tpl'*}
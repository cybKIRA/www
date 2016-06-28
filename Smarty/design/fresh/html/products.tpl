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

{if $page->body || $category->description && $current_page_num==1}
	<article>
	{if $category->description}
		<div class="content-text" data-category="{$category->id}">
		{$category->description}
		</div>
	{/if}
	{if $page->body}
		<div class="content-text p-15" data-page="{$page->id}">
		{$page->body}
		</div>
	{/if}
	</article>
{/if}


<!--Каталог товаров-->
{if $products}

	{* Панель выбора показа товаров *}
	<ul class='row list-inline products-toolbar'>
		<li class="view-switcher">
			<label class="gridBlock" data-view="gridBlock"><i class="i-th-large-1"></i></label>
			<label class="gridList" data-view="gridList"><i class="i-th-1"></i></label>
		</li>

		{* Сортировка *}
		{if $products|count>1}
		<li class="sort">
			<select onchange="location = this.value;">
				<option value="{url sort=position}#link-items" {if $sort=='position'} selected{/if}>Сортировать по умолчанию</option>
				<option value="{url sort=name}#link-items" {if $sort=='name'} selected{/if}>Сортировать по названию</option>
				<option value="{url sort=price}#link-items" {if $sort=='price'} selected{/if}>Сортировать по цене</option>
			</select>
		</li>
		{/if}

		<li class="pull-right">
		{include file='x_pagination.tpl'}
		</li>
	</ul>

	<!-- Список товаров-->
	<ul id='products' class="row list-inline">
		{foreach $products as $product}
		<li class="col-xs-6 col-sm-4 col-lg-4"><div class="product">{include file='x_producBlock.tpl'}</div></li>
		{/foreach}
	</ul>

	{* Панель выбора показа товаров *}
	<ul class='row list-inline products-toolbar'>
		<li class="hidden-xs view-switcher">
			<label class="gridBlock" data-view="gridBlock"><i class="i-th-large-1"></i></label>
			<label class="gridList" data-view="gridList"><i class="i-th-1"></i></label>
		</li>

		{* Сортировка *}
		{if $products|count>1}
		<li class="sort">
			<select onchange="location = this.value;">
				<option value="{url sort=position}#link-items" {if $sort=='position'} selected{/if}>Сортировать по умолчанию</option>
				<option value="{url sort=name}#link-items" {if $sort=='name'} selected{/if}>Сортировать по названию</option>
				<option value="{url sort=price}#link-items" {if $sort=='price'} selected{/if}>Сортировать по цене</option>
			</select>
		</li>
		{/if}

		<li class="pull-right">
		{include file='x_pagination.tpl'}
		</li>
	</ul>

{else}
	<div class="divider"></div>
	<div class="content-text">
		<i><b>Товары не найдены</b><br />
		Попробуйте зайти позже
		</i>
	</div>
{/if}


{literal}
<script>
	function equalize_products(view){
//		if(view == 'gridBlock'){
//		   Height = '';
//		   maxHeight = 0;
//		   $("#products .product").each(function(){
//			 if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
//			 Height = maxHeight;
//		   });
//		   $("#products .product").height(Height);
//
		//};
	};
	if($('#products').size()){
        if(sessionStorage){
            if(!sessionStorage.view){
                sessionStorage.view = "gridBlock";
				$('.view-switcher .block').addClass('selected');
                $('#products').addClass(sessionStorage.view).fadeIn(200);
                equalize_products(sessionStorage.view);
            }else{
                var view_elem = sessionStorage.view;
                $('label.'+sessionStorage.view).addClass('selected');
                $('#products').addClass(view_elem);
                equalize_products(sessionStorage.view);
            }

            $('.view-switcher label').click(function(e){
                e.preventDefault();
                sessionStorage.view = $(this).data('view');
                $('#products').hide();
                $('.view-switcher label').removeClass('selected');
				$('#products').removeClass('gridBlock').delay(100);
                $('#products').removeClass('gridList');
                $('#products').addClass(sessionStorage.view).fadeIn(200);
                $(this).addClass('selected');
                equalize_products(sessionStorage.view);
            });

        }else{
            $('#products').show();
            equalize_products(sessionStorage.view);
        }
    };
</script>
{/literal}

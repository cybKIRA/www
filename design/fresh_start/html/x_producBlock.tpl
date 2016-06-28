{*
	Блок товара для главной, каталога и т.п.
*}


<div class="transition1 image">
{if $product->image}<img src="{$product->image->filename|resize:180:180}" alt="{$product->name}"/>
{else}<i class="i-picture"></i>{/if}
</div>

<div class="transition1 itemDetails">

	{* Артикул *}
	{*
	<p class="hidden-xs m-0 text-xxs grey-text text-transparent" title='{$product->variant->sku}'>Код:{if $product->variant->sku}{$product->variant->sku|truncate:35:'...'}{else} -{/if}</p>
	*}
	{* Рейтинг *}
	{*
	<div class="rating text-xs grey-text" rel="{$product->id}" title='{$product->rating|string_format:"%.1f"}'>
	<span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span>
	</div>
	*}
	
	{* Название *}
	<h3 data-product="{$product->id}">{$product->name|escape|truncate:65:'...'}</h3>
	{if $product->city}
	<span>{$product->city}</span>
	{else}
	<span>&nbsp;</span>
	{/if}
	{* Блок текста только для товара в линию *}
	{if $smarty.get.module != MainView && $smarty.get.module != ProductView}
	<div class="description">
		{if $product->annotation}{$product->annotation|strip_tags|truncate:400:'...'}
		{else}Без описания
		{/if}
	</div>
	{/if}
</div>




<form class="variants" action="/cart">

	{if $product->variants|count > 0}

		{* Если цена у товара больше 0,00 руб и ОДИН вариант - выводим цену и заказ *}
		{if $product->variant->price > 0 && $product->variants|count == 1}
			<div class="transition1 price">
				<span class="one_price">{$product->variant->price|convert}</span><i>{$currency->sign|escape}</i>
				{if $product->variant->compare_price > 0}<strike class="one_compare_price">{$product->variant->compare_price|convert}</strike>{/if}
				<span style="display:none;" class="step_price">{$product->variant->price|convert}</span>
				<span style="display:none;" class="step_compare_price">{$product->variant->compare_price|convert}</span>
			</div>
			 
			
						<div class="amount">
							<span style="display:none;" class="amount_step">{if $product->variant->vis_sht != 1}{$product->variant->weight}{else}1{/if}</span>
							<input style="display:none;" type="text" name="amount" value="1">
							<span class="clickable minus">-</span>
							<input class="text-center" type="text" name="weight" value="{if $product->variant->vis_sht != 1}{$product->variant->weight}{else}1{/if}">
							<span class="clickable plus">+</span> <span class="amount-unit">{if $product->variant->vis_sht != 1}{$product->variant->unit}{else}шт{/if}</span>
							{*<button class="btn-primary btn action to-cart" type="submit"><i class="i-basket"></i> Купить</button>*}
						</div>
						
			
				<select class="form-control" name="variant" {if $product->variants|count==1}style='display:none;'{/if}>
				{foreach $product->variants as $v}
				<option value="{$v->id}" {if $v->compare_price > 0}compare_price="{$v->compare_price|convert}"{/if} price="{$v->price|convert}">{$v->name}</option>
				{/foreach}
				</select>
			<span class="card_btn">
				<button class="btn-primary btn action to-cart" type="submit"><i class="i-basket"></i> Купить</button>
			<span>

		{* Если цена у товара больше 0,00 руб и БОЛЬШЕ одного варианта - выводим цены и подробнее *}
		{elseif $product->variant->price > 0 && $product->variants|count > 1}

            {$min_variant = $product->variant}
			{foreach $product->variants as $v}
				{if $min_variant->price > $v->price && $v->price > 0}
					{$min_variant = $v}
				{/if}
			{/foreach}

			<div class="price" title='Несколько вариантов предложения'>
				<i>от&nbsp;</i>{$min_variant->price|convert}<i class="color">{$currency->sign|escape}...</i>
			</div>
 			<a class="btn-primary btn action to-cart" href=""><i class="i-newspaper"></i>{$product->variants|count} {$product->variants|count|plural:'Вариант':'Вариантов':'Варианта'}</a>

		{else}
			{* Иначе цена не указана и выводим просто кнопку звонка без корзины *}
			<div class='price text-lg text-bold'>Под заказ</div>
		{/if}


	{else}
		<!-- <div class='price text-lg text-bold'>Нет на складе</div>
		<div class="callBack btn-info btn-sm btn white-link text-noline"><div class="call-me"><a href="#call">Вам перезвонить? <i class="i-phone-1"></i></a></div></div> -->
	{/if}


	<noindex>
	</noindex>
</form>






<div class="itemsLabels">
	{if strtotime($product->created) >= strtotime('-1 months') && $smarty.get.module!='MainView'}<span class="transition1 tag" title='Добавлен в каталог недавно'>Новый</span>{/if}
	{if $product->variant->compare_price}<span class="transition1 itemsList-discounted tag" title='Специальная цена'>Скидка {floor(abs(100-{$product->variant->price}/($product->variant->compare_price)*100))}%</span>{/if}
	{if $product->featured && $smarty.get.module!='MainView'}<span class="transition1 itemsList-featured tag" title='Хит продаж по статистике'>Хит продаж</span>{/if}
</div>





<div class="clearfix"></div>

<div class="product-item-border outline-outward">

<a href="products/{$product->url}" class="product-image">
	{if $product->image}
		<img src="{$product->image->filename|resize:510:600}" alt="{$product->name|escape}" class="img-responsive">
	{else}
		<img src="design/{$settings->theme}/images/no_image_510x600.jpg" alt="{$product->name|escape}" class="img-responsive">
	{/if}
	
	{if $smarty.get.module != 'MainView'}
		{if $product->featured}
			<span class="bullet"><span class="glyphicon glyphicon-fire" aria-hidden="true"></span></span>
		{elseif $product->variant->compare_price}
			<span class="bullet label-sale">&minus;{(100-$product->variant->price * 100 / $product->variant->compare_price)|ceil}%</span>
		{/if}
	{/if}
</a>

<div class="product-title">
	{if $category->subcategories || $smarty.get.module == 'MainView'}
		<span class="">{$product->category->name}</span>
	{/if}
	
	<a href="products/{$product->url}" data-product="{$product->id}">{$product->name|escape}</a>
</div>

<div class="product-detail">
	{if $product->variants|count > 0}
	<div class="price-shop text-left">
		<ins>{$product->variant->price|convert} {$currency->sign|escape}</ins>
		{if $product->variant->compare_price}<del>{$product->variant->compare_price|convert} {$currency->sign|escape}</del>{/if}
		
	</div>
	{/if}
	
	<div class="rate">
		{strip}
			{section name=rate start=0 loop=5 step=1}
				{if $product->votes > 0}
					{if $smarty.section.rate.index < $product->rating / $product->votes}
						{if ($smarty.section.rate.index + 1) > $product->rating / $product->votes}
							<i class="fa fa-star-half-o"></i>
						{else}
							<i class="fa fa-star"></i>
						{/if}
					{else}
						<i class="fa fa-star-o"></i>
					{/if}
				{else}
					{*<i class="fa fa-star-o"></i>*}
					<i class="fa"></i>
				{/if}
			{/section}
		{/strip}
	</div>
	
	{if $product->comments_count > 0}
		<a href="products/{$product->url}/#comments">{$product->comments_count} {$product->comments_count|plural:'отзыв':'отзывов':'отзыва'}</a>
	{/if}
</div>

</div>
<a href="products/{$product->url}" class="pull-left">
	{if $product->image}
	<img src="{$product->image->filename|resize:510:600}" alt="{$product->name|escape}" width="82" height="100" class="img-responsive">
	{else}
	<img src="design/{$settings->theme}/images/no_image_510x600.jpg" alt="{$product->name|escape}" width="82" height="100" class="img-responsive">
	{/if}
</a>

<div class="media-body"><small class="">{$product->category->name|escape}</small>
	<h6 class="media-heading"><a href="/products/{$product->url}">{$product->name|escape}</a></h6>
	<div class="product-detail">
		<div class="rate">
			{strip}
				{section name=rate start=0 loop=5 step=1}
					{if $product->votes > 0}
						{if $smarty.section.rate.index < $product->rating / $product->votes && $product->votes > 0}
							{if ($smarty.section.rate.index + 1) > $product->rating / $product->votes}
								<i class="fa fa-star-half-o"></i>
							{else}
								<i class="fa fa-star"></i>
							{/if}
						{else}
							<i class="fa fa-star-o"></i>
						{/if}
					{else}
						<i class="fa fa-star-o"></i>
					{/if}
				{/section}
			{/strip}
		</div>
		{if $product->variants|count > 0}
		<div class="price-shop">
			{if $product->variant->compare_price}<del>{$product->variant->compare_price|convert} {$currency->sign|escape}</del>{/if}
			<ins>{$product->variant->price|convert} {$currency->sign|escape}</ins>
		</div>
		{/if}
	</div>
</div>
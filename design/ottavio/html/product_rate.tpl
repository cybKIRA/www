<div content="3" class="rate pull-left sep-bottom-xs">
	{*
	<meta itemprop="worstRating" content="1">
	<meta itemprop="ratingValue" content="{$product->rating}">
	<meta itemprop="bestRating" content="5">
	*}

	{strip}
		{section name=rate start=0 loop=5 step=1}
			{if $product->votes > 0}
				{if $smarty.section.rate.index < $product->rating / $product->votes && $product->votes > 0}
					{if ($smarty.section.rate.index + 1) > $product->rating / $product->votes}
						<i class="fa fa-star-half-o fa-lg"></i>
					{else}
						<i class="fa fa-star fa-lg"></i>
					{/if}
				{else}
					<i class="fa fa-star-o fa-lg"></i>
				{/if}
			{else}
				<i class="fa fa-star-o fa-lg"></i>
			{/if}
		{/section}
	{/strip}
						
	<small>
		<a href="#comments" class="scroll-to-product-comments">
			{if $comments}
				<span itemprop="ratingCount">{$comments|count}</span> {$comments|count|plural:'отзыв':'отзывов':'отзыва'}
			{else}
				{*Нет отзывов*}
			{/if}
		</a>
	</small>
						
	{if $product->featured==1}
	<br>
	<small>
		Рекомендуемый товар
	</small>
	{/if}
</div>
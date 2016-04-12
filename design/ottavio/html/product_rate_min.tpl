<span content="3" class="rate pull-left sep-bottom-xs">
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
						
</div>
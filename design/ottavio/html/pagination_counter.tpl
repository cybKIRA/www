<div class="sep-bottom-2x pull-right">Показаны
{if $current_page_num==1}
	1 - {$products|count}
{elseif $current_page_num==$total_pages_num}
	{$total_products_num - $products|count + 1} - {$total_products_num}
{else}
	{$products|count * ($current_page_num - 1) + 1} - {$products|count * $current_page_num}
{/if}
из {$total_products_num} {$total_products_num|plural:'товара':'товаров':'товаров'}
</div>
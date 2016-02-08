{if $delivery} 
	{if $cart->total_price < $delivery->free_from && $delivery->price>0}
		{$delivery->price|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}
	{elseif $cart->total_price >= $delivery->free_from}
		бесплатно
	{/if}
{else}
	{if $cart->total_price < $deliveries[0]->free_from && $deliveries[0]->price>0}
		{$deliveries[0]->price|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}
	{elseif $cart->total_price >= $deliveries[0]->free_from}
		бесплатно
	{/if}
{/if}
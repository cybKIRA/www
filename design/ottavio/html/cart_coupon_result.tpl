{if $coupon_result == min_order_price}
	Купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}
{elseif $coupon_result == invalid}
	Купон недействителен
{/if}
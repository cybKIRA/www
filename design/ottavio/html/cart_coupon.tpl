<span class="text-success">
{if $cart->coupon_discount>0}
&minus;{$cart->coupon_discount|convert}&nbsp;{$currency->sign}
{/if}
</span>


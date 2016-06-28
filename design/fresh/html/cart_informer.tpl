{if $cart->total_products>0}	<a href="/cart" class=""><span class='visible-xs'>Корзина</span>
{$cart->total_products}<span class='visible-xs'> {$cart->total_products|plural:'товар':'товаров':'товара'}</span></a>
{else}							<a href="/cart" class="disabled"><span class='visible-xs'>Корзина</span></a>{/if}


{if $cart->total_products>0}
	<div class="modalBlocks text-center" id="cart_popup" style='display:none;'>
		<div class="h5">Товар добавлен в корзину</div>
		<p class="">Сейчас в вашей корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}<br />на сумму {$cart->total_price|convert} {$currency->sign|escape}</p>
		<p><a class="btn btn-primary btn-mx m-10" href="cart">Оформить заказ / Изменить</a></p>
		<p><a class="text-underline color" href="javascript:jQuery.fancybox.close();">Продолжить покупки</a></p>
    </div>
{/if}
{if $cart->total_products>0}
<div class="shopping_cart_dropdown" >
	<ul class="cart_list product_list_widget">
		{foreach from=$cart->purchases item=purchase}
		{$image = $purchase->product->images|first}
		<li>
			<a href="cart/remove/{$purchase->variant->id}" class="delete" data-id="{$purchase->variant->id}"><i class="fa fa-close"></i></a>
			
			<a href="products/{$purchase->product->url}">
				{if $image}<img alt="{$product->name|escape}" src="{$image->filename|resize:510:600}">{/if}
				<span>{$purchase->product->name|escape}</span>
				
			</a>
			{if $purchase->variant->name}<small>{$purchase->variant->name|escape}</small>{/if}
			<h5 class="quantity"><small>{$purchase->amount} x </small>{$purchase->variant->price|convert}&nbsp;{$currency->sign}</h5>
		</li>
		{/foreach}
	</ul>

	<div class="total">
		<h6>Итого</h6><span>{$cart->total_price|convert} {$currency->sign|escape}</span>
	</div>

	<div class="action-button">
		<a href="./cart" class="btn btn-primary btn-xs upper">Оформить заказ</a></div>
	</div>
{else}
	<p class="text-center">В корзине нет товаров</p>
{/if}
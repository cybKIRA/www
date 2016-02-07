{* Шаблон корзины *}

{$meta_title = "Корзина" scope=parent}

<section class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="cart">Корзина</a></li>
				</ol>
				
				<h2 id="cart_title" class="small-space">{include file="cart_title.tpl"}</h2>
			</div>
		</div>
	</div>
</section>

<section class="sep-top-lg sep-bottom-lg">
	{if $cart->purchases}
	<form method="post" name="cart" id="purchases">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					{if $error || $coupon_error}
					<div class="sep-bottom-xs">
						<div role="alert" class="alert alert-danger ">
							{if $error == 'empty_name'}Введите имя{/if}
							{if $error == 'empty_email'}Введите email{/if}
							{if $coupon_error == 'invalid'}Купон недействителен{/if}
						</div>
					</div>
					{/if}
					
					<table class="table table-bordered table-condensed table-striped shop-table table-responsive">
						<thead>
							<tr>
								<th scope="col" class="dark">Товар</th>
								<th scope="col" class="dark text-center hidden-xs">Цена</th>
								<th scope="col" class="dark text-center">Количество</th>
								<th scope="col" class="dark text-center">Итого</th>
								<th scope="col" class="dark text-center">&nbsp;</th>
							</tr>
						</thead>
						
						<tbody>
							{foreach from=$cart->purchases item=purchase}
							<tr id="cart_item_{$purchase->variant->id}">
								<td class="text-left">
									{$image = $purchase->product->images|first}
									{if $image}
									<a href="products/{$purchase->product->url}" class="img-prod hidden-xs"><img src="{$image->filename|resize:510:600}" width="45" class="img-responsive" alt="{$product->name|escape}"></a>
									{/if}
									<h6 class="name-prod"><a href="products/{$purchase->product->url}">{$purchase->product->name|escape}</a></h6>{if $purchase->variant->name|escape}, {$purchase->variant->name|escape}{/if}
								</td>
								<td class="text-right hidden-xs">
									<h5 class="">{($purchase->variant->price)|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}</h5>
								</td>
								<td>
									<input type="text" name="amounts[{$purchase->variant->id}]" value="{$purchase->amount}" class="qty" data-id="{$purchase->variant->id}" autocomplete="off">
								</td>
								<td class="text-right">
									<h5 id="cart_item_total_{$purchase->variant->id}">{($purchase->variant->price*$purchase->amount)|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}</h5>
								</td>
								<td class="text-center">
									<a title="Удалить" href="cart/remove/{$purchase->variant->id}" class="remove-button " data-id="{$purchase->variant->id}">
										<span class="fa-stack fa-md"><i class="fa fa-times"></i></span>
									</a>
								</td>
							</tr>
							{/foreach}
						</tbody>
					</table>
				</div>
			</div>
			
			{if $coupon_request}
			<div class="row">
				<div class="col-md-12 sep-top-md">
					<div class="coupon-code form-group pull-left">
						<input type="text" placeholder="Код купона" value="{$cart->coupon->code|escape}" name="coupon_code" class="form-control input-lg" id="coupon_code">
					</div>

					<button type="button" class="btn btn-dark btn-bordered" id="coupon_apply">Применить купон</button>

					<span id="coupon_result" class="text-danger"></span>
				</div>
			</div>
			{/if}
		</div>
		
		<div class="container">
			<div class="row">
				<div id="deliveries" class="col-md-6">
					{include file="delivery.tpl"}
				</div>
				
				<div class="col-md-6">
					<div class="cart_totals sep-top-lg">
						<h5 class="">Итого</h5>
						<div class="sep-top-sm">
							<table class="table table-bordered table-condensed table-responsive">
								<tbody>
									<tr>
										<td>Стоимость заказа</td>
										<td id="cart_items_total">{include file="cart_items_total.tpl"}</td>
									</tr>
									
									{if $user->discount}
									<tr>
										<td>Cкидка</td>
										<td>{$user->discount}&nbsp;%</td>
									</tr>
									{/if}
									
									<tr {if !$cart->coupon || ($cart->coupon->min_order_price > $cart->total_price)}class="hidden"{/if}>
										<td>Купон</td>
										<td id="cart_coupon">{include file="cart_coupon.tpl"}</td>
									</tr>
									
									<tr>
										<td>Доставка</td>
										<td id="delivery_cost">{include file="delivery_cost.tpl"}</td>
									</tr>
									
									<tr class="evidence">
										<td>
											<h5>Итого</h5>
										</td>
										<td>
											<h5 id="cart_total">{include file="cart_total.tpl"}</h5>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="sep-top-lg">
						<h5 class="">Адрес получателя</h5>
						
						<div class="sep-top-sm form-gray-fields">
							<div class="row">
								<div class="col-sm-12 form-group">
									<label class="">Имя, фамилия <span class="text-danger">*</span></label>
									<input type="text" value="{$name|escape}" placeholder="" name="name" class="form-control input-lg" required>
								</div>
							</div>
							
							<div class="row">
								<div class="col-sm-6 form-group">
									<label class="">Email <span class="text-danger">*</span></label>
									<input type="email" value="{$email|escape}" placeholder="" name="email" class="form-control input-lg" required>
								</div>
								
								<div class="col-sm-6 form-group">
									<label class="">Телефон</label>
									<input type="text" value="{$phone|escape}" placeholder="" name="phone" class="form-control input-lg">
								</div>
							</div>
							
							<div class="row">
								<div class="col-sm-12 form-group">
									<label class="">Адрес доставки</label>
									<input type="text" value="{$address|escape}" placeholder="" name="address" class="form-control input-lg">
								</div>
							</div>
							
							<div class="row">
								<div class="col-sm-12 form-group">
									<label class="">Комментарий к&nbsp;заказу</label>
									<textarea name="comment" rows="4" placeholder="" class="form-control input-lg">{$comment|escape}</textarea>
								</div>
							</div>
						</div>

						<div class="sep-top-sm text-right"><input type="submit" name="checkout" class="btn btn-primary" value="Оформить заказ" /></div>
					</div>
				</div>
			</div>
		</div>
	</form>		
	{else}
	<div class="container sep-bottom-5x">
		<div class="row">
			<div class="col-md-12">	
				<div role="alert" class="alert alert-info alert-dismissible">В корзине нет товаров.</div>
			</div>
		</div>
	</div>
	{/if}
</section>
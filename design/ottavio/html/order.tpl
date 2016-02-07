{* Страница заказа *}

{$meta_title = "Ваш заказ №`$order->id`" scope=parent}

<section class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					{if $user}
					<li><a href="user">Личный кабинет</a></li>
					{/if}
					<li>Заказ №{$order->id}</li>
				</ol>
				
				<h2 class="small-space">
					Ваш заказ №{$order->id} 
					{if $order->status == 0}принят{/if}
					{if $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
					{if $order->paid == 1}, оплачен{else}{/if}
				</h2>
			</div>
		</div>
	</div>
</section>

<section class="sep-top-lg sep-bottom-lg">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-condensed table-striped shop-table table-responsive">
					<thead>
						<tr>
							<th scope="col" class="dark">Товар</th>
							<th scope="col" class="dark text-center hidden-xs">Цена</th>
							<th scope="col" class="dark text-center">Количество</th>
							<th scope="col" class="dark text-center">Итого</th>
						</tr>
					</thead>
					
					<tbody>
						{foreach $purchases as $purchase}
						<tr>
							<td class="text-left">
								{$image = $purchase->product->images|first}
								{if $image}
								<a href="products/{$purchase->product->url}" class="img-prod hidden-xs"><img src="{$image->filename|resize:510:600}" width="45" class="img-responsive" alt="{$product->name|escape}"></a>
								{/if}
								<h6 class="name-prod"><a href="products/{$purchase->product->url}">{$purchase->product->name|escape}</a></h6>{if $purchase->variant_name|escape}, {$purchase->variant_name|escape}{/if}
								{if $order->paid && $purchase->variant->attachment}
									<a class="download_attachment" href="order/{$order->url}/{$purchase->variant->attachment}">скачать файл</a>
								{/if}
							</td>
							<td class="text-right hidden-xs">
								<h5 class="">{($purchase->price)|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}</h5>
							</td>
							<td class="text-center">
								<h5>&times; {$purchase->amount}&nbsp;{$settings->units}</h5>
							</td>
							<td class="text-right">
								<h5>{($purchase->price*$purchase->amount)|convert|replace:' ':'&nbsp;'}&nbsp;{$currency->sign}</h5>
							</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="cart_totals sep-top-lg">
					<h5 class="">Детали заказа</h5>
					<div class="sep-top-sm">
						<table class="table table-bordered table-condensed table-responsive">
							<tbody>
								<tr>
									<td>Дата заказа</td>
									<td>{$order->date|date} в {$order->date|time}</td>
								</tr>
								{if $order->name}
								<tr>
									<td>Имя</td>
									<td>{$order->name|escape}</td>
								</tr>
								{/if}
								{if $order->email}
								<tr>
									<td>Email</td>
									<td>{$order->email|escape}</td>
								</tr>
								{/if}
								{if $order->phone}
								<tr>
									<td>Телефон</td>
									<td>{$order->phone|escape}</td>
								</tr>
								{/if}
								{if $order->address}
								<tr>
									<td>Адрес доставки</td>
									<td>{$order->address|escape}</td>
								</tr>
								{/if}
								{if $order->comment}
								<tr>
									<td>Комментарий</td>
									<td>{$order->comment|escape|nl2br}</td>
								</tr>
								{/if}
								
								{* Скидка, если есть *}
								{if $order->discount > 0}
								<tr>
									<td>скидка</td>
									<td>{$order->discount}&nbsp;%</td>
								</tr>
								{/if}
								{* Купон, если есть *}
								{if $order->coupon_discount > 0}
								<tr>
									<td>купон</td>
									<td>&minus;{$order->coupon_discount|convert}&nbsp;{$currency->sign}</td>
								</tr>
								{/if}
								{* Если стоимость доставки входит в сумму заказа *}
								{if !$order->separate_delivery && $order->delivery_price>0}
								<tr>
									<td>{$delivery->name|escape}</td>
									<td>{$order->delivery_price|convert}&nbsp;{$currency->sign}</td>
								</tr>
								{/if}
								{* Итого *}
								<tr class="evidence">
									<td><h5>Итого</h5></td>
									<td><h5>{$order->total_price|convert}&nbsp;{$currency->sign}</h5></td>
								</tr>
								{* Если стоимость доставки не входит в сумму заказа *}
								{if $order->separate_delivery}
								<tr>
									<td>{$delivery->name|escape}</td>
									<td>{$order->delivery_price|convert}&nbsp;{$currency->sign}</td>
								</tr>
								{/if}
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			{if !$order->paid}
			<div class="col-md-6">
				{if $payment_methods && !$payment_method && $order->total_price>0}
				<div class="sep-top-lg">
					<h5 class="">Выберите способ оплаты</h5>
					
					<div class="sep-top-sm">
						<form method="post" id="payment_methods">
							<table class="table table-bordered table-condensed table-responsive">
								<tbody>
									{foreach $payment_methods as $payment_method}
									<tr>
										<td>
											<div class="radio text-left">
												
												<label for="payment_{$payment_method->id}" {if $payment_method@first}class="active"{/if}>
													<div class="pull-right">{$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}</div>
													
													<input type="radio" value="{$payment_method->id}" name="payment_method_id" id="payment_{$payment_method->id}" {if $payment_method@first}checked{/if}>
													
													<strong class="dark">{$payment_method->name}</strong>
												</label>
												
												
												{if $payment_method->description}
												<div class="small sep-top-xs" {if !$payment_method@first}style="display: none"{/if}>
													{$payment_method->description}
												</div>
												{/if}
											</div>
										</td>
									</tr>
									{/foreach}
								</tbody>
							</table>
							
							<div class="sep-top-sm text-right"><input type="submit" class="btn btn-primary" value="Закончить заказ" /></div>
						</form>
					</div>
				</div>

				{* Выбраный способ оплаты *}
				{elseif $payment_method}
				<div class="sep-top-lg">
					<h5 class="">Способ оплаты &mdash; {$payment_method->name}</h5>
					
					<div class="sep-top-sm">
						{$payment_method->description}
						
						<form method="post">
							<input type="hidden" name="reset_payment_method" value="reset_payment_method">
							<button type="submit" class="btn btn-default btn-bordered btn-xs"><i class="fa fa-reply"></i>&nbsp;Выбрать другой способ оплаты</button>
						</form>	
						
					</div>	
				</div>	
				
				<div class="sep-top-lg">
					<h5 class="">К оплате {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}</h5>

					<div class="sep-top-sm">
						{* Форма оплаты, генерируется модулем оплаты *}
						{checkout_form order_id=$order->id module=$payment_method->module}
					</div>
				</div>
				{/if}
			</div>
			{/if}
		</div>
	</div>
</section> 
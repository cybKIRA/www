{* Шаблон корзины *}
{$meta_title = "Корзина" scope=parent}

{if $cart->purchases}


<form method="post" name="cart">

	<table class="table table-condensed table-hover cartTable text-left form ">
		<thead>
			<tr>
				<td><strong>Наименование</strong></td>
				<td class="text-center"><strong>Цена</strong></td>
				{*<td class="text-center"><strong>Количество</strong></td>*}
				<td class="text-center"><strong>Итого</strong></td>
			</tr>
		</thead>
		<tbody>
			{foreach $cart->purchases as $purchase}
			<tr class="">
				<td class="item-name">
					<div class="image">
						<a class='pull-left' title="Удалить из корзины" href="cart/remove/{$purchase->variant->id}"><i style="font-size:16px;color:red" class="i-cancel-1"></i></a>
						{$image = $purchase->product->images|first}
						<a href="products/{$purchase->product->url}">{if $image}<img src="{$image->filename|resize:50:50}" alt="{$product->name|escape}">{else}<i class="i-picture"></i>{/if}</a>
					</div>
					{$purchase->product->name|escape}{if $purchase->variant->name|escape}<br /><b><i>{$purchase->variant->name|escape}</i></b>{/if}
				</td>
				<td class="text-center">{($purchase->variant->price)|convert} {$currency->sign}, за {if $purchase->variant->unit != 'кг'}{$purchase->variant->weight|convert}{else}{$purchase->variant->weight}{/if} {$purchase->variant->unit}</td>
				<td style="display:none;" class="text-center">
					<select name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
						{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
						<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index}selected{/if}>{$smarty.section.amounts.index}<!-- , {if $purchase->variant->unit}{$purchase->variant->unit}{else}{$settings->units}{/if} --></option>
						{/section}
					</select>
				</td>
				<td class="text-center price">{($purchase->variant->price*$purchase->amount)|convert}&nbsp;{$currency->sign}</th>
			</tr>
			{/foreach}
		</tbody>
		<tfoot>
			{if $user->discount}
			<tr>
				<th class="text-right" colspan='3'><strong>Ваша персональная скидка</strong></th>
				<th class="text-center">{$user->discount}&nbsp;%</th>
			</tr>
			{/if}

			{if $coupon_request}
			<tr class="coupon" id=coupon>
				{if $coupon_request && $cart->coupon_discount==0}
				<th colspan=4>
					{if $coupon_error}
						<div class="text-alert alert-danger p-15">
						Купон недействителен или указан с ошибкой
						</div>
					{elseif $cart->coupon->min_order_price>0}
						<div class="alert alert-success p-15">
						Извините, но этот купон действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}
						</div>
					{/if}

					<h5>Код купона или подарочного ваучера для дополнительной скидки</h5>
					<input type="text" name="coupon_code" value="{$cart->coupon->code|escape}" class="coupon_code color-text text-md text-center text-bold">
					<input type="button" name="apply_coupon" value="Применить купон" class='btn-success btn' onclick="document.cart.submit();">
				</th>

				{elseif $cart->coupon_discount>0}
					<th class="text-right" colspan='2'><strong>Скидка по промо коду:</strong></div></th>
					<th class="text-center">{$cart->coupon_discount|convert}&nbsp;{$currency->sign}</th>
				{/if}
			</tr>
			{/if}
			<tr>
				<th class="text-right" colspan='2'><strong>{if $user->discount}Итого с учетом скидки{else}Итого{/if}</strong></th>
				<th class="text-center">{$cart->total_price|convert}&nbsp;{$currency->sign}</th>
			</tr>
		</tfoot>
	</table>


	
		<div class="col-xs-12 col-md-7">
			<div class="h3 text-uppercase"><span>СПОСОБ ОПЛАТЫ</span> НАЛИЧНЫМИ КУРЬЕРУ</div>
		</div>

	

	{if $deliveries}
	<div class="col-xs-12 col-md-7 form ">
		<div class="text-left deliveriesBlock">
			<div class="h3 text-uppercase"><span>Выберите</span> способ доставки</div>
			{foreach $deliveries as $delivery}
				<div class="checkbox pull-left">
				<input type="radio" name="delivery_id" value="{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if} id="deliveries_{$delivery->id}">
				</div>

				<h4 data-delivery="{$delivery->id}">
				<label for="deliveries_{$delivery->id}">
				{$delivery->name}
					<span>{if $cart->total_price < $delivery->free_from && $delivery->price>0}	({$delivery->price|convert}&nbsp;{$currency->sign})
					{elseif $cart->total_price >= $delivery->free_from}						(бесплатно){/if}</span>
				</label>
				</h4>
				<div class="description text-sm">{$delivery->description}</div>
				<hr class='small'>
			{/foreach}
		</div>
	</div>
	{/if}
	<div class="col-xs-12 col-md-5 form well text-left">
		{if $error}
			<div class="alert alert-danger">
			{if $error == 'empty_name'}Введите имя{/if}
			{if $error == 'empty_email'}Введите email{/if}
			{if $error == 'empty_phone'}Введите телефон{/if} {* GLOOBUS 2016-06-22 проверка ввода телефона *}
			{if $error == 'minimal'}Сумма заказа меньше минимальной{/if}
			{if $error == 'captcha'}Неверно введён защитный код{/if}
			</div>
		{/if}

		<div class="h3"><span>Укажите контакты</span> и пожелания по заказу</div>
		<div class="form-group">
			<label for="name">Имя, фамилия *</label>
			<div class="input-group">
				<span class="input-group-addon"><i class="i-user-1"></i></span>
				<input class="form-control" name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" placeholder="Представьтесь"/>
			</div>
		</div>
		{*
		<div class="form-group">
			<label for="email">Email *</label>
			<div class="input-group">
				<span class="input-group-addon"><i class="i-email"></i></span>
				<input class="form-control" type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" placeholder="Email" maxlength="255" />
			</div>
		</div>
		*}
		<div class="form-group">
			<label for="email">Ваш контактный телефон *</label>
			<div class="input-group">
				<span class="input-group-addon"><i class="i-phone-1"></i></span>
				<input class="form-control" name="phone" data-format=".+" data-notice="Введите телефон" type="text" value="{$phone|escape}" placeholder="Телефон" id="phoneCart" />
			</div>
		</div>
		<div class="form-group">
			<label for="email">Адрес доставки</label>
			<div class="input-group">
				<span class="input-group-addon"><i class="i-home-1"></i></span>
				<input class="form-control" name="address" type="text" value="{$address|escape}"/>
			</div>
		</div>
		{assign var="time" value="`$smarty.now|date_format:"%H"`"}
		
		<div class="form-group">
			<label for="time">Выбирите желаемое время доставки</label> {if $time > 17} <br> Доставка возможна на завтра {/if}
			<select class="form-control" id=time name="time">
				<option value="">&nbsp;</option>
				{if $time < 8 || $time > 17}<option value="c 10:00 до 12:00">c 10:00 до 12:00 </option>{/if}
				{if $time < 10 || $time > 17}<option value="c 12:00 до 14:00">c 12:00 до 14:00 </option>{/if}
				{if $time < 12 || $time > 17}<option value="c 14:00 до 16:00">c 14:00 до 16:00 </option>{/if}
				{if $time < 14 || $time > 17}<option value="c 16:00 до 18:00">c 16:00 до 18:00 </option>{/if}
				{if $time < 16 || $time > 17}<option value="c 18:00 до 20:00">c 18:00 до 20:00 </option>{/if}
			</select>
		</div>
		
		<div class="form-inline">
			<label for="sdacha">Необходима сдача с </label>
			<div class="">
				<input class="form-control" name="change_rub" type="number" min="0" max="50000" value="{$sdacha|escape}"/> <span class="input-rub"> руб.</span>
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="name">Примечание к заказу или пожелание</label>
			<textarea class="form-control" rows="7" cols="25" value="{$comment|escape}" name="comment" id="order_comment">{$comment|escape}</textarea>
		</div>
		<div class="form-group">
			<label>Введите код</label>
			<div class="input-group">
				<input class="col-xs-5 input_captcha text-center" id="comment_captcha" type="text" name="captcha_code" maxlength="6" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
				<div class="col-xs-6 captcha"><img src="captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/></div>
			</div>
		</div>
		<input type="submit" name="checkout" class="btn btn-lg btn-success"value="Отправить заказ">
	</div>

</form>

{else}

	<article class="content-text">
		<p>Вы можете оформить заказ на любое предложение в нашем каталоге, заполнив простую форму заказа на сайте. Добавьте выбранный вариант в корзину в каталоге товаров или на странице товара. При оформлении заказа укажите Ваши имя и фамилию, e-mail, контактный номер телефона и адрес. Если у Вас есть комментарии по заказу и доставке, напишите их в поле Дополнительной информации. </p>

		<div class="h3">Для чего регистрация</div>
		<p>Для наших постоянных клиентов мы предлагаем зарегистрироваться в нашем каталоге. </p>

		<p><a class='' href='/user/register'>Регистрация</a> не обязательна для совершения покупки, но создав учетную запись на нашем сайте, вы сможете оформлять заказ быстрее, просматривать и отслеживать состояние заказов, а не вводить личные данные при втором и последующих заказах. Чтобы зарегистрироваться, Вам необходимо ввести личные данные (имя и фамилию) и почтовый адрес (e-mail). Если Вы забыли свой пароль, <a class='' href='/user/password_remind'>воспользуйтесь службой напоминания пароля</a>. Ваш пароль будет выслан Вам по адресу Вашей электронной почты.</p>
		На странице <a class='' href='/user'>"Личный кабинет"</a> Вы всегда сможете изменить свою регистрационную информацию.
	</article>

	<div class="divider"></div>

	{* Рекомендуемые товары *}
	{get_featured_products var=featured_products limit=5 order='RAND()'}
	{if $featured_products}
		<div class="title-header text-center textLine m-t-20">
			<div class="h2"><span>Рекомендуемые товары</span> нашего каталога</div>
			<div class="dark-line"></div>
			<div class="sub-heading text-underline"><a href='/hits'>показать все</a></div>
		</div>

		<ul id='products' class="row list-inline gridBlock">
			{foreach $featured_products as $product}
			{$delay1=0.4 + $product@iteration / 12}
			<li class="col-md-3 col-20 wow fadeIn" data-wow-duration="1.35s" data-wow-delay="{$delay1|string_format:"%.2f"}s"><div class="product">{include file='x_producBlock.tpl'}</div></li>
			{/foreach}
		</ul>
	{/if}

{/if}


{* GLOOBUS 2016-06-22 тут я переделал ввод телефона на более продвинутый маск-фильтр *}
<script src="/js/jquery.maskedinput.min.js" type="text/javascript"></script>
{literal}
<script>
$(document).ready(function(){
	$("#phoneCart").mask("+7 (999) 999-99-99");
});
</script>
{/literal}
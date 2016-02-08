{* Шаблон страницы зарегистрированного пользователя *}

<section style="background-image: url('design/{$settings->theme}/images/intro-home5.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="user">Личный кабинет</a></li>
				</ol>
			
				<h2 class="small-space" >{$user->name|escape}</h2>
			</div>
		</div>
	</div>
</section>

<div class="sep-top-lg">
	<div class="container">
		<section class="row">
			<div class="col-md-6 sep-bottom-lg">
				{if $error}
				<div role="alert" class="alert alert-danger alert-dismissible">
					{if $error == 'empty_name'}Введите имя
					{elseif $error == 'empty_email'}Введите email
					{elseif $error == 'empty_password'}Введите пароль
					{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
					{else}{$error}{/if}
				</div>
				{/if}
				
				<h4>Личные данные</h4>
				
				<form class="form-gray-fields sep-top-xs" method="post">
					<div class="form-group">
						<label class="">Имя</label>
						<input type="name" value="{$name|escape}" placeholder="" name="name" class="form-control input-lg" required>
					</div>
					
					<div class="form-group">
						<label class="">Email</label>
						<input type="email" value="{$email|escape}" placeholder="" name="email" class="form-control input-lg" required>
					</div>
					
					<div class="form-group">
						<label class=""><a href='#' onclick="$('#password').show();return false;">Изменить пароль</a></label>
						<input id="password" type="password" value="" placeholder="" name="password" class="form-control input-lg" style="display:none;">
					</div>
 
					<div class="sep-top-sm text-center">
						<input type="submit" class="btn btn-primary" value="Сохранить" />
					</div>
				</form>
			</div>
			
			<div class="col-md-6 sep-bottom-lg">
				<h4>Ваши заказы</h4>
				
				<div class="sep-top-xs">
					{if $orders}
						<table class="table table-orders">
							<tbody>
								<tr>
									<th>Дата</th>
									<th>Номер</th>
									<th>Статус</th>
								</tr>
								{foreach name=orders item=order from=$orders}
								<tr>
									<td>{$order->date|date}</td>
									<td><a href='order/{$order->url}' class="primary">Заказ&nbsp;№{$order->id}</a></td>
									<td>{if $order->paid == 1}оплачен,{/if} {if $order->status == 0}ждет обработки{elseif $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}</td>
								</tr>
								{/foreach}
							</tbody>
						</table>
					{else}
						<p>Нет заказов</p>
					{/if}
				</div>
			</div>
		</section>
	</div>
</div>
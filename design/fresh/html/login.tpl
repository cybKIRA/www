{* Страница входа пользователя *}

{* Канонический адрес страницы *}
{$canonical="/user/login" scope=parent}

{$meta_title = "Вход" scope=parent}

<div class="col-md-10 col-lg-8 p-0">
	{if $user}
		<h2>{$user->name},</h2>
		<p>Вы авторизировались.{if $group->discount>0} Ваша скидка - {$group->discount}%{/if}<br />
		Можно перейти на главную страницу к просмотру предложений нашего каталога.</p>
		<a href="./">Главная</a>

	{else}

		<p>Выполнив вход, Вы сможете заказывать товары с учетом скидки, назначенной администрацией для вашего аккаунта. Уточнить Вашу персональную скидку Вы можете по нашим телефонам.</p>
		<div class="divider sm"></div>

		{if $error}
		<i class="color"><b>
		{if $error == 'login_incorrect'}Неверный логин или пароль
		{elseif $error == 'user_disabled'}Ваш аккаунт еще не активирован.
		{else}{$error}{/if}
		</b></i>
		<div class="divider"></div>
		{/if}

		<form class="row m-0 form" method="post" action='{$config->root_url}/user/login'>
			<div class="form-group col-md-6">
				<label for="email">Email *</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="i-email"></i></span>
					<input class="form-control" type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" placeholder="Email" maxlength="255" />
				</div>
			</div>
			<div class="form-group col-md-6">
				<label for="email">Пароль * (<a href="user/password_remind">напомнить</a>)</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="i-key"></i></span>
					<input class="form-control" type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" />
				</div>
			</div>
			<div class="col-xs-12">
			<input class="btn btn-primary btn-mx" type="submit" name="login" value="Вход для учета скидки" />
			</div>
		</form>
	{/if}
</div>
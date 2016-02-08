{* Письмо пользователю для восстановления пароля *}

{* Канонический адрес страницы *}
{$canonical="/user/password_remind" scope=parent}

<section style="background-image: url('design/{$settings->theme}/images/parallax/page.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="user/password_remind">Напоминание пароля</a></li>
				</ol>
			
				<h2 class="small-space">Напоминание пароля</h2>
			</div>
		</div>
	</div>
</section>

<div class="sep-top-lg sep-bottom-3x">
	<div class="container sep-bottom-{if $email_sent}5x{else}3x{/if}">
		<section class="row">
			<div class="col-md-6 col-md-push-3">
				{if $email_sent}
					<div role="alert" class="alert alert-success alert-dismissible">
						На <strong>{$email|escape}</strong> отправлено письмо для восстановления пароля.
					</div>
				{else}
					{if $error}
					<div role="alert" class="alert alert-danger alert-dismissible">
						{if $error == 'user_not_found'}Пользователь не найден{else}{$error}{/if}
					</div>
					{/if}
					
					<form class="form-gray-fields validate" method="post">
						<div class="form-group">
							<label class="">Введите email, который вы указывали при регистрации</label>
							<input type="email" value="{$email|escape}" placeholder="" name="email" class="form-control input-lg" required>
						</div>
						
						<div class="sep-top-sm text-center">
							<input type="submit" name="register" class="btn btn-primary" value="Вспомнить" />
						</div>
					</form>
				{/if}
			</div>
		</section>
	</div>
</div>
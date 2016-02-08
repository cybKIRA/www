{* Страница регистрации *}

{* Канонический адрес страницы *}
{$canonical="/user/register" scope=parent}

{$meta_title = "Регистрация" scope=parent}

<section style="background-image: url('design/{$settings->theme}/images/parallax/page.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="user/register">Регистрация</a></li>
				</ol>
			
				<h2 class="small-space">Регистрация</h2>
			</div>
		</div>
	</div>
</section>

<div class="sep-top-lg sep-bottom-lg">
	<div class="container">
		<section class="row">
			<div class="col-md-6 col-md-push-3">
				{if $error}
				<div role="alert" class="alert alert-danger alert-dismissible">
					{if $error == 'empty_name'}Введите имя
					{elseif $error == 'empty_email'}Введите email
					{elseif $error == 'empty_password'}Введите пароль
					{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
					{elseif $error == 'captcha'}Неверно введена капча
					{else}{$error}{/if}
				</div>
				{/if}
				
				<form class="form-gray-fields validate" method="post">
					<div class="form-group">
						<label >Имя</label>
						<input type="text" value="{$name|escape}" placeholder="" name="name" class="form-control input-lg" required>
					</div>

					<div class="form-group">
						<label >Email</label>
						<input type="email" value="{$email|escape}" placeholder="" name="email" class="form-control input-lg" required>
					</div>
					
					<div class="form-group">
						<label >Пароль</label>
						<input type="password" value="" placeholder="" name="password" class="form-control input-lg">
					</div>

					<div class="sep-top-sm text-center">
						<input type="submit" name="register" class="btn btn-primary" value="Зарегистрироваться" />
					</div>
				</form>
			</div>
		</section>
	</div>
</div>
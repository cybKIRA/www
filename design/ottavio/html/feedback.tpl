{* Страница с формой обратной связи *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<section style="background-image: url('design/{$settings->theme}/images/parallax/feedback.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="{$page->url}">{$page->name|escape}</a></li>
				</ol>
				
				<h2 class="small-space">{$page->header|escape}</h2>
			</div>
		</div>
	</div>
</section>

<section class="sep-top-lg">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center">
					<h2>Контактные данные</h2>
					
			<!--		{$page->body} -->
				</div>
			</div>
		</div>
	</div>
</section>
		
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<div class="col-sm-3 col-md-3 icon-gradient sep-top-lg">
					<div class="icon-box icon-horizontal icon-sm">
						<div class="icon-content img-circle"><i class="fa fa-map-marker"></i></div>
						<div class="icon-box-content">
							<h3 >Адрес</h3>
							<p>Москва<br>ул. Яблочкова, д. 21В, стр. 1</p>
						</div>
					</div>
				</div>
				<div class="col-sm-3 col-md-3 icon-gradient sep-top-lg">
					<div class="icon-box icon-horizontal icon-sm">
						<div class="icon-content img-circle"><i class="fa fa-phone"></i></div>
						<div class="icon-box-content">
							<h3>Телефон</h3>
							<p>8 (499)-40-40-996</p>
						</div>
					</div>
				</div>
				<div class="col-sm-3 col-md-3 icon-gradient sep-top-lg">
					<div class="icon-box icon-horizontal icon-sm">
						<div class="icon-content img-circle"><i class="fa fa-envelope"></i></div>
						<div class="icon-box-content">
							<h3>E-mail</h3>
							<p>info@kupi.watch</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 icon-gradient sep-top-lg">
					<div class="icon-box icon-horizontal icon-sm">
						<div class="icon-content img-circle"><i class="fa fa-clock-o"></i></div>
						<div class="icon-box-content">
							<h3>Работаем</h3>
							<p>Пн-Пт: <br>11:00 - 20:00</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section>
 	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1 text-center">
			<br><br>
 						<small>ИНН 010505143631 ОГРН 315010500013463 ИП Плотников Николай Николаевич</small>
			</div>
		</div>
	</div>
</section>
		
<section id="contactSection" class="sep-top-2x sep-bottom-2x">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center">
					<h2>Написать сообщение</h2>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<div class="contact-form sep-top-lg">
					{if $message_sent}
						<div role="alert" class="alert alert-success alert-dismissible">
							<strong>{$name|escape}</strong>,&nbsp;ваше сообщение отправлено.
						</div>
					{else}
					
					{if $error}
						<div role="alert" class="alert alert-danger alert-dismissible">
							{if $error=='captcha'}
							Неверно введена капча
							{elseif $error=='empty_name'}
							Введите имя
							{elseif $error=='empty_email'}
							Введите email
							{elseif $error=='empty_text'}
							Введите сообщение
							{/if}
						</div>
					{/if}
		
					<form id="contactForm" method="post" class="form-gray-fields">
						<div class="row">
							<div class="col-md-6 sep-top-xs">
								<div class="form-group">
									<label for="name" >Имя</label>
									<input id="name" type="text" value="{$name|escape}" name="name" class="form-control input-lg" required>
								</div>
							</div>
							<div class="col-md-6 sep-top-xs">
								<div class="form-group">
									<label for="email" >Email</label>
									<input id="email" type="email" value="{$email|escape}" name="email" class="form-control input-lg email" required>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 sep-top-xs">
								<div class="form-group">
									<label for="comment" >Сообщение</label>
									<textarea id="comment" rows="9" name="message" class="form-control input-lg" required>{$message|escape}</textarea>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 sep-top-xs">
								<div id="contactResult"></div>
								
								<div class="form-group text-center">
									<input type="hidden" name="feedback" value="input_for_submit_form">
									<button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i>&nbsp;Отправить</button>
								</div>
							</div>
						</div>
					</form>
					{/if}
					
					<div class="hidden"></div>
				</div>
			</div>
		</div>
	</div>
</section>
		

<section>
 <div>
 	<script type="text/javascript" charset="utf-8" src="https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=-7x0WW5THQ4FXpZ1KlKexHl2eon919cP&width=100%&height=366&lang=ru_RU&sourceType=constructor"></script>
 </div>
</section>
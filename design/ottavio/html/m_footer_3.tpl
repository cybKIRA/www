<footer id="footer">
	<div class="inner sep-bottom-md">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg"><img src="design/{$settings->theme}/images/logo-white.png" alt="" class="logo">
						<ul class="widget-address sep-top-xs">
							<li><i class="fa fa-map-marker fa-lg"></i><small>шоссе Энтузиастов 45/31<br>офис 453, Москва</small></li>
							<li><i class="fa fa-phone fa-lg"></i><small>(+39) 123-456-789 /<br>(+39) 123-456-789</small></li>
							<li><i class="fa fa-envelope fa-lg"></i><small><a href="#">info@ottaviostudios.com</a> /<br><a href="#">support@ottaviostudios.com</a></small></li>
							<li><i class="fa fa-clock-o fa-lg"></i><small>Пн / Сб<br>09:00 - 13.00 / 14:00 - 18:00</small></li>
						</ul>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg">
						<h6 class="upper widget-title">Каталог</h6>
						{* Рекурсивная функция вывода дерева категорий *}
						{function name=footer_categories_tree}
						{if $categories}
						<ul class="widget_archive sep-top-xs">
						{foreach $categories as $c}
							{* Показываем только видимые категории *}
							{if $c->visible}
								<li>
									<a href="catalog/{$c->url}" title="{$c->name|escape}" data-category="{$c->id}">{$c->name|escape}</a>
								</li>
							{/if}
						{/foreach}
						</ul>
						{/if}
						{/function}
						{footer_categories_tree categories=$categories}
					</div>
					<div class="widget sep-top-sm">
						<h6 class="upper widget-title">Мы в соцсетях</h6>
						<ul class="social-icon sep-top-xs">
							<li><a href="#" class="fa fa-github fa-lg"></a></li>
							<li><a href="#" class="fa fa-twitter fa-lg"></a></li>
							<li><a href="#" class="fa fa-facebook fa-lg"></a></li>
							<li><a href="#" class="fa fa-google-plus fa-lg"></a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg">
						<h6 class="upper widget-title">Текстовый блок</h6><small class="sep-top-xs">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature.</small>
					</div>
					<div class="widget sep-top-sm">
						<h6 class="upper widget-title">Тэги</h6>
						<div class="widget-tag sep-top-xs"><a href="#" class="btn btn-xs btn-light btn-bordered">Colors</a><a href="#" class="btn btn-xs btn-light btn-bordered">Creativity</a><a href="#" class="btn btn-xs btn-light btn-bordered">Culture</a><a href="#" class="btn btn-xs btn-light btn-bordered">Design</a><a href="#" class="btn btn-xs btn-light btn-bordered">Marketing</a><a href="#" class="btn btn-xs btn-light btn-bordered">Music</a>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg">
						<h6 class="upper widget-title">Обратная связь</h6>
						<div class="form-gray-fields sep-top-xs">
							<form id="contactFormFooter" method="post" class="validate">
								<div class="form-group">
									<label for="contactFormFooterName" class="sr-only">Ваше имя</label>
									<input id="contactFormFooterName" type="text" placeholder="Ваше имя" name="name" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="contactFormFooterEmail" class="sr-only">Ваш Email</label>
									<input id="contactFormFooterEmail" type="email" placeholder="Ваш email" name="email" class="form-control email" required>
								</div>
								<div class="form-group">
									<label for="contactFormFooterComment" class="sr-only">Ваше сообщение</label>
									<textarea id="contactFormFooterComment" placeholder="Ваше сообщение" rows="4" name="message" class="form-control" required></textarea>
								</div>
								<div class="form-group">
									<div id="contactFormFooterResult"></div>
									
									<button type="submit" class="btn btn-xs btn-primary"><i class="fa fa-paper-plane"></i>&nbsp;Отправить</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="copyright sep-top-xs sep-bottom-xs">
		<div class="container">
			<div class="row">
				<div class="col-md-12"><small>© Copyright 2015. Адаптация для Simpla CMS — <a href="//chocolatemol.es" target="_blank">chocolate_moles</a></small></div>
			</div>
		</div>
	</div>
</footer>
<footer id="footer">
	<div id="demo-footer-1" class="demo-footer">
		<div class="inner sep-bottom-md">
			<div class="container">
				<div class="row">
					<div class="col-md-3 col-sm-6">
						<div class="widget sep-top-lg">
							<img src="design/{$settings->theme}/images/logo-white.png" alt="" class="logo">
							<small class="sep-top-xs sep-bottom-md">Этот магазин является демонстрацией шаблона Ottavio для Simpla CMS. Все материалы на этом сайте присутствуют исключительно в демострационных целях.</small>
							<!-- <h6 class="upper widget-title">Мы в соцсетях</h6>
							
							<ul class="social-icon sep-top-xs">
								<li><a href="#" class="fa fa-github fa-lg"></a></li>
								<li><a href="#" class="fa fa-twitter fa-lg"></a></li>
								<li><a href="#" class="fa fa-facebook fa-lg"></a></li>
								<li><a href="#" class="fa fa-google-plus fa-lg"></a></li>
							</ul> -->
						</div>
					</div>
					
					{get_posts var=f_last_posts limit=3}
					{if $f_last_posts}
					<div class="col-md-3 col-sm-6">
						<div class="widget sep-top-lg">
							<h6 class="upper widget-title">Последние записи в блоге</h6>
							
							<ul class="widget-post sep-top-xs">
								{foreach $f_last_posts as $post}
								<li>
									<span class="date-post">{$post->date|date_format:'%d'}<small class="upper">{$post->date|date_format:'%b'}</small></span>
									<a href="blog/{$post->url}" class="title-post" data-post="{$post->id}">{$post->name|escape}</a>
									<small><a href="blog/{$post->url}#comments">{if $post->comments_count > 0}{$post->comments_count}&nbsp;{$post->comments_count|plural:'комментарий':'комментариев':'комментария'}{else}Нет&nbsp;комментариев{/if}</a></small>
								</li>
								{/foreach}
							</ul>
						</div>
					</div>
					{/if}
					
					<div class="col-md-3 col-sm-6">
						<div class="widget sep-top-lg">
							<h6 class="upper widget-title">Контактная информация</h6>
							
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
							<h6 class="upper widget-title">Фотогаллерея Flickr</h6>
							
							<div class="flickr_container sep-top-xs">
								<div id="flickr_badge_image1" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14983708011/" target="_blank"><img width="75" height="75" title="Collis does the ice bucket challenge" alt="Una foto su Flickr" src="http://farm4.staticflickr.com/3923/14983708011_6bcbba0e2c_s.jpg"></a></div>
								<div id="flickr_badge_image2" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14596923138/" target="_blank"><img width="75" height="75" title="Justin 05" alt="Una foto su Flickr" src="http://farm6.staticflickr.com/5555/14596923138_d4d46d271c_s.jpg"></a></div>
								<div id="flickr_badge_image3" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14760569666/" target="_blank"><img width="75" height="75" title="Justin 04" alt="Una foto su Flickr" src="http://farm4.staticflickr.com/3909/14760569666_7c6c02da27_s.jpg"></a></div>
								<div id="flickr_badge_image4" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14783568265/" target="_blank"><img width="75" height="75" title="Justin 03" alt="Una foto su Flickr" src="http://farm6.staticflickr.com/5590/14783568265_90657d440f_s.jpg"></a></div>
								<div id="flickr_badge_image5" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14781214704/" target="_blank"><img width="75" height="75" title="Justin 01" alt="Una foto su Flickr" src="http://farm3.staticflickr.com/2925/14781214704_955df76638_s.jpg"></a></div>
								<div id="flickr_badge_image6" class="flickr_badge_image"><a href="http://www.flickr.com/photos/we-are-envato/14471910420/" target="_blank"><img width="75" height="75" title="Envato Live" alt="Una foto su Flickr" src="http://farm6.staticflickr.com/5548/14471910420_cf12dd0a16_s.jpg"></a></div>
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
	</div>

	<div id="demo-footer-2" class="demo-footer hidden">
		<div class="inner sep-top-md sep-bottom-md">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center"><img src="design/{$settings->theme}/images/logo-white.png" alt="" class="logo"><small class="sep-top-xs">There are many variations of passages of Lorem Ipsum available</small>
						<ul class="social-icon sep-top-sm">
							<li><a href="#" class="fa fa-github fa-2x"></a></li>
							<li><a href="#" class="fa fa-twitter fa-2x"></a></li>
							<li><a href="#" class="fa fa-facebook fa-2x"></a></li>
							<li><a href="#" class="fa fa-google-plus fa-2x"></a></li>
						</ul>
					</div>
				</div>	
			</div>
		</div>
		<div class="copyright sep-top-xs sep-bottom-xs">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center"><small>© Copyright 2015. Адаптация для Simpla CMS — <a href="//chocolatemol.es" target="_blank">chocolate_moles</a></small></div>
				</div>
			</div>
		</div>
	</div>

	<div id="demo-footer-3" class="demo-footer hidden">
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
	</div>
</footer>
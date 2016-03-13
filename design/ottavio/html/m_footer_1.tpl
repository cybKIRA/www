<footer id="footer">
	<div class="inner sep-bottom-md">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg">
						<img src="design/{$settings->theme}/images/logo-white.png" alt="" class="logo">
						<small class="sep-top-xs sep-bottom-md">Оригинальные часы по доступной цене</small>
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
                         <li><i class="fa fa-map-marker fa-lg"></i><small>г. Москва <br>ул. Яблочкова, д. 21В, стр. 1</small></li>
						 	<li><i class=""></i><small>&nbsp;</small></li>
						</ul>
						<i class=""></i><strong>Отдел продаж:</strong>
						<ul class="widget-address sep-top-xs">
							<li><i class="fa fa-phone fa-lg"></i><small>+7 (499) 40 40 996</small></li>
							<li><i class="fa fa-envelope fa-lg"></i><small><a href="#">info@kupi.watch</a></small></li>
							<li><i class="fa fa-clock-o fa-lg"></i><small>Обработка заказов: <br>пн-пт c 10:00 до 20.00</small></li>
							<li><i class=""></i><small>Прием заказов: круглосуточно!</small></li>
							<li><i class=""></i><small>&nbsp;</small></li>
						</ul>
						<strong>Отдел доставки:</strong>
						<ul class="widget-address sep-top-xs">
							<li><i class="fa fa-phone fa-lg"></i><small>+7 (926) 462 07 37</small></li>
							<li><i class="fa fa-envelope fa-lg"></i><small><a href="#">dostavka@kupi.watch</a></small></li>

						</ul>
					</div>
				</div>
				
				<div class="col-md-3 col-sm-6">
					<div class="widget sep-top-lg">
						<h6 class="upper widget-title sep-bottom-xs">Мы в соц. сетях. Подпишись!</h6>
						
						<ul>
						<li class=sep-bottom-xs><a href="https://vk.com/kupi.watch"><i class="fa fa-vk fa-3x" style="vertical-align: middle;"></i> Вконтакте</a> </li>
						<li class=sep-bottom-xs><a href="https://facebook.com/kupi.watch"><i class="fa fa-facebook fa-3x" style="vertical-align: middle;"></i> Фейсбук</a> </li>
						<li class=sep-bottom-xs><a href="https://ok.ru/kupi.watch"><i class="fa fa-odnoklassniki fa-3x" style="vertical-align: middle;"></i> Одноклассники</a> </li>
						<li class=sep-bottom-xs><a href="https://instagram.com/kupi.watch/"><i class="fa fa-instagram fa-3x" style="vertical-align: middle;"></i> Инстаграм</a> </li>
						</ul>
						
					</div>
				</div>
				
				<div class="col-md-12 col-sm-12">
					<div class="widget sep-top-lg">
                     <p class="footer-text-big" style="line-height: inherit;"><span style="color:white;">Kupi.</span><span style="color:#f28500;">Watch</span></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	{*
	<div class="copyright sep-top-xs sep-bottom-xs">
		<div class="container">
			<div class="row">
				<div class="col-md-12"><small>© Copyright 2015. Kupi.Watch - Оригинальные часы по доступной цене. &nbsp;&nbsp; ИНН 010505143631 ОГРН 315010500013463 ИП Плотников Николай Николаевич</small>
				</div>
			</div>
		</div>
	</div>
	*}
</footer>

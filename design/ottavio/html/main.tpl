{* Главная страница магазина *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}

{* Канонический адрес страницы *}
{$canonical="" scope=parent}



<section style="background-image: url('design/{$settings->theme}/images/parallax/feedback.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<h2 class="small-space">Оригинальные часы по доступной цене</h2>
			</div>
		</div>
	</div>
</section>



{include file = 'm_slider.tpl'}

<section class="sep-bottom-md sep-top-md">
	<div class="container">
        
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center sep-bottom-lg">
					<h2 class="upper">Каталог по всем часам</h2>
					<p class="lead">Найдите часы своей мечты!</p>
				</div>
			</div>
		</div>
		<div class="row">
			{$iteration = 1}
			{function name=categories_grid}
			{if $categories}
			{foreach $categories as $c}
				{if $c->visible}
					{if $c->subcategories}
						{categories_grid categories=$c->subcategories}
					{else}
						{if $c->parent_id == 26}
						<div class="col-md-4 col-sm-6 col-xs-12 sep-bottom-lg" style="text-align:center;">
							
							<a href="catalog/{$c->url}" class="outline-outward category-banner">
								{if $c->thumb}
									<img src="{$config->categories_thumbs_dir}{$c->thumb}" alt="{$c->name}" class="img-responsive" style="">
								{else}
									<img src="design/{$settings->theme|escape}/images/no_image_510x600.jpg" alt="{$c->name}" class="img-responsive">
								{/if}
								
								<div class="category-content text-center">
									<h6 class="category-title" data-category="{$c->id}">{$c->name}</h6>{*<small>{$c->products_count} {$c->products_count|plural:'товар':'товаров':'товара'}</small>*}
								</div>
								
							</a>
						</div>
						
						{if $iteration is div by 4}<div class="clearfix"></div>{/if}
						
						{$iteration = $iteration + 1}
						{/if}
					{/if}
				{/if}
			{/foreach}
			{/if}
			{/function}
			{categories_grid categories=$categories}
		</div>
	</div>
</section>	

{* Выбираем в переменную $all_brands все бренды *}
{if $all_brands}

<section class="sep-bottom-2x shop-content">
	<div class="container">
	<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center sep-bottom-lg">
					<h2 class="upper">Каталог по брендам</h2>
					<p class="lead">Выбери совой любимый бренд!</p>
				</div>
			</div>
		</div>
		
        <div  class="row">
			        {foreach $all_brands as $b}	

			        <div style="text-align:center;" class="col-md-4 col-sm-6 col-xs-12 {*wow bounceInUp*} item sep-bottom-xs">
				        <a class="outline-outward category-banner" href="/catalog/{$b->url}/{$b->url_brand}">
					        {if $b->image}
						        <img src="{$config->brands_images_dir}{$b->image}" alt="{$b->name|escape}" class="img-responsive" style="max-width:300px">
					        {else}
						        {$b->name}
					        {/if}
				        </a>
			        </div>
			        {/foreach}

        </div>
    </div>
</section>
{/if}

		
<section class="sep-bottom-2x">
	<div class="container">
		<hr class="slim">
		<div class="row">
			<div class="col-md-3 icon-gradient">
				<div class="icon-box icon-horizontal icon-lg sep-top-2x">
					<div data-wow-delay=".5s" class="icon-content img-circle wow bounceInUp"><i class="fa fa-rocket"></i></div>
					<div class="icon-box-content">
						<h5 class="">Быстрая доставка</h5>
						<p>Мы отправим Ваш заказ в течении 24 часов. Или доставим по Москве в пределах того же времени!</p>
					</div>
				</div>
			</div>
			<div class="col-md-3 icon-gradient">
				<div class="icon-box icon-horizontal icon-lg sep-top-2x">
					<div data-wow-delay=".5s" class="icon-content img-circle wow bounceInUp"><i class="fa fa-thumbs-o-up"></i></div>
					<div class="icon-box-content">
						<h5 class="">Качество</h5>
						<p>Мы продаем только оригинальные часы! На весь товар имеются соответсвующие сертификаты.</p>
					</div>
				</div>
			</div>
			<div class="col-md-3 icon-gradient">
				<div class="icon-box icon-horizontal icon-lg sep-top-2x">
					<div data-wow-delay=".5s" class="icon-content img-circle wow bounceInUp"><i class="fa fa-check-square"></i></div>
					<div class="icon-box-content">
						<h5 class="">Гарантия</h5>
						<p>Мы даем год гарантии на весь товар!</p>
					</div>
				</div>
			</div>
			<div class="col-md-3 icon-gradient">
				<div class="icon-box icon-horizontal icon-lg sep-top-2x">
					<div data-wow-delay=".5s" class="icon-content img-circle wow bounceInUp"><i class="fa fa-credit-card"></i></div>
					<div class="icon-box-content">
						<h5 class="">5% скидки всегда</h5>
						<p>При оплате товара он-лайн, мы предоставляем скидку 5%!</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

{*	
<section id="parallax3" style="background-image: url(design/{$settings->theme}/images/parallax/podarki.jpg);" class="parallax">
	<div class="section-shade sep-top-3x sep-bottom-3x">
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1 text-center">
					<div class="section-title">
						<h3 class="upper light small-space">Хотите получить скидку?</h3>
						<p class="lead light lighter">Нет ничего проще! Оставьте свой email и мы вышлем Вам купон на скидку!</p>
					</div>
					
					<div class="row">
						<div class="col-md-8 col-md-offset-2 sep-top-md">
							<form role="form">
								<label for="nlEmail" class="sr-only">Ваш E-mail</label>
								<div class="newsletter-form">
									<input id="nlEmail" type="email" placeholder="Ваш E-mail" class="text-center form-control input-lg primary">
									<button type="submit" class="fa fa-paper-plane fa-2x light"></button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
*}


{* Акции
<section class="sep-bottom-2x shop-content">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="banner-shop sep-top-2x">
					<a href="#" target="_blank" class="bubble">
						<div class="banner-container">
							<div class="banner-content text-center">
								<div class="banner-text">
									<h5 class="banner-title upper">Акция 1+1=3</h5>
								</div>
							</div>
						</div>
						
						<img src="design/{$settings->theme}/images/banners/1+1=3.jpg" alt="" class="img-responsive">
					</a>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="banner-shop sep-top-2x">
					<a href="#" target="_blank" class="bubble">
						<div class="banner-container">
							<div class="banner-content text-center">
								<div class="banner-text">
									<h5 class="banner-title upper">Товар за который можно поторговаться!</h5>
								</div>
							</div>
						</div>
						
						<img src="design/{$settings->theme}/images/banners/banner_02.jpg" alt="" class="img-responsive">
					</a>
				</div>
			</div>
		</div>
        *}

		{* Рекомендуемые товары *}
		{get_featured_products var=featured_products}
		{if $featured_products}	
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center sep-top-2x sep-bottom-2x">
					<h2 class="upper">Рекомендуемые товары</h2>
					<p class="lead"></p>
				</div>
			</div>
		</div>
		
		<div class="row">
			{foreach $featured_products as $product}
				<div class="col-md-3 sep-bottom-lg">
					{include file='product_item.tpl'}
				</div>
				{if $product@iteration is div by 4}<div class="clearfix"></div>{/if}
			{/foreach}
		</div>
		{/if}
	</div>
</section>

		
<section class="widget_products sep-top-2x">
	<div class="container">
		<div class="row">
			{* Новинки *}
			{get_new_products var=new_products limit=6}
			{if $new_products}
			<div class="col-md-6">
				<h5 class="widget-title-bordered upper">Новинки</h5>
				<div class="row">
					<div class="col-md-6">
						<ul class="widget widget-media sep-bottom-lg">
							{foreach $new_products as $product}
							<li class="media media-bordered clearfix">
								{include file='product_item_tiny.tpl'}
							</li>
						{if $product@iteration == 3 && !$product@last}	
						</ul>
					</div>
					<div class="col-md-6">
						<ul class="widget widget-media sep-bottom-lg">
						{/if}
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
			{/if}
			
			{* Акционные товары *}
			{get_discounted_products var=discounted_products limit=6}
			{if $discounted_products}
			<div class="col-md-6">
				<h5 class="widget-title-bordered upper">Акционные товары</h5>
				<div class="row">
					<div class="col-md-6">
						<ul class="widget widget-media sep-bottom-lg">
							{foreach $discounted_products as $product}
							<li class="media media-bordered clearfix">
								{include file='product_item_tiny.tpl'}
							</li>
						{if $product@iteration == 3 && !$product@last}	
						</ul>
					</div>
					<div class="col-md-6">
						<ul class="widget widget-media sep-bottom-lg">
						{/if}
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
			{/if}
		</div>
	</div>
</section>
		

{* Выбираем в переменную $last_posts последние записи *}
{get_posts var=last_posts limit=10}
{if $last_posts}
<section id="blog" class="sep-top-2x">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="section-title text-center">

					<h2 class="upper">Новые записи в <a href="blog">блоге</a></h2>
					<p class="lead">Полезные статьи на тему наручных часов для мужчин и женщин</p>
				</div>
			</div>
		</div>
	
		
	<div class="blog-preview swiper-container">
		<div class="swiper-wrapper sep-top-md">
			{foreach $last_posts as $post}
			<article class="swiper-slide">
				{if $post->thumb}
					<a href="blog/{$post->url}">
						<img src="files/posts/thumbs/{$post->thumb}" alt="{$post->name|escape}" class="img-responsive" />
					</a>
				{/if}
				
				<div class="post-content">
					<h5 data-post="{$post->id}"><a href="blog/{$post->url}">{$post->name|escape}</a></h5>
					{$post->annotation_tiny}
					<small class="info-text pull-left text-left">{$post->date|date}</small>
					<small class="info-text pull-right text-right"><a href="blog/{$post->url}#comments">{if $post->comments_count > 0}{$post->comments_count}&nbsp;{$post->comments_count|plural:'комментарий':'комментариев':'комментария'}{else}Нет&nbsp;комментариев{/if}</a></small>
				</div>
			</article>
			{/foreach}
		</div>
	</div>

    </div>
</section>
{/if}

{*
<div class="sep-top-2x">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="text-center">
					<p class="lead">Поддерживаем разные системы оплаты.</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="text-center"><img alt="" src="design/{$settings->theme}/images/card.png" class="sep-top-sm img-responsive">
					<ul class="shop-info-link sep-top-2x sep-bottom-lg">
						<li class="sep-bottom-sm"><a href="#">Доставка и возврат</a></li>
						<li class="sep-bottom-sm"><a href="#">Информация о доставке</a></li>
						
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
*}

<br>
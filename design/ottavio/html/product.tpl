{* Страница товара *}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}

<section itemscope itemtype="http://schema.org/Product">

<section class="header-section fading-title parallax">
	<div class="section-shade sep-top-2x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="products">Каталог</a></li>
					
					{foreach from=$category->path item=cat}
						<li><a href="catalog/{$cat->url}">{$cat->name|escape}</a></li>
					{/foreach}
					
					{if $brand}
						<li>{$brand->name|escape}</li>
					{/if}
				</ol>
				
				
				<div class="row">
					<div class="col-sm-6">
						<h2 id="name_product" itemprop="name" class="small-space name" data-product="{$product->id}">{$product->name|escape}</h2>
						<br>
						<a class="btn" href="catalog/{$cat->url}/{$brand->url}" >Перейти в каталог</a>
					</div>
					<div class="col-sm-6">
						<h4 class="small-space">100% оригинальные часы</h3>
						<ul class="text-left">
							<li>Доставим лично в руки или до почты по всей России за 50% от стоимости доставки.</li>
							<li>На вторую покупку часов даем скидку 10%.</li>
							<li>1 год официальной гарантии от производителя. Обменяем, починим или вернем деньги.</li>
						</ul>
					</div>
				
				</div>
		</div>
	</div>
</section>

<section>
	<div class="container">
		<div class="row">
			<div class="col-md-5 sep-top-lg mfp-gallery">
				<div class="product-images">
					{if $product->image}
					<a href="{$product->image->filename|resize:960:600}" title="{$product->name|escape}">
						<img alt="{$product->name|escape}" src="{$product->image->filename|resize:510:600}" class="img-responsive" itemprop="image">
					</a>
					{else}
						<img src="design/{$settings->theme}/images/no_image_510x600.jpg" alt="{$product->name|escape}" class="img-responsive">
					{/if}
				</div>
				
				{if $product->images|count>1}
				<div class="product-thumbnails">
					{foreach $product->images|cut as $i=>$image}
					<a href="{$image->filename|resize:960:600}"	title="{$product->name|escape}">
						<img alt="{$product->name|escape}" src="{$image->filename|resize:510:600}" class="img-responsive">
					</a>
					{/foreach}			
				</div>
				{/if}
			</div>

			<div class="col-md-7 sep-top-lg">
				<div class="clearfix">
					<div content="3" class="rate pull-left sep-bottom-xs">
						{*
						<meta itemprop="worstRating" content="1">
						<meta itemprop="ratingValue" content="{$product->rating}">
						<meta itemprop="bestRating" content="5">
						*}

						{strip}
							{section name=rate start=0 loop=5 step=1}
								{if $product->votes > 0}
									{if $smarty.section.rate.index < $product->rating / $product->votes && $product->votes > 0}
										{if ($smarty.section.rate.index + 1) > $product->rating / $product->votes}
											<i class="fa fa-star-half-o fa-lg"></i>
										{else}
											<i class="fa fa-star fa-lg"></i>
										{/if}
									{else}
										<i class="fa fa-star-o fa-lg"></i>
									{/if}
								{else}
									<i class="fa fa-star-o fa-lg"></i>
								{/if}
							{/section}
						{/strip}
						
						<small>
							<a href="#comments" class="scroll-to-product-comments">
								{if $comments}
									<span itemprop="ratingCount">{$comments|count}</span> {$comments|count|plural:'отзыв':'отзывов':'отзыва'}
								{else}
									{*Нет отзывов*}
								{/if}
							</a>
						</small>
						
						{if $product->featured==1}
						<br>
						<small>
							Рекомендуемый товар
						</small>
						{/if}
					</div>
					
					<ul class="social-icon pull-right sep-bottom-xs">
						<li><a href="https://vk.com/kupi.watch"><i class="fa fa-vk fa-lg"></i></a></li>
						<li><a href="https://facebook.com/kupi.watch"><i class="fa fa-facebook fa-lg"></i> </a> </li>
						<li><a href="https://ok.ru/kupi.watch"><i class="fa fa-odnoklassniki fa-lg"></i></a> </li>
					</ul>
				</div>
				
				<div itemprop="description">
					{$product->annotation|replace:'<p>':'<p class="lead">'}
					&nbsp;
				</div>
				
				{if $product->variants|count > 0}
					<div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="price-shop sep-top-xs">
						<meta itemprop="priceCurrency" content="{$currency->code|escape}">
						<del id="product-compare">{if $product->variant->compare_price}{$product->variant->compare_price|convert} {$currency->sign|escape}{/if}</del>
						<ins><span id="product-price" itemprop="price">{$product->variant->price|convert}</span> {$currency->sign|escape}</ins>
					</div>
					
					<form class="variants" action="/cart" data-name="{$product->name|escape}">
						<div class="row">
							<div class="col-md-6 sep-top-sm {if $product->variants|count<2} hidden{/if}">
								<select name="variant" class="color-product form-control input-lg">
									{foreach $product->variants as $v}
										<option value="{$v->id}" 
												data-price="{$v->price|convert}" 
												{if $v->name}data-name="{$v->name}"{/if}
												{if $v->compare_price} data-compare="{$v->compare_price|convert} {$currency->sign|escape}"{/if}
												{if $product->variant->id==$v->id}selected="selected"{/if}>{$v->name}</option>
									{/foreach}
								</select>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-3 col-sm-6 sep-top-md">
								<input type="text" value="1" name="amount" class="qty">
							</div>
							
							<div class="col-md-9 col-sm-6 sep-top-md">
								<button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-shopping-cart"></i> В корзину</button>
							</div>
						</div>
					</form>
				{else}
					<p class="lead sep-top-xs text-danger">Нет в наличии</p>
				{/if}
			</div>
		</div>
	</div>
</section>


<div id="comments" class="container">
	<div class="row">
		<div class="col-md-12 sep-top-lg">
			<div role="tabpanel">
				<ul class="nav nav-tabs" role="tablist">
					{if $product->body}
						<li role="presentation" class="active"><a href="#description-tab" aria-controls="description-tab" role="tab" data-toggle="tab">Описание</a></li>
					{/if}
					
					{if $product->features}
						<li role="presentation" {if !$product->body}class="active"{/if}><a href="#features-tab" aria-controls="features-tab" role="tab" data-toggle="tab">Характеристики</a></li>
					{/if}
					
					<li role="presentation" {if !$product->body && !$product->features}class="active"{/if}><a href="#comments-tab" aria-controls="comments-tab" role="tab" data-toggle="tab">Отзывы ({$comments|count})</a></li>
				</ul>

				<div class="tab-content sep-top-md ">
					{if $product->body}
					<div role="tabpanel" class="tab-pane fade sep-bottom-lg in active" id="description-tab">
						{$product->body}
					</div>
					{/if}
					
					{if $product->features}
					<div role="tabpanel" class="tab-pane fade sep-bottom-lg {if !$product->body}in active{/if}" id="features-tab">
						<table class="table table-hover table-features text-left">
							{foreach $product->features as $f}
								<tr>
									<td>{$f->name}</td>
									<td>{$f->value}</td>
								</tr>
							{/foreach}
						</table>
					</div>
					{/if}
					
					<div role="tabpanel" class="tab-pane fade {if !$product->body && !$product->features}in active{/if}" id="comments-tab">
						{if $user->comment}
							<div class="sep-bottom-xs">
								{*<div role="alert" class="alert alert-warning no-margin rate">
									Ваша оценка {section name=rate start=0 loop=5 step=1}<i class="fa fa-star{if $smarty.section.rate.index >= $user->comment->rate}-o{/if}"></i>{/section}{if !$user->comment->approved}, отзыв проверяется модератором.{/if}
									<a href="#modalCommentEdit" data-toggle="modal" class="primary pull-right">Редактировать&nbsp;отзыв</a>
								</div>*}

							</div>
							{include file = 'm_modal_comment_edit.tpl'}
						{/if}

						{if $comments}
							{if !$user}
								{*<div class="sep-bottom-xs">
									<div role="alert" class="alert alert-warning no-margin">Только зарегистрированные пользователи могут оставлять отзывы. <a href="#modalLogin" class="primary" data-toggle="modal">Войдите</a>, пожалуйста.</div>
								</div>*}
							{/if}
							
							<section id="rate-product" class="">
								{foreach $comments as $comment}
								<a name="comment_{$comment->id}"></a>
								
								<article itemprop="review" itemscope itemtype="http://data-vocabulary.org/Review" class="sep-bottom-xs media media-bordered">
									<div class="media-body">
										<footer>
											<div itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating" class="rate">
												<meta itemprop="ratingValue" content="3">
												{section name=rate start=0 loop=5 step=1}<i class="fa fa-star{if $smarty.section.rate.index >= $comment->rate}-o{/if}"></i>{/section}
			
												<small>
													<meta content="{$comment->date|date_format:'%Y-%m-%d'}" itemprop="publishDate">{$comment->date|date}, {$comment->date|time}
												</small>
											</div>
											
											
											<h5 itemprop="author" class="media-heading">{$comment->name|escape}</h5>
											<p itemprop="reviewBody">{$comment->text|escape|nl2br}</p>
											
											{if !$comment->approved}<p class="text-danger">ожидает модерации</p>{/if}
										</footer>
									</div>
								</article>
								{/foreach}
							</section>
						{elseif !$user->comment}
							<div role="alert" class="alert alert-warning ">
								{if !$user}
									{*Только зарегистрированные пользователи могут оставлять отзывы. <a href="#modalLogin" class="primary" data-toggle="modal">Войдите</a>, пожалуйста.*}
								{else}
									В данный момент отзывы о товаре отсутствуют. Вы можете стать первым.
								{/if}
							</div>
						{/if}

						{if !$user}
							{include file = 'm_modal_login.tpl'}
						{/if}
						
						{if true}
						{*if $user && !$user->comment*}
							<section id="comment-form" class="sep-top-sm ">
								{if $error}
									<div role="alert" class="alert alert-danger alert-dismissible">
										{if $error=='empty_name'}
											Введите имя
										{elseif $error=='empty_comment'}
											Введите отзыв
										{else}
											Ну спасибо. Вот вы все и поломали. Либо произошла страшная, трагическая ошибка.
										{/if}
									</div>
								{/if}
								<div class="row">
									<div class="col-md-6 col-md-push-6 sep-bottom-lg">
										<h4>Правила публикации отзывов</h4>
										
										<div class="sep-top-sm text-left">
											<p>Спасибо, что решили поделиться опытом!</p>
											<p>Ваш отзыв будет опубликован через некоторое время после проверки модератором.</p>
											<p>Обратите внимание, мы не публикуем отзывы: </p>
											<ul class="sep-bottom-xs">
												<li>написанные ЗАГЛАВНЫМИ буквами, </li>
												<li>содержащие ненормативную лексику или оскорбления, </li>
												<li>не относящиеся к потребительским свойствам конкретного товара, </li>
												<li>рекламного характера (содержащие контактную информацию и ссылки на другие сайты).</li>
											</ul>
											<p>Любые вопросы о товаре вы можете задать в разделе «Вопросы и ответы».</p>
											<p>Пожалуйста, учтите, что публикуя отзыв или отвечая на вопросы вы принимаете некоторую ответственность перед читателями, поэтому на вашей персональной странице будут доступны все ваши отзывы, ответы и рейтинг.</p>
										</div>
									</div>
									
									<div class="col-md-6 col-md-pull-6 sep-bottom-lg">
										<h4>Написать отзыв</h4>
									
										<div class="sep-top-sm">
											<div class="contact-form">
												<form id="commentProductForm" method="post" class="validate">
													<div class="form-group">
														<label for="post_rating">Ваша оценка</label>
														
														<div class="rate post_rating">
															<input id="post_rating" type="number" name="rate" value="{$comment_rate}" 
																	data-max="5" 
																	data-min="1" 
																	data-icon-lib="fa fa-lg" 
																	data-active-icon="fa-star" 
																	data-inactive-icon="fa-star-o"
																	data-clearable-icon="fa-times" 
																	class="rating">
														</div>
													</div>
												
													<div class="form-group">
														<label for="post_name">Имя</label>
														<input id="post_name" type="text" name="name" value="{$comment_name|escape}" class="form-control input-lg" >
													</div>
													
													<div class="form-group">
														<label for="post_comment">Отзыв</label>
														<textarea id="post_comment" rows="9" name="text" class="form-control input-lg">{if !$comment_text}{/if}</textarea>
													</div>
													
													<div class="form-group sep-top-xs">
														<input type="hidden" name="comment_add" value="input_for_submit_form">
														<button type="submit" class="btn btn-primary" id="commentProductFormSubmit"><i class="fa fa-comment"></i>&nbsp;Опубликовать</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</section>
						{else}
							<div class="sep-bottom-lg"></div>
						{/if}
					</div>
				</div>
			</div>
		</div>
	</div>
</div>				
</section>
{* Связанные товары *}
{if $related_products}
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<h5 class="widget-title-bordered upper">Так же советуем посмотреть</h5>
		</div>
	</div>
	
	<div class="row">
		{foreach $related_products as $related_product}
			<div class="col-md-3 sep-bottom-lg">
				<a href="products/{$related_product->url}" class="product-image outline-outward">
					{if $related_product->image}
						<img src="{$related_product->image->filename|resize:510:600}" alt="{$related_product->name|escape}" class="img-responsive">
					{else}
						Нет изображения
					{/if}
				</a>
				
				<div class="product-title">
					<span class="">{$related_product->category->name}</span>
					<p data-product="{$related_product->id}">{$related_product->name|escape}</p>
				</div>
				
				<div class="product-detail">
					{if $related_product->variants|count > 0}
					<div class="pull-right price-shop text-right">
						{if $related_product->variant->compare_price}<del>{$related_product->variant->compare_price|convert} {$currency->sign|escape}</del>{/if}
						<ins>{$related_product->variant->price|convert} {$currency->sign|escape}</ins>
					</div>
					{/if}
					<div class="rate">
						{strip}
							{section name=rate start=0 loop=5 step=1}
								{if $related_product->votes > 0}
									{if $smarty.section.rate.index < $related_product->rating / $related_product->votes && $related_product->votes > 0}
										{if ($smarty.section.rate.index + 1) > $related_product->rating / $related_product->votes}
											<i class="fa fa-star-half-o"></i>
										{else}
											<i class="fa fa-star"></i>
										{/if}
									{else}
										<i class="fa fa-star-o"></i>
									{/if}
								{else}
									<i class="fa fa-star-o"></i>
								{/if}
							{/section}
						{/strip}
					</div>
					
					{if $related_product->comments_count > 0}
						<a href="products/{$related_product->url}/#comments">{$related_product->comments_count} {$related_product->comments_count|plural:'отзыв':'отзывов':'отзыва'}</a>
					{/if}
				</div>
			</div>
			{if $related_product@iteration is div by 4}<div class="clearfix"></div>{/if}
		{/foreach}
	</div>
</div>
{/if}

{get_browsed_products var=browsed_products limit=20}
{if $browsed_products}
<div class="container sep-bottom-lg">
	<h5 class="widget-title-bordered upper">Вы уже смотрели</h5>
	
	<div class="owl-carousel owl-theme widget widget-media">
		{foreach $browsed_products as $browsed_product}
		<div class="item sep-top-lg media media-bordered">
			<a href="products/{$browsed_product->url}" class="pull-left">
			{if $browsed_product->image}
				<img src="{$browsed_product->image->filename|resize:510:600}" alt="{$browsed_product->name|escape}" width="82" height="100" class="img-responsive">
			{/if}
			</a>
			
			<div class="media-body">
				<small>{$browsed_product->category->name|escape}</small>
				<h6 class="media-heading"><a href="products/{$browsed_product->url}">{$browsed_product->name|escape}</a></h6>
				<div class="product-detail">
					<div class="rate">
						{strip}
							{section name=rate start=0 loop=5 step=1}
								{if $browsed_product->votes > 0}
									{if $smarty.section.rate.index < $browsed_product->rating / $browsed_product->votes && $browsed_product->votes > 0}
										{if ($smarty.section.rate.index + 1) > $browsed_product->rating / $browsed_product->votes}
											<i class="fa fa-star-half-o"></i>
										{else}
											<i class="fa fa-star"></i>
										{/if}
									{else}
										<i class="fa fa-star-o"></i>
									{/if}
								{else}
									<i class="fa fa-star-o"></i>
								{/if}
							{/section}
						{/strip}
					</div>
					
					<div class="price-shop">
						{if $browsed_product->variants|count > 0}
							<ins>{$browsed_product->variant->price|convert} {$currency->sign|escape}</ins>
						{else}
							<small>Нет в наличии</small>
						{/if}
					</div>
				</div>
			</div>
		</div>
		{/foreach}
	</div>
</div>
{/if}
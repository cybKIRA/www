{* Страница товара *}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}


	{if $brand}
	{assign "brand_name" ""}
	{$brand_name = $brand->name}
	{/if}

<section itemscope itemtype="http://schema.org/Product">

<section class="header-section fading-title parallax header-section-product outline-product">

	<div class="section-shade sep-breadcrumb-product">
		<div class="container">
			<div class="section-title light">
			
				<div class="row">
				
					<div class="col-sm-8">
						{*<a class="btn" href="catalog/{$cat->url}/{$brand->url}" >Перейти обратно в каталог</a>*}
						{*<h1 id="name_product" itemprop="name" class="small-space name" data-product="{$product->id}">Наручные часы <br> {$brand_name|escape}</h1>*}

						<ol class="breadcrumb breadcrumb_product">
							<li><a href="./">Главная</a></li>
							<li><a href="/catalog/vse-chasy">Каталог</a></li>
							
							{foreach from=$category->path item=cat}
								<li><a href="catalog/{$cat->url}">{$cat->name|escape}</a></li>
							{/foreach}
							
							{if $my_brand}
							<li>
								<a href="/catalog/{$my_brand->url}/{$my_brand->url_brand}">{$my_brand->name|escape}</a>
							</li>
							{/if}
						</ol>						
					</div>
					
					<div class="col-sm-4">

					</div>
				
				</div>
				
			</div>
		</div>
	</div>
</section>

{if $comment_name && !$error}
	<div class="row">
		<br>
		<div role="alert" class="col-sm-8 col-sm-offset-1 alert alert-success alert-dismissible">
			<strong>{$comment_name|escape}</strong>,&nbsp;Ваш отзыв отправлен! И проверяется модерацией!
		</div>
	</div>
{/if}
						

<section>
	<div class="container">
		<div class="row">
			<div class="col-md-5 sep-top-xs mfp-gallery">
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

			<div class="col-md-7 sep-top-xs">
				<div class="clearfix">

					{*include file='product_rate.tpl'*}
					

				</div>
				
				<div itemprop="description">
					{$product->annotation|replace:'<p>':'<p class="lead">'}
					&nbsp;
				</div>
				
				
					<div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="price-shop sep-top-xs">
						<div>
							<h1>Наручные часы {$product->name}</h1>
 						</div>
						<div>
							Наличие: <span class="nal">{if $product->variants|count > 0} Есть в наличии {else} Нет в наличии {/if}<span>
						</div>
						{if $product->variants|count > 0}
						<div>
							<meta itemprop="priceCurrency" content="{$currency->code|escape}">
							<del id="product-compare">{if $product->variant->compare_price}{$product->variant->compare_price|convert} {$currency->sign|escape}{/if}</del>
							Цена: <ins><span id="product-price" itemprop="price">{$product->variant->price|convert}</span> {$currency->sign|escape}</ins>
						</div>
						{/if}
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
												{if $product->variant->id==$v->id}selected="selected"{/if}>{$v->name}
												&nbsp;
										</option>
									{/foreach}
								</select>
							</div>
						</div>
						
						{if $product->variants|count > 0}
						<div class="row">
							<div class="col-md-3 col-sm-6 sep-top-md">
								<input type="text" value="1" name="amount" class="qty">
							</div>
							
							<div class="col-md-9 col-sm-6 sep-top-md">
								<button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-shopping-cart"></i> В корзину</button>
							</div>
							
						</div>
						{else}
						<div class="sep-top-md">
							&nbsp;
						</div>
						
						<a class="btn btn-primary btn-lg" href="catalog/{$cat->url}/{$brand->url}" >Посмотреть еще часы</a>
							
						{/if}
						
						<div class="row sep-top-md">
							<div class="col-sm-6">
								<ul class="social-icon pull-left sep-bottom-xs">
									<li><a href="https://vk.com/kupi.watch"><i class="fa fa-vk fa-lg"></i></a></li>
									<li><a href="https://facebook.com/kupi.watch"><i class="fa fa-facebook fa-lg"></i> </a> </li>
									<li><a href="https://ok.ru/kupi.watch"><i class="fa fa-odnoklassniki fa-lg"></i></a> </li>
									<li><a href="https://instagram.com/kupi.watch/"><i class="fa fa-instagram fa-lg"></i></a> </li>
								</ul>
							</div>
						</div>
					</form>

					<div>
						{*<h3 class="small-space">Оригинальные часы</h3>*}
						<ul class="text-left">
							<li>Доставим лично в руки или до почты по всей России за 50% от стоимости доставки.</li>
							<li>1 год официальной гарантии от производителя. Обменяем, починим или вернем деньги.</li>
						</ul>
					</div>
			</div>
		</div>
	</div>
</section>

<section>
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
					
					<li role="presentation" {if !$product->body && !$product->features}class="active"{/if}><a href="#comments-tab" aria-controls="comments-tab" role="tab" data-toggle="tab">Отзывы ({$comments|count}) {include file='product_rate_min.tpl'}</a></li>
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
						
						
						{if !$comment_name || $error}
						{*if $user && !$user->comment*}
							<section id="comment-form" class="sep-top-sm ">
								{if $error}
									<div role="alert" class="alert alert-danger alert-dismissible">
										{if $error=='captcha'}
											Неверно введена капча
										{elseif $error=='empty_name'}
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
										<h4>Публикация отзывов</h4>
										
										<div class="sep-top-sm text-left">
											<p>Спасибо, что решили поделиться опытом!</p>
											<p>Ваш отзыв будет опубликован через некоторое время после проверки модератором.</p>
											<p>Пожалуйста, учтите, что публикуя отзыв Вы принимаете некоторую ответственность.</p>
										</div>
									</div>
									
									<div class="col-md-6 col-md-pull-6 sep-bottom-lg">
										<h4>Написать отзыв</h4>
									
										<div class="sep-top-sm">
											<div class="contact-form">
												<form id="commentProductForm" method="post" class="form-gray-fields">
												<input name="object_id" type="hidden" value="{$product->id}" >
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
														<input id="post_name" type="text" name="name" value="{$comment_name|escape}" class="form-control input-lg" required>
													</div>
													
													<div class="form-group">
														<label for="post_comment">Отзыв</label>
														<textarea id="post_comment" rows="9" name="text" class="form-control input-lg" required>{$comment_text|escape}</textarea>
													</div>
													
													<div class="form-group">
													<label for="post_image">Картинка</label>
													<span class="btn btn-default btn-file">
														Выбрать фотографию <input type="file" id="files" name="image" />										  
													</span>
													<span id="list"></span>	
													</div>
													
													<div class="form-group">
														<img class="img-thumbnail" src="captcha/image.php?{math equation='rand(10,10000)'}"/>
															<label for="comment_captcha" >Введите число с картинки</label>
																	
														<input  class="form-control input-lg" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
													</div>
														<div id="commentResult"></div>
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

</section>


<script type="text/javascript">
  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<img class="thumb" src="', e.target.result,
                            '" title="', theFile.name, '"/>'].join('');
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

document.getElementById('files').addEventListener('change', handleFileSelect, false);
</script>
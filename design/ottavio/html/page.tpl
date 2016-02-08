{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{if $page->url != '404'}
	<section style="background-image: url('design/{$settings->theme}/images/parallax/page.jpg');" class="header-section fading-title parallax">
		<div class="section-shade sep-top-3x sep-bottom-md">
			<div class="container">
				<div class="section-title light">
					<ol class="breadcrumb">
						<li><a href="./">Главная</a></li>
						<li><a href="{$page->url}">{$page->name|escape}</a></li>
					</ol>
				
					<h2 class="small-space" data-page="{$page->id}">{$page->header|escape}</h2>
				</div>
			</div>
		</div>
	</section>

	<div class="sep-top-lg sep-bottom-2x">
		<div class="container">
			<section class="row">
				<div class="col-md-12">
					{$page->body}
				</div>
			</section>
		</div>
	</div>
{else}
	<div class="sep-top-5x sep-bottom-3x error-404">
		<div class="container">
			<div class="sep-bottom-lg">
				<div class="text-center">
					<h3 class=""><small>ошибка 404</small></h3>
					<h1 class="">Страница не найдена</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 col-md-push-3 text-center">
					<p class="lead">Страницы которую вы ищите, не существует. Попробуйте воспользоваться поиском:</p>
					<!-- start search form-->
					<form action="products" role="search" class="input-group theme-form-group">
						<span class="input-group-btn">
							<button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search fa-2x"></i></button>
						</span>
						
						<input type="text" name="keyword" placeholder="Поиск по сайту" class="form-control input-lg" autocomplete="off">
					</form>
					<!-- end search form-->
				</div>
			</div>
		</div>
	</div>

	{include file = 'm_call_to_action.tpl'}
{/if}
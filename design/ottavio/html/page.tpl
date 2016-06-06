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

	<div class="sep-top-2x sep-bottom-3x {*error-404*}" >
		<div class="container">
			<div class=row>
				<div class=col-sm-4>
					<div class='text-center'>
						<img alt='Страница не найдена' src="/design/ottavio/images/chasy.png" >
					</div>
				</div>
				<div class=col-sm-6>
					<div class="sep-bottom-lg">
						<div class="text-center sep-top-2x" >
							<h1 style="">Такой страницы не существует :(</h1>
						</div>
						<div class="text-center sep-top-sm">
							<a href="/" class="btn btn-primary btn-lg">Перейти на главную</a>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

{/if}
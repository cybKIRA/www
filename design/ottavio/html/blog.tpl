{* Список записей блога *}

{* Канонический адрес страницы *}
{$canonical="/blog" scope=parent}

<section style="background-image: url('design/{$settings->theme}/images/parallax/blog.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
				</ol>

				<h2 class="small-space">{$page->name}</h2>
			</div>
		</div>
	</div>
</section>

<section class="sep-bottom-2x">
	<div class="container">
		{foreach $posts as $post}
		<article id="post-{$post->id}" itemscope itemtype="http://schema.org/BlogPosting" class="sep-top-lg">
			<div class="row">
				<div role="contentinfo" class="col-md-2 sep-top-xs">
					<footer class="author-info">
						<div class="author-info-content">
							<time datetime="{$post->date|date_format:'%Y-%m-%d'}" itemprop="datePublished" class="small">{$post->date|date_format:"%d %m, %Y":"":"rus"}</time>
						</div>
					</footer>
				</div>
				
				<div class="col-md-10 sep-top-xs">
					<header>
						<h3 itemprop="headline" data-post="{$post->id}" class="post-title"><a href="blog/{$post->url}" rel="bookmark" title="link to this post" itemprop="url" class="dark">{$post->name|escape}</a></h3>
						<time datetime="{$post->date|date_format:'%Y-%m-%d'}" itemprop="datePublished"></time>
					</header>

					<footer class="post-info sep-top-xs">
						<ul class="social-icon pull-right">
							<li><a href="https://vk.com/kupi.watch"><i class="fa fa-vk fa-lg"></i></a></li>							
							<li><a href="https://facebook.com/kupi.watch"><i class="fa fa-facebook fa-lg"></i> </a> </li>
							<li><a href="https://ok.ru/kupi.watch"><i class="fa fa-odnoklassniki fa-lg"></i></a> </li>
							<li><a href="https://instagram.com/kupi.watch/"><i class="fa fa-instagram fa-lg"></i></a> </li>
						</ul>

						<ul class="social-icon">
							<li>
								<a href="blog/{$post->url}" title="{if $post->views > 0}{$post->views} {$post->views|plural:'просмотр':'просмотров':'просмотра'}{else}Нет просмотров{/if}">
									<i class="fa fa-eye"></i><small>&nbsp;{$post->views}</small>
								</a>
							</li>

							<li>
								<a href="blog/{$post->url}/#comments" title="{if $post->comments_count > 0}{$post->comments_count} {$post->comments_count|plural:'комментарий':'комментариев':'комментария'}{else}Нет комментариев{/if}">
									<i class="fa fa-comments"></i><small>&nbsp;{$post->comments_count}</small>
								</a>
							</li>
						</ul>
					</footer>
					
					{if $post->image}
						<div class="post-image sep-top-md"><a title="" href="blog/{$post->url}"><img alt="" src="files/posts/{$post->image}" itemprop="thumbnailUrl" class="img-responsive"></a></div>
					{/if}
					
					<div itemprop="articleBody" class="post-text sep-top-md">
						{$post->annotation}
					</div>
					
					<div class="post-more sep-top-md"><a href="blog/{$post->url}" rel="bookmark" title="link to this post" class="btn btn-primary btn-large">Читать дальше</a></div>
				</div>
			</div>
		</article>
		{/foreach}
		
		<div class="sep-top-2x">
			{include file='pagination_blog.tpl'}
		</div>
	</div>
</section>
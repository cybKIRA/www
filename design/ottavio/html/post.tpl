{* Страница отдельной записи блога *}

{* Канонический адрес страницы *}
{$canonical="/blog/{$post->url}" scope=parent}

<section style="background-image: url('design/{$settings->theme}/images/parallax/blog.jpg');" class="header-section fading-title parallax">
	<div class="section-shade sep-top-3x sep-bottom-md">
		<div class="container">
			<div class="section-title light">
				<ol class="breadcrumb">
					<li><a href="./">Главная</a></li>
					<li><a href="blog">Блог</a></li>
				</ol>

				<h2 data-post="{$post->id}" class="small-space">{$post->name|escape}</h2>
			</div>
		</div>
	</div>
</section>

<div class="container">
	<div class="row">
		<div class="col-md-9">
			<footer role="contentinfo" class="post-info sep-top-md">
				<time datetime="{$post->date|date_format:'%Y-%m-%d'}" itemprop="datePublished">{$post->date|date_format:"%d %m, %Y":"":"rus"}</time>
			
				<ul class="social-icon pull-right">
					<li><span class="cursor-default" title="{if $post->views > 0}{$post->views} {$post->views|plural:'просмотр':'просмотров':'просмотра'}{else}Нет просмотров{/if}"><i class="fa fa-eye"></i><small>&nbsp;{$post->views}</small></span></li>
					<li><a href="#comments" class="scroll-to-comments" title="{if $post->comments_count > 0}{$post->comments_count} {$post->comments_count|plural:'комментарий':'комментариев':'комментария'}{else}Нет комментариев{/if}"><i class="fa fa-comments"></i><small>&nbsp;{$post->comments_count}</small></a></li>
				</ul>
			</footer>
			
			{if $post->image}
				<div class="post-image sep-top-md"><img alt="" src="files/posts/{$post->image}" itemprop="thumbnailUrl" class="img-responsive"></div>
			{/if}
					
			<div itemprop="articleBody" class="post-text sep-top-md">
				{$post->text}
			</div>
			
			<footer role="contentinfo" class="post-info sep-top-md">
				<ul class="social-icon">
					<li><a href="https://vk.com/kupi.watch"><i class="fa fa-vk fa-lg"></i></a></li>
					<li><a href="https://facebook.com/kupi.watch"><i class="fa fa-facebook fa-lg"></i> </a> </li>
					<li><a href="https://ok.ru/kupi.watch"><i class="fa fa-odnoklassniki fa-lg"></i></a> </li>
					<li><a href="https://instagram.com/kupi.watch/"><i class="fa fa-instagram fa-lg"></i></a> </li>
				</ul>
			</footer>
			
			<!-- start Comments-->
			<section id="comments" class="sep-top-2x">
				{if $comments}
					<h4>{$comments|count} {$comments|count|plural:'комментарий':'комментариев':'комментария'}</h4>
					
					{foreach $comments as $comment}
					<a name="comment_{$comment->id}"></a>
					<article itemprop="comment" itemscope itemtype="http://schema.org/UserComments" class="sep-top-xs media media-bordered">
						<div class="media-body">
							<footer>
								<h5 class="media-heading">{$comment->name|escape}</h5>
								<div class="small">
									<time itemprop="commentTime" datetime="{$comment->date|date_format:'%Y-%m-%d'}">{$comment->date|date}, {$comment->date|time}</time>
								</div>
							</footer>
						
							<p>{$comment->text|escape|nl2br}</p>
							
							{if !$comment->approved}<p class="text-danger">ожидает модерации</p>{/if}
						</div>
					</article>
					{/foreach}
				{else}
					<h4>Нет комментариев</h4>
					<p>Удивительно, но никто не оставил ни одного комменатрия. Вы можете стать первым!</p>
				{/if}
			</section>
			<!-- end Comments-->
			
			<!-- start Comment Form-->
			<section id="comment-form" class="sep-top-lg sep-bottom-2x">
				<h4>Написать комментарий</h4>
				
				{if $error}
					<div role="alert" class="alert alert-danger alert-dismissible">
						{if $error=='empty_name'}
							Введите имя
						{elseif $error=='empty_comment'}
							Введите комментарий
						{/if}
					</div>
				{/if}
				
				<div class="sep-top-sm">
					<div class="contact-form">
						<form method="post" action="" class="validate">
							<div class="form-group">
								<label for="post_name">Имя</label>
								<input id="post_name" type="text" name="name" value="{$comment_name|escape}" class="form-control input-lg required" required>
							</div>
							
							<div class="form-group">
								<label for="post_comment">Комментарий</label>
								<textarea id="post_comment" rows="9" name="text" class="form-control input-lg required" required>{$comment_text}</textarea>
							</div>
							
							<div class="form-group sep-top-xs">
								<input type="hidden" name="comment" value="input_for_submit_form">
								<button type="submit" class="btn btn-primary"><i class="fa fa-comment"></i>&nbsp;Отправить</button>
							</div>
						</form>
					</div>
				</div>
			</section>
			<!-- end Comment Form-->
		</div>
		
		<aside id="sidebar" role="complementary" class="col-md-3 sep-top-md sidebar">
			{if $prev_post || $next_post}
			<h5 class="widget-title  sep-bottom-xs">Соседние записи</h5>
			
			<ul class="widget widget-media rounded sep-bottom-lg">
				{if $prev_post}
					<li class="media media-bordered clearfix">
						{if $prev_post->thumb}
							<div class="pull-left"><a href="blog/{$prev_post->url}" class="media-object post-image" style="background-image: url(files/posts/thumbs/{$prev_post->thumb})"></a></div>
						{/if}
						
						<div class="media-body">
							<h6 class="media-heading"><a href="blog/{$prev_post->url}">{$prev_post->name|escape}</a></h6><small>{$prev_post->date|date}</small>
						</div>
					</li>
				{/if}
				{if $next_post}
					<li class="media media-bordered clearfix">
						{if $next_post->thumb}
							<div class="pull-left"><a href="blog/{$next_post->url}" class="media-object post-image" style="background-image: url(files/posts/thumbs/{$next_post->thumb})"></a></div>
						{/if}
						
						<div class="media-body">
							<h6 class="media-heading"><a href="blog/{$next_post->url}">{$next_post->name|escape}</a></h6><small>{$next_post->date|date}</small>
						</div>
					</li>
				{/if}
			</ul>
			{/if}
			
			<h5 class="widget-title  sep-bottom-xs">Недавние записи</h5>

			{* Выбираем в переменную $last_posts последние записи *}
			{get_posts var=last_posts limit=6}
			{if $last_posts}
				<ul class="widget widget-media rounded sep-bottom-lg">
					{foreach $last_posts as $last_post}
					{if $last_post->id != $post->id}
						<li class="media media-bordered clearfix">
							{if $last_post->thumb}
								<div class="pull-left"><a href="blog/{$last_post->url}" class="media-object post-image" style="background-image: url(files/posts/thumbs/{$last_post->thumb})"></a></div>
							{/if}
							
							<div class="media-body">
								<h6 class="media-heading"><a href="blog/{$last_post->url}">{$last_post->name|escape}</a></h6><small>{$last_post->date|date}</small>
							</div>
						</li>
						{/if}
					{/foreach}
				</ul>
			{else}
				<p>Увы, это пока единственная запись, но скоро мы напишем еще :)</p> 
			{/if}
		</aside>
	</div>
</div>
{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

<div class="content-text p-t-0">
{if $page->body}{$page->body}{else}
	<i><b>Страница на стадии оформления</b><br />
	Попробуйте зайти позже
	</i>
{/if}
</div>
{* Постраничный вывод *}

{if $total_pages_num>1}
<ul class="pager">
	{* Количество выводимых ссылок на страницы *}
	{$visible_pages = 11}

	{* По умолчанию начинаем вывод со страницы 1 *}
	{$page_from = 1}
	
	{* Если выбранная пользователем страница дальше середины "окна" - начинаем вывод уже не с первой *}
	{if $current_page_num > floor($visible_pages/2)}
		{$page_from = max(1, $current_page_num-floor($visible_pages/2)-1)}
	{/if}	
	
	{* Если выбранная пользователем страница близка к концу навигации - начинаем с "конца-окно" *}
	{if $current_page_num > $total_pages_num-ceil($visible_pages/2)}
		{$page_from = max(1, $total_pages_num-$visible_pages-1)}
	{/if}
	
	{* До какой страницы выводить - выводим всё окно, но не более ощего количества страниц *}
	{$page_to = min($page_from+$visible_pages, $total_pages_num-1)}

	{if $current_page_num==2}
		<li class="previous hidden-xs"><a href="{url page=null}"><i class="fa fa-arrow-left"></i>&nbsp;Сюда</a></li>
	{elseif $current_page_num>2}
		<li class="previous hidden-xs"><a href="{url page=$current_page_num-1}"><i class="fa fa-arrow-left"></i>&nbsp;Сюда</a></li>
	{else}
		<li class="previous hidden-xs invisible"><a href="#"><i class="fa fa-arrow-left"></i>&nbsp;Сюда</a></li>
	{/if}
	
	{* Ссылка на 1 страницу отображается всегда *}
	<li>
		{if $current_page_num==1}<span class="current">1</span>{else}<a href="{url page=null}">1</a>{/if}
	</li>
	
	{* Выводим страницы нашего "окна" *}	
	{section name=pages loop=$page_to start=$page_from}
		{* Номер текущей выводимой страницы *}	
		{$p = $smarty.section.pages.index+1}	
		{* Для крайних страниц "окна" выводим троеточие, если окно не возле границы навигации *}
		<li>
			{if ($p == $page_from+1 && $p!=2) || ($p == $page_to && $p != $total_pages_num-1)}	
				{if $p==$current_page_num}<span class="current">…</span>{else}<a href="{url page=$p}">…</a>{/if} 
			{else}
				{if $p==$current_page_num}<span class="current">{$p}</span>{else}<a href="{url page=$p}">{$p}</a>{/if}
			{/if}
		</li>
	{/section}

	{* Ссылка на последнююю страницу отображается всегда *}
	<li>
		{if $current_page_num==$total_pages_num}<span class="current">{$total_pages_num}</span>{else}<a href="{url page=$total_pages_num}">{$total_pages_num}</a>{/if}
	</li>

	{if $current_page_num<$total_pages_num}
		<li class="next hidden-xs"><a href="{url page=$current_page_num+1}">Туда&nbsp;<i class="fa fa-arrow-right"></i></a></li>
	{else}
		<li class="next hidden-xs invisible"><a href="#">Туда&nbsp;<i class="fa fa-arrow-right"></i></a></li>
	{/if}
</ul>  
{/if}
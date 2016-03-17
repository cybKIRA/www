{* Вкладки *}
{capture name=tabs}
	{if in_array('import', $manager->permissions)}<li><a href="index.php?module=ImportAdmin">Импорт</a></li>{/if}
	{if in_array('export', $manager->permissions)}<li><a href="index.php?module=ExportAdmin">Экспорт</a></li>{/if}
	{if in_array('backup', $manager->permissions)}<li><a href="index.php?module=BackupAdmin">Бекап</a></li>{/if}
	<li class="active"><a href="index.php?module=AvangardAdmin">Авангард</a></li>
{/capture}

{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span class="text">{if $message_success=='added'}Товары добавлены{elseif $message_success=='updated'}Товар изменен{else}{$message_success|escape}{/if}</span>

</div>
<!-- Системное сообщение (The End)-->
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span class="text">{if $message_error=='url_exists'}Есть товары где адрес совпадает{elseif $message_error=='empty_name'}Есть пустые имена{else}{$message_error|escape}{/if}</span>

</div>
<!-- Системное сообщение (The End)-->
{/if}

<form method=post enctype="multipart/form-data">
<input type=hidden name="session_id" value="{$smarty.session.id}">


<h2>Всего в импорте [{count($products)}]</h2>
{*
<table style='width:100%'>
<tr>
 <td>ID пост.</td><td>Название</td> <td>Цена поставщика</td> <td>Цена</td> <td>Бренд</td><td>id_brand</td> <td>ЧПУ</td><td>Применить</td>
</tr>
{foreach from=$products item=product}
    <tr id={$product.id_post}>
		<td>
			{$product.id_post}
		</td>
		<td>
			{$product.name}
		</td>
		<td>
		    {$product.price_post}
		</td>
		<td>
			{$product.price} руб
		</td>
		<td>
			{$product.brand}
		</td>
		<td>
		{$product.id_brand}
		</td>
	   <td>
			{$product.name_pars}
		</td>
		<td>
			&nbsp;
		</td>
	</tr>
{/foreach}
</table>
*}

<hr>

<h2>Новое поступление (добавить в базу) [{count($products_add)}]</h2>
<table style='width:100%'>
<tr>
 <td>ID пост.</td><td>Название</td> <td>Цена поставщика</td> <td>Цена</td> <td>Бренд</td><td>id_brand</td><td>Пол</td> <td>ЧПУ</td> <td>Применить</td>
</tr>
{foreach from=$products_add item=product}
    <tr id={$product.id_post}>
		<td>
			{$product.id_post}
		</td>
		<td>
			{$product.name}
		</td>
		<td>
		    {$product.price_post}
		</td>
		<td>
			{$product.price} руб
		</td>
		<td>
			{$product.brand}
		</td>
		<td>
			{$product.id_brand}
		</td>
		<td>
			{$product.sex}
		</td>
	   <td>
			{$product.name_pars}
		</td>
		<td>
			<input name="id_add[]" value="{$product.id_post}" type="checkbox" checked="checked" />
		</td>
	</tr>
{/foreach}
</table>

<hr>
<h2>Теперь нет в выгрузке (спрятать) [{count($products_del)}]</h2>
<table style='width:100%'>
<tr>
 <td>ID Симпла</td><td>ID пост.</td><td>Название</td> <td>Цена поставщика</td> <td>Цена</td> <td>Бренд</td> <td>ЧПУ</td> <td>Применить</td>
</tr>
{foreach from=$products_del item=product}
    <tr id={$product.id_post}>
		<td>
		{$product.id}
		</td>
		<td>
			{$product.id_post}
		</td>
		<td>
			{$product.name}
		</td>
		<td>
		    {$product.price_post}
		</td>
		<td>
			{$product.price} руб
		</td>
		<td>
			{$product.brand}
		</td>
	   <td>
			{$product.url}
		</td>
		<td>
			<input name="id_del[]" value="{$product.id_post}" checked="checked" type="checkbox" />
		</td>
	</tr>
{/foreach}
</table>

<hr>
<h2>Появилось в выгрузке (показать) [{count($products_vis)}]</h2>
<table style='width:100%'>
<tr>
 <td>ID Симпла</td><td>ID пост.</td><td>Название</td> <td>Цена поставщика</td> <td>Цена</td> <td>Бренд</td> <td>ЧПУ</td> <td>Применить</td>
</tr>
{foreach from=$products_vis item=product}
    <tr id={$product.id_post}>
		<td>
		{$product.id}
		</td>
		<td>
			{$product.id_post}
		</td>
		<td>
			{$product.name}
		</td>
		<td>
		    {$product.price_post}
		</td>
		<td>
			{$product.price} руб
		</td>
		<td>
			{$product.brand}
		</td>
	   <td>
			{$product.url}
		</td>
		<td>
			<input name="id_vis[]" value="{$product.id_post}" checked="checked"  type="checkbox" />
		</td>
	</tr>
{/foreach}
</table>

<hr>
<h2>Изменения цены/имени (изменить) [{count($products_change)}]</h2>
<table style='width:100%'>
<tr>
 <td>ID Симпла</td><td>ID пост.</td><td>Название</td> <td>Цена поставщика</td> <td>Цена</td> <td>Бренд</td> <td>ЧПУ</td> <td>Применить</td>
</tr>
{foreach from=$products_change item=product}
    <tr id={$product.id_post}>
		<td>
		{$product.id}
		</td>
		<td>
			{$product.id_post}
		</td>
		<td>
			{$product.name}
		</td>
		<td>
		    {$product.price_post}
		</td>
		<td>
			{$product.price} руб
		</td>
		<td>
			{$product.brand}
		</td>
	   <td>
			{$product.url}
		</td>
		<td>
			<input name="id_ch[{$product.id_post}]" value="{$product.id_post}" {*checked="checked"*} type="checkbox" />
		</td>
	</tr>
	</tr>
	<tr>
		<td colspan="8">
			{$product.change_options_str}
		</td>
	</tr>
	<tr style="color:#c0c0c0;">
		<td>
		{$product.change.id}
		</td>
		<td>
			{$product.change.id_post}
		</td>
		<td>
			{$product.change.name}
		</td>
		<td>
		    {$product.change.price_post}
		</td>
		<td>
			{$product.change.price} руб
		</td>
		<td>
			{$product.change.brand}
		</td>
	   <td>
			{$product.change.url}
		</td>
		<td>
			{$product.change_str}
		</td>
	</tr>
	<tr style="color:#c0c0c0;">
		<td colspan="8">
			{$product.change.change_options_str}

			<input name="change_str[{$product.id_post}]" type="hidden" value="{$product.change_str}" >
		</td>
	</tr>
{/foreach}
</table>
 <br>
 <input class="button_green button_save" type="submit" name="" value="Применить" />
</form> 
</br>
{*$result->tttime*}
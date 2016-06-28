<!DOCTYPE html>
{*
	Печать заказа
*}
{$wrapper='' scope=parent}
<html>
<head>
	<base href="{$config->root_url}/"/>
	<title>Заказ №{$order->id}</title>	
	{* Метатеги *}
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="description" content="{$meta_description|escape}" />
    <style>
    body {
        width: 100%;
        height: 100%;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        //border: 1px solid black;

		font-family: Trebuchet MS, times, arial, sans-serif;		
		font-size: 10pt;
		color: black;
		background-color: white;         
    }
    
    div#header{
    	margin-left: 50px;
    	margin-top: 50px;
    	height: 150px;
    	width: 30%;
    	float: left;
    }
    div#company{
    	margin-right: 50px;
    	margin-top: 50px;
    	height: 150px;
    	width: 30%;
    	float: right;
    	text-align: right;
    }
    div#customer{
    	margin-right: 50px;
    	height: 200px;
    	width: 30%;
    	float: right;
    }
    div#customer table{
        margin-bottom: 20px;
        font-size: 20px;
    }

    div#purchases{
    	margin-left: 50px;
    	margin-bottom: 20px;
    	min-height: 300px;
    	width: 100%;
    	float: left;
    	
    }
    div#purchases table{
    	width: 90%;
    	border-collapse:collapse
    }
    div#purchases table th
    {
    	font-weight: normal;
    	text-align: left;
    	font-size: 25px;
    }
    div#purchases td, div#purchases th
    {
    	font-size: 18px;
    	padding-top: 10px;
    	padding-bottom: 10px;
    	margin: 0;    	
    }
    div#purchases td
    {
    	border-top: 1px solid black; 	
    }
 
    div#total{
    	float: right;
    	margin-right: 50px;
    	height: 100px;
    	width: 70%;
    	text-align: right;
    }
    div#total table{
    	width: 70%;
    	float: right;
    	border-collapse:collapse
    }
    div#total th
    {
    	font-weight: normal;
    	text-align: left;
    	font-size: 22px;
    	border-top: 1px solid black; 	
    }
    div#total td
    {
    	text-align: right;
    	border-top: 1px solid black; 	
    	font-size: 18px;
    	padding-top: 10px;
    	padding-bottom: 10px;
    	margin: 0;    	
    }
    div#total .total
    {
    	font-size: 30px;
    }
    h1{
    	margin: 0;
    	font-weight: normal;
    	font-size: 40px;
    }
    h2{
    	margin: 0;
    	font-weight: normal;
    	font-size: 24px;
    }
    p
    {
    	margin: 0;
    	font-size: 20px;
    }
    div#purchases td.align_right, div#purchases th.align_right
    {
    	text-align: right;
    }
    </style>	
</head>

<body _onload="window.print();">

<div id="header">
	<h1>Заказ №{$order->id}</h1>
	<p>от {$order->date|date}</p>
</div>

<div id="company">
	<h2>{$settings->site_name}</h2>
	<p>{$config->root_url}</p>
</div>


<div id="purchases">
	<table width=100%>
		<tr>
			<th>Товар</th>
			<th class="align_right">Количество</th>
			<th class="align_right">Стоимость</th>
		</tr>
		{foreach $purchases as $purchase}
		<tr>
			<td>
				<span class=view_purchase>
					{$purchase->product_name} {$purchase->variant_name} {if $purchase->sku} (артикул {$purchase->sku}){/if}			
				</span>
			</td>

			<td class="align_right">			
				<span class=view_purchase>
					{$purchase->weight} {$purchase->variant->unit}
				</span>
			</td>
			<td class="align_right">
				<span class=view_purchase>{$purchase->price}</span> {$currency->sign}
			</td>
		</tr>
		{/foreach}

		
	</table>
</div>


<div id="total">
	<table>
		{if $order->discount>0}
		<tr>
			<th>Скидка</th>
			<td>{$order->discount} %</td>
		</tr>
		{/if}
		{if $order->coupon_discount>0}
		<tr>
			<th>Купон{if $order->coupon_code} ({$order->coupon_code}){/if}</th>
			<td>{$order->coupon_discount}&nbsp;{$currency->sign}</td>
		</tr>
		{/if}		
		<tr>
			<th>Итого</th>
			<td class="total">{$order->total_price}&nbsp;{$currency->sign}</td>
		</tr>
		{* Если стоимость доставки входит в сумму заказа *}
		{if $order->delivery_price>0}
		<tr>
			<td colspan=0>{$delivery->name|escape}{if $order->separate_delivery} {/if}</td>
			<td class="align_right">{$order->delivery_price|convert}&nbsp;{$currency->sign}</td>
		</tr>
		{/if}
		{if $payment_method}
		<tr>
			<td colspan="2">Способ оплаты: {$payment_method->name}</td>
		</tr>
		<tr>
			<th>К оплате</th>
			<td class="total">{$order->total_price + $order->delivery_price} &nbsp;{$payment_currency->sign}</td>
		</tr>
		{/if}
	</table>
</div>

</body>
</html>


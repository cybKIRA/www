<?php
	session_start();
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();

    $variant_id 		= $simpla->request->get('variant_id', 'integer');
    $amount    			= $simpla->request->get('amount',     'integer');
    $remove_id  		= $simpla->request->get('remove_id',  'integer');
    $delivery_id  		= $simpla->request->get('delivery_id',  'integer');
    //$delivery_checked  	= $simpla->request->get('delivery_id',  'integer') - 1;
	$coupon_code 		= trim($simpla->request->get('coupon_code', 'string'));
	
	// Если есть remove
    if($remove_id)
		$simpla->cart->delete_item($remove_id);

    // Если есть amount, обновляем их
    if($amount && $variant_id) {
       $simpla->cart->update_item($variant_id, $amount);
       $variant = $simpla->variants->get_variants(array('id'=>$variant_id));
       $simpla->design->assign('amount',  $_SESSION['shopping_cart'][$variant_id]);
       $simpla->design->assign('variant', $variant[0]);
    }

	// Если есть купон 
	if(empty($coupon_code))
	{
		$simpla->cart->apply_coupon('');
		$coupon_result = 'empty';
	}
	else
	{
		$coupon = $simpla->coupons->get_coupon((string)$coupon_code);
		$simpla->cart->apply_coupon($coupon_code);
		
		if(empty($coupon) || !$coupon->valid)
		{
			$coupon_result = 'invalid';
		}
		else
		{
			$cart = $simpla->cart->get_cart();

			if($coupon && $coupon->valid && $cart->total_price >= $coupon->min_order_price)
			{
				$coupon_result = 'success';
				
				if($coupon->type=='absolute')
				{
					// Абсолютная скидка не более суммы заказа
					$cart->coupon_discount = $cart->total_price > $coupon->value ? $coupon->value : $cart->total_price;
					$cart->total_price = max(0, $cart->total_price - $coupon->value);
				}
				else
				{
					$cart->coupon_discount = $cart->total_price * ($coupon->value)/100;
					$cart->total_price = $cart->total_price - $cart->coupon_discount;
				}
			}
			else
			{
				unset($_SESSION['coupon_code']);
				$coupon_result = 'min_order_price';
			}
		}
	}
		
	$cart = $simpla->cart->get_cart();
		
	$cart->coupon = $coupon;
	$simpla->design->assign('cart', $cart);

	$deliveries = $simpla->delivery->get_deliveries(array('enabled'=>1));
	$simpla->design->assign('deliveries', $deliveries);

	$delivery = $simpla->delivery->get_delivery($delivery_id);
	$simpla->design->assign('delivery', $delivery);
	
	if ( $cart->total_price < $delivery->free_from && $delivery->price > 0 )
		$simpla->design->assign('delivery_price', $delivery->price);
	elseif ( $cart->total_price >= $delivery->free_from )
		$simpla->design->assign('delivery_price', 0);
	
	$currencies = $simpla->money->get_currencies(array('enabled'=>1));
	if(isset($_SESSION['currency_id']))
		$currency = $simpla->money->get_currency($_SESSION['currency_id']);
	else
		$currency = reset($currencies);
	$simpla->design->assign('currency',	  $currency);
	$simpla->design->assign('delivery_id',	  $delivery_id);
	$simpla->design->assign('coupon_result', $coupon_result);

	$result = array('cart_title'=>$simpla->design->fetch('cart_title.tpl'),
					'cart_informer'=>$simpla->design->fetch('cart_informer.tpl'),
					'cart_item_total'=>$simpla->design->fetch('cart_item_total.tpl'),
					'cart_items_total'=>$simpla->design->fetch('cart_items_total.tpl'), 
					'cart_total'=>$simpla->design->fetch('cart_total.tpl'), 
					
					'deliveries'=>$simpla->design->fetch('delivery.tpl'),
					'delivery_cost'=>$simpla->design->fetch('delivery_cost.tpl'),
					'incart'=>$cart->total_products,
					'cart_coupon'=>$simpla->design->fetch('cart_coupon.tpl'),
					'coupon_status'=>$coupon_result,
					'coupon_result'=>$simpla->design->fetch('cart_coupon_result.tpl')
	);
	
	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");
	print json_encode($result);
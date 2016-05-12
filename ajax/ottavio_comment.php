<?php
	session_start();
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();
	
	/*$product_url = $simpla->request->get('product_url', 'string');
	if(empty($product_url)) {
			//$result = array('status'=>'error', 'data'=>'Ошибка');	
			return false;
	}

	$product = $simpla->products->get_product((string)$product_url);*/
	
	$comment = new stdClass;
	
	$comment->name     = $_POST['name'];
	$comment->text     = $_POST['text'];
	$comment->rate     = $_POST['rate'];
	$captcha_code      = $_POST['captcha_code'];
	$comment->object_id = $_POST['object_id'];
	
	// Передадим комментарий обратно в шаблон - при ошибке нужно будет заполнить форму
	$simpla->design->assign('comment_rate', $comment->rate);
	$simpla->design->assign('comment_text', $comment->text);
	$simpla->design->assign('comment_name', $comment->name);
	
	if(empty($comment->name))
		$result = array('status'=>'error', 'data'=>'Введите имя');		
	elseif(empty($comment->rate))
		$result = array('status'=>'error', 'data'=>'Поставьте оценку');		
	elseif(empty($comment->text))
		$result = array('status'=>'error', 'data'=>'Введите текст отзыва');	
	elseif(empty($captcha_code))
			$result = array('status'=>'error', 'data'=>'Введите число с картинки');
	elseif(empty($_SESSION['captcha_code']) || $_SESSION['captcha_code'] != $captcha_code || empty($captcha_code))
			$result = array('status'=>'error', 'data'=>'Число с картинки введено неверно');
	else
	{
		// Создаем комментарий
		//$comment->object_id = $product->id;
		$comment->type      = 'product';
		$comment->ip        = $_SERVER['REMOTE_ADDR'];
				
		// Добавляем комментарий в базу
		$comment_id = $simpla->comments->add_comment($comment);
			
		// Отправляем email
		$simpla->notify->email_comment_admin($comment_id);				
				
		// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
		unset($_SESSION['captcha_code']);	
		
		$result = array('status'=>'success', 'data'=>$comment->name);		
	}

	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");
	print json_encode($result);
<?php
	session_start();
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();

	$feedback = new stdClass;
	
	$feedback->name         = $_POST['name'];
	$feedback->email        = $_POST['email'];
	$feedback->message      = $_POST['message'];
	$captcha_code           = $_POST['captcha_code'];
	
	$simpla->design->assign('name',  $feedback->name);
	$simpla->design->assign('email', $feedback->email);
	$simpla->design->assign('message', $feedback->message);
	
	if(empty($feedback->name))
		$result = array('status'=>'error', 'data'=>'Введите имя');		
	elseif(empty($feedback->email))
		$result = array('status'=>'error', 'data'=>'Введите email');		
	elseif(empty($feedback->message))
		$result = array('status'=>'error', 'data'=>'Введите сообщение');	
	elseif(empty($captcha_code))
			$result = array('status'=>'error', 'data'=>'Введите число с картинки');
	elseif(empty($_SESSION['captcha_code']) || $_SESSION['captcha_code'] != $captcha_code || empty($captcha_code))
			$result = array('status'=>'error', 'data'=>'Число с картинки введено неверно');
	else
	{
		$feedback->ip = $_SERVER['REMOTE_ADDR'];
		$feedback_id = $simpla->feedbacks->add_feedback($feedback);
		
		// Отправляем email
		$simpla->notify->email_feedback_admin($feedback_id);	
		// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
		unset($_SESSION['captcha_code']);
		
		$result = array('status'=>'success', 'data'=>$feedback->name);		
	}

	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");
	print json_encode($result);
<?php
	session_start();
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();

	$feedback = new stdClass;
	
	$feedback->name         = $_POST['name'];
	$feedback->email        = $_POST['email'];
	$feedback->message      = $_POST['message'];
	
	$simpla->design->assign('name',  $feedback->name);
	$simpla->design->assign('email', $feedback->email);
	$simpla->design->assign('message', $feedback->message);
	
	if(empty($feedback->name))
		$result = array('status'=>'error', 'data'=>'Введите имя');		
	elseif(empty($feedback->email))
		$result = array('status'=>'error', 'data'=>'Введите email');		
	elseif(empty($feedback->message))
		$result = array('status'=>'error', 'data'=>'Введите сообщение');		
	else
	{
		$feedback->ip = $_SERVER['REMOTE_ADDR'];
		$feedback_id = $simpla->feedbacks->add_feedback($feedback);
		
		// Отправляем email
		$simpla->notify->email_feedback_admin($feedback_id);	

		$result = array('status'=>'success', 'data'=>$feedback->name);		
	}

	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");
	print json_encode($result);
<?php
	session_start();
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();

    $email		 = $_POST["email"];
    $password    = $_POST["password"];
	
	$simpla->design->assign('email', $email);

	if($user_id = $simpla->users->check_password($email, $password))
	{
		$user = $simpla->users->get_user($email);
		if($user->enabled)
		{
			$_SESSION['user_id'] = $user_id;
			$simpla->users->update_user($user_id, array('last_ip'=>$_SERVER['REMOTE_ADDR']));
			
			$result = 'correct';						
		}
		else
		{
			$result = 'user_disabled';						
		}
	}
	else
	{
		$result = 'login_incorrect';	
	}				
	
	header("Content-type: application/json; charset=UTF-8");
	header("Cache-Control: must-revalidate");
	header("Pragma: no-cache");
	header("Expires: -1");
	print json_encode($result);
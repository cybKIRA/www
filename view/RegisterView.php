<?PHP

require_once('View.php');

class RegisterView extends View
{
	function fetch()
	{
		$default_status = 1; // Активен ли пользователь сразу после регистрации (0 или 1)
		
		if($this->request->method('post') && $this->request->post('register'))
		{
			$name			= $this->request->post('name');
			$email			= $this->request->post('email');
			$password		= $this->request->post('password');
			
			$this->design->assign('name', $name);
			$this->design->assign('email', $email);
			
			$this->db->query('SELECT count(*) as count FROM __users WHERE email=?', $email);
			$user_exists = $this->db->result('count');

			if($user_exists)
				$this->design->assign('error', 'user_exists');
			elseif(empty($name))
				$this->design->assign('error', 'empty_name');
			elseif(empty($email))
				$this->design->assign('error', 'empty_email');
			elseif(empty($password))
				$this->design->assign('error', 'empty_password');		
			elseif($user_id = $this->users->add_user(array('name'=>$name, 'email'=>$email, 'password'=>$password, 'enabled'=>$default_status, 'last_ip'=>$_SERVER['REMOTE_ADDR'])))
			{
				/* Генерация и отправка купона
				$coupon = array('code'=>'REGISTER'.$user_id, 'single'=>1, 'type'=>'absolute', 'value'=>300);
				if ($coupon_id = $this->coupons->add_coupon((object)$coupon)) {
					$message = "Спасибо за регистрацию <br> В качестве благодарности вот вам купон: " .'REGISTER'.$user_id;
					$this->notify->email($email, 'Ваш купон', $message, $this->settings->notify_from_email);
				}
				*/
				
				$_SESSION['user_id'] = $user_id;
				if(!empty($_SESSION['last_visited_page']))
					header('Location: '.$_SESSION['last_visited_page']);				
				else
					header('Location: '.$this->config->root_url);
			}
			else
				$this->design->assign('error', 'unknown error');
	
		}
		return $this->design->fetch('register.tpl');
	}	
}

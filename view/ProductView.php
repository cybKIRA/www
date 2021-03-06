<?PHP

/**
 * Simpla CMS
 *
 * @copyright 	2011 Denis Pikusov
 * @link 		http://simplacms.ru
 * @author 		Denis Pikusov
 *
 * Этот класс использует шаблон product.tpl
 *
 */

require_once('View.php');


class ProductView extends View
{

	function fetch()
	{   
		$product_url = $this->request->get('product_url', 'string');
		
		if(empty($product_url))
			return false;

		// Выбираем товар из базы
		$product = $this->products->get_product((string)$product_url);
		if(empty($product) || (!$product->visible && empty($_SESSION['admin'])))
			return false;
		
		$product->images = $this->products->get_images(array('product_id'=>$product->id));
		$product->image = reset($product->images);

		$variants = array();
		foreach($this->variants->get_variants(array('product_id'=>$product->id, 'in_stock'=>true)) as $v)
			$variants[$v->id] = $v;
		
		$product->variants = $variants;
		
		// Вариант по умолчанию
		if(($v_id = $this->request->get('variant', 'integer'))>0 && isset($variants[$v_id]))
			$product->variant = $variants[$v_id];
		else
			$product->variant = reset($variants);
					
		$product->features = $this->features->get_product_options(array('product_id'=>$product->id));
	
		// Автозаполнение имени для формы комментария
		if(!empty($this->user))
			$this->design->assign('comment_name', $this->user->name);

		// Если были отзывы от текущего пользователя
		if(!empty($this->user)) {
			$query = $this->db->placehold("SELECT c.approved, c.rate, c.name, c.text FROM __comments c WHERE object_id=? AND user_id=? LIMIT 1", $product->id, $this->user->id);
			
			if($this->db->query($query)) {
				if($result = $this->db->result())
					$this->user->comment = $result;
			}
		}
		
		// Принимаем комментарий
		if ($this->request->method('post') && $this->request->post('comment_add'))
		{
			$comment = new stdClass;
			$comment->rate 	  = $this->request->post('rate');
			$comment->name 	  = $this->request->post('name');
			$comment->text 	  = $this->request->post('text');
			$captcha_code =  $this->request->post('captcha_code', 'string');
			$comment->user_id = $this->user->id;
			
			// Передадим комментарий обратно в шаблон - при ошибке нужно будет заполнить форму
			$this->design->assign('comment_rate', $comment->rate);
			$this->design->assign('comment_text', $comment->text);
			$this->design->assign('comment_name', $comment->name);
			
			// Проверяем заполнение формы
			if ($_SESSION['captcha_code'] != $captcha_code || empty($captcha_code))
			{
				$this->design->assign('error', 'captcha');
			}
			elseif (empty($comment->name))
			{
				$this->design->assign('error', 'empty_name');
			}
			elseif (empty($comment->text))
			{
				$this->design->assign('error', 'empty_comment');
			}
			else 
			{
				// Создаем комментарий
				$comment->object_id = $product->id;
				$comment->type      = 'product';
				$comment->ip        = $_SERVER['REMOTE_ADDR'];
				
				// Добавляем комментарий в базу
				$comment_id = $this->comments->add_comment($comment);
				
				// Отправляем email
				$this->notify->email_comment_admin($comment_id);				
				
				// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
				unset($_SESSION['captcha_code']);
				//header('location: '.$_SERVER['REQUEST_URI'].'#comments');
			}			
		}
		
		// Редактируем комментарий
		if ($this->request->method('post') && $this->request->post('comment_edit'))
		{
			$comment = $this->comments->get_comment_by_user($this->user->id, $product->id);

			if ( $comment->object_id == $product->id ) {
				if($comment->approved == 1) {
					// Убираем рейтинг
					$this->products->decrease_rate_product(intval($comment->object_id), intval($comment->rate));
					$comment->approved = 0;
				}
				
				unset($comment->date);
				$comment->rate 	  = $this->request->post('rate');
				$comment->name 	  = $this->request->post('name');
				$comment->text 	  = $this->request->post('text');
				//$comment->user_id = $this->user->id;
				
				// Передадим комментарий обратно в шаблон - при ошибке нужно будет заполнить форму
				$this->design->assign('comment_rate', $rate);
				$this->design->assign('comment_text', $comment->text);
				$this->design->assign('comment_name', $comment->name);
				
				// Проверяем заполнение формы
				if (empty($comment->rate))
					$this->design->assign('error', 'empty_rate');
				elseif (empty($comment->name))
					$this->design->assign('error', 'empty_name');
				elseif (empty($comment->text))
					$this->design->assign('error', 'empty_comment');
				else
				{
					// Обновляем комментарий в базе
					$comment_id = $this->comments->update_comment($comment->id, $comment);
					
					// Отправляем email
					$this->notify->email_comment_admin($comment_id);				
					
					// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
					//unset($_SESSION['captcha_code']);
					header('location: '.$_SERVER['REQUEST_URI'].'#comments');
				}
			} else {
				$this->design->assign('error', 'wtf');
			}	
			

		}	
		
		// Связанные товары
		$related_ids = array();
		$related_products = array();
		foreach($this->products->get_related_products($product->id) as $p)
		{
			$related_ids[] = $p->related_id;
			$related_products[$p->related_id] = null;
		}
		if(!empty($related_ids))
		{
			foreach($this->products->get_products(array('id'=>$related_ids, 'in_stock'=>1, 'visible'=>1)) as $p)
				$related_products[$p->id] = $p;
			
			$related_products_images = $this->products->get_images(array('product_id'=>array_keys($related_products)));
			foreach($related_products_images as $related_product_image)
				if(isset($related_products[$related_product_image->product_id]))
					$related_products[$related_product_image->product_id]->images[] = $related_product_image;
			$related_products_variants = $this->variants->get_variants(array('product_id'=>array_keys($related_products), 'in_stock'=>1));
			foreach($related_products_variants as $related_product_variant)
			{
				if(isset($related_products[$related_product_variant->product_id]))
				{
					$related_products[$related_product_variant->product_id]->variants[] = $related_product_variant;
				}
			}
			foreach($related_products as $id=>$r)
			{
				if(is_object($r))
				{
					$r->image = &$r->images[0];
					$r->variant = &$r->variants[0];
				}
				else
				{
					unset($related_products[$id]);
				}
			}
			
			// Категория товара
			$related_products_categories = $this->categories->get_product_categories(array_keys($related_products));
			foreach($related_products_categories as $cat)
				$related_products[$cat->product_id]->category = $this->categories->get_category((int)$cat->category_id);
				
			$this->design->assign('related_products', $related_products);
		}

		// Отзывы о товаре
		$comments = $this->comments->get_comments(array('type'=>'product', 'object_id'=>$product->id, 'approved'=>1));
		
		// Соседние товары
		$this->design->assign('next_product', $this->products->get_next_product($product->id));
		$this->design->assign('prev_product', $this->products->get_prev_product($product->id));

		// И передаем его в шаблон
		$this->design->assign('product', $product);
		$this->design->assign('comments', $comments);
		
		// Категория и бренд товара
		$product->categories = $this->categories->get_categories(array('product_id'=>$product->id));
		$brand = $this->brands->get_brand(intval($product->brand_id));
		$this->design->assign('brand', $brand);		
		$this->design->assign('category', reset($product->categories));		
		

		// Добавление в историю просмотров товаров
		$max_visited_products = 100; // Максимальное число хранимых товаров в истории
		$expire = time()+60*60*24*30; // Время жизни - 30 дней
		if(!empty($_COOKIE['browsed_products']))
		{
			$browsed_products = explode(',', $_COOKIE['browsed_products']);
			// Удалим текущий товар, если он был
			if(($exists = array_search($product->id, $browsed_products)) !== false)
				unset($browsed_products[$exists]);
		}
		// Добавим текущий товар
		$browsed_products[] = $product->id;
		$cookie_val = implode(',', array_slice($browsed_products, -$max_visited_products, $max_visited_products));
		setcookie("browsed_products", $cookie_val, $expire, "/");
		
		$sex = $product->features[0]->value;
		$meta_title = 'Часы ' . $product->name . ' - купить оригинальные ' . $sex . ' наручные часы ' . (isset($brand->name_ru) ? $brand->name_ru : '') .' в Интернет магазине Kupi.watch с доставкой по России. Цена, отзывы, характеристики, описание.';
		$this->design->assign('meta_title', $meta_title);
		
		$product_name = $product->name;
		if (isset($brand->name_ru)) $product_name = str_replace($brand->name,$brand->name.' ('.$brand->name_ru.')',$product_name);
		$meta_description = 'Купить часы '  .  $product_name . ' оригинал недорого Вы можете в нашем Интернет-магазине наручных часов Kupi.watch (Купи Вотч). Наш магазин осуществляет доставку в любой регион России!';
		
		$this->design->assign('meta_description', $meta_description);
	    $meta_keywords = $brand->name.', '.(isset($brand->name_ru) ? $brand->name_ru .', ' : '').$product->name.', '.'купить, мужские, женские, наручные, оригинальные, недорого, часы, цена, характеристики, отзывы, описание, доставка';
		$this->design->assign('meta_keywords', $meta_keywords);
		
		$this->design->assign('my_brand', $this->brands->get_brands_catalog_url(array('category_id'=>intval($product->brand_id))));
		
		return $this->design->fetch('product.tpl');
	}
	


}

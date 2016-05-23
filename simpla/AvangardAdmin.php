<?PHP
require_once('api/Simpla.php');
require_once('simpla/AvangardLib.php');
require_once('simpla/AvangardConfig.php');



class AvangardAdmin extends Simpla
{	
	
	public function fetch()
	{
	    $dop_proverka = true; // Если нужно проверить свойства
		
		$myLogin = new AvangardConfig;
		//функция выгрузки от Авангарда
		$output = get_avangard_products($myLogin->login, $myLogin->password);
			
		$output = mb_convert_encoding($output, 'utf-8', 'windows-1251');
		
		//какие нужны каталоги
		//$list_cat = array("naruchnie_chasi/slava");
		$list_cat = array("naruchnie_chasi/q_amp_q","naruchnie_chasi/orient","naruchnie_chasi/vostok","naruchnie_chasi/casio","naruchnie_chasi/slava","naruchnie_chasi/sever","naruchnie_chasi/zarya","naruchnie_chasi/spetsnaz"); 
		
		$output_count = count(str_getcsv($output,"\n"));
		
		$products = avangard_filter_and_pars($output,$list_cat);
		
		function cmp($a, $b) //функция сортировки
		{
			$pole = 'name';
			if ($a[$pole] == $b[$pole]) {
				return 0;
			}
			return ($a[$pole] < $b[$pole]) ? -1 : 1;
		}

		usort($products, "cmp"); //сортируем массив и получаем готовый к употреблению массив выгрузки от поставщика
		

		
		if($this->request->method('post') && !empty($_POST)) 
		{ //если есть POST

		if ($this->request->post('id_add') ) { //если есть отмеченные чекбоксы для добавления
			foreach ($this->request->post('id_add') as $id_post) {
				//найдем те продукты которые можно добавлять
				foreach ($products as $part) {
				
					//Если нужно добавлять
					if ($id_post == $part['id_post'])
					{
						//Собираем объект Продукт для добавления в БД
						$product = new stdClass;
						$variants = array();
						$product_categories = array();
						$options = array();
						
						$product->name = $part['name'];
						$product->visible = true;
						//$product->featured = false;
						$product->brand_id = $part['id_brand']; 

						$product->url = trim($part['name_pars']);
						$product->meta_title = $part['name'];
						$product->meta_keywords = $part['name'];
						$product->meta_description = "Наручные часы " . $part['name'];
						
						$product->annotation = '';
						$product->body = '';
						
						$variants[0]->sku = $part['id_post'];
						$variants[0]->price = $part['price'];
						$variants[0]->price_post = $part['price_post'];
						$variants[0]->id_post = $part['id_post'];
						
						//Собираем Категории товара для дальнейшего использования
						$product_categories = $part['categories'];
						
						$pc = array();
						if(is_array($product_categories))
						{
							foreach($product_categories as $c)
							{
								$x = new stdClass;
								$x->id = $c;
								$pc[] = $x;
							}
							$product_categories = $pc;
							
						}

						//Собираем Свойства товара для дальнейшего использования
						$options =  $part['options'];
						$po = array();
						if(is_array($options))
						{
							foreach($options as $f_id=>$val)
							{
								$po[$f_id] = new stdClass;
								$po[$f_id]->feature_id = $f_id;
								$po[$f_id]->value = $val;
							}
							$options = $po;
						}
									
						//ДОБАВЛЕНИЕ
						// Не допустить пустое название товара.
						if(empty($product->name))
						{			
							$this->design->assign('message_error', 'empty_name');
							if(!empty($product->id))
								$images = $this->products->get_images(array('product_id'=>$product->id));
						}
						// Не допустить одинаковые URL разделов.
						elseif(($p = $this->products->get_product($product->url)) && $p->id!=$product->id)
						{			
							$this->design->assign('message_error', 'url_exists');
							if(!empty($product->id))
								$images = $this->products->get_images(array('product_id'=>$product->id));
						}
						else
						{	//Если всо ОК добавляем все в БД
							if(empty($product->id))
							{
								$product->id = $this->products->add_product($product);
								$product = $this->products->get_product($product->id);
								$this->design->assign('message_success', 'added');
								
								
								if($product->id)
								{
									
									//Загрузка картинки и добавление урла в БД
									$dir_to = $this->config->root_dir.$this->config->original_images_dir;
										
									copy($part['images_av'],$dir_to. $part['images'] );
									$this->products->add_image($product->id, $part['images']);
									
								    //Категории товара
									$query = $this->db->placehold('DELETE FROM __products_categories WHERE product_id=?', $product->id);
									$this->db->query($query);
									
									if(is_array($product_categories))
									{
										foreach($product_categories as $i=>$category)
											$this->categories->add_product_category($product->id, $category->id, $i);
									}
									
									//Свойства текущей категории
									$category_features = array();
									foreach($this->features->get_features(array('category_id'=>$product_categories[0])) as $f)
										$category_features[] = $f->id;
									
									//Добавляем свойства
									if(is_array($options))
									foreach($options as $option)
									{
										if(in_array($option->feature_id, $category_features))
											$this->features->update_option($product->id, $option->feature_id, $option->value);
									}
												
									//Добавляем Варианты
									if(is_array($variants))
									{
										$variant = $variants[0];
										$variant->product_id = $product->id;
										$variant->id = $this->variants->add_variant($variant);
																
										$variant = $this->variants->get_variant($variant->id);
										
									}
								}
							}
						} //добавление
						
					} //if если нужный id для добавления
					
				}
			}
		}
		
		if ($this->request->post('id_del') ) { //если есть выбранные чекбоксы для удаления
			foreach ($this->request->post('id_del') as $id_post) {
				//найдем те продукты которые нужно убрать
				
				$variants = $this->variants->get_variants(array('id_post'=>$id_post));
					
				foreach ($variants as $var) {
					//$this->products->update_product($var->product_id, array('visible'=>0));
					$this->variants->update_variant($var->id, array('stock'=>0));
				}
			}
		}
		
		
		if ($this->request->post('id_vis') ) { //если есть выбранные чекбоксы для возврата
			foreach ($this->request->post('id_vis') as $id_post) {
				//найдем те продукты которые нужно вернуть
				
				$variants = $this->variants->get_variants(array('id_post'=>$id_post));
				
				foreach ($variants as $var) {
					//$this->products->update_product($var->product_id, array('visible'=>1));
					$this->variants->update_variant($var->id, array('stock'=>null));
				}
			}
		}
		
		//подготовим массив строк изменений
		if ($this->request->post('change_str') ) {
			$change_str_arr = $this->request->post('change_str');
		}
		if ($this->request->post('id_ch') ) { //если есть выбранные чекбоксы для Изменения
			foreach ($this->request->post('id_ch') as $id_post) {

				//получим строку кодов изменений свойств
				$change_str = $change_str_arr[$id_post];
				
				$variants = $this->variants->get_variants(array('id_post'=>$id_post));

				foreach ($variants as $var) {
					
					//найдем те поля которые будем менять
					foreach ($products as $prod ) {
						if ($var->id_post == $prod['id_post'])
						{						
							$change = explode("|", $change_str);
							array_pop($change);

							$variants = $this->variants->get_variants(array('id_post'=>$id_post));
							//пока апдейтим постоянно, потом можно проверку ввести
							$this->products->update_product($var->product_id, array('name'=>$prod['name']));
							$this->variants->update_variant($var->id, array('price'=>$prod['price'],'price_post'=>$prod['price_post']));
							if ($dop_proverka) {
								$options = array();
								
								if(in_array('sex', $change)){
									$f_id = 159;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['sex'];						
								}
								
								if(in_array('wtr', $change)){
									$f_id = 161;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['water_resist'];
								}
								
								if(in_array('hod', $change)){
									$f_id = 177;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['hod'];
								}
								
								if(in_array('mcase', $change)){
									$f_id = 166;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['material_case'];
								}
								
								
								if(in_array('mech', $change)){
									$f_id = 160;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['mechanism'];
								}
								
								
								if(in_array('count', $change)){
									$f_id = 165;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['country'];
								}
								
								if(in_array('gls', $change)){
									$f_id = 162;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['glass'];
								}
								
								if(in_array('brc', $change)){
									$f_id = 176;
									$options[$f_id] = new stdClass;
									$options[$f_id]->feature_id = $f_id;
									$options[$f_id]->value = $prod['bracelet'];
								}
								
								
								//Свойства текущей категории
								$category_features = array();
								foreach($this->features->get_features(array('category_id'=>$product_categories[0])) as $f)
								$category_features[] = $f->id;
									
								//Добавляем свойства
								if(is_array($options))
								foreach($options as $option)
									{
										if(in_array($option->feature_id, $category_features))
										{
											//echo "update:".$var->product_id." - ".$option->feature_id." - ".$option->value."<br>";
											$this->features->update_option($var->product_id, $option->feature_id, $option->value);
										}
									}

							}
						}
					}
					
				}
			}
		}
		
		$this->design->assign('products', $products );
		}//else is POST
		else
		{			
			//если нет POST собираем массивы для выдачи в шаблон администратору (информация об экспорте)
			
			$variants_bd = $this->variants->get_variants(array('product_id'=>null)); //Получить все варианты из БД
			
			//Получить массив на добавление
			$products_add = array();
			$products_is = array(); //соберем массив который будем использовать для обнаружения удаленных и вновь появившихся товаров
			$products_change = array(); // массив изменений
			$i=0; $j=0; $v=0;
			foreach ($products as $prod ) {
				$isVariandDb = false;
				foreach ($variants_bd as $var) {
					if ($var->id_post == $prod['id_post'])
					{
						$isVariandDb = true;
						$var_visble = $var; //Вариант для будущей обратки (сделать видимыми)
					}
				}
				if (!$isVariandDb) {
					//тест загрузки картинки
					$check_url = array('0');
					if ($prod['images_av'] != "") {
						$check_url = get_headers($prod['images_av']);
					}
					if (strpos($check_url[0],'200')) {
						$products_add[$i] =  $prod; $i++;
					} else
					{
						
					}
				} else
				{					
					$variants_is[$j] =  $var_visble; //варианты что есть в БД и в продукте
					
					//соберем массив изменений по некоторым полям
					$prodBd = $this->products->get_product_var($var_visble);
					//Объект свойств
					$options = $this->features->get_options(array('product_id'=>$var_visble->product_id));//,'feature_id' => 159));
					$opt = array();
					foreach ($options as $option) {
						if($option->feature_id == 169 ) $opt['show_time'] = $option->value;
						//if($option->feature_id == 164 ) $opt['style'] = $option->value;
						if($option->feature_id == 170 ) $opt['backlight'] = $option->value;
						if($option->feature_id == 163 ) $opt['shockproof'] = $option->value;
						if($option->feature_id == 171 ) $opt['case'] = $option->value;
						if($option->feature_id == 166 ) $opt['material_case'] = $option->value;
						if($option->feature_id == 172 ) $opt['color_case'] = $option->value;
						if($option->feature_id == 168 ) $opt['material_bracelet'] = $option->value;
						if($option->feature_id == 173 ) $opt['color_bracelet'] = $option->value;
						if($option->feature_id == 174 ) $opt['color_dial'] = $option->value;
						if($option->feature_id == 175 ) $opt['number'] = $option->value;
						if($option->feature_id == 167 ) $opt['additional'] = $option->value;
						if($option->feature_id == 160 ) $opt['mechanism'] = $option->value;
						if($option->feature_id == 176 ) $opt['bracelet'] = $option->value;
						if($option->feature_id == 161 ) $opt['water_resist'] = $option->value;
						if($option->feature_id == 162 ) $opt['glass'] = $option->value;
						if($option->feature_id == 177 ) $opt['hod'] = $option->value;
						if($option->feature_id == 159) $opt['sex'] = $option->value;
						if($option->feature_id == 165) $opt['country'] = $option->value;						
					}
					
					//Собираю строки что бы сравнить свойства в БД и выгрузке
					$opt_str = $opt['show_time']. ' | ' . $opt['style']. ' | ' . $opt['backlight']. ' | ' . $opt['shockproof']. ' | ' . $opt['case']. ' | ' . $opt['material_case']. ' | ' . $opt['color_case']. ' | ' . $opt['material_bracelet']. ' | ' . $opt['color_bracelet']. ' | ' . $opt['color_dial']. ' | ' . $opt['number']. ' | ' . $opt['additional']. ' | ' . $opt['mechanism']. ' | ' . $opt['bracelet']. ' | ' . $opt['water_resist']. ' | ' . $opt['glass']. ' | ' . $opt['hod']. ' | ' . $opt['sex'] . ' | ' . $opt['country'];
					$opt_str_prod = $prod['show_time']. ' | ' . $prod['style']. ' | ' . $prod['backlight']. ' | ' . $prod['shockproof']. ' | ' . $prod['case']. ' | ' . $prod['material_case']. ' | ' . $prod['color_case']. ' | ' . $prod['material_bracelet']. ' | ' . $prod['color_bracelet']. ' | ' . $prod['color_dial']. ' | ' . $prod['number']. ' | ' . $prod['additional']. ' | ' . $prod['mechanism']. ' | ' . $prod['bracelet']. ' | ' . $prod['water_resist']. ' | ' . $prod['glass']. ' | ' . $prod['hod']. ' | ' . $prod['sex'] . ' | ' . $prod['country'];
					
					
					//echo $var_visble->product_id." -  Есть: ".$opt['sex']."   -  Будет:".$prod['sex']."<br>";
					
					$change_str = ''; //Изменения
					//$change_str  используется для вывода в кратком виде что поменялось, плюс потом передается по пост и обрабатывается, что бы понять какие именно свойства менять
					//ниже задаются краткие описания
					$isChange = false;
					if ($prodBd['price_post'] != $prod['price_post'] )
					{
						$isChange = true;
						$change_str = $change_str . 'prp|';
					}
					if ($prodBd['price'] != $prod['price'] )
					{
						$isChange = true;
						$change_str = $change_str . 'pr|';
					}
					if ($prodBd['name'] != $prod['name'] )
					{
						$isChange = true;
						$change_str = $change_str . 'nm|';
					}
					
					if ($dop_proverka) {
						
						if ($opt['water_resist'] != $prod['water_resist'] )
						{
							$isChange = true;
							$change_str = $change_str . 'wtr|';
						}
						
						if ($opt['hod'] != $prod['hod'] )
						{
							$isChange = true;
							$change_str = $change_str . 'hod|';
						}
						
						// Смотрим только было ли поле пустое, т.к. пол, могли поменять руками в админке
						if ($opt['sex'] != $prod['sex'] && $opt['sex']=="")
						{
							$isChange = true;
							$change_str = $change_str . 'sex|';
						}
						
						if ($opt['material_case'] != $prod['material_case'] )
						{
							$isChange = true;
							$change_str = $change_str . 'mcase|';
						}
						if ($opt['mechanism'] != $prod['mechanism'] )
						{
							$isChange = true;
							$change_str = $change_str . 'mech|';
						}
						if ($opt['bracelet'] != $prod['bracelet'] )
						{
							$isChange = true;
							$change_str = $change_str . 'brc|';
						}
						if ($opt['glass'] != $prod['glass'] )
						{
							$isChange = true;
							$change_str = $change_str . 'gls|';
						}
						
						if ($opt['country'] != $prod['country'] )
						{
							$isChange = true;
							$change_str = $change_str . 'count|';
						}
					}
					
					/*
					if ($opt_str_prod   != $opt_str )
					{
						
					    //Для тестов
						if ($v<0) {
							echo $var_visble->id_post.' В базе &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:'.$opt_str.'<br>';
							echo $prod['id_post'].' В выгрузке:'.$opt_str_prod.'<br><br>';
						$v++;}
						$isChange = true;
						$change_str = $change_str . 'op|';
						
					}
					*/
					
					/*if (strtoupper($prodBd['brand']) != strtoupper($prod['brand']) )
					{
						$isChange = true;
						$change_str = $change_str . 'br|';
					}*/
					if ($isChange) {
						//Добавим строки свойств
						$prod['change_options_str'] = $opt_str_prod;
						$prodBd['change_options_str'] = $opt_str;
						
						$products_change[$j] = $prod; //выгрузка
						$products_change[$j]['change'] = $prodBd; //в БД
						$products_change[$j]['change_str'] = $change_str;
					}
					$j++;
				}
			}
			
			//Получить массив на те, что нужно сделать видимыми (появились в выгрузке)
			$i=0;
			$products_vis = array();

			foreach ($variants_is as $var ) {
				$prod = $this->products->get_product_var($var);
				if ($var->stock == 0) {
					//Создаем строку массива для вывода "видимости"
					$products_vis[$i] = $prod; $i++;
				}
			}
			
			//Получить массив на удаление (убрать из наличия)
			$isProduct = bool; $i=0;
			$products_del = array();
			foreach ($variants_bd as $var ) {
				$isProduct = false;
				
				foreach ($products as $prod ) {
					if ($var->id_post == $prod['id_post'])
					{
						$isProduct = true;
					}
				}

				$prod = $this->products->get_product_var($var);
				if (!$isProduct and $prod['id_post'] !=0 and $var->stock == 30 /*$prod['visible'] == 1*/) { //id_post !=0  не добавлено из админки (отбрасываем что из админки создано)
					//Создаем строку массива для вывода "удаления"
					$products_del[$i] =  $prod; $i++;
				}
			}
			
			//передаим в шаблон все это барахло
			$this->design->assign('products', $products );
			$this->design->assign('products_add', $products_add );
			$this->design->assign('products_vis', $products_vis );
			$this->design->assign('products_del', $products_del );
			$this->design->assign('products_change', $products_change );
			$this->design->assign('output_count', $output_count );			
		}
		
/*
		// так можно лезть в базу:
		$query = $this->db->placehold("SELECT NOW() tttime"); // так готовится запрос, примеры смотри в любом файле в папке Api
		$this->db->query($query); // так он выполняется
		$result = $this->db->result(); // так получаем результат, если вернулась одна строка, и в $result у тебя объект
		//$result = $this->db->result(); // а так если вернулось много строк, в итоге у тебя массив объектов
		
		// Можем передать результат запроса к базе в шаблон
		$this->design->assign('result', $result);
		
		// Что бы получит данные по submit формы методом POST делай так
		$a = $this->request->post('login', 'integer'); // где login это переданный из формы <input name="login"...>
		// Аналогично кажется и с GET

		// Дальше тебе понадобится работа с товаром, за это отвечает Api/Products.php и Api/Variants.php
		// Изучи функции в них
		// Например что бы удалить продукт, в Api/Products.php есть функция delete_product($id) и работает так:
		
		$this->products->delete_product(999999999); // специально поставил не существующий айди продукта, что бы ниче не удалить
		
		// у любого товара есть варианты, даже если он один, то он один и хранится в таблице s_variants
		// и цена хранится там же... тоесть поменять цену товара можно так:
		
		$this->variants->update_variant(99999999, array('price'=>100)); // ВНИМАНИЕ тут указывается не ID продукта, а ID варианта!
		
		// тобишь что бы поменять цену у продукта, зная его айди, тебе нужно сначала получить его вариант(ы)
		
		$variants = $this->variants->get_variants(array('product_id'=>999999));
		// далее перебрать варианты
		foreach ($variants as $variant) {
			//и уже менять цену
			$this->variants->update_variant($variant->id, array('price'=>100));
		}
*/
			
  	  	return $this->design->fetch('avangard.tpl');
	}
	
}


<?php
require_once('api/Simpla.php');
/*
Функция возвращает строку выгрузки

code Уникальный артикул товара
folder_id ID папки товара name Наименование товара
size Размер часов photo Ссылка на фотографию с водным знаком price Оптовая базовая цена
url Адрес товара нс сайте Аванграда
folder_alias Иерархия синонимов папки (разделитель — "/")
folder_name Иерархия имен папки (разделитель — "/")
attributes Свойства товара в html-формате
*/

function get_avangard_products($login, $password) {
	$url = 'http://api.avangard-time.ru/products/';
	$crlf = "\r\n";
	$parts = parse_url($url);
	$path = $parts['path'];
	$scheme = 'http';
	if (isset($parts['scheme']) && ($parts['scheme']=='http' || $parts['scheme']=='https'))
		$scheme = $parts['scheme'];
	$host = $parts['host'];
	$ssl = $scheme=='https' ? TRUE : FALSE;
	$port = isset($parts['port']) ? intval($parts['port']) : ($ssl ? 443 : 80);
	if (isset($parts['query']))
		$path .= '?'.$parts['query'];
	$timeout = 25;

	$errno = 0;
	$errstr = NULL;
	$h = @fsockopen(($ssl?'ssl://':'').$host, $port, $errno, $errstr, $timeout);
	if (!is_resource($h))
		return FALSE;
	if (function_exists('stream_set_timeout'))
		stream_set_timeout($h, $timeout);

	$content = 'login='.urlencode($login).'&password='.urlencode($password);
	$headers = array(
		'Host'				=> $host,
		'User-Agent'		=> 'API-requester',
		'Accept'			=> '*/*',
		'Connection'		=> 'close',
		'Content-Type'		=> 'application/x-www-form-urlencoded',
		'Content-Length'	=> strlen($content)
	);
	$request = 'POST '.$path.' HTTP/1.0';
	foreach ($headers as $key=>$value)
		$request .= $crlf.$key.': '.$value;
		
	$request .= $crlf.$crlf.$content;
	
	fputs($h, $request);

	$response = '';

	while (!feof($h))
		$response .= fgets($h);

	fclose($h);

	if (!preg_match('/^HTTP\/1\.0|1 ([0-9]+)/', $response, $r)) 
		return FALSE;

	$http_code = intval($r[1]);
	if ($http_code != 200)
		return FALSE;

	$body_at = strpos($response, $crlf.$crlf);
	if ($body_at===FALSE)
		return FALSE;
    
	return substr($response, $body_at+strlen($crlf)*2);
}

/*принимает респонс авангарда и массив списка совпадения по каталогам, например "naruchnie_chasi/casio"
возвращает двумерный массив
*/


function avangard_filter_and_pars($output,$list_cat) {
	$parts = str_getcsv($output,"\n");
	
	$product = array();
	$products = array();
	
	$i=0;
	foreach ($parts as $key=>$part) {
		
	$array_str = str_getcsv($part,";");
	
	
	$insert=false;
	foreach ($list_cat as $cat) {
		if (stripos($array_str[7],$cat)!== false /*and $array_str[5] > 1400*/) {
			$insert=true; $brand = explode("/",$array_str[7]);
		}
	}
	
	if ($insert) {
		
		$product['id_post'] = ltrim($array_str[0], '0');; //id поставщика
		$product['brand'] = strtoupper($brand[1]); //Бренд
		// фикс Q&Q
		if ($product['brand'] == 'Q_AMP_Q') {
			$product['categories'][0] = 16;
			$product['brand'] = 'Q&Q';
			$product['id_brand'] = 33;
			}
		if ($product['brand'] == 'VOSTOK') {
			$product['brand'] = 'Vostok';
			$product['categories'][0] = 17;
			$product['id_brand'] = 31;
		}
		
        $product['brand_s'] = strtoupper($brand[2]); //Серия
	
		
		if  ($product['brand'] == "CASIO") {
			$product['categories'][0] = 16; //Все Касио в категории Япоснкие часы
			
			$product['brand'] = "Casio";
			$product['id_brand'] = 32;
			$str_arr = explode(" ",$array_str[2]);
			$baby_g = array ('BA','BG','BGA','BGD');
			
			if(in_array($product['brand_s'],$baby_g)) {
				$product['brand'] = 'Casio Baby-G';
				$product['id_brand'] = 37;
			}
			$g_shock = array ('DW','G','GA','GB','GBA','GD','GF','GLS','GLX','GMA','GMD','GN','GST','GW','GWG','GWN','GWX');
			if(in_array($product['brand_s'],$g_shock )) {
				$product['brand'] = 'Casio G-Shock';
				$product['id_brand'] = 36;
			}
			$edifice = array ('EF','EFA','EFM','EFR','EMA','EQB','EQS','EQW','ERA');
			if(in_array($product['brand_s'],$edifice )) {
				$product['brand'] = 'Casio Edifice';
				$product['id_brand'] = 38;
			}
			
			$protrek = array ('PRG','PRW');
			if(in_array($product['brand_s'],$protrek )) {
				$product['brand'] = 'Casio Pro Trek';
				$product['id_brand'] = 40;
			}
		}
		
		$product['name_post'] = $array_str[2];
		
		if ($product['brand'] == "ORIENT") {
			$product['categories'][0] = 16;
			$product['brand'] = 'Orient';
			$product['id_brand'] = 34;
			$str_arr = explode(" ",$array_str[2]);
			$product['name'] = $product['brand'] . " " . $str_arr[0];
		} else
		{
			$iskl = array('GMA','GMD'); //Для фикса где в конце не стоит Бренд
			
			if (!in_array($product['brand_s'],array('GMA','GMD') ) ) {
				$str_arr = explode(" ",$array_str[2]);
				array_pop($str_arr);
				array_unshift($str_arr,$product['brand']);
				$product['name'] = implode(' ',$str_arr);
			}
			//фикс где в конце не стоит Бренд
			if (in_array($product['brand_s'],array('GMA','GMD') ) ) {
				$product['name'] = $product['brand'] . ' ' .$array_str[2];
			}
		}
		
		//$name_pars = str_ireplace("&","",$product['name']);
		
		$name_pars = preg_replace("/[&()]+/ui", '', $product['name']);	
		$name_pars = preg_replace("/[\s]+/ui", '-', $name_pars);	
		$product['name_pars'] = $name_pars; //Имя без пробелов и спец. символов
		
		// меняем имя после формирование ЧПУ для Восто на русское
		if ( $product['brand'] == 'Vostok'){
			$product['brand'] = 'Восток'; //mb_convert_encoding('Восток', 'utf-8', 'windows-1251');
			$product['name'] = str_ireplace("Vostok",$product['brand'],$product['name']);
		}
		
		//$product['url'] = $product['name_pars']; //ЧПУ	
		
		$product['images'] = $product['name_pars'].'.jpg'; //имя файла картинки
		$product['price_post'] = $array_str[5]; //цена поставщика
		
		$product['price'] = kw_good_price($product['price_post']); //Рекомендуемая цена
		
		//Свойства товара
		$product['size'] = $array_str[3];
		
		$product['show_time'] = $array_str[10]; //Отображение времени
		//Добавляем ID элемента из БД симплы + значение. Делается под Симплу.
		$product['options'][169] = $product['show_time'];
		
		$product['style'] = $array_str[11];
		$product['options'][164] = $product['style'];
		
		$product['backlight'] = $array_str[12]; //Подсветка
		$product['options'][170] = $product['backlight'];
		
		$product['shockproof'] = $array_str[13]; //Противоударные
		$product['options'][163] = $product['shockproof'];
		
		$product['case'] = $array_str[14]; //Форма корпуса
		$product['options'][171] = $product['case'];
		
		$product['color_case'] = $array_str[15]; //Цвет корпуса
		$product['options'][172] = $product['color_case'];
		
		$product['material_bracelet'] = $array_str[16]; //Материал браслета
		$product['options'][168] = $product['material_bracelet'];
		
		$product['color_bracelet'] = $array_str[17]; //Цвет браслета
		$product['options'][173] = $product['color_bracelet'];
		
		$product['color_dial'] = $array_str[18]; //Цвет циферблата
		$product['options'][174] = $product['color_dial'];
		
		$product['number'] = $array_str[19]; //Цифры
		$product['options'][175] = $product['number'];
		
		$product['strazy'] = $array_str[20]; //Стразы
		//$product['options'][174] = $product['strazy'];
		
		$product['bluetooth'] = $array_str[22]; //bluetooth
		//$product['options'][174] = $product['color_dial'];
		
		$product['additional'] = $array_str[23]; //Дополнительные функции
		$product['options'][167] = $product['additional'];
		
		$product['diving'] = $array_str[24]; //Для дайвинга и рыбалки
		//$product['options'][174] = $product['diving'];
		
		$product['mechanism'] = $array_str[27]; //Тип механизма
		$product['options'][160] = $product['mechanism'];
		
		$product['bracelet'] = $array_str[28]; //Ремешок/Браслет
        $product['options'][176] = $product['bracelet'];
		
		$product['material_case'] = $array_str[29]; //Материал корпуса
		$product['options'][166] = $product['material_case'];
		
		$product['water_resist'] = $array_str[30]; //Водозащита
		$product['options'][161] = $product['water_resist'];
		
		$product['glass'] = $array_str[31]; //Стекло
		$product['options'][162] = $product['glass'];
		
		$product['hod'] = $array_str[32]; //Ход
		$product['options'][177] = $product['hod'];
		
		$product['sex'] = $array_str[35]; //Пол
		$product['options'][159] = $product['sex'];

		$str = $product['sex'];
		$str2= 'мужские'; //mb_convert_encoding('мужские', 'utf-8', 'windows-1251');
		$str3= 'женские'; //mb_convert_encoding('женские', 'utf-8', 'windows-1251');
		$str4= 'unisex'; //mb_convert_encoding('unisex', 'utf-8', 'windows-1251');
		switch ($product['sex']) {
			case $str2:
				$product['categories'][1] = 21; //Добавляем категорию Мужские часы
				break;
			case $str3:
				$product['categories'][1] = 24; //Добавляем категорию Женские часы
				break;
			case $str4:
				$product['categories'][1] = 25; //Унисекс
				break;
			}
		
		$product['country'] = $array_str[36]; //Страна
		$product['options'][165] = $product['country'];
		
		$product['images_av'] = $array_str[4]; //url картинки от поставщика
		//$product['name_post'] = $array_str[2];
		
		if ($product['price'] <= 12000) {
			$products[$i] = $product;
			$i++;
		}
		//copy($array_str[4],"photos/" . $product['photo'] );
		
		//if ($i>100) break; //Ограничитель объема вывода
		}
	}
	
	return $products;
}


function kw_good_price($price) {
	
	if ($price < 1000) {
		$price = $price + 1000;
	} else
	{
		$price = $price * 2;
	}
	
	$price = ceil($price/10) * 10;
	
	return $price;
}


//отдает заголовки массива
function get_header_products($product) {
	$header = array();
	foreach ($product as $key=>$part) {
		$header[$key] = $key;
	}
	return $header;
}



?>
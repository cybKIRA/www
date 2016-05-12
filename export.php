<?php

/**
 * Simpla CMS
 *
 * @author 		Yuriy Petunin
 *
 * Класс для экспорта содержимого каталога
 *
 */
 
require_once('api/Simpla.php');

class ExportCataloge extends Simpla
{
	private $hash = 'c5a4d94044f647d94dec24f5a77d54e4'; // HASH-ключ для доступа к выгрузкам
	
	function CallCenterExport() {
		// GET-Параметры
		$hash = $this->request->get('hash', 'string');

		// проверка хэша, если не совпадает, то заканчиваем выполнение
		if ($hash != $this->hash)
			return "Не верно указан токен-ключ!";
		
		
		/** Include PHPExcel */
		require_once 'classes/PHPExcel.php';
		$objReader = PHPExcel_IOFactory::createReader('Excel2007');
		$objPHPExcel = $objReader->load("files/uploads/Catalogue.xlsx");
				
		// Все товары
		$products = array();
 		foreach($this->products->get_products(array('visible' => 1)) as $p)
 		{
 			$products[$p->id] = (array)$p;
 			
	 		// Свойства товаров
	 		$options = $this->features->get_product_options($p->id);
	 		foreach($options as $option)
	 		{
	 			if(!isset($products[$option->product_id]['options'][$option->name]))
					$products[$option->product_id]['options'][$option->name] = str_replace(',', '.', trim($option->value));
	 		}

 			
 		}
 		
 		if(empty($products))
 			return false;
 		
 		// Категории товаров
 		foreach($products as $p_id=>&$product)
 		{
	 		$categories = array();
	 		$cats = $this->categories->get_product_categories($p_id);
	 		foreach($cats as $category)
	 		{
	 			$path = array();
	 			$cat = $this->categories->get_category((int)$category->category_id);
	 			if(!empty($cat))
 				{
	 				// Вычисляем составляющие категории
	 				foreach($cat->path as $p)
	 					$path[] = str_replace($this->subcategory_delimiter, '\\'.$this->subcategory_delimiter, $p->name);
	 				// Добавляем категорию к товару 
	 				$categories[] = implode('/', $path);
 				}
	 		}
	 		$product['category'] = implode(', ', $categories);
 		}
 		
 		// Изображения товаров
 		$images = $this->products->get_images(array('product_id'=>array_keys($products)));
		$img_dir = 'http://kupi.watch/files/originals/';
 		foreach($images as $image)
 		{
 			// Добавляем первое изображение к товару
 			if(empty($products[$image->product_id]['images']))
 				$products[$image->product_id]['images'] = $img_dir.$image->filename;
 		}
 
 		$variants = $this->variants->get_variants(array('product_id'=>array_keys($products)));

		foreach($variants as $variant)
 		{
 			if(isset($products[$variant->product_id]))
 			{
	 			$v                    = array();
	 			$v['variant']         = $variant->name;
	 			$v['price']           = $variant->price;
	 			$v['compare_price']   = $variant->compare_price;
	 			$v['sku']             = $variant->sku;
	 			$v['stock']           = $variant->stock;
	 			if($variant->infinity)
	 				$v['stock']           = '';
				$products[$variant->product_id]['variants'][] = $v;
	 		}
		}	
		
		$row = 2;		
		foreach ($products as $p) {
			$options = '';
			if (isset($p['options']) && !empty($p['options'])) {
				foreach($p['options'] as $o => $ov) {
					$options .= $o.": ".$ov."; ";
					$options = trim($options);
				}
			}
			if (isset($p['variants']) && !empty($p['variants'])) {
				foreach ($p['variants'] as $v) {
					$objPHPExcel->getActiveSheet()->setCellValue('A'.$row, $p['id'])
												  ->setCellValue('B'.$row, trim($p['name'].' '.$v['variant']))
												  ->setCellValue('C'.$row, $v['price'])
												  ->setCellValue('D'.$row, (empty($v['stock']) ? 'да':$v['stock']))
												  ->setCellValue('E'.$row, $p['images'])
												  ->setCellValue('F'.$row, $p['brand'])
												  ->setCellValue('G'.$row, $options)
												  ->setCellValue('H'.$row, 'http://kupi.watch/products/'.$p['url'])
												  ->setCellValue('I'.$row, $p['meta_description']);
					$objPHPExcel->getActiveSheet()->getCell('E'.$row)->getHyperlink()->setUrl($p['images']);
					$objPHPExcel->getActiveSheet()->getCell('H'.$row)->getHyperlink()->setUrl('http://kupi.watch/products/'.$p['url']);
					$row++;
				}
			}
		}
		
		/*
		echo "<pre>";
		var_dump($products);
		echo "</pre>";
		exit;
		*/
		
		header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
		header('Content-Disposition: attachment;filename="CallCenterExport_'.date('Y-m-d').'.xlsx"');
		header('Cache-Control: max-age=0');
		header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
		header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT'); // always modified
		header ('Pragma: public'); // HTTP/1.0

		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');		
		//$objWriter->save('php://output');	
		$this->SaveViaTempFile($objWriter);
		exit;	
			
		return "CallCenterExport";
	}

	private function SaveViaTempFile($objWriter){
		$filePath = '' . rand(0, getrandmax()) . rand(0, getrandmax()) . ".tmp";
		$objWriter->save($filePath);
		readfile($filePath);
		unlink($filePath);
	}	
	
}

$view = new ExportCataloge();

// Что будем выгружать?
$url = $view->request->get('url', 'string');	

if (strtolower($url) == 'callcenterexport')
	echo $view->CallCenterExport();
else 
	echo 'Не верно указана функция экспорта';

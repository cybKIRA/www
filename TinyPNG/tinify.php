#!/usr/bin/php
<?php

// Проверяем, скрипт должен быть запущет только в режиме CLI
if (php_sapi_name() != 'cli')
	die("Запуск скрипта возможен только из командной строки!");

// Если параметры не переданы или есть параметр вызхов хелпа, то отображаем его и завершаем работу скрипта
/*if ($argc < 2 || in_array($argv[1], array('--help', '-help', '-h', '-?')))  {
	echo "Консольный PHP-скрипт квантирование изображений с помощью сервиса TinyPNG.".PHP_EOL;
	echo PHP_EOL;
	echo "Использование: $argv[0] <path>".PHP_EOL;
	echo "	<path> Путь к каталогу с изображениями относительно расположения данного скрипта".PHP_EOL;
	echo "	--help, -help, -h или -? покажут текущую справочную информацию.".PHP_EOL;
	echo PHP_EOL;
	echo "Для работы скрипта необходимы API ключи, поулчить можно на сайте сервиса http://tinypng.com".PHP_EOL;
	echo "Ключи должны располагаться в файле keys.txt в одном каталоге со скриптом. Каждый ключ отдельной строкой в файле!".PHP_EOL;
	echo PHP_EOL;
	exit;
}*/

//путь по умолочанию
//if (!isset($argv[1])) {$argv[1] = "../files/products";}
//if (!isset($argv[1])) {$argv[1] = "../files/originals";}

$path_log = __DIR__ . '/tinify_log.txt';
$str = "\n".'Start: '.date("H:i:s");

$file_log = fopen($path_log,"a+") or die("err");
fwrite($file_log,$str."\n");


// Подключаем класс для работы с сервисом TinyPNG
require_once("TinyPNG.php");

// Каталог, в котором будем работать
$tinydir = __DIR__ . "/".$argv[1];
fwrite($file_log,$tinydir."\n");
//echo "Каталог: ".$tinydir;
// Размер картинки, которую надо обработать
$image_size = isset($argv[2]) ? intval($argv[2]) : 0;  

// Проверяем рабочий каталог что он каталог
if(!is_dir($tinydir)) {
	fwrite($file_log,"Не верно указан каталог для работы в качестве обязательного параметра: \nПуть к ".$argv[1]." не найден!" . PHP_EOL . PHP_EOL);
	die("Не верно указан каталог для работы в качестве обязательного параметра: \nПуть к ".$argv[1]." не найден!" . PHP_EOL . PHP_EOL);
	}

// Проверяем существования .tinypng в папке где будем работать
if (file_exists($tinydir.'/.tinypng')) {  
	// Если есть и это НЕ каталог (а значит файл) то, удаляем файл и создаем каталог
	if(!is_dir($tinydir.'/.tinypng')) { 
		unlink($tinydir.'/.tinypng');
		mkdir($tinydir.'/.tinypng');
	} 
} else {
	// ... иначе, просто создаем каталог
	mkdir($tinydir.'/.tinypng');
}

// Если файла с ключами нет, заканчиваем работу с ошибкой
$key_path = __DIR__ . '/keys.txt';
if (!file_exists($key_path))
{
	fwrite($file_log,"Не найден файл keys.txt с API ключами" . PHP_EOL . PHP_EOL);
	die("Не найден файл keys.txt с API ключами" . PHP_EOL . PHP_EOL);
}
// Читаем ключи из файла в массив
$keys = file($key_path);
$lineskey = array();
// Перебираем массив и "чистим" ключи
foreach ($keys as $k=>$v) {
	if (trim($v))
		$lineskey[] = trim($v);	
}

// По умолчанию берем первый ключ в массиве
$key = 0;

// Если ключей в массиве нет, заказчиваем работу с ошибкой
if (empty($lineskey)) {
	fwrite($file_log,"Не найдено не одного API ключа в файле keys.txt" . PHP_EOL . PHP_EOL);
	die("Не найдено не одного API ключа в файле keys.txt" . PHP_EOL . PHP_EOL);
	}

// Массив разрешенных расширений файлов
$extension = array('jpg','jpeg','png');

$tinypng = new TinyPNG();

// Устанавливаем первый ключ из файла
$tinypng->setKey($lineskey[$key]);

$count = 0; // Общее кол-во найденных файлов удовлетворяющих условию
$quant = 0; // Кол-во файлов прошедших квантирование 

// Читаем каталог...
if ($handle = opendir($tinydir)) {
	// Сюда будем писать лог
	$log_name = __DIR__ . "/log_".date("Ymd_His").".csv";
	$log = fopen($log_name, "w");	
	// Рисуем заголовок полей лога 
	fwrite($log, "Time;Status;ErrorText;FileName;SizeInput;SizeOutput;Ratio;Key"."\n");
    while (false !== ($entry = readdir($handle))) {
        if ($entry != "." && $entry != "..") {
			// Получаем разширение файла
			$ext = mb_strtolower(pathinfo($tinydir."/".$entry, PATHINFO_EXTENSION));
			// Если расширение соответствует разрешенному в массиве, то берем этот файл
			if (in_array($ext, $extension)) {
				$tiny_size = null; // "Квантовый" размер (размер изображения после квантования) обнуляем для текущего файла
				// Ищем файл с квантовым размером файла, если он есть, берем из него размер
				if (file_exists($tinydir."/.tinypng/".$entry.'.tiny')) {
					$tmp_file_size = file($tinydir."/.tinypng/".$entry.'.tiny');
					$tiny_size = $tmp_file_size[0]; // Это тот размер файла, который был записан после квантования изображения
				}				
				// Если квантовый размер пуст или НЕ РАВЕН текущему размеру файла, то необходимо квантование!
				if ((empty($tiny_size) ||  $tiny_size != filesize($tinydir."/".$entry)) && filesize($tinydir."/".$entry) > $image_size) {
					$status = false; // изначально статус FALSE
					// Квантовать будем из цикла, что бы повторять попытку, пока не получим статус TRUE
					while ($status == false) {
						$tinyImage = $tinypng->compress($tinydir."/".$entry, $tinydir."/".$entry);
						// Если в ответе есть линк на файл, то значит квантование прошло удачно
						if (isset($tinyImage['output']['url'])) {
							// Создадим файл в .tinypng и запишем в него размер изображения после квантования
							$tinyfile = fopen($tinydir."/.tinypng/".$entry.'.tiny', "w");
							fwrite($tinyfile, $tinyImage['output']['size']);
							fclose($tinyfile);
							$status = true; // Статус !!!
							// Запишем в лог результат
							fwrite($log, date("Y-m-d H:i:s").";OK;;".$tinydir."/".$entry.";".$tinyImage['input']['size'].";".$tinyImage['output']['size'].";".$tinyImage['output']['ratio'].";".$lineskey[$key]."\n");
							$quant++;
						} else {
							// .. иначе, если квантование не удалось, то пишем лог
							$error = str_replace(";","",(isset($tinyImage['error']) ? $tinyImage['error'].' '.$tinyImage['message'] : ''));
							fwrite($log, date("Y-m-d H:i:s").";ERROR;".$error.";".$tinydir."/".$entry.";;;;".$lineskey[$key]."\n");
							// Берем следующий ключ
							$key++;
							// Если элемента в массиве ключей не существует или он пуст, то заканчиваем работу с сообщением
							if (!isset($lineskey[$key]) || empty($lineskey[$key])) {
								fclose($log); // закрываем файл с логом
								die("API ключи в файле keys.txt закончились! Смотрите лог $log_name" . PHP_EOL . PHP_EOL);
							}
							// Устанавливаем ключ для класса TinyPNG
							$tinypng->setKey($lineskey[$key]); // и далее начинаем с начала цикла...
						}
						
					}	
				}
				$count++;
			}
        }
    }
	fclose($log);
    closedir($handle);
}

// Мы не прочитали не одного файла, то удаляем CSV и заканчиваем работу с сообщением
if ($count == 0) {
	unlink($log_name);
	fwrite($file_log,"Не найдено не одного файла для квантования!"."\n");
	die("Не найдено не одного файла для квантования!" . PHP_EOL . PHP_EOL);
}

// Выводим информацию по работе скрипта
echo "Найдено изображений в каталоге: ".$count.PHP_EOL;
fwrite($file_log,"Найдено изображений в каталоге: ".$count."\n");
echo "Файлов для квантования: ".$quant.PHP_EOL;
fwrite($file_log,"Файлов для квантования: ".$quant."\n");

// Если не было не одного квантирования, то удаляем лог и не выводим сообщение
if ($quant == 0) 
	unlink($log_name);
else
{
	echo "Лог работы можно посмотреть в файле: ".$log_name.PHP_EOL;
	fwrite($file_log,"Лог работы можно посмотреть в файле: ".$log_name."\n");
	}
echo PHP_EOL;

$str = 'End: '.date("H:i:s");
fwrite($file_log,$str ."\n");
fclose($file_log);// Закрыть файл лога
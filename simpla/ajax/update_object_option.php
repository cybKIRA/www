<?php
// mcbronx  24/05/2016 Апдейт для определенных свойств
session_start();

require_once('../../api/Simpla.php');

$simpla = new Simpla();

// Проверка сессии для защиты от xss
if(!$simpla->request->check_session())
{
	trigger_error('Session expired', E_USER_WARNING);
	exit();
}

$object = $simpla->request->post('object');
$id = intval($simpla->request->post('id'));
$state = $simpla->request->post('state');
$value = $simpla->request->post('value');

switch ($object)
{
    case 'option_style':
    	if($simpla->managers->access('products'))
		{
			//$options = $simpla->features->get_product_options($id);
		}
        break;
}

header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");		
$json = json_encode($result);
print $json;
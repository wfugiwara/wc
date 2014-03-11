<?php
include("dados.php");
include("loja5.php");
$url_web = BraspagTipo($config->get('braspagapi_ambiente'));
$soap_opt['encoding']    = 'UTF-8';
$soap_opt['trace']           = true;
$soap_opt['exceptions'] = true;
$soap_client = new SoapClient($url_web, $soap_opt);
$request['merchantId'] = $config->get('braspagapi_chave');
$request['orderId'] = '1040';
$res = $soap_client->DisableOrder($request);
print_r($res);
?>
<?php
include("dados.php");
include("../app/braspag/loja5.php");
if(!isset($_SESSION['braspagapi_email']) && !isset($_SESSION['braspagapi_id'])){
@header("Location: index.php");
}
//
$pedido_id = base64_decode($_GET['token']);
echo $pedido_id;
$dados_pedido = TotalPedidoBrasPag($pedido_id);
$url_web = BraspagTipo($config->get('braspagapi_ambiente'));
$soap_opt['encoding']    = 'UTF-8';
$soap_opt['trace']           = true;
$soap_opt['exceptions'] = true;
$soap_client = new SoapClient($url_web, $soap_opt);
$request['merchantId'] = $config->get('braspagapi_chave');
$request['orderId'] = $dados_pedido['order_id'];
$key1 = "GetOrderRecurrenciesResult";
$res = $soap_client->GetOrder($request);
print_r($res);
?>
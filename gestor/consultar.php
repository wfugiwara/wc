<?php
include("dados.php");
include("../app/braspag/loja5.php");
if(!isset($_SESSION['braspagapi_email']) && !isset($_SESSION['braspagapi_id'])){
@header("Location: index.php");
}
//
/*
$pedido_id = base64_decode($_GET['token']);
$dados_pedido = TotalPedidoBrasPag($pedido_id);
$url_web = BraspagTipo($config->get('braspagapi_ambiente'));
$soap_opt['encoding']    = 'UTF-8';
$soap_opt['trace']           = true;
$soap_opt['exceptions'] = true;
$soap_client = new SoapClient($url_web, $soap_opt);
$request['merchantId'] = $config->get('braspagapi_chave');
$request['orderId'] = $dados_pedido['order_id'];
$key1 = "GetOrderRecurrenciesResult";
$res = $soap_client->GetOrderRecurrencies($request);
print_r($res);
if(isset($res->GetOrderRecurrenciesResult->Code) && $res->GetOrderRecurrenciesResult->Code==0 && false==true){

if(sizeof($res->$key1->Recurrencies)>=1){
foreach($res->$key1->Recurrencies AS $key=>$raw){
if(isset($raw->Status)){
$mum_pag = $raw->RecurrencyNumber;
$status = $raw->Status;
$dados_item = DetalhesItemBrasPag($pedido_id,$mum_pag);
$msg = "Data Tentativa: ".$raw->RecurrencyDate."<br>Prox. Cobranca/Tentativa: ".$res->$key1->NextPaymentAttemptDate."<br>Mensagem: ".$raw->AcquirerMessage."<br>Status: ".$lista_de_status_braspag[$status]."";

if($status==0){
$pg = "SIM";
}else{
$pg = "NAO";
}

if($dados_item['statusPagamento']==$status){
$sql = "UPDATE `braspag_itens` SET `dadosPag` =  '".$msg."', `pago` =  '".$pg."' WHERE `idItem` ='".$dados_item['idItem']."';";
}else{
$sql = "UPDATE `braspag_itens` SET  `statusPagamento` =  '".$status."', `dadosPag` =  '".$msg."', `pago` =  '".$pg."' WHERE `idItem` ='".$dados_item['idItem']."';";
}
$db->query($sql);

}
}
}

}
//utimo status
$request = null;
$request['merchantId'] = $config->get('braspagapi_chave');
$request['orderId'] = $dados_pedido['order_id'];
$res2 = $soap_client->GetOrder($request);
if(isset($res2->GetOrderResult->Code) && $res2->GetOrderResult->Code==0){
$sql = "UPDATE `braspag_pedidos` SET  `statusPedido` =  '".$res2->GetOrderResult->Order->Status."' WHERE `idPedido` ='".$pedido_id."';";
$db->query($sql);
}
*/
echo "<script>location.href='detalhes.php?token=".$_GET['token']."';</script>";
?>
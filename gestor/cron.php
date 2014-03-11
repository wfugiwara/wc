<?php
include("dados.php");
include("../app/braspag/loja5.php");
//busca os pedidos de acordo com a regra
$fator = 60*60*24*5;//5 dias
$data_hoje = "%%/".date('m')."/".date('Y')."";
$sql = "SELECT UNIX_TIMESTAMP(STR_TO_DATE(p.dataDebito,'%d/%m/%Y')) AS tempoSegundos,p.* FROM `braspag_itens` AS p,`".DB_PREFIX."order` AS z WHERE p.idPedido=z.order_id AND pago = 'NAO' AND dataDebito LIKE '".$data_hoje." AND p.statusPagamento NOT IN(3,4,5)';";
$query = $db->query($sql);
$res = $query->rows;

//faz a listagm de pedidos de acordo a regra
foreach($res AS $linha){
//pega as consultas
$pedido_id = $linha['idPedido'];
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

//se retornou dados com sucesso
if(isset($res->$key1->Code) && $res->$key1->Code==0){

//caso tenha lista de recorrencias
if(sizeof($res->$key1->Recurrencies)>=1){
foreach($res->$key1->Recurrencies AS $key=>$raw){

$mum_pag = $raw->RecurrencyNumber;
$status = $raw->Status;
$dados_item = DetalhesItemBrasPag($pedido_id,$mum_pag);
$msg = "Data Tentativa: ".$raw->RecurrencyDate."<br>Prox. Cobranca/Tentativa: ".$res->$key1->NextPaymentAttemptDate."<br>Mensagem: ".$raw->AcquirerMessage."<br>Status: ".$lista_de_status_braspag[$status]."";
if($status==0){
$pg = "SIM";
}else{
$pg = "NAO";
}

//atualiza o item
if($dados_item['statusPagamento']==$status){
$sql = "UPDATE `braspag_itens` SET `dadosPag` =  '".$msg."', `pago` =  '".$pg."' WHERE `idItem` ='".$dados_item['idItem']."';";
}else{
$sql = "UPDATE `braspag_itens` SET  `statusPagamento` =  '".$status."', `dadosPag` =  '".$msg."', `pago` =  '".$pg."' WHERE `idItem` ='".$dados_item['idItem']."';";
}
$db->query($sql);

//atualiza o pedido
$sql = "UPDATE `braspag_pedidos` SET  `statusPedido` =  '".$status."' WHERE `idPedido` ='".$pedido_id."';";
$db->query($sql);

//atualiza o cron
$sql = "INSERT INTO `braspag_cron` (`data_hora`, `id`, `numpg`, `pedido`) VALUES ('".date('d/m/Y H:i:s')."', NULL, '".$dados_item['numPag']."', '".$dados_pedido['order_id']."');";
$db->query($sql);

//atualiza o history order na opencart
$status_pedido = 0;
if($status==0){//aprovado
$foi = "Aprovada";
$titulo = "Fatura #".$dados_pedido['order_id']."/".$dados_item['numPag']." Aprovada - ".$config->get('config_title')."";
$status_pedido = $config->get('braspagapi_aprovado');
$sql = "INSERT INTO `" . DB_PREFIX . "order_history` (order_id, order_status_id, notify, comment, date_added) VALUES ('".$pedido_id."', '".$config->get('braspagapi_aprovado')."', 0, '".$msg."', NOW());";
$db->query($sql);
}elseif($status==1){//autorizado
$foi = "Autorizada";
$titulo = "Autorizada #".$dados_pedido['order_id']."/".$dados_item['numPag']." Aprovada - ".$config->get('config_title')."";
$status_pedido = $config->get('braspagapi_autorizado');
$sql = "INSERT INTO `" . DB_PREFIX . "order_history` (order_id, order_status_id, notify, comment, date_added) VALUES ('".$pedido_id."', '".$config->get('braspagapi_autorizado')."', 0, '".$msg."', NOW());";
$db->query($sql);
}elseif($status==2){//cancelado
$foi = "Negado o Pagamento";
$titulo = "Fatura #".$dados_pedido['order_id']."/".$dados_item['numPag']." Negada o Pagamento - ".$config->get('config_title')."";
$status_pedido = $config->get('braspagapi_cancelado');
$sql = "INSERT INTO `" . DB_PREFIX . "order_history` (order_id, order_status_id, notify, comment, date_added) VALUES ('".$pedido_id."', '".$config->get('braspagapi_cancelado')."', 0, '".$msg."', NOW());";
$db->query($sql);
}elseif($status==3 || $status==4 || $status==5){//cancelado
$foi = "Cancelado";
$titulo = "Fatura #".$dados_pedido['order_id']."/".$dados_item['numPag']." Pagamento Cancelado - ".$config->get('config_title')."";
$status_pedido = $config->get('braspagapi_cancelado');
$sql = "INSERT INTO `" . DB_PREFIX . "order_history` (order_id, order_status_id, notify, comment, date_added) VALUES ('".$pedido_id."', '".$config->get('braspagapi_cancelado')."', 0, '".$msg."', NOW());";
$db->query($sql);
}
//atualiza o pedido em geral na loja
if($status_pedido>0){
$sql = "UPDATE `" . DB_PREFIX . "order` SET order_status_id='".$status_pedido."' WHERE order_id='".$pedido_id."'";
$db->query($sql);
//manda um email
$html_itens = HTMLPedidos($pedido_id);
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
$headers .= 'From: '.$config->get('config_title').' <'.$config->get('config_email').'>' . "\r\n";

//lay do email
$message = "
Ola, <b>".$dados_pedido['firstname']." ".$dados_pedido['lastname']."</b><br>
A fatura de numero <b>#".$dados_item['numPag']."</b> do pedido <b>#".$dados_pedido['order_id']."</b> foi <b>".$foi."</b> em ".$config->get('config_title').".<br><br>
";
$message .= $html_itens;//tabelas de pedidos
//fim lay

//envia
mail($dados_pedido['email'], $titulo, $message, $headers);

}//fim opencart

echo "#".$dados_pedido['order_id']."/".$dados_item['numPag']." - Cron completo ".date('d/m/Y H:i:s')."!<br>";

}
}

}
}
?>
<?php
if(isset($_POST) && count($_POST)>=1){
//chama os dados
$pedido_id = (int)$_POST['ped'];
include("dados.php");
include("loja5.php");
$dados_pedido = TotalPedidoBrasPag($pedido_id);
$url_web = BraspagTipo($config->get('braspagapi_ambiente'));

function EstadosBrasilPayFast($zona,$db){
	$estado = $db->query("SELECT * FROM `".DB_PREFIX."zone` WHERE zone_id ='".$zona."';");
	return $estado->row['code'];
}

//$pedido_id = "ab".time();

$soap_opt['encoding']    = 'UTF-8';
$soap_opt['trace']           = true;
$soap_opt['exceptions'] = true;
$soap_client = new SoapClient($url_web, $soap_opt);

//define os meses
$periodicidade = 1;
$valor_pagar = $dados_pedido['total'];


$data_hoje = date('d/m/Y');
$data_fim = SomarDatas($data_hoje, 0, 12, 0);
//gera datas

$request['merchantId'] = $config->get('braspagapi_chave');
$request['orderId'] = $pedido_id;
$request['startDate'] = $data_hoje;
$request['endDate'] = $data_fim;
$request['recurrenceInterval'] = $periodicidade;
$request['amount'] = number_format($valor_pagar, 2, ',', '.');
$request['paymentMethod'] = $config->get('braspagapi_bo');
$request['payerName'] = $dados_pedido['firstname']." ".$dados_pedido['lastname'];
$request['payerEmail'] = $dados_pedido['email'];
$request['payerId'] = "";
$request['payerAddress'] = $dados_pedido['payment_address_1'];
$request['payerNumber'] = "";
$request['payerComplement'] = "";
$request['payerNeighborhood'] = $dados_pedido['payment_address_2'];
$request['payerCity'] = $dados_pedido['payment_city'];
$request['payerZipCode'] = $dados_pedido['payment_postcode'];
$request['payerState'] = EstadosBrasilPayFast($dados_pedido['payment_zone_id'],$db);
$request['payerCountry'] = "BRA";
$key1 = "CreateBoletoOrderResult";
$res = $soap_client->CreateBoletoOrder($request);
if($res->$key1->code==0){//sucesso
//cria o pedido no bd
$sql = "INSERT INTO `braspag_pedidos` (`idUnica`, `idPedido`, `periodicidade`, `codPagamento`, `dataInicio`, `dataFim`, `statusPedido`) VALUES (NULL, '".$pedido_id."', '".$periodicidade."', '36', '".$data_hoje."', '".$data_fim."', '6');";
$db->query($sql);
//cria as mensalidades
for($i=1;$i<=12;$i++){
$laco_mes = SomarDatas($data_hoje, 0, $i-1, 0);
$db->query("INSERT INTO `braspag_itens` (`idItem`, `idPedido`, `dataDebito`, `statusPagamento`, `valorPago`, `numPag`, `dadosPag`) VALUES (NULL, '".$pedido_id."', '".$laco_mes."', '6', '".number_format($valor_pagar, 2, '.', '')."', '".$i."', '');");
}
//
$dados['erro'] = 'false';
$dados['msg'] = "okkkkkkkkkkkkkk";
echo json_encode($dados);
}else{//erro
$dados['erro'] = 'true';
$dados['msg'] = $res->$key1->code.' - '.$res->$key1->description;
echo json_encode($dados);
}
}
?>
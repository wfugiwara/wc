<?php
if(isset($_POST) && count($_POST)>5){
//chama os dados
$pedido_id = (int)$_POST['ped'];
include("dados.php");
include("loja5.php");
$dados_pedido = TotalPedidoBrasPag($pedido_id);
$url_web = BraspagTipo($config->get('braspagapi_ambiente'));

//$pedido_id = "1234567890".time();

$soap_opt['encoding']    = 'UTF-8';
$soap_opt['trace']           = true;
$soap_opt['exceptions'] = true;
$soap_client = new SoapClient($url_web, $soap_opt);

//define os meses
$periodicidade = 12;
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
$request['paymentMethod'] = $_POST['cc'];
//cartao
$request['holder'] = $_POST['nome'];
$request['cardNumber'] = $_POST['cartao'];
$request['expirationDate'] = $_POST['validade'];
$request['securityCode'] = $_POST['cod'];
$request['numberInstallments'] = "1";
$request['paymentType'] = "0";

$key1 = "CreateCreditCardOrderResult";

$res = $soap_client->CreateCreditCardOrder($request);

if($res->$key1->code==0){//sucesso

//cria o pedido no bd
$sql = "INSERT INTO `braspag_pedidos` (`idUnica`, `idPedido`, `periodicidade`, `codPagamento`, `dataInicio`, `dataFim`, `statusPedido`) VALUES (NULL, '".$pedido_id."', '".$periodicidade."', '".$_POST['cc']."', '".$data_hoje."', '".$data_fim."', '6');";
$db->query($sql);
//cria o pagamento
$laco_mes = SomarDatas($data_hoje, 0, 0, 0);
$db->query("INSERT INTO `braspag_itens` (`idItem`, `idPedido`, `dataDebito`, `statusPagamento`, `valorPago`, `numPag`, `dadosPag`) VALUES (NULL, '".$pedido_id."', '".$laco_mes."', '6', '".number_format($valor_pagar, 2, '.', '')."', '1', '');");
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
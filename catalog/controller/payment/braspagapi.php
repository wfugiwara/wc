<?php
class ControllerPaymentBrasPagAPI extends Controller {

	protected function index() {

		$this->data['ativa_cartao'] = $this->cartao_ativo();
		$this->data['cc'] = $this->config->get('braspagapi_cc');
		$this->data['ativa_boleto'] = $this->boleto_ativo();
		$this->data['bo'] = $this->config->get('braspagapi_bo');
		$this->data['ativa_debito'] = $this->debito_ativo();
		$this->data['de'] = $this->config->get('braspagapi_de');
		$this->data['minimo'] = $this->config->get('braspagapi_minimo');
		$this->data['juros'] = $this->config->get('braspagapi_juros');
		$this->data['div'] = $this->config->get('braspagapi_div');
		$this->data['sem'] = $this->config->get('braspagapi_sem');
		
		$this->data['pedido'] = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/braspagapi.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/payment/braspagapi.tpl';
		} else {
			$this->template = 'default/template/payment/braspagapi.tpl';
		}
		$this->render();
	}
	
	public function cartao_ativo(){
	if(sizeof($this->config->get('braspagapi_cc'))>=1){
	return 'sim';
	}else{
	return 'nao';
	}
	}
	
	public function boleto_ativo(){
	if($this->config->get('braspagapi_bo')!=998){
	return 'sim';
	}else{
	return 'nao';
	}
	}
	
	public function debito_ativo(){
	if(sizeof($this->config->get('braspagapi_de'))>=1){
	return 'sim';
	}else{
	return 'nao';
	}
	}
	
	public function itens(){
	
	if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    } 
	
	if (isset($this->session->data['order_id'])) {
			$this->cart->clear();
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);	
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
	}

	if(isset($_GET['assinatura'])){
	$numero_do_pedido = base64_decode($_GET['assinatura']);
	$this->document->setTitle('Detalhes da Assinatura #'.$numero_do_pedido.'');
	$this->load->model('checkout/order');
	$order = $this->model_checkout_order->getOrder($numero_do_pedido);
	if($this->session->data['customer_id']!=$order['customer_id']){
	echo "Apenas o cliente possui acesso!";
	exit;
	}
	$this->data['ped'] = $order;
	//query os detalhes
	$linhas = $this->db->query("SELECT * FROM  `braspag_itens` WHERE idPedido = '".$numero_do_pedido."' ORDER BY numPag ASC");
	$this->data['registros'] = $linhas->rows;
	$linhas = $this->db->query("SELECT * FROM  `braspag_pedidos` WHERE idPedido = '".$numero_do_pedido."'");
	$this->data['registro'] = $linhas->row;
	//template
	$this->template = 'default/template/payment/braspagapi_detalhes.tpl';
	$this->children = array(
					'common/column_left',
					'common/column_right',
					'common/content_top',
					'common/content_bottom',
					'common/footer',
					'common/header'
	);
	$this->response->setOutput($this->render());
	}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	public function ver_cupom(){
	//pega os dados do cliente e pedido
	if(isset($_GET['token'])){
	$numero_do_pedido = base64_decode($_GET['assinatura']);
	$this->load->model('checkout/order');
	$order = $this->model_checkout_order->getOrder($numero_do_pedido);
	$tid = base64_decode($_GET['session']);
	if(md5($tid)!=$_GET['hash']){
	echo "Ops, dados invalidos!";
	exit;
	}
	//chama as classes cielo
	include("app/buypagecielo/loja5.php");
	//pega as variaveis do modulo cielo
	$afiliacao = $this->config->get('braspagapi_afiliacao');
	$chav____e = $this->config->get('braspagapi_chave');
	$ambient_e = $this->config->get('braspagapi_ambiente');
	//define se o ambiente esta em teste ou producao
	if($ambient_e=='1'){
	define("ENDERECO", TESTE_CIELO);
	}else{
	define("ENDERECO", PRODUCAO_CIELO);
	}
	//inicializa a classe cielo
	$Pedido = new Pedido();
	$Pedido->dadosEcNumero = $afiliacao;
	$Pedido->dadosEcChave = $chav____e;
	$Pedido->dadosPedidoNumero = $numero_do_pedido;
	$Pedido->tid = $tid;
	//faz a consulta
	$consulta = $Pedido->RequisicaoConsulta();
	//keys
	$f_pag = "forma-pagamento";
	$f_ped = "dados-pedido";

	if(is_object($consulta) && isset($consulta->tid)){
	$cod_lr = 'n/a';
	$tid = $consulta->tid;
	$status_id = $consulta->status;
	$meio_pag = $consulta->$f_pag->bandeira;
	$meio_pag_par = $consulta->$f_pag->parcelas;
	$meio_pag_pro = $consulta->$f_pag->produto;
	$total_pedido = $consulta->$f_ped->valor;
	$Pedido->status = $status_id;
	$status_nome = $Pedido->getStatus();
	$res_status = $this->getStatusCielo($status_id);
	if(isset($consulta->autorizacao->lr)){
	$cod_lr = $consulta->autorizacao->lr;
	}
	
	//faz o update da resposta
	$this->db->query("UPDATE `" . DB_PREFIX . "order_cielo` SET  `lrCielo` =  '".$cod_lr."', `statusCielo` =  '".$status_id."' WHERE `idOrder` ='".$numero_do_pedido."';");
	//atualiza para um novo status
	$log = "".$res_status['nome']." | TID: ".$tid." | LR: ".$cod_lr." | ".strtoupper($meio_pag)."";
	$this->model_checkout_order->update($numero_do_pedido, $res_status['id'], $log, true);
	
	echo '<html>
	<head>
	<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
	<title>Recibo #'.$numero_do_pedido.'</title>
	</head>
	<body>
	<div class="container">
	<center>
	<h4>Resultado da Transa&ccedil;&atilde;o #'.$numero_do_pedido.'</h4>
	<table>
	<tr><td align="right"><b>Total:</b></td><td>'.number_format(($total_pedido/100), 2, '.', '').' em '.$meio_pag_par.'x</td></tr>
	<tr><td align="right"><b>Status:</b></td><td>'.$res_status['nome'].'</td></tr>';

	$lrIdNum = 0;
	if(isset($consulta->autorizacao->lr) && is_object($consulta->autorizacao->lr)){
	$Pedido->lrcod = $consulta->autorizacao->lr;
	$lr_nome = $Pedido->getLr();
	$lrIdNum = $Pedido->lrcod;
	echo '<tr><td align="right"><b>LR:</b></td><td>'.$lr_nome.'</td></tr>';
	}
	
	echo '<tr><td align="right"><b>TID:</b></td><td>'.$tid.'</td></tr>';
	echo '<tr><td align="right"><b>Bandeira:</b></td><td>'.strtoupper($meio_pag).'</td></tr>';
	echo "<tr><td></td><td><img src='app/buypagecielo/images/".$meio_pag.".gif' border='0'></td></tr>";
	echo "<tr><td colspan='2'><br><center>".strtoupper($order['firstname'])." ".strtoupper($order['lastname'])."<br>____________________________________</center></td></tr>";
	echo "<tr><td colspan='2'><br><center><button class='btn btn-success' onclick='self.print()'>IMPRIMIR</button></center></td></tr>";
	echo '<script>window.resizeTo(770,550);';
	echo'
	</table>
	</center>
	</div>
	</body>
	</html>';
	
	}
	}else{
	}
	}
	
	public function getStatusCielo($status)
	{
			switch($status)
			{
				case "0": 
				$status = "Criada (Aguardando Pagamento)";
				$status_id = $this->config->get('braspagapi_order_status_id');
				break;
				case "1": 
				$status = "Em andamento";
				$status_id = $this->config->get('braspagapi_pendente');
				break;
				case "2": 
				$status = "Autenticada";
				$status_id = $this->config->get('braspagapi_pendente');
				break;
				case "3": 
				$status = "Nao autenticada";
				$status_id = $this->config->get('braspagapi_pendente');
				break;
				case "4": 
				$status = "Autorizada";
				$status_id = $this->config->get('braspagapi_autorizado');
				break;
				case "5": 
				$status = "Nao autorizada";
				$status_id = $this->config->get('braspagapi_cancelado');
				break;
				case "6": 
				$status = "Capturada (Aprovada)";
				$status_id = $this->config->get('braspagapi_aprovado');
				break;
				case "8": 
				$status = "Nao capturada";
				$status_id = $this->config->get('braspagapi_pendente');
				break;
				case "9": 
				$status = "Cancelada pelo Usuario";
				$status_id = $this->config->get('braspagapi_cancelado');
				break;
				case "10": 
				$status = "Em autenticacao";
				$status_id = $this->config->get('braspagapi_pendente');
				break;
				default: 
				$status = "n/a";
				$status_id = $this->config->get('braspagapi_order_status_id');
				break;
			}
			
			return array('nome'=>$status,'id'=>$status_id);
	}
	
	public function confirm() {
		$this->load->model('checkout/order');
		$url_confirma = $this->url->link('payment/braspagapi/itens&assinatura='.base64_encode($this->session->data['order_id']).'');
		$msg = "<a href='".$url_confirma."'>Detalhes da Assinatura #".$this->session->data['order_id']."</a>";
		$this->model_checkout_order->confirm($this->session->data['order_id'], $this->config->get('braspagapi_order_status_id'),$msg,true);
		$html = '<script>location.href = "'.$url_confirma.'";</script>';
		echo $html;
	}
}
?>
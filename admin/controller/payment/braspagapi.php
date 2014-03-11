<?php 
/*
BrasPag API Loja5 - 29/07/2013 Todos os direitos reservados
Site: www.loja5.com.br
Contato: suportedaloja@gmail.com
Modudo Comercial de Propriedade Unica - Licenciado por Loja5
*/
class ControllerPaymentBrasPagAPI extends Controller {

	private $error = array(); 
	
	public function cap(){
	$this->load->model('sale/braspagapi');
	$dados = $this->model_sale_braspagapi->getDados((int)$_GET['pedido']);
	$res = $this->model_sale_braspagapi->Aprovar($dados['tidCielo']);
	if(is_object($res) && isset($res->tid)){
	
	//peg o lr se tiver
	$cod_lr = '';
	if(isset($res->autorizacao->lr)){
	$cod_lr = $res->autorizacao->lr;
	}
	
	//cria a url
	$pedido = (int)$_GET['pedido'];
	$url_pedido = $this->url->link('payment/braspagapi/consultar', 'token=' . $this->session->data['token'].'&pedido='.$pedido, 'SSL');
	
	//faz o update da resposta
	$this->db->query("UPDATE `" . DB_PREFIX . "order_cielo` SET  `lrCielo` =  '".$cod_lr."', `statusCielo` =  '".$res->status."' WHERE `idOrder` ='".$pedido."';");
	
	//muda na loja
	$pet = $this->getStatusCielo($res->status);
	$this->load->model('sale/order');

	//atualiza o pedido
	$data['order_status_id'] = $pet['id'];
	$data['comment'] = $pet['nome'];
	$data['notify'] = true;
	$this->model_sale_order->addOrderHistory($pedido, $data);
	
	//redireciona
	$this->redirect($url_pedido);
	
	}
	}
	
	public function can(){
	$this->load->model('sale/braspagapi');
	$dados = $this->model_sale_braspagapi->getDados((int)$_GET['pedido']);
	$res = $this->model_sale_braspagapi->Cancelar($dados['tidCielo']);
	if(is_object($res) && isset($res->tid)){
	
	//peg o lr se tiver
	$cod_lr = '';
	if(isset($res->autorizacao->lr)){
	$cod_lr = $res->autorizacao->lr;
	}
	
	//cria a url
	$pedido = (int)$_GET['pedido'];
	$url_pedido = $this->url->link('payment/braspagapi/consultar', 'token=' . $this->session->data['token'].'&pedido='.$pedido, 'SSL');
	
	//faz o update da resposta
	$this->db->query("UPDATE `" . DB_PREFIX . "order_cielo` SET  `lrCielo` =  '".$cod_lr."', `statusCielo` =  '".$res->status."' WHERE `idOrder` ='".$pedido."';");
	
	//muda na loja
	$pet = $this->getStatusCielo($res->status);
	$this->load->model('sale/order');
	
	//atualiza o pedido
	$data['order_status_id'] = $pet['id'];
	$data['comment'] = $pet['nome'];
	$data['notify'] = true;
	$this->model_sale_order->addOrderHistory($pedido, $data);
	
	//redireciona
	$this->redirect($url_pedido);
	
	}
	}
	
	public function consultar(){
	$this->load->model('sale/braspagapi');
	$dados = $this->model_sale_braspagapi->getDados((int)$_GET['pedido']);
	$res = $this->model_sale_braspagapi->Consultar($dados['tidCielo']);

	if(is_object($res) && isset($res->tid)){
	$dadospedido = "dados-pedido";
	$forma = "forma-pagamento";
	$datahora = "data-hora";
	$totalcielo = number_format(($res->$dadospedido->valor/100), 2, '.', '');
	if(($res->$forma->produto)=='A'){
	$tipopg= "Debito a vista";
	}elseif(($res->$forma->produto)=='1'){
	$tipopg= "Credito a vista";
	}elseif(($res->$forma->produto)=='2'){
	$tipopg= "Parcelado Loja";
	}elseif(($res->$forma->produto)=='3'){
	$tipopg= "Parcelado Operadora";
	}
	echo '<html>
	<head>
	<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
	<title>Detalhes</title>
	</head>
	<body>
	<div class="container">
	<center>
	<h3>Detalhes Pedido #'.(int)$_GET['pedido'].'</h3>
	<b>Status:</b> '.$this->getStatus($res->status).'<br>
	<b>TID:</b> '.$res->tid.'<br>';
	$cod_lr = '';
	if(isset($res->autorizacao->lr)){
	$cod_lr = $res->autorizacao->lr;
	echo '<b>LR:</b> '.$this->getLr($res->autorizacao->lr).'<br>';
	}
	if(isset($res->autorizacao->nsu)){
	echo '<b>NSU:</b> '.$res->autorizacao->nsu.'<br>';
	}
	if(isset($res->autenticacao->mensagem)){
	echo '<b>Autentica&ccedil;&atilde;o:</b> '.$res->autenticacao->mensagem.'<br>';
	}
	if(isset($res->captura->mensagem)){
	echo '<b>Captura:</b> '.$res->captura->mensagem.'<br>';
	}
	if(isset($res->cancelamentos->cancelamento)){
	echo '<b>Cancelamento:</b> '.$res->cancelamentos->cancelamento->mensagem.'<br>';
	}
	echo '<b>Total Cielo:</b> '.$totalcielo.'<br>
	<b>Data/Hota:</b> '.$res->$dadospedido->$datahora.'<br>
	<b>Bandeira:</b> '.strtoupper($res->$forma->bandeira).' em '.$res->$forma->parcelas.'x - '.$tipopg.'<br>
	<br>';
	
	$prazo_captura = (int)(5*(60*60*24));//captura ate 5 dias
	$prazo_can = (int)(10*(60*60*24));//cancelamento ate 90 dias
	$data_compra = strtotime($res->$dadospedido->$datahora);
	
	$agora = time();
	$tempo = (int)$agora-$data_compra;
	
	$rem1 = ($data_compra+$prazo_captura)-$agora;
	$rem2 = ($data_compra+$prazo_can)-$agora;

	$day1 = floor($rem1 / 86400);
	$hr1  = floor(($rem1 % 86400) / 3600);
	$min1 = floor(($rem1 % 3600) / 60);

	$day2 = floor($rem2 / 86400);
	$hr2  = floor(($rem2 % 86400) / 3600);
	$min2 = floor(($rem2 % 3600) / 60);
	
	$pedido_id = (int)$_GET['pedido'];
	$cap = $this->url->link('payment/braspagapi/cap', 'token=' . $this->session->data['token'].'&pedido='.$pedido_id, 'SSL');
	$can = $this->url->link('payment/braspagapi/can', 'token=' . $this->session->data['token'].'&pedido='.$pedido_id, 'SSL');
	
	echo '<button onclick="self.print()" class="btn btn-small btn-info" type="button">Imprimir</button> ';
	
	if($tempo<$prazo_captura && $res->status==4){
	echo '<a href="'.$cap.'" class="btn btn-small btn-success" onclick="return confirm(\'Deseja aprovar o pedido #'.$pedido_id.'?\');">Capturar ('.$day1.' dias '.$hr1.'rs '.$min1.'min)</a> ';
	}else{
	echo '<button class="btn btn-small btn-success" type="button" disabled>Capturar</button> ';
	}
	
	if($tempo<$prazo_can && $res->status==6){
	echo '<a href="'.$can.'" class="btn btn-small btn-danger" onclick="return confirm(\'Deseja cancelar por definitivo o pedido #'.$pedido_id.'? \n(Atencao: Esta acao nao poderar ser desfeita!!)\');">Cancelar ('.$day2.' dias '.$hr2.'rs '.$min2.'min)</a> ';
	}else{
	echo '<button class="btn btn-small btn-danger" type="button" disabled>Cancelar</button> ';
	}
	
	echo '</center>
	</div>
	</body>
	</html>';
	//faz o update da resposta
	$this->db->query("UPDATE `" . DB_PREFIX . "order_cielo` SET  `lrCielo` =  '".$cod_lr."', `statusCielo` =  '".$res->status."' WHERE `idOrder` ='".$pedido_id."';");
	}else{
	echo "Ops, problema ao consultar dados junto a cielo!";
	}
	}
	 
	public function index() { 
		$this->language->load('payment/braspagapi');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('braspagapi', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
				
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');		
		$this->data['entry_total'] = $this->language->get('entry_total');	
		$this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/braspagapi', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('payment/braspagapi', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');	
		
		//chama os pedidos cielo
		/*
		$this->load->model('sale/braspagapi');
		$url='';
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$pagination = new Pagination();
		$pagination->total = $this->model_sale_braspagapi->getTotalSales();
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = "";
		$pagination->url = $this->url->link('payment/braspagapi', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$this->data['pagination'] = $pagination->render();
		$data = array(
			'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                  => $this->config->get('config_admin_limit')
		);
		$this->data['link_consulta'] = $this->url->link('payment/braspagapi/consultar', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['pedidos_cielo'] = $this->model_sale_braspagapi->getOrders($data);
		*/
		
		
		//dados modulo
		$this->pegar('braspagapi_nome');
		$this->pegar('braspagapi_order_status_id');
		$this->pegar('braspagapi_autorizado');
		$this->pegar('braspagapi_aprovado');
		$this->pegar('braspagapi_cancelado');
		$this->pegar('braspagapi_chave');
		$this->pegar('braspagapi_ambiente');
		$this->pegar('braspagapi_cancelado');
		$this->pegar('braspagapi_cc');
		$this->pegar('braspagapi_bo');
		$this->pegar('braspagapi_de');
		$this->pegar('braspagapi_total');

		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		$this->pegar('braspagapi_geo_zone_id');
		
		$this->load->model('localisation/geo_zone');						
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		$this->pegar('braspagapi_status');
		
		$this->pegar('braspagapi_sort_order');

		$this->template = 'payment/braspagapi.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function pegar($campo){
		if (isset($this->request->post[$campo])) {
			$this->data[$campo] = $this->request->post[$campo];
		} else {
			$this->data[$campo] = $this->config->get($campo); 
		}
	}
	
	protected function validate() {
		return true;	
	}
	
	public function getStatus($status)
		{
			
			switch($status)
			{
				case "0": $status = "Criada (Aguardando Pagamento)";
						break;
				case "1": $status = "Em andamento";
						break;
				case "2": $status = "Autenticada";
						break;
				case "3": $status = "Nao autenticada";
						break;
				case "4": $status = "Autorizada";
						break;
				case "5": $status = "Nao autorizada";
						break;
				case "6": $status = "Capturada (Aprovada)";
						break;
				case "8": $status = "Nao capturada";
						break;
				case "9": $status = "Cancelada";
						break;
				case "10": $status = "Em autenticacao";
						break;
				default: $status = "n/a";
						break;
			}
			
			return $status;
		}
		
		public function getLr($lrcod)
		{
			
			switch($lrcod)
			{
				case "00": 
				$lrcod = "00 - Transacao autorizada";
				break;
				case "01":
				case "04":
				case "07":
				case "41":
				case "62":
				case "63":
				$lrcod = $lrcod." - Transacao referida/com restricao pelo emissor (Contate o emissor de seu cartao)";
				break;
				case "05": 
				$lrcod = "05 - Transacao nao autorizada";
				break;
				case "12": 
				case "82": 
				$lrcod = $lrcod." - Transacao invalida";
				break;
				case "13": 
				$lrcod = "13 - Valor invalido";
				break;
				case "14": 
				$lrcod = "14 - Cartao invalido";
				break;
				case "15": 
				$lrcod = "15 - Emissor invalido";
				break;
				case "51": 
				$lrcod = "51 - Saldo insuficiente";
				break;
				case "54": 
				$lrcod = "54 - Cartao vencido";
				break;
				case "57": 
				case "58":
				$lrcod = $lrcod." - Transacao nao permitida";
				break;
				case "78":
				$lrcod = "78 - Cartao nao desbloqueado (Contate o emissor de seu cartao)";
				break;
				case "91":
				$lrcod = "91 - Banco indisponivel";
				break;
				case "AC":
				$lrcod = "AC - Cartao de debito tentando seu usado como credito.";
				break;
				default:
				$lrcod = $lrcod;
			}
			
			return $lrcod;
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
				$status = "Cancelada";
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
}
?>
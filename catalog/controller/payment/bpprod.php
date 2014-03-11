<?php
class ControllerPaymentBPProd extends Controller {

	protected function index() {

		$this->data['ativa_cartao'] = $this->cartao_ativo();
		$this->data['cc'] = $this->config->get('bpprod_cc');
		$this->data['ativa_boleto'] = $this->boleto_ativo();
		$this->data['bo'] = $this->config->get('bpprod_bo');
		$this->data['minimo'] = $this->config->get('bpprod_minimo');
		$this->data['juros'] = $this->config->get('bpprod_juros');
		$this->data['div'] = $this->config->get('bpprod_div');
		$this->data['sem'] = $this->config->get('bpprod_sem');
		
		$this->data['pedido'] = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/bpprod.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/payment/bpprod.tpl';
		} else {
			$this->template = 'default/template/payment/bpprod.tpl';
		}
		$this->render();
	}
	
	public function cartao_ativo(){
	if(sizeof($this->config->get('bpprod_cc'))>=1){
	return 'sim';
	}else{
	return 'nao';
	}
	}
	
	public function boleto_ativo(){
	if($this->config->get('bpprod_bo')!=998){
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
	$this->document->setTitle('Detalhes do Pagamento #'.$numero_do_pedido.'');
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
	$this->template = 'default/template/payment/bpprod_detalhes.tpl';
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
	
	public function confirm() {
		$this->load->model('checkout/order');
		$url_confirma = $this->url->link('payment/bpprod/itens&assinatura='.base64_encode($this->session->data['order_id']).'');
		$msg = "<a href='".$url_confirma."'>Detalhes da Pagamento #".$this->session->data['order_id']."</a>";
		$this->model_checkout_order->confirm($this->session->data['order_id'], $this->config->get('bpprod_order_status_id'),$msg,true);
		$html = '<script>location.href = "'.$url_confirma.'";</script>';
		echo $html;
	}
}
?>
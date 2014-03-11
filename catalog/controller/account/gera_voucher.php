<?php 
class ControllerAccountGeraVoucher extends Controller { 
	private $error = array();
	
	public function salvar(){
		$this->language->load('account/voucher');
		
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}
		
	if(isset($_POST['parceiro']) && isset($_POST['cliente'])){
	$par = $this->getParceiro($_POST['parceiro']);
	$end = $_POST['end'];
	$sql = "INSERT INTO `voucher_cupons` (`idCupon`, `idPar`, `idEnd`, `idCli`, `valCupon`, `dataCupon`, `status`) VALUES (NULL, '".$par['idPar']."', '".$end."', '".$this->customer->getId()."', '".$par['valVoucher']."', UNIX_TIMESTAMP(), 'gerado');";
	$this->db->query($sql);
	}
	
	$this->redirect($this->url->link('account/meus_vouchers','','SSL'));
	
	}
	
	private function Enderecos($parceiro){
	$sql = "SELECT * FROM `voucher_locais` WHERE idPar = '".$parceiro."'";
	$a = $this->db->query($sql);
	return $a->rows;
	}
	
	public function parceiro() {
		$this->language->load('account/voucher');
		
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}

		$this->document->setTitle("Parceiro ".$_GET['nome'].""); 
		$this->data['parceiro'] = $this->getParceiro($_GET['par']);
		$this->data['total_cliente'] = $this->getVouCliPar($this->customer->getId(),$_GET['par']);
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->data['cliente'] = $this->customer->getFirstName()." ".$this->customer->getLastName();
		$this->data['cliente_id'] = $this->customer->getId();

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => "Parceiro ".$_GET['nome']."",
			'href'      => $this->url->link('account/gera_voucher/parceiro&par='.(int)$_GET['par'].'&nome='.$_GET['nome'].''),
        	'separator' => $this->language->get('text_separator')
      	);	
		
    	$this->data['heading_title'] = "Gerar Voucher para ".$_GET['nome']."";

    	$this->data['text_message'] = $this->language->get('text_message');

    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('checkout/cart');
		
		$this->data['ends'] = $this->Enderecos((int)$_GET['par']);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/gera_voucher_parceiro.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/gera_voucher_parceiro.tpl';
		} else {
			$this->template = 'default/template/account/gera_voucher_parceiro.tpl';
		}
		
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
	
	public function index() {
		$this->language->load('account/voucher');
		$this->load->model('account/order');
		
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}

		$this->document->setTitle("Gerar Voucher");
		
		//pega os pedidos do cliente
		$pedidos = $this->model_account_order->getOrders();
		$ini = 0;
		foreach($pedidos AS $key=>$ped){
		if($ped['status']==$this->config->get('voucherparceiros_status')){
		$ini++;
		}
		}
		
		
		$av = array();
		$prod_v = $this->getProdutosValidos();
		if(sizeof($prod_v)>0){
		foreach($prod_v AS $pv){
		$av[] = $pv['idProd'];
		}
		}
		$ac = array();
		$prod_c = $this->produtosComprados();
		if(sizeof($prod_c)>0){
		foreach($prod_c AS $pc){
		$ac[] = $pc['product_id'];
		}
		}
		$r =  array_intersect($av, $ac);
        $this->data['pedido_validos'] = sizeof($r);

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => "Gerar Voucher",
			'href'      => $this->url->link('account/gera_voucher', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		//dados
		$this->data['categorias'] = $this->getCategorias();
				
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_description'] = $this->language->get('text_description');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
			
		$this->data['action'] = $this->url->link('account/voucher', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/gera_voucher.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/gera_voucher.tpl';
		} else {
			$this->template = 'default/template/account/gera_voucher.tpl';
		}
		
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
	
  	public function parceiros() {
		$this->language->load('account/voucher');
		
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}

		$this->document->setTitle("Parceiros"); 
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => "Parceiros",
			'href'      => $this->url->link('account/gera_voucher/parceiros&cat='.(int)$_GET['cat'].'&nome='.$_GET['nome'].''),
        	'separator' => $this->language->get('text_separator')
      	);	
		
    	$this->data['heading_title'] = "Parceiros";

    	$this->data['text_message'] = $this->language->get('text_message');

    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('checkout/cart');
		
		$this->data['parceiros'] = $this->getParceiros($_GET['cat']);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/gera_voucher_parceiros.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/gera_voucher_parceiros.tpl';
		} else {
			$this->template = 'default/template/account/gera_voucher_parceiros.tpl';
		}
		
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
	
	public function getCategorias() {
      	$query = $this->db->query("SELECT * FROM `voucher_categorias` WHERE (SELECT COUNT(*) FROM  `voucher_parceiros` WHERE catPar=idCat)>=1");
		return $query->rows;
	}
	
	public function produtosComprados() {
      	$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "order_product` AS a,`" . DB_PREFIX . "order` AS b WHERE a.order_id=b.order_id AND b.customer_id='".$this->customer->getId()."' GROUP BY product_id");
		return $query->rows;
	}
	
	public function getProdutosValidos() {
      	$query = $this->db->query("SELECT idProd FROM voucher_produtos GROUP BY idProd");
		return $query->rows;
	}
	
	public function getParceiros($cat) {
      	$query = $this->db->query("SELECT * FROM `voucher_parceiros`  WHERE catPar = '".(int)$cat."'");
		return $query->rows;
	}
	
	public function getParceiro($id) {
      	$query = $this->db->query("SELECT * FROM `voucher_parceiros`  WHERE idPar = '".(int)$id."'");
		return $query->row;
	}
	
	public function getVouCliPar($cli,$par) {
      	$query = $this->db->query("SELECT * FROM `voucher_cupons`  WHERE idPar = '".(int)$par."' AND idCli = '".(int)$cli."'");
		return $query->num_rows;
	}
	
	protected function validate() {
    	return true;				
	}
}
?>
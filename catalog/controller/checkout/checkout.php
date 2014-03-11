<?php  
class ControllerCheckoutCheckout extends Controller { 
	// alteração antonio
	public function alterarenavam() {
		$this->session->data['gravado'] = 0;
		$this->redirect($this->url->link('checkout/cart'));
	}
	
	public function validarenavam() {
		if (strlen(utf8_decode($this->request->post['valor'])) < 1) {
			
		
		}else{
			if (!$this->customer->renavam($this->request->post['valor'])){
				//$json['error']['placa1'] =  "O campo Renavam é inválido";
				echo "O renavam ".$this->request->post['numrenavam']." preenchido não é válido!";
			}
		}
		// .$this->request->post['valor'];
	}
	public function renavam() {
		$ids = array();
		$renavams = array();
		$options = array();
		$ids = $this->request->post['ids'];
		$key = "";
		$validacao = 1;
		for ($i = 0;$i < $this->request->post['total'];$i++ ){
			$key = $ids[$i];
			$quantidade = $this->session->data['cart'][$key];
			$product = explode(':', $key);
			$product_id = $product[0];
			// Options
			
			if (isset($product[1])) {
				$options = unserialize(base64_decode($product[1]));
			} else {
				$options = array();
			} 
			// apaga renavans antigos
			for ($h = 0;$h < 50;$h++ ){
				unset($options[$h]);
			}

			$texto="options".$i;
			//$renavams[$ids[$i]] = $this->request->post[$texto];
			$contador = 0 ;
			foreach ($this->request->post[$texto] as $renavam) { 
				// $nome = $product_id.$contador;
				if (($contador == "0")&&($renavam=="")){
					$validacao = 0;	
				}elseif ($renavam<>""){
					if (!$this->customer->renavam($renavam)){
						$validacao = 0;
					}
					$options[$contador] = $renavam;
					$contador++;
				}
				
			}
			
			
			if ($validacao == "1"){
				$this->cart->renavam($product_id, $key,$quantidade,$options);
				$this->session->data['gravado'] = 1;
				echo "1";
			}else{
				$this->session->data['gravado'] = 0;
			}
		}		
	}
	// fim alteração antonio
	public function index() {
		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
	  		$this->redirect($this->url->link('checkout/cart'));
    	}	
		
		// alteração antonio inicio
		if ($this->session->data['gravado'] == "0"){
			 echo "<script>alert('É necessário registrar pelo menos 1 renavam por produto antes de prosseguir');location.href='index.php?route=checkout/cart';</script>";
		}
		
		if ($this->customer->isLogged()) {			  	  
			
		}else{
			$this->redirect($this->url->link('account/login'));
		}	
		// Validate minimum quantity requirments.			
		$products = $this->cart->getProducts();
				
		foreach ($products as $product) {
			$product_total = 0;
				
			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}		
			
			if ($product['minimum'] > $product_total) {
				$this->redirect($this->url->link('checkout/cart'));
			}				
		}
				
		$this->language->load('checkout/checkout');
		
		$this->document->setTitle($this->language->get('heading_title')); 
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
					
		$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_cart'),
			'href'      => $this->url->link('checkout/cart'),
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
					
	    $this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');		
		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$this->data['text_modify'] = $this->language->get('text_modify');
		
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['shipping_required'] = $this->cart->hasShipping();	
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/checkout/checkout.tpl';
		} else {
			$this->template = 'default/template/checkout/checkout.tpl';
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
	
	public function country() {
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>
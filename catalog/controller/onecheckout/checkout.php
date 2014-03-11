<?php  
class ControllerOneCheckoutCheckout extends Controller { 
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

		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
	  		$this->redirect($this->url->link('checkout/cart'));
    	}	
		
		// alteração antonio inicio
		if ($this->session->data['gravado'] == "0"){
		    echo "<script>alert('É necessário registrar pelo menos 1 renavam por produto antes de prosseguir');location.href='index.php?route=checkout/cart';</script>";
		}
		
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
				
      	$this->language->load('onecheckout/checkout');		

		$this->document->setTitle($this->language->get('heading_title'));

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

			'href'      => $this->url->link('onecheckout/checkout', '', 'SSL'),

        	'separator' => $this->language->get('text_separator')

      	);

					

	    $this->data['heading_title'] = $this->language->get('heading_title');		

		$this->data['text_checkout_option'] = sprintf($this->language->get('text_already_reg'));

		$this->data['text_checkout_account'] = $this->language->get('text_checkout_account');

		$this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');

		$this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');

		$this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');

		$this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');		

		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');

		$this->data['text_modify'] = $this->language->get('text_modify');
		
		$this->data['entry_shipping'] = $this->language->get('entry_shipping');
		
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');

		$this->data['logged'] = $this->customer->isLogged();
		
		$this->data['shipping_required'] = $this->cart->hasShipping();
		
		$this->load->model('onecheckout/checkout');	
		$this->data['version_int'] = $this->model_onecheckout_checkout->versiontoint();
		
		if ($this->customer->isLogged()) {	
		
			if (isset($this->session->data['shipping_address_id'])) {

				$shipping_address = $this->model_onecheckout_checkout->getAddress($this->session->data['shipping_address_id']);

			} else {

				$shipping_address = $this->model_onecheckout_checkout->getAddress($this->customer->getAddressId());

			}	
			
		} elseif (isset($this->session->data['guest']['shipping'])) {

			if(!isset($this->session->data['guest']['shipping']['city']))$this->session->data['guest']['shipping']['city']='';
			$shipping_address = $this->session->data['guest']['shipping'];

		}
		
		if (isset($shipping_address)) {
		
			$this->data['shipping_country_id'] = $shipping_address['country_id'];
			
			$this->data['shipping_zone_id'] = $shipping_address['zone_id'];
			
			$this->data['shipping_city'] = $shipping_address['city'];
			
			$this->data['shipping_postcode'] = $shipping_address['postcode'];
			
			$this->session->data['shipping']['firstname'] = isset($shipping_address['firstname'])?$shipping_address['firstname']:'';
			$this->session->data['shipping']['lastname'] = isset($shipping_address['lastname'])?$shipping_address['lastname']:'';
			$this->session->data['shipping']['company'] = isset($shipping_address['company'])?$shipping_address['company']:'';
			$this->session->data['shipping']['address_1'] = isset($shipping_address['address_1'])?$shipping_address['address_1']:'';
			
		} else {
		
			$this->data['shipping_country_id'] = isset($this->session->data['shipping_country_id']) ? $this->session->data['shipping_country_id'] : $this->config->get('config_country_id');
			
			$this->data['shipping_zone_id'] = isset($this->session->data['shipping_zone_id']) ? $this->session->data['shipping_zone_id'] : $this->config->get('config_zone_id');
			
			$this->data['shipping_city'] = '';
			
			$this->data['shipping_postcode'] = isset($this->session->data['shipping_postcode']) ? $this->session->data['shipping_postcode'] : '';
			
			$this->session->data['shipping']['firstname'] = '';
			$this->session->data['shipping']['lastname'] = '';
			$this->session->data['shipping']['company'] = '';
			$this->session->data['shipping']['address_1'] = '';
			
		}
		
		if ($this->customer->isLogged()) {

			if (isset($this->session->data['payment_address_id'])) {

				$payment_address = $this->model_onecheckout_checkout->getAddress($this->session->data['payment_address_id']);

			} else {

				$payment_address = $this->model_onecheckout_checkout->getAddress($this->customer->getAddressId());

			}					

		} elseif (isset($this->session->data['guest']['payment'])) {

			$payment_address = $this->session->data['guest']['payment'];

		}
		
		if (isset($payment_address)) {
		
			$this->data['payment_country_id'] = $payment_address['country_id'];
			
			$this->data['payment_zone_id'] = $payment_address['zone_id'];
			
			$this->data['payment_city'] = $payment_address['city'];
			
			$this->data['payment_postcode'] = $payment_address['postcode'];
			
		} else {
		
			$this->data['payment_country_id'] =  isset($this->session->data['payment_country_id']) ? $this->session->data['payment_country_id'] : $this->config->get('config_country_id');
			
			$this->data['payment_zone_id'] = isset($this->session->data['payment_zone_id']) ? $this->session->data['payment_zone_id'] : $this->config->get('config_zone_id');
			
			$this->data['payment_city'] = '';
			
			$this->data['payment_postcode'] = '';
			
		}
		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/onecheckout/checkout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/onecheckout/checkout.tpl';
		} else {
			$this->template = 'default/template/onecheckout/checkout.tpl';
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
	
	public function ini() {
		$user_agent = isset($this->request->server['HTTP_USER_AGENT'])?$this->request->server['HTTP_USER_AGENT']:'';
		if($this->isMobile($user_agent) || $this->isTablet($user_agent))$this->config->set('onecheckout_status',0);
		if ($this->config->get('onecheckout_status') && isset($this->request->get['_route_'])) {
			if($this->onestristr($this->request->get['_route_'], 'checkout/checkout')){
				$this->request->get['route'] = 'onecheckout/checkout';
				$this->loadseourl();
				return $this->forward($this->request->get['route']);
			}
			
			if(trim($this->request->get['_route_']) == 'checkout'){
				$this->request->get['route'] = 'onecheckout/checkout';
				$this->loadseourl();
				return $this->forward($this->request->get['route']);
			}
		}
		
		if ($this->config->get('onecheckout_status') && isset($this->request->get['route'])) {
			if($this->onestristr($this->request->get['route'], 'checkout/checkout')){
				$this->request->get['route'] = 'onecheckout/checkout';
				$this->loadseourl();
				return $this->forward($this->request->get['route']);
			}
		}
	}
	
	public function isMobile($user_agent) {
		$mobile = false;
		if(stripos($user_agent,"iPod") || stripos($user_agent,"iPhone") || stripos($user_agent,"webOS") || stripos($user_agent,"BlackBerry") || stripos($user_agent,"windows phone") || stripos($user_agent,"symbian") || stripos($user_agent,"vodafone") || stripos($user_agent,"opera mini") || stripos($user_agent,"windows ce") || stripos($user_agent,"smartphone") || stripos($user_agent,"palm") || stripos($user_agent,"midp")) {
			$mobile = true;
		}
		if(stripos($user_agent,"Android") && stripos($user_agent,"mobile")){
		    $mobile = true;
		}else if(stripos($user_agent,"Android")){
	    	$mobile = false;
	   	}
		
		return $mobile;
	}
	
	public function isTablet($user_agent) {
		$tablet = false;
		if(stripos($user_agent,"Android") && stripos($user_agent,"mobile")){
		    $tablet = false;
		}else if(stripos($user_agent,"Android")){
	    	$tablet = true;
	   	}
		if(stripos($user_agent,"iPad") || stripos($user_agent,"RIM Tablet") || stripos($user_agent,"hp-tablet") || stripos($user_agent,"Kindle Fire")) {
			$tablet = true;
		}
		
		return $tablet;
	}
	
	private function onestristr($route, $str) {
		return ((trim($route) == $str || substr($route,0-strlen($str)) == $str) && !stristr($route, 'onecheckout'));
	}
	
	public function loadseourl(){
		if(!class_exists('ControllerCommonSeoUrl')){
			global $vqmod;
			if ($vqmod) {				
				require_once($vqmod->modCheck(DIR_APPLICATION . 'controller/common/seo_url.php'));
			}else{
				require_once(DIR_APPLICATION . 'controller/common/seo_url.php');
			}
			$class = 'ControllerCommonSeoUrl';
			$class = new $class($this->registry);
			if ($this->config->get('config_seo_url')) {
				$this->url->addRewrite($class);
			}
		}	
	}

}

?>
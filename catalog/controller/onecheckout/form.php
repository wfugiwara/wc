<?php 
class ControllerOneCheckoutForm extends Controller {
	// inicio módulo cpf ###############################################   
	public function estado_autocompletar() {
		$this->load->model('localisation/zone');
		$code = $this->model_localisation_zone->getZonesByEstado($this->request->get['estado']);
		if ($code <> "") {
			$output = '<option value="' . $code . '" selected="selected"> '.$this->request->get['estado'].'</option>';
		}else{
			$output = "";
		}
		$this->response->setOutput($output);
	} 
  	public function index() {

		$this->language->load('onecheckout/checkout');
		$this->load->model('onecheckout/checkout');		
		$version_int = $this->model_onecheckout_checkout->versiontoint();
		$this->data['version_int'] = $version_int;
		
		$json = array();

		if ($this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('onecheckout/checkout', '', 'SSL');
		}

		if ((!$this->cart->hasProducts() && (!isset($this->session->data['vouchers']) || !$this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');	

		}

			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_none'] = $this->language->get('text_none');
			$this->data['text_your_details'] = $this->language->get('text_your_details');
			$this->data['text_your_address'] = $this->language->get('text_your_address');
			$this->data['text_your_password'] = $this->language->get('text_your_password');
					
			$this->data['entry_firstname'] = $this->language->get('entry_firstname');
			$this->data['entry_lastname'] = $this->language->get('entry_lastname');
			$this->data['entry_email'] = $this->language->get('entry_email');
			$this->data['entry_telephone'] = $this->language->get('entry_telephone');
			$this->data['entry_fax'] = $this->language->get('entry_fax');
			$this->data['entry_company'] = $this->language->get('entry_company');
			$this->data['entry_account'] = $this->language->get('entry_account');
			$this->data['entry_company_id'] = $this->language->get('entry_company_id');
			$this->data['entry_tax_id'] = $this->language->get('entry_tax_id');
			$this->data['entry_address_1'] = $this->language->get('entry_address_1');
			$this->data['entry_address_2'] = $this->language->get('entry_address_2');
			$this->data['entry_postcode'] = $this->language->get('entry_postcode');
			$this->data['entry_city'] = $this->language->get('entry_city');
			$this->data['entry_country'] = $this->language->get('entry_country');
			$this->data['entry_zone'] = $this->language->get('entry_zone');
			$this->data['entry_newsletter'] = sprintf($this->language->get('entry_newsletter'), $this->config->get('config_name'));
			$this->data['entry_password'] = $this->language->get('entry_password');
			$this->data['entry_confirm'] = $this->language->get('entry_confirm');
			$this->data['entry_shipping'] = $this->language->get('entry_shipping');			
			$this->data['error_firstname'] = $this->language->get('error_firstname');			
			$this->data['text_reg'] = $this->language->get('text_reg');

			if (isset($this->session->data['guest']['firstname'])) {
				$this->data['firstname'] = $this->session->data['guest']['firstname'];
			} else {
				$this->data['firstname'] = '';
			}	

			if (isset($this->session->data['guest']['lastname'])) {
				$this->data['lastname'] = $this->session->data['guest']['lastname'];
			} else {
				$this->data['lastname'] = '';
			}			

			if (isset($this->session->data['guest']['email'])) {
				$this->data['email'] = $this->session->data['guest']['email'];
			} else {
				$this->data['email'] = '';
			}			

			if (isset($this->session->data['guest']['telephone'])) {
				$this->data['telephone'] = $this->session->data['guest']['telephone'];	
			} else {
				$this->data['telephone'] = '';
			}

			// inicio módulo cpf ###############################################   
			
			if (isset($this->request->post['sexo'])) {
				$this->data['sexo'] = $this->request->post['sexo'];
			} else {
				$this->data['sexo'] = '';
			}
			
			if (isset($this->request->post['placa1'])) {
				$this->data['placa1'] = $this->request->post['placa1'];
			} else {
				$this->data['placa1'] = '';
			}
			
			if (isset($this->request->post['placa2'])) {
				$this->data['placa2'] = $this->request->post['placa2'];
			} else {
				$this->data['placa2'] = '';
			}
			
			if (isset($this->request->post['data_nascimento'])) {
				$this->data['data_nascimento'] = $this->request->post['data_nascimento'];
			} else {
				$this->data['data_nascimento'] = '';
			}
			if (isset($this->request->post['pessoa'])) {
				$this->data['pessoa'] = $this->request->post['pessoa'];
			} else {
				$this->data['pessoa'] = '';
			}
			if (isset($this->request->post['cpf'])) {
				$this->data['cpf'] = $this->request->post['cpf'];
			} else {
				$this->data['cpf'] = '';
			}
			if (isset($this->request->post['cnpj'])) {
					$this->data['cnpj'] = $this->request->post['cnpj'];
			} else {
				$this->data['cnpj'] = '';
			}
			if (isset($this->request->post['razao_social'])) {
					$this->data['razao_social'] = $this->request->post['razao_social'];
			} else {
				$this->data['razao_social'] = '';
			}
			if (isset($this->request->post['inscricao_estadual'])) {
					$this->data['inscricao_estadual'] = $this->request->post['inscricao_estadual'];
			} else {
				$this->data['inscricao_estadual'] = '';
			}
			
			if (isset($this->request->post['ddd'])) {
					$this->data['ddd'] = $this->request->post['ddd'];
			} else {
				$this->data['ddd'] = '';
			}
			if (isset($this->request->post['numero'])) {
					$this->data['numero'] = $this->request->post['numero'];
			} else {
				$this->data['numero'] = '';
			}
			
			if (isset($this->request->post['complemento'])) {
				$this->data['complemento'] = $this->request->post['complemento'];
			} else {
				$this->data['complemento'] = '';
			}
			
			if (isset($this->request->post['ddd2'])) {
					$this->data['ddd2'] = $this->request->post['ddd2'];
			} else {
				$this->data['ddd2'] = '';
			}
		
			if (isset($this->request->post['telephone2'])) {
					$this->data['telephone2'] = $this->request->post['telephone2'];
			} else {
				$this->data['telephone2'] = '';
			}
	
		// fim módulo cpf ###############################################   
			
			if (isset($this->session->data['guest']['fax'])) {
				$this->data['fax'] = $this->session->data['guest']['fax'];	
			} else {
				$this->data['fax'] = '';
			}	

			if (isset($this->session->data['guest']['payment']['company'])) {
				$this->data['company'] = $this->session->data['guest']['payment']['company'];	
			} else {
				$this->data['company'] = '';
			}			
			
			//version			
			if($version_int >= 1530){
				$this->load->model('account/customer_group');
				$this->data['customer_groups'] = array();
		
				if (is_array($this->config->get('config_customer_group_display'))) {
					$customer_groups = $this->model_account_customer_group->getCustomerGroups();
			
					foreach ($customer_groups as $customer_group) {
						if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
							$this->data['customer_groups'][] = $customer_group;
						}
					}
				}
		
				if (isset($this->session->data['guest']['customer_group_id'])) {
    				$this->data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];
				} else {
					$this->data['customer_group_id'] = $this->config->get('config_customer_group_id');
				}
		
				// Company ID
				if (isset($this->session->data['guest']['payment']['company_id'])) {
					$this->data['company_id'] = $this->session->data['guest']['payment']['company_id'];			
				} else {
					$this->data['company_id'] = '';
				}
		
				// Tax ID
				if (isset($this->session->data['guest']['payment']['tax_id'])) {
					$this->data['tax_id'] = $this->session->data['guest']['payment']['tax_id'];			
				} else {
					$this->data['tax_id'] = '';
				}
			}

			if (isset($this->session->data['guest']['payment']['address_1'])) {
				$this->data['address_1'] = $this->session->data['guest']['payment']['address_1'];
			} else {
				$this->data['address_1'] = '';
			}

			if (isset($this->session->data['guest']['payment']['address_2'])) {
				$this->data['address_2'] = $this->session->data['guest']['payment']['address_2'];	
			} else {
				$this->data['address_2'] = '';
			}	

			if (isset($this->session->data['guest']['payment']['postcode'])) {
			//	$this->data['postcode'] = $this->session->data['guest']['payment']['postcode'];	
			//} elseif (isset($this->session->data['shipping_postcode'])) {
				//$this->data['postcode'] = $this->session->data['shipping_postcode'];			
			} else {
				$this->data['postcode'] = '';
			}			

			if (isset($this->session->data['guest']['payment']['city'])) {
				$this->data['city'] = $this->session->data['guest']['payment']['city'];	
			} else {
				$this->data['city'] = '';
			}	

			if (isset($this->session->data['guest']['payment']['country_id'])) {
				$this->data['country_id'] = $this->session->data['guest']['payment']['country_id'];	
			} elseif (isset($this->session->data['shipping_country_id'])) {
				$this->data['country_id'] = $this->session->data['shipping_country_id'];		
			} else {
				$this->data['country_id'] = $this->config->get('config_country_id');
			}

	

			if (isset($this->session->data['guest']['payment']['zone_id'])) {
				$this->data['zone_id'] = $this->session->data['guest']['payment']['zone_id'];	
			} elseif (isset($this->session->data['shipping_zone_id'])) {
				$this->data['zone_id'] = $this->session->data['shipping_zone_id'];						
			} else {
				$this->data['zone_id'] = $this->config->get('config_zone_id');
			}

			$this->data['countries'] = $this->model_onecheckout_checkout->getCountries();


			if ($this->config->get('config_account_id')) {

				$information_info = $this->model_onecheckout_checkout->getInformation($this->config->get('config_account_id'));


				if ($information_info) {
					$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
				} else {
					$this->data['text_agree'] = '';
				}

			} else {

				$this->data['text_agree'] = '';

			}
			
			$this->data['guest_checkout'] = ($this->config->get('config_guest_checkout') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());
			

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/onecheckout/form.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/onecheckout/form.tpl';
			} else {
				$this->template = 'default/template/onecheckout/form.tpl';
			}		

			$json['output'] = $this->render();		

		$this->response->setOutput($this->model_onecheckout_checkout->jsonencode($json));			

  	}
	
	public function validate(){
		
		$json['error']=array();
		
		$this->language->load('onecheckout/checkout');
		$this->load->model('onecheckout/checkout');	
		$version_int = $this->model_onecheckout_checkout->versiontoint();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			// inicio módulo cpf ###############################################   
			// separa a data
			if(isset($this->request->post['sexo'])) {
				if (strlen(utf8_decode($this->request->post['sexo'])) < 1) {
					$json['error']['sexo'] = "O campo Sexo é obrigatório";
				} else {
					$this->session->data['shipping']['sexo'] = $this->request->post['sexo'];
				}
			}
		
			if(isset($this->request->post['data_nascimento'])) {
				if (strlen(utf8_decode($this->request->post['data_nascimento'])) < 1) {
					$json['error']['data_nascimento'] = "O campo Data de nascimento é obrigatório";
				} else {
					$this->session->data['shipping']['data_nascimento'] = $this->request->post['data_nascimento'];
				}
			}
			/*
			if(isset($this->request->post['placa1'])) {
				if (strlen(utf8_decode($this->request->post['placa1'])) < 1) {
					$json['error']['placa1'] = "O campo Renavam do veiculo é obrigatório";
				} else {	
						$this->session->data['shipping']['placa1'] = $this->request->post['placa1']; 
				}
				
			}elseif (!$this->customer->renavam($this->request->post['placa1'])){
				$json['error']['placa1'] =  "O campo Renavam é inválido";
			}
			*/			
						
			
			if(isset($this->request->post['numero'])) {
				if (strlen(utf8_decode($this->request->post['numero'])) < 1) {
					$json['error']['numero'] = "O campo número é obrigatório";
				} else {
					$this->session->data['shipping']['numero'] = $this->request->post['numero']; 
				}
			}
			if ($this->request->post['pessoa'] == "fisica"){
				
					if ((strlen(utf8_decode($this->request->post['cpf'])) < 1) || (strlen(utf8_decode($this->request->post['cpf'])) > 14)) {
							$json['error']['cpf'] = "O CPF é obrigatório";  
					}elseif (!$this->customer->cpf($this->request->post['cpf'])){
						$json['error']['cpf'] = "O CPF é inválido!";  
					}
				
			}else if ($this->request->post['pessoa'] == "juridica"){
				
					 if ((strlen(utf8_decode($this->request->post['cnpj'])) < 1) || (strlen(utf8_decode($this->request->post['cnpj'])) > 18)&&($this->request->post['pessoa'] == "juridica")) {
					$json['error']['cnpj'] = "O CNPJ é obrigatório";
					}elseif (!$this->customer->cnpj($this->request->post['cnpj'])){
						$json['error']['cnpj'] = "O CNPJ é inválido!";  
					}
					
			}
			if (empty($this->request->post['sexo'])){
				$json['error']['sexo'] = "O campo Sexo é obrigatório";		
			}
			
			if ((strlen(utf8_decode($this->request->post['ddd'])) < 1)) {
					$json['error']['ddd'] = "O campo DDD é obrigatório";
			}
			if ((strlen(utf8_decode($this->request->post['numero'])) < 1)) {
					$json['error']['numero'] = "O campo número é obrigatório";
			}
			
			if ((strlen(utf8_decode($this->request->post['postcode'])) < 1)) {
				$json['error']['postcode'] = "O campo CEP é obrigatório";
			}
			
			// Fim módulo cpf ############################################### 
			
			if(isset($this->request->post['firstname'])) {
				if ((strlen(utf8_decode($this->request->post['firstname'])) < 1) || (strlen(utf8_decode($this->request->post['firstname'])) > 32)) {
					$json['error']['firstname'] = $this->language->get('error_firstname');
				} else {
					$this->session->data['shipping']['firstname'] = $this->request->post['firstname'];
				}
			}
		

			if(isset($this->request->post['lastname'])) {
				if ((strlen(utf8_decode($this->request->post['lastname'])) < 1) || (strlen(utf8_decode($this->request->post['lastname'])) > 32)) {
					$json['error']['lastname'] = $this->language->get('error_lastname');
				} else {
					$this->session->data['shipping']['lastname'] = $this->request->post['lastname'];
				}
			}

		
			if(isset($this->request->post['email'])) {
				
				if ((strlen(utf8_decode($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
					$json['error']['email'] = $this->language->get('error_email');
				} elseif ($this->model_onecheckout_checkout->getTotalCustomersByEmail($this->request->post['email'])) {
					$json['error']['email'] = $this->language->get('error_exists');
				}
			}

			if(isset($this->request->post['telephone'])) {
				if ((strlen(utf8_decode($this->request->post['telephone'])) < 3) || (strlen(utf8_decode($this->request->post['telephone'])) > 32)) {
					$json['error']['telephone'] = $this->language->get('error_telephone');
				}
			}
			
			//version
			if($version_int >= 1530){
				// Customer Group
				$this->load->model('account/customer_group');
			
				if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$customer_group_id = $this->request->post['customer_group_id'];
				} elseif ($this->customer->isLogged()) {
					$customer_group_id = $this->customer->getCustomerGroupId();
				} else {
					$customer_group_id = $this->config->get('config_customer_group_id');
				}
			
				$customer_group = $this->model_account_customer_group->getCustomerGroup($customer_group_id);
				
				if ($customer_group) {	
					// Company ID
					if ($customer_group['company_id_display'] && $customer_group['company_id_required'] && isset($this->request->post['company_id']) && empty($this->request->post['company_id'])) {
						$json['error']['company_id'] = $this->language->get('error_company_id');
					}
				
					// Tax ID
					if ($customer_group['tax_id_display'] && $customer_group['tax_id_required'] && isset($this->request->post['tax_id']) && empty($this->request->post['tax_id'])) {
						$json['error']['tax_id'] = $this->language->get('error_tax_id');
					}						
				}
			}
			
			if(isset($this->request->post['company'])) {
				$this->session->data['shipping']['company'] = $this->request->post['company'];
			}
	
			if(isset($this->request->post['address_1'])) {
				if ((strlen(utf8_decode($this->request->post['address_1'])) < 3) || (strlen(utf8_decode($this->request->post['address_1'])) > 128)) {
					$json['error']['address_1'] = $this->language->get('error_address_1');
				} else {
					$this->session->data['shipping']['address_1'] = $this->request->post['address_1'];
				}
			}

			if(isset($this->request->post['city'])) {
				if ((strlen(utf8_decode($this->request->post['city'])) < 2) || (strlen(utf8_decode($this->request->post['city'])) > 128)) {
					$json['error']['city'] = $this->language->get('error_city');
				}
			}

			if(isset($this->request->post['country_id'])) {				
				$country_info = $this->model_onecheckout_checkout->getCountry($this->request->post['country_id']);				

				if ($country_info){
					if(isset($this->request->post['postcode'])){
						if($country_info['postcode_required'] && (strlen(utf8_decode($this->request->post['postcode'])) < 2) || (strlen(utf8_decode($this->request->post['postcode'])) > 10)) {
							$json['error']['postcode'] = $this->language->get('error_postcode');
						}
					}
					
					if($version_int >= 1530 && isset($this->request->post['tax_id'])){
						// VAT Validation
						$this->load->helper('vat');
				
						if ($this->config->get('config_vat') && $this->request->post['tax_id'] && (vat_validation($country_info['iso_code_2'], $this->request->post['tax_id']) == 'invalid')) {
							$json['error']['tax_id'] = $this->language->get('error_vat');
						}
					}
				}				
			}

			if(isset($this->request->post['password'])) {
				if ((strlen(utf8_decode($this->request->post['password'])) < 4) || (strlen(utf8_decode($this->request->post['password'])) > 20)) {
					$json['error']['password'] = $this->language->get('error_password');
				}
			}		

			if(isset($this->request->post['password'])&&isset($this->request->post['confirm'])) {
				if ($this->request->post['confirm'] != $this->request->post['password']) {
					$json['error']['confirm'] = $this->language->get('error_confirm');
				}
			}
		
		}

		$this->response->setOutput($this->model_onecheckout_checkout->jsonencode($json));
	}
}
?>
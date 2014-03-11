<?php 
class ControllerPaymentPagamentoDigital extends Controller {
 	private $error = array(); 
	
	public function index() {
		$this->load->language('payment/pagamento_digital');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('pagamento_digital', $this->request->post);				
		  	
			$this->session->data['success'] = $this->language->get('text_success');
		  	
			$this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));			
		}
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		
		$this->data['entry_token'] = $this->language->get('entry_token');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_posfixo'] = $this->language->get('entry_posfixo');
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');		
		$this->data['entry_order_finalizando'] = $this->language->get('entry_order_finalizando');
		$this->data['entry_order_andamento'] = $this->language->get('entry_order_andamento');
		$this->data['entry_order_concluido'] = $this->language->get('entry_order_concluido');
		$this->data['entry_order_cancelado'] = $this->language->get('entry_order_cancelado');
		$this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');	
		$this->data['entry_dados_cliente'] = $this->language->get('entry_dados_cliente');
		$this->data['entry_update_status_alert'] = $this->language->get('entry_update_status_alert');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
		  $this->data['error_warning'] = $this->error['warning'];
		} else {
		  $this->data['error_warning'] = '';
		}
					
		if (isset($this->error['token'])) {
		  $this->data['error_token'] = $this->error['token'];
		} else {
		  $this->data['error_token'] = '';
		}
		
		if (isset($this->error['email'])) {
		  $this->data['error_email'] = $this->error['email'];
		} else {
		  $this->data['error_email'] = '';
		}
		
		$this->data['breadcrumbs'] = array();
		
		$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),  
				'text'      => $this->language->get('text_home'),
				'separator' => false
		);
		
		$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
				'text'      => $this->language->get('text_payment'),
				'separator' => ' :: '
		);
		
		$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('payment/pagamento_digital', 'token=' . $this->session->data['token'], 'SSL'),
				'text'      => $this->language->get('heading_title'),
				'separator' => ' :: '
		);
					
		$this->data['action'] = $this->url->link('payment/pagamento_digital', 'token=' . $this->session->data['token'], 'SSL');
			
		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['pagamento_digital_token'])) {
		  $this->data['pagamento_digital_token'] = $this->request->post['pagamento_digital_token'];
		} else {
		  $this->data['pagamento_digital_token'] = $this->config->get('pagamento_digital_token');
		}
			
		if (isset($this->request->post['pagamento_digital_email'])) {
		  $this->data['pagamento_digital_email'] = $this->request->post['pagamento_digital_email'];
		} else {
		  $this->data['pagamento_digital_email'] = $this->config->get('pagamento_digital_email');
		}

		if (isset($this->request->post['pagamento_digital_posfixo'])) {
			$this->data['pagamento_digital_posfixo'] = $this->request->post['pagamento_digital_posfixo'];
		} else {
			$this->data['pagamento_digital_posfixo'] = $this->config->get('pagamento_digital_posfixo');
		}

		if (isset($this->request->post['pagamento_digital_dados_cliente'])) {
			$this->data['pagamento_digital_dados_cliente'] = $this->request->post['pagamento_digital_dados_cliente'];
		} else {
			$this->data['pagamento_digital_dados_cliente'] = $this->config->get('pagamento_digital_dados_cliente');
		}

		if (isset($this->request->post['pagamento_digital_update_status_alert'])) {
			$this->data['pagamento_digital_update_status_alert'] = $this->request->post['pagamento_digital_update_status_alert'];
		} else {
			$this->data['pagamento_digital_update_status_alert'] = $this->config->get('pagamento_digital_update_status_alert');
		}		
		
		if (isset($this->request->post['pagamento_digital_order_finalizando'])) {
		  $this->data['pagamento_digital_order_finalizando'] = $this->request->post['pagamento_digital_order_finalizando'];
		} else {
		  $this->data['pagamento_digital_order_finalizando'] = $this->config->get('pagamento_digital_order_finalizando'); 
		}    
		
		if (isset($this->request->post['pagamento_digital_order_andamento'])) {
		  $this->data['pagamento_digital_order_andamento'] = $this->request->post['pagamento_digital_order_andamento'];
		} else {
		  $this->data['pagamento_digital_order_andamento'] = $this->config->get('pagamento_digital_order_andamento'); 
		}
			
		if (isset($this->request->post['pagamento_digital_order_concluido'])) {
		  $this->data['pagamento_digital_order_concluido'] = $this->request->post['pagamento_digital_order_concluido'];
		} else {
		  $this->data['pagamento_digital_order_concluido'] = $this->config->get('pagamento_digital_order_concluido'); 
		}
			
		if (isset($this->request->post['pagamento_digital_order_cancelado'])) {
		  $this->data['pagamento_digital_order_cancelado'] = $this->request->post['pagamento_digital_order_cancelado'];
		} else {
		  $this->data['pagamento_digital_order_cancelado'] = $this->config->get('pagamento_digital_order_cancelado'); 
		}
		
		if (isset($this->request->post['pagamento_digital_order_nao_efetivado'])) {
			$this->data['pagamento_digital_order_nao_efetivado'] = $this->request->post['pagamento_digital_order_nao_efetivado'];
		} else {
			$this->data['pagamento_digital_order_nao_efetivado'] = $this->config->get('pagamento_digital_order_nao_efetivado');
		}    
		
		if (isset($this->request->post['pagamento_digital_order_status_id'])) {
		  $this->data['pagamento_digital_order_status_id'] = $this->request->post['pagamento_digital_order_status_id'];
		} else {
		  $this->data['pagamento_digital_order_status_id'] = $this->config->get('pagamento_digital_order_status_id'); 
		}
		
		$this->load->model('localisation/order_status');
		
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['pagamento_digital_geo_zone_id'])) {
		  $this->data['pagamento_digital_geo_zone_id'] = $this->request->post['pagamento_digital_geo_zone_id'];
		} else {
		  $this->data['pagamento_digital_geo_zone_id'] = $this->config->get('pagamento_digital_geo_zone_id'); 
		} 
		
		$this->load->model('localisation/geo_zone');
		
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['pagamento_digital_status'])) {
		  $this->data['pagamento_digital_status'] = $this->request->post['pagamento_digital_status'];
		} else {
		  $this->data['pagamento_digital_status'] = $this->config->get('pagamento_digital_status');
		}
		
		if (isset($this->request->post['pagamento_digital_sort_order'])) {
		  $this->data['pagamento_digital_sort_order'] = $this->request->post['pagamento_digital_sort_order'];
		} else {
		  $this->data['pagamento_digital_sort_order'] = $this->config->get('pagamento_digital_sort_order');
		}
		
		$this->template = 'payment/pagamento_digital.tpl';
		$this->children = array(
				'common/header',	
				'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	private function validate() {
	
		if (!$this->user->hasPermission('modify', 'payment/pagamento_digital')) {
		  $this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['pagamento_digital_token']) {
		  $this->error['token'] = $this->language->get('error_token');
		}
		
		if (!$this->request->post['pagamento_digital_email']) {
		  $this->error['email'] = $this->language->get('error_email');
		}
		
		if (!$this->error) {
		  return TRUE;
		} else {
		  return FALSE;
		}	
	}
}
?>
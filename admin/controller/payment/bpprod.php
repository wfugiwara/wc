<?php 
/*
BrasPag Produtos API Loja5 - 29/07/2013 Todos os direitos reservados
Site: www.loja5.com.br
Contato: suportedaloja@gmail.com
Modudo Comercial de Propriedade Unica - Licenciado por Loja5
*/
class ControllerPaymentBPProd extends Controller {

	private $error = array(); 
	
	public function index() { 
		$this->language->load('payment/bpprod');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('bpprod', $this->request->post);
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
			'href'      => $this->url->link('payment/bpprod', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('payment/bpprod', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');	
			
		
		//dados modulo
		$this->pegar('bpprod_nome');
		$this->pegar('bpprod_order_status_id');
		$this->pegar('bpprod_autorizado');
		$this->pegar('bpprod_aprovado');
		$this->pegar('bpprod_cancelado');
		$this->pegar('bpprod_chave');
		$this->pegar('bpprod_ambiente');
		$this->pegar('bpprod_cancelado');
		$this->pegar('bpprod_cc');
		$this->pegar('bpprod_bo');
		$this->pegar('bpprod_total');

		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		$this->pegar('bpprod_geo_zone_id');
		
		$this->load->model('localisation/geo_zone');						
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		$this->pegar('bpprod_status');
		
		$this->pegar('bpprod_sort_order');

		$this->template = 'payment/bpprod.tpl';
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
	
}
?>
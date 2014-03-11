<?php
class ControllerLocalisationEmailProviders extends Controller {
	private $error = array();  
 
	public function index() {
		$this->data = array();
		$this->data = array_merge($this->data, $this->load->language('localisation/email_providers'));

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),     		
      		'separator' => false
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('localisation/email_providers', 'token=' . $this->session->data['token'], 'SSL'),     		
      		'separator' => ' : : '
   		);
				
		$this->load->model('localisation/email_providers');
		
		// Check if installed
		$this->model_localisation_email_providers->install();
		
		$results = $this->model_localisation_email_providers->getProviders();
		
		if(isset($results['email_providers'])){
			$this->data['email_providers'] = $results['email_providers'];
		}else{
			$this->data['email_providers'] = '';
		}
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['action'] = $this->url->link('localisation/email_providers/update', 'token=' . $this->session->data['token'] . '', 'SSL');
		
		$this->template = 'localisation/email_providers.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function update() {
		$this->load->language('localisation/email_providers');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('localisation/email_providers');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_email_providers->updateProviders($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			
			$this->redirect($this->url->link('localisation/email_providers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		$this->index();
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'localisation/email_providers')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
			
		if (!$this->error) {
			return true;
		} else {
			echo 'test';
			return false;
		}
	}
	
}
?>
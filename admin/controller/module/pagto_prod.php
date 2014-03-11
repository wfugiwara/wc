<?php
class ControllerModulePagtoProd extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/pagto_prod');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('pagto_prod', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_frase'] = $this->language->get('entry_frase');
		$this->data['entry_frase2'] = $this->language->get('entry_frase2');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}
				
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pagto_prod', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/pagto_prod', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		
		
		if (isset($this->request->post['status_pagto_prod'])) {
			$this->data['status_pagto_prod'] = $this->request->post['status_pagto_prod'];
		} elseif ($this->config->get('banner_module')) { 
			$this->data['status_pagto_prod'] = $this->config->get('status_pagto_prod');
		}	
		if (isset($this->request->post['frase_pagto_prod'])) {
			$this->data['frase_pagto_prod'] = $this->request->post['frase_pagto_prod'];
		} elseif ($this->config->get('frase_pagto_prod')) { 
			$this->data['frase_pagto_prod'] = $this->config->get('frase_pagto_prod');
		}else{
			$this->data['frase_pagto_prod'] = "";
		}	
		
		if (isset($this->request->post['frase_pagto_prod2'])) {
			$this->data['frase_pagto_prod2'] = $this->request->post['frase_pagto_prod2'];
		} elseif ($this->config->get('frase_pagto_prod2')) { 
			$this->data['frase_pagto_prod2'] = $this->config->get('frase_pagto_prod2');
		}else{
			$this->data['frase_pagto_prod2'] = "";
		}		
		
				
		$this->template = 'module/pagto_prod.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/pagto_prod')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	 public function install() {
        $query = $this->db->query("ALTER TABLE  `" . DB_PREFIX . "product` ADD  `forma_pgto` VARCHAR( 20 ) NOT NULL AFTER  `viewed`");	
	}
	public function uninstall() {
		$query = $this->db->query("ALTER TABLE  `" . DB_PREFIX . "product` DROP  `forma_pgto` ");
	}      
}
?>
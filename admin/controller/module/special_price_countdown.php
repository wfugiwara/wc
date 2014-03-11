<?php
class ControllerModuleSpecialPriceCountDown extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/special_price_countdown');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('special_price_countdown', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_heading_title'] = $this->language->get('text_heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
				
		$this->data['entry_hours_bs'] = $this->language->get('entry_hours_bs');
		$this->data['entry_show_days'] = $this->language->get('entry_show_days');
		$this->data['entry_digit_wh'] = $this->language->get('entry_digit_wh');

		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
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
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/special_price_countdown', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/special_price_countdown', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;
		
		foreach($languages as $language){
			$key = 'special_price_countdown_heading_title_' . $language['language_id'];
			if (isset($this->request->post[$key])){
				$this->data['box_heading_title'][$language['language_id']] = $this->request->post[$key]; 
			} elseif ( $this->config->get($key) ){
				$this->data['box_heading_title'][$language['language_id']] = $this->config->get($key); 
			} else {
				$this->data['box_heading_title'][$language['language_id']] = ' ';
			}
		}
		
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['special_price_countdown_module'])) {
			$this->data['modules'] = $this->request->post['special_price_countdown_module'];
		} elseif ($this->config->get('special_price_countdown_module')) { 
			$this->data['modules'] = $this->config->get('special_price_countdown_module');
		}				

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->template = 'module/special_price_countdown.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/special_price_countdown')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}	
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
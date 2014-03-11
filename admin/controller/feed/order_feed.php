<?php 
#####################################################################################
#  Module Order Feed for Opencart 1.5.0.x From HostJars opencart.hostjars.com 		#
#####################################################################################
?>
<?php

class ControllerFeedOrderFeed extends Controller {
	public function index() {
		$this->load->language('feed/order_feed');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		//define all language items
		$language_info = array(
			'heading_title',
			'entry_status',
			'entry_date',
			'entry_from',
			'entry_to',
			'entry_total_sum',
			'entry_order_numbers',
			'entry_none',
			'entry_export',
			'entry_currency',
			'option_filtered',
			'option_all',
			'button_export',
			'button_save',
			'button_cancel',
			'text_success',
		);
		
		//load each language item
		foreach ($language_info as $language) {
			$this->data[$language] = $this->language->get($language);
		}
		
		//define each setting
		$settings_info = array(
			'order_feed_status',
			'order_feed_sum_from',
			'order_feed_date_from',
			'order_feed_order_from',
			'order_feed_sum_to',
			'order_feed_date_to',
			'order_feed_order_to',
			'order_feed_export',
		);
		
		//generate the blank settings array for each setting
		foreach ($settings_info as $setting) {
			if (isset($this->request->post[$setting])) {
				$this->data[$setting] = $this->request->post[$setting];
			} else {
				$this->data[$setting] = $this->config->get($setting);
			}	
		}
		
		$this->load->model('localisation/order_status');
    	$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
				
		//get the token
		$this->data['token'] = $this->session->data['token'];
		
		//get any stored settings data
		$settings = $this->model_setting_setting->getSetting('order_feed');
		foreach ($settings as $key => $value) {
			$this->data[$key] = $value ? unserialize($value) : $value;
		}
						
		$this->data['data_feed'] = HTTP_CATALOG . 'index.php?route=feed/order_feed';
		
		if (isset($this->session->data['warning'])) {
			$this->data['error_warning'] = $this->session->data['warning'];
			unset($this->session->data['warning']);
		} else {
			$this->data['error_warning'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_feed'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('feed/order_feed', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
				
		$this->data['action'] = $this->url->link('feed/order_feed', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['backup'] = $this->url->link('feed/order_feed/backup', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->template = 'feed/order_feed.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render());
	} 
	
	public function backup() {
		
		$data = array();
		
		if (defined('CLI_INITIATED')) {
			
			$this->load->model('feed/order_feed');
			$this->load->model('setting/setting');
			$settings = $this->model_setting_setting->getSetting('order_feed');
			foreach ($settings as $key => $value) {
				$settings[$key] = $value ? unserialize($value) : $value;
			}
			
			if(isset($settings['order_feed_export']) && $settings['order_feed_export'] != 'all') {
				$data = $settings;
			}
			$output = $this->model_feed_order_feed->createCSV($data);
			file_put_contents(FILE_NAME, $output);
			return;
		}
		
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('feed/order_feed');
			
			$settings = $this->request->post;
			
			if($settings['order_feed_export'] != 'all') {
				$data = $settings;
			}
			$this->saveSettings();
	
			$output = $this->model_feed_order_feed->createCSV($data);
						
			if ($output) {
				$this->response->addheader('Pragma: public');
				$this->response->addheader('Expires: 0');
				$this->response->addheader('Content-Description: File Transfer');
				$this->response->addheader('Content-Type: application/octet-stream ; charset=utf-8');
				$this->response->addheader('Content-Disposition: attachment; filename=order_export.csv');
				$this->response->addheader('Content-Transfer-Encoding: binary');
				$this->response->setOutput($output);
			} else {
				$this->session->data['warning'] = "No orders to export";
				$this->redirect($this->url->link('feed/order_feed', 'token=' . $this->session->data['token'], 'SSL'));				
			}
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'feed/order_feed')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}

	private function saveSettings($type='POST') {
		if($type = 'POST') {
			$settings = $this->request->post;
		} else {
			$settings = $this->request->get;
		}
		
		if($settings){
			$settings = $this->request->post;
			foreach ($settings as $key => $value) {
				$settings[$key] = serialize($value);
			}
			//store each setting for this module
			$this->load->model('setting/setting');
			$this->model_setting_setting->editSetting('order_feed', $settings);
		}
	}
	
	public function saveModuleSettings() {
		$this->saveSettings('GET');
		$this->load->language('feed/order_feed');
		print $this->language->get('text_success');
	}
}
?>
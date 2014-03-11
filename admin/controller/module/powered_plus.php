<?php
class ControllerModulePoweredPlus extends Controller {
	private $error = array();
	public function index() {
		$this->load->language('module/powered_plus');
		$this->document->setTitle($this->language->get('pp_title'));
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$arr_pp = array('pplus_align' => $this->request->post['pp_align'], 'pplus_setting' => implode(',', $this->request->post['pp_use']), 'pplus_message' => $this->request->post['pp_text']);
			$this->model_setting_setting->editSetting('pplus', $arr_pp);
			$this->session->data['success'] = $this->language->get('pp_success_text');
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error']) ) {
			$this->data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		}
		else {
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
			'text'      => $this->language->get('pp_title'),
			'href'      => $this->url->link('module/powered_plus', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['button_save'] = $this->language->get('pp_save');
		$this->data['button_cancel'] = $this->language->get('pp_cancel');

		if (isset($this->request->post['pp_align'])) {
			$this->data['pp_align'] = $this->request->post['pp_align'];
		} else {
			$this->data['pp_align'] = $this->config->get('pplus_align');
		}
		
		if (isset($this->request->post['pp_use'])) {
			$this->data['pp_use'] = $this->request->post['pp_use'];
		} else {
			$this->data['pp_use'] = explode(",", $this->config->get('pplus_setting'));
		}
		
		if (isset($this->request->post['pp_text'])) {
			$this->data['pp_text'] = $this->request->post['pp_text'];
		} else {
			$this->data['pp_text'] = $this->config->get('pplus_message');
		}

		$this->data['action'] = $this->url->link('module/powered_plus', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['heading_title'] = $this->language->get('pp_title');
		$this->data['description'] = $this->language->get('pp_description');
		$this->data['entry_align'] = $this->language->get('pp_entry_align');
		$this->data['entry_left'] = $this->language->get('pp_entry_left');
		$this->data['entry_center'] = $this->language->get('pp_entry_center');
		$this->data['entry_right'] = $this->language->get('pp_entry_right');
		$this->data['entry_use_copyright'] = $this->language->get('pp_entry_use_copyright');
		$this->data['entry_use_shop_name'] = $this->language->get('pp_entry_use_shop_name');
		$this->data['entry_use_address'] = $this->language->get('pp_entry_use_address');
		$this->data['entry_use_phone'] = $this->language->get('pp_entry_use_phone');
		$this->data['entry_use_fax'] = $this->language->get('pp_entry_use_fax');
		$this->data['entry_use_mail'] = $this->language->get('pp_entry_use_mail');
		$this->data['entry_use_id'] = $this->language->get('pp_entry_use_id');
		$this->data['entry_use_id_description'] = $this->language->get('pp_entry_use_id_description');
		$this->data['entry_my_text'] = $this->language->get('pp_entry_my_text');
		$this->data['entry_my_text_description'] = $this->language->get('pp_entry_my_text_description');
		$this->data['yes'] = $this->language->get('pp_yes');
		$this->data['yes_nl'] = $this->language->get('pp_yes_nl');
		$this->data['no'] = $this->language->get('pp_no');

		$this->data['modules'] = array();
		
		if (isset($this->request->post['powered_plus_module'])) {
			$this->data['modules'] = $this->request->post['powered_plus_module'];
		} else { 
			$this->data['modules'] = $this->config->get('powered_plus_module');
		}

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
						
		$this->template = 'module/powered_plus.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());

	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/powered_plus')) {
			$this->error['warning'] = $this->language->get('pp_error_access');
		}
		
		if (isset($this->request->post['powered_plus_module'])) {
			foreach ($this->request->post['powered_plus_module'] as $key => $value) {				
				
			}
		}	
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	public function install() {
		$this->db->query("INSERT INTO ". DB_PREFIX . "setting VALUES (NULL,'". (int)$this->config->get('store_admin') ."','pplus','pplus_setting','Y,y,y,y,y,y,Y','0')");
		$this->db->query("INSERT INTO ". DB_PREFIX . "setting VALUES (NULL,'". (int)$this->config->get('store_admin') ."','pplus','pplus_message','','0')");
		$this->db->query("INSERT INTO ". DB_PREFIX . "setting VALUES (NULL,'". (int)$this->config->get('store_admin') ."','pplus','pplus_align','left','0')");
	}

	public function uninstall() {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `key` = 'pplus_setting'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `key` = 'pplus_message'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `key` = 'pplus_align'");
	}

}
?>

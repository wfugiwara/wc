<?php
class ControllerTotalAVista extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('total/avista');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('avista', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

      $this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['entry_total'] = $this->language->get('entry_total');
		$this->data['entry_methods'] = $this->language->get('entry_methods');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

      $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_total'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('total/avista', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('total/avista', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['avista_status'])) {
			$this->data['avista_status'] = $this->request->post['avista_status'];
		} else {
			$this->data['avista_status'] = $this->config->get('avista_status');
		}

		if (isset($this->request->post['avista_sort_order'])) {
			$this->data['avista_sort_order'] = $this->request->post['avista_sort_order'];
		} else {
			$this->data['avista_sort_order'] = $this->config->get('avista_sort_order');
		}

		if (isset($this->request->post['avista_total'])) {
			$this->data['avista_total'] = $this->request->post['avista_total'];
		} else {
			$this->data['avista_total'] = $this->config->get('avista_total');
		}

		if (isset($this->request->post['avista_methods'])) {
			$this->data['avista_methods'] = $this->request->post['avista_methods'];
		} else {
			$this->data['avista_methods'] = $this->config->get('avista_methods');
		}
		$this->template = 'total/avista.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'total/avista')) {
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

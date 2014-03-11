<?php  
class ControllerModuleCorreiosRastreamento extends Controller {
	protected function index() {
		$this->language->load('module/correios_rastreamento');
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_tip'] = $this->language->get('text_tip');
		$this->data['text_button'] = $this->language->get('text_button');
		$this->data['text_tip2'] = $this->language->get('text_tip2');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/correios_rastreamento.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/correios_rastreamento.tpl';
		} else {
			$this->template = 'default/template/module/correios_rastreamento.tpl';
		}
		
		$this->render();
	}
}
?>

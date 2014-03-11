<?php
class ControllerModuleServiceAvailability extends Controller {
	protected function index($setting) {
		$this->language->load('module/service_availability');
 
      		$this->data['heading_title'] = $this->language->get('heading_title');		

		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_check_availability'] = $this->language->get('text_check_availability');
		$this->data['text_service_available'] = $this->language->get('text_service_available');
		$this->data['text_service_unavailable'] = $this->language->get('text_service_unavailable');
		
		$this->data['entry_country'] = $this->language->get('entry_country');
		$this->data['entry_zone'] = $this->language->get('entry_zone');
		
		$this->data['country_id'] = $this->config->get('config_country_id');

		$this->load->model('localisation/country');
		
		$this->data['countries'] = $this->model_localisation_country->getCountries();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/service_availability.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/service_availability.tpl';
		} else {
			$this->template = 'default/template/module/service_availability.tpl';
		}

		$this->render();
	}

	public function country() {
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'zone'=> $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id'])		
			);
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function getserviceavailability(){
		
		$this->load->model('localisation/service_availability');
		$total = $this->model_localisation_service_availability->getServiceAvailability($this->request->get['country_id'],$this->request->get['zone_id']);
		if($total > 0) {
			$json = array("service_available"=>"true");
		} else {
			$json = array("service_available"=>"false");
		}
		$this->response->setOutput(json_encode($json));
	}
}
?>

<?php
class ControllerModuleShopbycolor extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/shopbycolor');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('shopbycolor', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['select_color'] = $this->language->get('Select Color');
		$this->data['color_name'] = $this->language->get('Color Tag Name');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
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
			'href'      => $this->url->link('module/shopbycolor', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/shopbycolor', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['sbc_width'])) {
			$this->data['sbc_width'] = $this->request->post['sbc_width'];
		} else {
			$this->data['sbc_width'] = $this->config->get('sbc_width');
		}
		
		if (isset($this->request->post['sbc_height'])) {
			$this->data['sbc_height'] = $this->request->post['sbc_height'];
		} else {
			$this->data['sbc_height'] = $this->config->get('sbc_height');
		}
		
		if (isset($this->request->post['sbc_margin'])) {
			$this->data['sbc_margin'] = $this->request->post['sbc_margin'];
		} else {
			$this->data['sbc_margin'] = $this->config->get('sbc_margin');
		}

		if (isset($this->request->post['color_1'])) {
			$this->data['color_1'] = $this->request->post['color_1'];
		} else {
			$this->data['color_1'] = $this->config->get('color_1');
		}
		
		if (isset($this->request->post['color_1_tag'])) {
			$this->data['color_1_tag'] = $this->request->post['color_1_tag'];
		} else {
			$this->data['color_1_tag'] = $this->config->get('color_1_tag');
		}
		
		
		
		if (isset($this->request->post['color_2'])) {
			$this->data['color_2'] = $this->request->post['color_2'];
		} else {
			$this->data['color_2'] = $this->config->get('color_2');
		}
		
		if (isset($this->request->post['color_2_tag'])) {
			$this->data['color_2_tag'] = $this->request->post['color_2_tag'];
		} else {
			$this->data['color_2_tag'] = $this->config->get('color_2_tag');
		}
		
		
		if (isset($this->request->post['color_3'])) {
			$this->data['color_3'] = $this->request->post['color_3'];
		} else {
			$this->data['color_3'] = $this->config->get('color_3');
		}
		
		if (isset($this->request->post['color_3_tag'])) {
			$this->data['color_3_tag'] = $this->request->post['color_3_tag'];
		} else {
			$this->data['color_3_tag'] = $this->config->get('color_3_tag');
		}
		
		if (isset($this->request->post['color_4'])) {
			$this->data['color_4'] = $this->request->post['color_4'];
		} else {
			$this->data['color_4'] = $this->config->get('color_4');
		}
		
		if (isset($this->request->post['color_4_tag'])) {
			$this->data['color_4_tag'] = $this->request->post['color_4_tag'];
		} else {
			$this->data['color_4_tag'] = $this->config->get('color_4_tag');
		}
		
		
		if (isset($this->request->post['color_5'])) {
			$this->data['color_5'] = $this->request->post['color_5'];
		} else {
			$this->data['color_5'] = $this->config->get('color_5');
		}
		
		if (isset($this->request->post['color_5_tag'])) {
			$this->data['color_5_tag'] = $this->request->post['color_5_tag'];
		} else {
			$this->data['color_5_tag'] = $this->config->get('color_5_tag');
		}
		
		if (isset($this->request->post['color_6'])) {
			$this->data['color_6'] = $this->request->post['color_6'];
		} else {
			$this->data['color_6'] = $this->config->get('color_6');
		}
		
		if (isset($this->request->post['color_6_tag'])) {
			$this->data['color_6_tag'] = $this->request->post['color_6_tag'];
		} else {
			$this->data['color_6_tag'] = $this->config->get('color_6_tag');
		}
		
		if (isset($this->request->post['color_7'])) {
			$this->data['color_7'] = $this->request->post['color_7'];
		} else {
			$this->data['color_7'] = $this->config->get('color_7');
		}
		
		if (isset($this->request->post['color_7_tag'])) {
			$this->data['color_7_tag'] = $this->request->post['color_7_tag'];
		} else {
			$this->data['color_7_tag'] = $this->config->get('color_7_tag');
		}
		
		if (isset($this->request->post['color_8'])) {
			$this->data['color_8'] = $this->request->post['color_8'];
		} else {
			$this->data['color_8'] = $this->config->get('color_8');
		}

		if (isset($this->request->post['color_8_tag'])) {
			$this->data['color_8_tag'] = $this->request->post['color_8_tag'];
		} else {
			$this->data['color_8_tag'] = $this->config->get('color_8_tag');
		}
		
		if (isset($this->request->post['color_9'])) {
			$this->data['color_9'] = $this->request->post['color_9'];
		} else {
			$this->data['color_9'] = $this->config->get('color_9');
		}
		
		if (isset($this->request->post['color_9_tag'])) {
			$this->data['color_9_tag'] = $this->request->post['color_9_tag'];
		} else {
			$this->data['color_9_tag'] = $this->config->get('color_9_tag');
		}
		
		if (isset($this->request->post['color_10'])) {
			$this->data['color_10'] = $this->request->post['color_10'];
		} else {
			$this->data['color_10'] = $this->config->get('color_10');
		}
		
		if (isset($this->request->post['color_10_tag'])) {
			$this->data['color_10_tag'] = $this->request->post['color_10_tag'];
		} else {
			$this->data['color_10_tag'] = $this->config->get('color_10_tag');
		}
		
		if (isset($this->request->post['color_11'])) {
			$this->data['color_11'] = $this->request->post['color_11'];
		} else {
			$this->data['color_11'] = $this->config->get('color_11');
		}
		
		if (isset($this->request->post['color_11_tag'])) {
			$this->data['color_11_tag'] = $this->request->post['color_11_tag'];
		} else {
			$this->data['color_11_tag'] = $this->config->get('color_11_tag');
		}
		
		if (isset($this->request->post['color_12'])) {
			$this->data['color_12'] = $this->request->post['color_12'];
		} else {
			$this->data['color_12'] = $this->config->get('color_12');
		}
		
		if (isset($this->request->post['color_12_tag'])) {
			$this->data['color_12_tag'] = $this->request->post['color_12_tag'];
		} else {
			$this->data['color_12_tag'] = $this->config->get('color_12_tag');
		}
		
		if (isset($this->request->post['color_13'])) {
			$this->data['color_13'] = $this->request->post['color_13'];
		} else {
			$this->data['color_13'] = $this->config->get('color_13');
		}
		
		if (isset($this->request->post['color_13_tag'])) {
			$this->data['color_13_tag'] = $this->request->post['color_13_tag'];
		} else {
			$this->data['color_13_tag'] = $this->config->get('color_13_tag');
		}
		
		if (isset($this->request->post['color_14'])) {
			$this->data['color_14'] = $this->request->post['color_14'];
		} else {
			$this->data['color_14'] = $this->config->get('color_14');
		}
		
		if (isset($this->request->post['color_14_tag'])) {
			$this->data['color_14_tag'] = $this->request->post['color_14_tag'];
		} else {
			$this->data['color_14_tag'] = $this->config->get('color_14_tag');
		}
		
		if (isset($this->request->post['color_15'])) {
			$this->data['color_15'] = $this->request->post['color_15'];
		} else {
			$this->data['color_15'] = $this->config->get('color_15');
		}

		if (isset($this->request->post['color_15_tag'])) {
			$this->data['color_15_tag'] = $this->request->post['color_15_tag'];
		} else {
			$this->data['color_15_tag'] = $this->config->get('color_15_tag');
		}
		
		if (isset($this->request->post['color_16'])) {
			$this->data['color_16'] = $this->request->post['color_16'];
		} else {
			$this->data['color_16'] = $this->config->get('color_16');
		}
		
		if (isset($this->request->post['color_16_tag'])) {
			$this->data['color_16_tag'] = $this->request->post['color_16_tag'];
		} else {
			$this->data['color_16_tag'] = $this->config->get('color_16_tag');
		}
		
		if (isset($this->request->post['color_17'])) {
			$this->data['color_17'] = $this->request->post['color_17'];
		} else {
			$this->data['color_17'] = $this->config->get('color_17');
		}

		if (isset($this->request->post['color_17_tag'])) {
			$this->data['color_17_tag'] = $this->request->post['color_17_tag'];
		} else {
			$this->data['color_17_tag'] = $this->config->get('color_17_tag');
		}
		
		if (isset($this->request->post['color_18'])) {
			$this->data['color_18'] = $this->request->post['color_18'];
		} else {
			$this->data['color_18'] = $this->config->get('color_18');
		}
		
		if (isset($this->request->post['color_18_tag'])) {
			$this->data['color_18_tag'] = $this->request->post['color_18_tag'];
		} else {
			$this->data['color_18_tag'] = $this->config->get('color_18_tag');
		}

		
		if (isset($this->request->post['color_19'])) {
			$this->data['color_19'] = $this->request->post['color_19'];
		} else {
			$this->data['color_19'] = $this->config->get('color_19');
		}
				
		if (isset($this->request->post['color_19_tag'])) {
			$this->data['color_19_tag'] = $this->request->post['color_19_tag'];
		} else {
			$this->data['color_19_tag'] = $this->config->get('color_19_tag');
		}
		
		if (isset($this->request->post['color_20'])) {
			$this->data['color_20'] = $this->request->post['color_20'];
		} else {
			$this->data['color_20'] = $this->config->get('color_20');
		}

		if (isset($this->request->post['color_20_tag'])) {
			$this->data['color_20_tag'] = $this->request->post['color_20_tag'];
		} else {
			$this->data['color_20_tag'] = $this->config->get('color_20_tag');
		}
		
		if (isset($this->request->post['color_21'])) {
			$this->data['color_21'] = $this->request->post['color_21'];
		} else {
			$this->data['color_21'] = $this->config->get('color_21');
		}

		if (isset($this->request->post['color_21_tag'])) {
			$this->data['color_21_tag'] = $this->request->post['color_21_tag'];
		} else {
			$this->data['color_21_tag'] = $this->config->get('color_21_tag');
		}
		
		if (isset($this->request->post['color_22'])) {
			$this->data['color_22'] = $this->request->post['color_22'];
		} else {
			$this->data['color_22'] = $this->config->get('color_22');
		}

		if (isset($this->request->post['color_22_tag'])) {
			$this->data['color_22_tag'] = $this->request->post['color_22_tag'];
		} else {
			$this->data['color_22_tag'] = $this->config->get('color_22_tag');
		}
		
		if (isset($this->request->post['color_23'])) {
			$this->data['color_23'] = $this->request->post['color_23'];
		} else {
			$this->data['color_23'] = $this->config->get('color_23');
		}
		
		if (isset($this->request->post['color_23_tag'])) {
			$this->data['color_23_tag'] = $this->request->post['color_23_tag'];
		} else {
			$this->data['color_23_tag'] = $this->config->get('color_23_tag');
		}
		
		if (isset($this->request->post['color_24'])) {
			$this->data['color_24'] = $this->request->post['color_24'];
		} else {
			$this->data['color_24'] = $this->config->get('color_24');
		}
		
		if (isset($this->request->post['color_24_tag'])) {
			$this->data['color_24_tag'] = $this->request->post['color_24_tag'];
		} else {
			$this->data['color_24_tag'] = $this->config->get('color_24_tag');
		}		
		
		if (isset($this->request->post['color_25'])) {
			$this->data['color_25'] = $this->request->post['color_25'];
		} else {
			$this->data['color_25'] = $this->config->get('color_25');
		}
		
		if (isset($this->request->post['color_25_tag'])) {
			$this->data['color_25_tag'] = $this->request->post['color_25_tag'];
		} else {
			$this->data['color_25_tag'] = $this->config->get('color_25_tag');
		}

		
		if (isset($this->request->post['color_26'])) {
			$this->data['color_26'] = $this->request->post['color_26'];
		} else {
			$this->data['color_26'] = $this->config->get('color_26');
		}
				
		if (isset($this->request->post['color_26_tag'])) {
			$this->data['color_26_tag'] = $this->request->post['color_26_tag'];
		} else {
			$this->data['color_26_tag'] = $this->config->get('color_26_tag');
		}
		
		if (isset($this->request->post['color_27'])) {
			$this->data['color_27'] = $this->request->post['color_27'];
		} else {
			$this->data['color_27'] = $this->config->get('color_27');
		}

		if (isset($this->request->post['color_27_tag'])) {
			$this->data['color_27_tag'] = $this->request->post['color_27_tag'];
		} else {
			$this->data['color_27_tag'] = $this->config->get('color_27_tag');
		}
		
		if (isset($this->request->post['color_28'])) {
			$this->data['color_28'] = $this->request->post['color_28'];
		} else {
			$this->data['color_28'] = $this->config->get('color_28');
		}
		
		
		if (isset($this->request->post['color_28_tag'])) {
			$this->data['color_28_tag'] = $this->request->post['color_28_tag'];
		} else {
			$this->data['color_28_tag'] = $this->config->get('color_28_tag');
		}
		
		if (isset($this->request->post['color_29'])) {
			$this->data['color_29'] = $this->request->post['color_29'];
		} else {
			$this->data['color_29'] = $this->config->get('color_29');
		}
		
		
		if (isset($this->request->post['color_29_tag'])) {
			$this->data['color_29_tag'] = $this->request->post['color_29_tag'];
		} else {
			$this->data['color_29_tag'] = $this->config->get('color_29_tag');
		}
		
		if (isset($this->request->post['color_30_tag'])) {
			$this->data['color_30'] = $this->request->post['color_30'];
		} else {
			$this->data['color_30'] = $this->config->get('color_30');
		}

		
		if (isset($this->request->post['color_30_tag'])) {
			$this->data['color_30_tag'] = $this->request->post['color_30_tag'];
		} else {
			$this->data['color_30_tag'] = $this->config->get('color_30_tag');
		}		

		if (isset($this->request->post['color_31'])) {
			$this->data['color_31'] = $this->request->post['color_31'];
		} else {
			$this->data['color_31'] = $this->config->get('color_31');
		}
		
		if (isset($this->request->post['color_31_tag'])) {
			$this->data['color_31_tag'] = $this->request->post['color_31_tag'];
		} else {
			$this->data['color_31_tag'] = $this->config->get('color_31_tag');
		}
		
		if (isset($this->request->post['color_32'])) {
			$this->data['color_32'] = $this->request->post['color_32'];
		} else {
			$this->data['color_32'] = $this->config->get('color_32');
		}
		
		if (isset($this->request->post['color_32_tag'])) {
			$this->data['color_32_tag'] = $this->request->post['color_32_tag'];
		} else {
			$this->data['color_32_tag'] = $this->config->get('color_32_tag');
		}
		
		
		if (isset($this->request->post['color_33'])) {
			$this->data['color_33'] = $this->request->post['color_33'];
		} else {
			$this->data['color_33'] = $this->config->get('color_33');
		}
		
		if (isset($this->request->post['color_33_tag'])) {
			$this->data['color_33_tag'] = $this->request->post['color_33_tag'];
		} else {
			$this->data['color_33_tag'] = $this->config->get('color_33_tag');
		}
		
		if (isset($this->request->post['color_34'])) {
			$this->data['color_34'] = $this->request->post['color_34'];
		} else {
			$this->data['color_34'] = $this->config->get('color_34');
		}

		if (isset($this->request->post['color_34_tag'])) {
			$this->data['color_34_tag'] = $this->request->post['color_34_tag'];
		} else {
			$this->data['color_34_tag'] = $this->config->get('color_34_tag');
		}
		
		if (isset($this->request->post['color_35'])) {
			$this->data['color_35'] = $this->request->post['color_35'];
		} else {
			$this->data['color_35'] = $this->config->get('color_35');
		}

		if (isset($this->request->post['color_35_tag'])) {
			$this->data['color_35_tag'] = $this->request->post['color_35_tag'];
		} else {
			$this->data['color_35_tag'] = $this->config->get('color_35_tag');
		}
		
		
		
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['shopbycolor_module'])) {
			$this->data['modules'] = $this->request->post['shopbycolor_module'];
		} elseif ($this->config->get('shopbycolor_module')) { 
			$this->data['modules'] = $this->config->get('shopbycolor_module');
		}			
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/shopbycolor.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/shopbycolor')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
//		if (!$this->request->post['color_1']) {
//			$this->error['color_1'] = $this->language->get('error_code');
//		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
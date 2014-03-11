<?php  
class ControllerModuleShopbycolor extends Controller {
	protected function index() {
		$this->language->load('module/shopbycolor');

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['color_1'] = html_entity_decode($this->config->get('color_1'));
		$this->data['color_1_tag'] = html_entity_decode($this->config->get('color_1_tag'));
		$this->data['color_2'] = html_entity_decode($this->config->get('color_2'));
		$this->data['color_2_tag'] = html_entity_decode($this->config->get('color_2_tag'));
		$this->data['color_3'] = html_entity_decode($this->config->get('color_3'));
		$this->data['color_3_tag'] = html_entity_decode($this->config->get('color_3_tag'));
		$this->data['color_4'] = html_entity_decode($this->config->get('color_4'));
		$this->data['color_4_tag'] = html_entity_decode($this->config->get('color_4_tag'));

		$this->data['color_5'] = html_entity_decode($this->config->get('color_5'));
		$this->data['color_5_tag'] = html_entity_decode($this->config->get('color_5_tag'));
		$this->data['color_6'] = html_entity_decode($this->config->get('color_6'));
		$this->data['color_6_tag'] = html_entity_decode($this->config->get('color_6_tag'));
		$this->data['color_7'] = html_entity_decode($this->config->get('color_7'));
		$this->data['color_7_tag'] = html_entity_decode($this->config->get('color_7_tag'));
		$this->data['color_8'] = html_entity_decode($this->config->get('color_8'));
		$this->data['color_8_tag'] = html_entity_decode($this->config->get('color_8_tag'));
		
		$this->data['color_9'] = html_entity_decode($this->config->get('color_9'));
		$this->data['color_9_tag'] = html_entity_decode($this->config->get('color_9_tag'));
		$this->data['color_10'] = html_entity_decode($this->config->get('color_10'));
		$this->data['color_10_tag'] = html_entity_decode($this->config->get('color_10_tag'));
		$this->data['color_11'] = html_entity_decode($this->config->get('color_11'));
		$this->data['color_11_tag'] = html_entity_decode($this->config->get('color_11_tag'));
		$this->data['color_12'] = html_entity_decode($this->config->get('color_12'));
		$this->data['color_12_tag'] = html_entity_decode($this->config->get('color_12_tag'));
		
		$this->data['color_13'] = html_entity_decode($this->config->get('color_13'));
		$this->data['color_13_tag'] = html_entity_decode($this->config->get('color_13_tag'));
		$this->data['color_14'] = html_entity_decode($this->config->get('color_14'));
		$this->data['color_14_tag'] = html_entity_decode($this->config->get('color_14_tag'));
		$this->data['color_15'] = html_entity_decode($this->config->get('color_15'));
		$this->data['color_15_tag'] = html_entity_decode($this->config->get('color_15_tag'));
		$this->data['color_16'] = html_entity_decode($this->config->get('color_16'));
		$this->data['color_16_tag'] = html_entity_decode($this->config->get('color_16_tag'));
		
		$this->data['color_17'] = html_entity_decode($this->config->get('color_17'));
		$this->data['color_17_tag'] = html_entity_decode($this->config->get('color_17_tag'));
		$this->data['color_18'] = html_entity_decode($this->config->get('color_18'));
		$this->data['color_18_tag'] = html_entity_decode($this->config->get('color_18_tag'));
		$this->data['color_19'] = html_entity_decode($this->config->get('color_19'));
		$this->data['color_19_tag'] = html_entity_decode($this->config->get('color_19_tag'));
		$this->data['color_20'] = html_entity_decode($this->config->get('color_20'));
		$this->data['color_20_tag'] = html_entity_decode($this->config->get('color_20_tag'));
		
		$this->data['color_21'] = html_entity_decode($this->config->get('color_21'));
		$this->data['color_21_tag'] = html_entity_decode($this->config->get('color_21_tag'));
		$this->data['color_22'] = html_entity_decode($this->config->get('color_22'));
		$this->data['color_22_tag'] = html_entity_decode($this->config->get('color_22_tag'));
		$this->data['color_23'] = html_entity_decode($this->config->get('color_23'));
		$this->data['color_23_tag'] = html_entity_decode($this->config->get('color_23_tag'));
		$this->data['color_24'] = html_entity_decode($this->config->get('color_24'));
		$this->data['color_24_tag'] = html_entity_decode($this->config->get('color_24_tag'));
		
		$this->data['color_25'] = html_entity_decode($this->config->get('color_25'));
		$this->data['color_25_tag'] = html_entity_decode($this->config->get('color_25_tag'));
		$this->data['color_26'] = html_entity_decode($this->config->get('color_26'));
		$this->data['color_26_tag'] = html_entity_decode($this->config->get('color_26_tag'));
		$this->data['color_27'] = html_entity_decode($this->config->get('color_27'));
		$this->data['color_27_tag'] = html_entity_decode($this->config->get('color_27_tag'));
		$this->data['color_28'] = html_entity_decode($this->config->get('color_28'));
		$this->data['color_28_tag'] = html_entity_decode($this->config->get('color_28_tag'));
		
		$this->data['color_29'] = html_entity_decode($this->config->get('color_29'));
		$this->data['color_29_tag'] = html_entity_decode($this->config->get('color_29_tag'));
		$this->data['color_30'] = html_entity_decode($this->config->get('color_30'));
		$this->data['color_30_tag'] = html_entity_decode($this->config->get('color_30_tag'));
		$this->data['color_31'] = html_entity_decode($this->config->get('color_31'));
		$this->data['color_31_tag'] = html_entity_decode($this->config->get('color_31_tag'));
		$this->data['color_32'] = html_entity_decode($this->config->get('color_32'));
		$this->data['color_32_tag'] = html_entity_decode($this->config->get('color_32_tag'));
		
		$this->data['color_33'] = html_entity_decode($this->config->get('color_33'));
		$this->data['color_33_tag'] = html_entity_decode($this->config->get('color_33_tag'));
		$this->data['color_34'] = html_entity_decode($this->config->get('color_34'));
		$this->data['color_34_tag'] = html_entity_decode($this->config->get('color_34_tag'));
		$this->data['color_35'] = html_entity_decode($this->config->get('color_35'));
		$this->data['color_35_tag'] = html_entity_decode($this->config->get('color_35_tag'));
		$this->data['color_36'] = html_entity_decode($this->config->get('color_36'));
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/shopbycolor.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/shopbycolor.tpl';
		} else {
			$this->template = 'default/template/module/shopbycolor.tpl';
		}
		
		$this->render();
	}
}
?>
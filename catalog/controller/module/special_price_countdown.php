<?php
class ControllerModuleSpecialPriceCountDown extends Controller {
	protected function index($setting) {
		static $module = 0;

		$this->data['heading_title'] = $this->config->get('special_price_countdown_heading_title_' . $this->config->get('config_language_id') );
		
		$this->document->addScript('catalog/view/javascript/jquery/jquery.countdown.js');
		
		$this->load->model('module/special_price_countdown');
		
		$this->data['show_special_price_countdown'] = 0;
		
		if (isset($this->request->get['product_id'])){
		
			$date_stop = $this->model_module_special_price_countdown->getSpecialPriceEndData($this->request->get['product_id']);
			
			if ($date_stop){
				
				$target_split = preg_split('/\-/', $date_stop);		
				
				$now = time();
				$target = mktime(0,0,0, $target_split[1], $target_split[2], $target_split[0]);
				$diffSecs = $target - $now;
				
				if ($diffSecs <= $setting['hours_bs'] * 60 * 60 && $diffSecs > 0){
				    
					$this->data['show_special_price_countdown'] = 1;
					
					$this->data['countdown_format'] = 'dd:hh:mm:ss';
					$this->data['show_days'] = 1;
					
					if ($setting['show_days'] ==0 && $diffSecs < 24 * 60 * 60 ){
						$this->data['countdown_format'] = 'hh:mm:ss';
						$this->data['show_days'] = 0;
					}
					
					$date = array();
					$date['secs'] = $diffSecs % 60;
					$date['mins'] = floor($diffSecs/60)%60;
					$date['hours'] = floor($diffSecs/60/60)%24;
					$date['days'] = floor($diffSecs/60/60/24);//%7;
					$date['weeks']	= floor($diffSecs/60/60/24/7);
				
					foreach ($date as $i => $d) {
						$d1 = $d%10;
						$d2 = ($d-$d1) / 10;
						$date[$i] = array(
							(int)$d2,
							(int)$d1,
							(int)$d
						);
					}
					
					$this->data['target_split'] = $target_split;
					$this->data['date']         = $date;
					
					$this->data['secs']  = $diffSecs % 60;
					$this->data['mins']  = floor($diffSecs/60)%60;
					$this->data['hours'] = floor($diffSecs/60/60)%24;
					$this->data['days']  = floor($diffSecs/60/60/24);//%7;
					$this->data['weeks'] = floor($diffSecs/60/60/24/7);
					
					$this->data['digit_width']  = $setting['digit_width'];
					$this->data['digit_height'] = $setting['digit_height'];
					$countdown_image_width  = $setting['digit_width'];
					$countdown_image_height = $setting['digit_height'] *60; 
					$search_height = $setting['digit_height'];
					
					if ( ($setting['digit_width'] != 53 && $setting['digit_height'] != 77) || $search_height < 10 ){  // original image
						
						$calcWidth      = 53 / (4619 / ($search_height * 60));
						$roundCalcWidth = round($calcWidth);

						while( $roundCalcWidth - $calcWidth < 0){
						    $search_height--;
							$calcWidth      = 53 / (4619 / ($search_height * 60));
							$roundCalcWidth = round($calcWidth);
						}

						$countdown_image_width  = $roundCalcWidth;
						$countdown_image_height = $search_height *60; 
						$this->data['digit_height'] = $search_height;
						$this->data['digit_width']  = $roundCalcWidth;
						
					}	
					
			
					$this->load->model('tool/image');
					$this->data['digit_image']  = $this->model_tool_image->resize('data/special_price_countdown/digits.png', $countdown_image_width, $countdown_image_height );
					
					$this->data['new_font_size'] = round(($setting['digit_height'] * 43 ) / 77);
				}
			} 	
		}
		
		$this->data['theme_name'] = $this->config->get('config_template');

		$this->data['module'] = $module++;
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/special_price_countdown.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/special_price_countdown.tpl';
		} else {
			$this->template = 'default/template/module/special_price_countdown.tpl';
		}

		$this->render();
	}
}
?>
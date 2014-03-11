<?php
/* 
 * @package Zopim Live Chat
 * @version 0.2.2
 */  
class ControllerModuleZopimLiveChat extends Controller {
	protected function index() {
		$this->load->language('module/zopim_live_chat');
		$this->load->model('account/customer');
		
		if ($this->customer->isLogged()) {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
			$zopimname = $customer_info['firstname']." ".$customer_info['lastname'];
			$zopimemail = $customer_info['email'];
		}else{
			$zopimname = "Visitor from ".$this->config->get('zopim_store');
			$zopimemail = "Set Your Email Here";
		}
		
		$this->data['code'] = $this->config->get('zopim_code');
		$this->data['username'] = $zopimname;
		$this->data['useremail'] = $zopimemail;
		$this->data['language'] = $this->config->get('zopim_language');
		$this->data['position'] = $this->config->get('zopim_position');
		$this->data['theme'] = $this->config->get('zopim_theme');
		$this->data['color'] = $this->config->get('zopim_color');
		$this->data['bubbleTitle'] = $this->config->get('zopim_bubbletitle');
		$this->data['bubbleText'] = $this->config->get('zopim_bubbletext');
		$this->data['bubbleEnable'] = $this->config->get('zopim_bubbleEnable');
		$this->data['OnlineShort'] = $this->config->get('zopim_OnlineShort');
		$this->data['AwayShort'] = $this->config->get('zopim_AwayShort');
		$this->data['OfflineShort'] = $this->config->get('zopim_OfflineShort');
		$this->data['OnlineLong'] = $this->config->get('zopim_OnlineLong');
		$this->data['AwayLong'] = $this->config->get('zopim_AwayLong');
		$this->data['OfflineLong'] = $this->config->get('zopim_OfflineLong');
		$this->data['hideonoffline'] = $this->config->get('zopim_hideonoffline');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/zopim_live_chat.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/zopim_live_chat.tpl';
		} else {
			$this->template = 'default/template/module/zopim_live_chat.tpl';
		}
		
		$this->render();
	}
}
?>

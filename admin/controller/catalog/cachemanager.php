<?php 
class ControllerCatalogCacheManager extends Controller {
	public function index(){
		$this->load->language('catalog/cachemanager');

		$this->document->setTitle($this->language->get('heading_title'));
				
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/cachemanager', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['delete'] = HTTPS_SERVER . 'index.php?route=catalog/cachemanager/delete&token=' . $this->session->data['token'];
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_expire'] = $this->language->get('column_expire');
		$this->data['column_action'] = $this->language->get('column_action');
		$this->data['button_delete'] = $this->language->get('button_delete');
		
		$this->data['caches'] = array();
		$files = glob(DIR_CACHE . 'cache.*');
		foreach($files as $file){
			$data = explode('/', $file);
			if (strpos(end($data),'.') > 0){
				if (end($data) != 'index.html') {
					$time = substr(strrchr(end($data), '.'), 1);
					$this->data['caches'][] = array(
						'name' 		=> end($data),
						'time'		=> round(($time - time())/60),
						'selected'  => isset($this->request->post['selected']) && in_array(end($data), $this->request->post['selected']),
					);
				}
			}
		}
		
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->template = 'catalog/cache_list.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	public function delete(){
		$this->load->language('catalog/cachemanager');

		$this->document->setTitle($this->language->get('heading_title'));
				
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $name) {
				$fullpath = DIR_CACHE . $name;
				if (file_exists($fullpath)){
					@unlink($fullpath);
				}
			}

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect(HTTPS_SERVER . 'index.php?route=catalog/cachemanager&token=' . $this->session->data['token']);
		}

		$this->getList();
	}
	
	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/cachemanager')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
 
		if (!$this->error) {
			return TRUE; 
		} else {
			return FALSE;
		}
	}
}
?>
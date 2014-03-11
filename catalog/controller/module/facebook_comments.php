<?php
class ControllerModuleFacebookComments extends Controller {
	protected function index($setting) {				
		static $module = 0;
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/information');
		
		$this->data['heading_title'] = $this->config->get('facebook_comments_heading_title_' . $this->config->get('config_language_id'));
		$this->data['app_id']         = $this->config->get('facebook_comments_app_id');
		$this->data['width']          = $setting['width'];
		$this->data['posts']          = $setting['posts'];
		$this->data['color_scheme']   = $setting['color_scheme'];
		
		$this->document->addFBMeta('fb:app_id', $this->config->get('facebook_comments_app_id'));
		
		if (isset($this->request->get['route'])){
			$route = $this->request->get['route'];
		} else {
			$route = 'common/home';
		}
		
		
		if (isset($this->request->get['product_id'])){
			$current_url = $this->url->link('product/product', 'product_id=' . $this->request->get['product_id'], 'SSL');
			$product_id = $this->request->get['product_id'];
			$product_info = $this->model_catalog_product->getProduct($product_id);
			$this->document->addFBMeta('og:title', $product_info['name']);
			$this->document->addFBMeta('og:type', 'product');
			$this->document->addFBMeta('og:url', $this->url->link('product/product', 'product_id=' . $product_id, 'SSL'));
			if ($product_info['image']) {
				$image = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$image = '';
			}
			$this->document->addFBMeta('og:image', $image);
			$this->document->addFBMeta('og:description', trim(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8'))));
			
		
		} elseif ( $route == 'product/category' && isset($this->request->get['path'])){
			$parts =  explode('_', $this->request->get['path']);
			$category_id = $parts[ count($parts) - 1];
			$current_url = $this->url->link('product/category', 'path=' . $category_id, 'SSL');
			
			$category_info = $this->model_catalog_category->getCategory($category_id);
			$this->document->addFBMeta('og:title', $category_info['name']);
			$this->document->addFBMeta('og:type', 'product');
			$this->document->addFBMeta('og:url', $this->url->link('product/category', 'path=' . $category_id, 'SSL'));
			if ($category_info['image']) {
				$image = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$image = '';
			}
			$this->document->addFBMeta('og:image', $image);
			$this->document->addFBMeta('og:description', trim(strip_tags(html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8'))));
		
		} elseif ( $route == 'product/manufacturer'){
			if (isset($this->request->get['manufacturer_id'])){
				$current_url = $this->url->link('product/manufacturer', 'manufacturer_id=' . $this->request->get['manufacturer_id'], 'SSL');
				$manufacturer_id = $this->request->get['manufacturer_id'];
				$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);
				$this->document->addFBMeta('og:title', $manufacturer_info['name']);
				$this->document->addFBMeta('og:type', 'product');
				$this->document->addFBMeta('og:url', $this->url->link('product/manufacturer', 'manufacturer_id=' . $manufacturer_id, 'SSL'));
				if ($manufacturer_info['image']) {
					$image = $this->model_tool_image->resize($manufacturer_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
				} else {
					$image = '';
				}
				$this->document->addFBMeta('og:image', $image);
				$this->document->addFBMeta('og:description', $manufacturer_info['name']);
				
			} else {
				$current_url = $this->url->link('product/manufacturer', '', 'SSL'); 	
			}				
		
		} elseif ( $route == 'information/information' && isset($this->request->get['information_id'])){
			$current_url = $this->url->link('information/information', 'information_id=' . $this->request->get['information_id'], 'SSL'); 
			$information_id = $this->request->get['information_id'];
			$information_info = $this->model_catalog_information->getInformation($information_id);
			$this->document->addFBMeta('og:title', trim(strip_tags(html_entity_decode($information_info['title'], ENT_QUOTES, 'UTF-8'))));
			$this->document->addFBMeta('og:type', 'product');
			$this->document->addFBMeta('og:url', $this->url->link('information/information', 'information_id=' . $information_id, 'SSL'));
			$this->document->addFBMeta('og:image', '');
			$this->document->addFBMeta('og:description', trim(strip_tags(html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8'))));
		
		} else {
				$current_url = 'http';
	   
				/*
				if ($this->request->server["HTTPS"] == "on") {
					$current_url .= "s";
				}
				*/
				
				$current_url .= "://";
				
				if ($this->request->server["SERVER_PORT"] != "80") {
					$current_url .= $this->request->server["SERVER_NAME"] . ":" . $this->request->server["SERVER_PORT"] . $this->request->server["REQUEST_URI"];
				} else {
					$current_url .= $this->request->server["SERVER_NAME"] . $this->request->server["REQUEST_URI"];
				}
		  }
		 
		
		$this->data['current_url'] = $current_url;
		
		$this->data['module'] = $module++; 
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/facebook_comments.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/facebook_comments.tpl';
		} else {
			$this->template = 'default/template/module/facebook_comments.tpl';
		}

		$this->render();
	}
}
?>
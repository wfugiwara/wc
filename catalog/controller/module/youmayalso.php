<?php
class ControllerModuleYoumayalso extends Controller {
	protected function index($setting) {
		$this->language->load('module/youmayalso');
		
      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
				
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
		
		$this->data['products'] = array();
		if($this->cart->hasProducts()){
			foreach ($this->cart->getProducts() as $product) {
				$products = $this->model_catalog_product->getProductRelated($product['product_id']);
				foreach($products as $result){
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
					} else {
						$image = false;
					}
								
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
							
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}
					
					$this->data['products'][$result['product_id']] = array(
						'product_id' => $result['product_id'],
						'thumb'   	 => $image,
						'name'    	 => $result['name'],
						'price'   	 => $price,
						'special' 	 => $special,
						'rating'     => $rating,
						'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
						'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
			}
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/youmayalso.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/youmayalso.tpl';
		} else {
			$this->template = 'default/template/module/youmayalso.tpl';
		}

		$this->render();
	}
}
?>
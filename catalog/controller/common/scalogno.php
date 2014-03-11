<?php   
class ControllerCommonScalogno extends Controller {
	public function getCatChildren() {
		$children = array();
		if (isset($this->request->post['category_id'])) { 
			$category_id = $this->request->post['category_id'];
		} else {
			$category_id = 0;
		} 
		if (isset($this->request->post['category_path'])) { 
			$category_path = $this->request->post['category_path'];
		} else {
			$category_path = "";
		} 
		if ( isset($this->session->data['cacheCatChildren'.$category_id.'-'.$this->config->get('config_language_id')]) ) {
			$this->response->setOutput(json_encode($this->session->data['cacheCatChildren'.$category_id.'-'.$this->config->get('config_language_id')]));
		} else {
			$this->load->model('catalog/category');
			$this->load->model('catalog/product');		
			$children = $this->model_catalog_category->getCategories($category_id);
			foreach ($children as &$child) { //occhio all'&
				$child["href"] = $this->url->link('product/category', 'path=' . implode("_",explode(",",$category_path))."_".$child["category_id"]);
				$child["total"] = $this->model_catalog_product->getTotalProducts( array( 
					"filter_category_id" => $child["category_id"],
					'filter_sub_category' => true
				));
			}
			$this->session->data['cacheCatChildren'.$category_id.'-'.$this->config->get('config_language_id')] = $children;
			$this->response->setOutput(json_encode($children));
		}
	}		
	
	public function getCatProducts() {
		$products = array();
		if (isset($this->request->post['category_id'])) {
			$category_id = $this->request->post['category_id'];
		} else {
			$category_id = 0;
		} 
		if (isset($this->request->post['start'])) {
			$start = $this->request->post['start'];
		} else {
			$start = 0;
		} 
		if (isset($this->request->post['limit'])) {
			$limit = $this->request->post['limit'];
		} else {
			$limit = 6;
		} 
		if (isset($this->request->post['category_path'])) { 
			$category_path = $this->request->post['category_path'];
		} else {
			$category_path = "";
		} 
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		
		$products = $this->model_catalog_product->getProducts(array( 
				"filter_category_id" => $category_id,
				"filter_sub_category" => true,
				"start" => $start,
				"limit" => $limit
			));
		
		$this->load->model('tool/image');
		foreach ($products as &$product) { //occhio all'&
			$product["imageThumb"] = $this->model_tool_image->resize( ($product['image']) ? $product['image'] : 'no_image_70x70.jpg' , 70, 70);
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$product["priceFull"] = $this->currency->format($this->tax->calculate($product["price"], 9, $this->config->get('config_tax')));
			} else {
				$product["priceFull"] = 'price error';
			}
			if ($product["special"])
			{
			    $product["specialFull"] = $this->currency->format($this->tax->calculate($product["special"], 9, $this->config->get('config_tax')));
			}			
			$product["href"] = $this->url->link('product/product', 'path=' . implode("_",explode(",",$category_path)) . '&product_id='.$product["product_id"], 'SSL' );
			
		}
		$this->response->setOutput(json_encode($products));
	}		
	
	
	
	
	
	
	
	
	
	
}
?>
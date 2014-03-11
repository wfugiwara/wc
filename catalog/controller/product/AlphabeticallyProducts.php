<?php
class ControllerProductAlphabeticallyProducts extends Controller{
    
    private $page_limit = 10;
    
    public function index(){
        
        $this->language->load('product/AlphabeticallyProducts');
        
        $this->load->model('catalog/AlphabeticallyProducts');
        
        $this->load->model('tool/image');
		
        if(isset($this->request->get['char'])){
            $char = $this->request->get['char'];            
            
            if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}
            
            $results = $this->model_catalog_AlphabeticallyProducts->get_selected_products($char,($page-1)*$this->page_limit,$this->page_limit);
            $total = sizeof($results);
	    
	    if ($char==''){
                $title = "Products starting with non alphabetic character";   
            } else {
                $title = str_replace('%char',strtoupper($char),$this->language->get('heading_title'));
            }                
            
                $this->document->setTitle($title);
                
                $this->data['heading_title'] = $title;              
                
                $this->data['breadcrumbs'] = array();
                $this->data['href'] = HTTP_SERVER;

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),			
			'separator' => false
		);
                
                $this->data['breadcrumbs'][] = array(
        		'href'      => $this->url->link('product/AlphabeticallyProducts&char='.$char),
        		'text'      => $title,
        		'separator' => $this->language->get('text_separator')
      		);		
						
      		$this->data['heading_title'] = $title;
      		
      		$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->data['continue'] = (HTTP_SERVER . 'index.php?route=common/home');
                
                $this->data['products'] = array();
                //$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
                foreach ($results as $result) {
				
				$this->data['products'][] = array(
					'name'    => $result['name'],
					'id'	=> $result['product_id'],
                                        'image' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'))
				);
				//print($this->data['testimonials']);
			}
			
			$url = '';
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$pagination = new Pagination();
			$pagination->total = $total;
			$pagination->page = $page;
			$pagination->limit = 10; 
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/AlphabeticallyProducts&page={page}');			
		
			$this->data['pagination'] = $pagination->render();	


			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/AlphabeticallyProducts.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/AlphabeticallyProducts.tpl';
			} else {
				$this->template = 'default/template/product/AlphabeticallyProducts.tpl';
			}
			
			$this->children = array(
				'common/header',
				'common/footer',
				'common/content_top',
				'common/content_bottom',
				'common/column_left',
				'common/column_right'
			);		
			
	  		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
        }
    }
}
?>
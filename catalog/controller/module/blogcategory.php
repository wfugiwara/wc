<?php  
class ControllerModuleBlogcategory extends Controller {
   protected function index($setting) {
      $this->load->model('blog/category');
      $this->language->load('module/blogcategory');
      
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_module.css')) {
         $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_module.css');
      } else {
         $this->document->addStyle('catalog/view/theme/default/stylesheet/blog_module.css');
      }
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_module_custom.css')) { // use for customize
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_module_custom.css');
		} elseif (file_exists(DIR_TEMPLATE . 'default/stylesheet/blog_module_custom.css')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_module_custom.css');
		}
      
      $this->data['heading_title'] = $this->language->get('heading_title');
      $this->data['classSuffix']      = $setting['suffix'];
      
      if (isset($this->request->get['category_id'])) {
         $parts = explode('_', (string)$this->request->get['category_id']);
      } else {
         $parts = array();
      }
      if (isset($parts[0])) {
         $this->data['category_id'] = $parts[0];
      } else {
         $this->data['category_id'] = 0;
      }
      if (isset($parts[1])) {
         $this->data['child_id'] = $parts[1];
      } else {
         $this->data['child_id'] = 0;
      }
      
      $data = array();
      if(isset($setting['exclude']) && $setting['exclude']) { $data = array( 'exclude' => $setting['exclude']); }
      
      $categories = $this->model_blog_category->getCategories(0, $data);
      
      $this->data['categories'] = array();
      foreach ($categories as $category) {
         $children = $this->model_blog_category->getCategories($category['category_id'], $data);
         
         $children_data = array();
         foreach ($children as $child) {
            $data = array(
               'filter_category_id'  => $child['category_id'],
               'filter_sub_category' => true
            );      
               
            if ($setting['count']) {
               $article_total = '['.$this->model_blog_article->getTotalArticles($data).'] ';
            } else {
               $article_total = false;
            }
            
            $children_data[] = array(
               'category_id' => $child['category_id'],
               'name'        => $article_total . $child['name'],
               'href'        => $this->url->link('blog/category', 'category_id=' . $category['category_id'] . '_' . $child['category_id'])   
            );               
         }
         
         $data = array(
            'filter_category_id'  => $category['category_id'],
            'filter_sub_category' => true
         );      
            
         if ($setting['count']) {
            $article_total = '['.$this->model_blog_article->getTotalArticles($data).'] ';
         } else {
            $article_total = false;
         }
         
         $this->data['categories'][] = array(
            'category_id' => $category['category_id'],
            'name'        => $article_total . $category['name'],
            'children'    => $children_data,
            'href'        => $this->url->link('blog/category', 'category_id=' . $category['category_id'])
         );
      }
      
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blogcategory.tpl')) {
         $this->template = $this->config->get('config_template') . '/template/module/blogcategory.tpl';
      } else {
         $this->template = 'default/template/module/blogcategory.tpl';
      }
      
      $this->render();
     }
}
?>
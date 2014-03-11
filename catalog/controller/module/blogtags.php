<?php
class ControllerModuleBlogtags extends Controller {
   protected function index($setting) {
      $this->load->model('blog/article');
      $this->data = $this->language->load('module/blogtags');
      
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
      
      $this->data['classSuffix']      = $setting['suffix'];

      $tagsData = $this->model_blog_article->getTags($setting['limit']);
      $this->data['tagsData'] = $this->generateTags($tagsData, 10, 20);

      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blogtags.tpl')) {
         $this->template = $this->config->get('config_template') . '/template/module/blogtags.tpl';
      } else {
         $this->template = 'default/template/module/blogtags.tpl';
      }

      $this->render();
   }
   
   private function generateTags($tags, $min_font = 10, $max_font = 20) {
      $max_qty = null;
      $min_qty = null;
      
      if (!empty($tags)) {
         $max_qty = max(array_values($tags));
         $min_qty = min(array_values($tags));
      }

      $spread = $max_qty - $min_qty; if ($spread == 0) { $spread = 1; }
      $step = ($max_font - $min_font) / ($spread);
      $cloud = array();

      foreach ($tags as $key => $value) {
         if($this->config->get('tagcloud_font_function') == '0'){
            $size=rand((int)$min_font,(int)$max_font);
         }else{
            $size = round($min_font + (($value - $min_qty) * $step));
         }
         $cloud[] = '<a href="' . $this->url->link('product/search', 'filter_tag=' . $key) . '" style="font-size: ' . $size . 'px" title="' . $value . ' ' .$this->language->get('text_href_title') . ' ' . $key . '">' . $key . '</a> ';
      }

      $tagcloud = '';
      for ($x = 0; $x < count($cloud); $x++) {
         $tagcloud .= $cloud[$x];
      }

      return $tagcloud;
   }
}
?>
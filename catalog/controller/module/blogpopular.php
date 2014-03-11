<?php
class ControllerModuleBlogpopular extends Controller {
   protected function index($setting) {
      $this->load->model('tool/image');
      $this->load->model('blog/article');
      $this->language->load('module/blogpopular');
      
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
      
		$this->data['heading_title']		= $this->language->get('heading_title');
		$this->data['classSuffix']			= $setting['suffix'];

      if ($setting['spesific']) {
         if ($setting['spesific'] < 0 || $setting['spesific'] == '-') {
            $title_position = 'top';
         } else {
            $title_position = false;
         }
         $spesific = abs($setting['spesific']);
      } else {
         $spesific = false;
         $title_position = false;
      }
      
      if ($setting['exclude'] && !$setting['spesific']) {
         $exclude = explode(',', $setting['exclude']);
      } else {
         $exclude = array();
      }
      
      $data = array(
         'article_order'      => 'viewDesc',
         'filter_category_id' => $spesific,
         'exclude_category'   => $exclude,
         'start'              => 0,
         'limit'              => $setting['limit']
      );

      $this->load->model('blog/category');
      $categoryData = $this->model_blog_category->getCategory($spesific);
      if ($categoryData) {
         $this->data['catTitle'] = $categoryData['name'];
      } else {
         $this->data['catTitle'] = '';
      }
      $this->load->model('blog/setting');
      $blogSetting = $this->model_blog_setting->getSettings();
      $this->load->model('blog/helper');
      $this->data['articles'] = array();
      $results = $this->model_blog_article->getArticles($data);
      
      foreach ($results as $result) {
         if ($result['image']) {
            $image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
         } else {
            $image = false;
         }
         if (isset($blogSetting['artInfoDate'])) {
            $art_InfoDate = $this->model_blog_helper->date_format($result['created'], 'dfs');
         } else {
            $art_InfoDate = '';
         }
         if ($setting['description']) {
            $description = strip_tags($this->model_blog_helper->truncate(html_entity_decode($result['description']), $setting['description']));
         } else {
            $description = false;
         }

         $this->data['articles'][] = array(
            'articlet_id'   => $result['article_id'],
            'image'         => $image,
            'title'         => $result['title'],
            'titlePos'      => $title_position,
            'author'        => $result['author'],
            'created'       => $art_InfoDate, 
            'description'   => $description,
            'link'          => $this->url->link('blog/article', 'article_id=' . $result['article_id'])
         );
      }

      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blogpopular.tpl')) {
         $this->template = $this->config->get('config_template') . '/template/module/blogpopular.tpl';
      } else {
         $this->template = 'default/template/module/blogpopular.tpl';
      }

      $this->render();
   }
}
?>
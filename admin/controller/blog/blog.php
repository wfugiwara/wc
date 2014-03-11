<?php
class ControllerBlogBlog extends Controller {
   private $error = array();
 
   public function index() {
      $this->load->model('blog/blog');
      $this->load->model('blog/author');
      $this->load->model('blog/setting');
      $this->data = $this->load->language('blog/blog');

      $this->document->setTitle($this->language->get('heading_title'));
      $this->document->addStyle('view/stylesheet/blog.css');
      
      $this->data['link_author']          = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
      $this->data['link_copyright']       = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
      $this->data['oc_footer']            = sprintf($this->language->get('oc_footer'), VERSION);
      
      $blogSetting = $this->model_blog_setting->getSettings();
      
      if (mysql_num_rows(mysql_query("SHOW TABLES LIKE '". DB_PREFIX ."blog_setting'")) != '1') { $this->redirect($this->url->link('blog/blog/install', 'token=' . $this->session->data['token'], 'SSL')); }
      
		//===== Update db from 1.1 to 1.2.x
      if (!isset($blogSetting['seoSuffix'])) {
         // updating Database
         $this->model_blog_blog->update11to12x();
         
         $this->session->data['success']      = sprintf($this->language->get('success_update'), $this->language->get('product_version'));
      }
		
		//===== Update db from 1.2.x to 1.3
      if (!isset($blogSetting['guestComment'])) {
			// listing and update all existing categories
			$catBlogCols	= array();
			$this->load->model('blog/category');
			$results			= $this->model_blog_category->getCategories(0);
			
			foreach ($results as $result) {
				$category_info = $this->model_blog_category->getCategory($result['category_id']);
				$catBlogCols[] = array(
					'cat_id'		=> $result['category_id'],
					'cat_col'	=> $category_info['suffix'],
				);
			}
		
			// update database
			$data = array(
				'blogExclude'				=> $blogSetting['blogExclude'],
				'commentDisableCat'		=> $blogSetting['commentDisableGroup'],
				'commentApproveGroup'	=> $blogSetting['commentApproveGroup'],
				'commentBadgeGroup'		=> $blogSetting['commentBadgeGroup'],
            'blogVirDir'				=> $blogSetting['virDir'],
				'blogVirDirName'        => $blogSetting['virDirName'],
				'virDirExclude'			=> $blogSetting['virDirExclude'],
				'blogCol'					=> $blogSetting['blogSuffix'],
				'catBlogCols'				=> $catBlogCols
			);
		
         $this->model_blog_blog->update12xto13($data);
         
         $this->session->data['success']      = sprintf($this->language->get('success_update'), $this->language->get('product_version'));
      }
      
      if (!isset($blogSetting['blogHomeDescription'])) {
         // updating Database
         $this->model_blog_blog->update131to132();

         $this->session->data['success']     = sprintf($this->language->get('success_update'), $this->language->get('product_version'));  
         $this->session->data['success_attention']   = sprintf($this->language->get('update_attention'), $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL'), $this->data['text_menu_setting'], $this->data['text_menu_setting']);
      }
      
      if (!isset($blogSetting['feedLimit'])) {
         // updating Database
         $this->model_blog_blog->update132to133();

         // updating vQmod
         if (file_exists(DIR_CATALOG.'../vqmod/xml/blog_manager.xml')) { rename(DIR_CATALOG.'../vqmod/xml/blog_manager.xml', DIR_CATALOG.'../vqmod/xml/blog_manager.xml_bak'); }
         if (file_exists(DIR_CATALOG.'../vqmod/xml/blog_manager.xml_')) { rename(DIR_CATALOG.'../vqmod/xml/blog_manager.xml_', DIR_CATALOG.'../vqmod/xml/blog_manager.xml'); }
         $this->session->data['success']     = sprintf($this->language->get('success_update'), $this->language->get('product_version'));  
         $this->session->data['success_attention']   = sprintf($this->language->get('update_attention'), $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL'), $this->data['text_menu_setting'], $this->data['text_menu_setting']);
      }
      
      if (isset($this->session->data['success'])) {
         $this->data['success'] = $this->session->data['success'];
         unset($this->session->data['success']);
      } else {
         $this->data['success'] = '';
      }
      
      if (isset($this->session->data['success_attention'])) {
         $this->data['success_attention'] = $this->session->data['success_attention'];
         unset($this->session->data['success_attention']);
      } else {
         $this->data['success_attention'] = '';
      }
      
      $adminAvailable = $this->model_blog_author->checkAdminUser();
      if (!$adminAvailable) {
         $this->redirect($this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL'));
      }
      
      $this->load->model('blog/article');
      $isAuthor = $this->model_blog_article->getAuthorByUser($this->user->getId());
      if (!$isAuthor) {
         $this->session->data['warning'] = $this->language->get('error_notauthor');
      }
      
      $this->load->model('blog/author');
      $blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
      if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; }; }
      
      $this->data['breadcrumbs'] = array();
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => false
      );
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('heading_title'),
         'href'      => $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );

      //== Menu
      $this->data['menu_home_href']       = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_article_href']    = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_category_href']    = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_comment_href']    = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_author_href']       = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_setting_href']    = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_about_href']       = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');

      //== Dashboard Resume
      $this->data['text_res_article2']         = sprintf($this->language->get('text_res_article2'), $this->model_blog_blog->getTotalArticles());
      $this->data['text_res_comment2']         = sprintf($this->language->get('text_res_comment2'), $this->model_blog_blog->getTotalComments());
      $this->data['text_res_category2']      = sprintf($this->language->get('text_res_category2'), $this->model_blog_blog->getTotalCategories());
      $this->data['text_res_author2']         = sprintf($this->language->get('text_res_author2'), $this->model_blog_blog->getTotalAuthors());
      
      
      if (isset($this->session->data['warning'])) {
          $this->data['warning'] = $this->session->data['warning'];
         unset($this->session->data['warning']);
      } else {
         $this->data['warning'] = '';
      }
      
      $this->template = 'blog/blog.tpl';
      $this->children = array(
         'common/header',
         'common/footer',
      );
      
      $this->response->setOutput($this->render());
   }
   
   public function install() {
      if (!$this->user->hasPermission('modify', 'blog/blog')) {
         $this->data = $this->load->language('blog/blog');
         $this->session->data['error'] = $this->data['error_permission']; 
         $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
      } else {
         $this->load->model('blog/blog');
         $this->data = $this->load->language('blog/blog');
         
         if (file_exists(DIR_CATALOG.'../vqmod/xml/blog_manager.xml_')) {
            rename(DIR_CATALOG.'../vqmod/xml/blog_manager.xml_', DIR_CATALOG.'../vqmod/xml/blog_manager.xml');
         }
         
         $dirSysCache = DIR_CACHE;
         foreach(glob($dirSysCache.'*.*') as $fileSysCache){ 
            if ($fileSysCache != DIR_CACHE . 'index.html') { unlink($fileSysCache); }
         }
         $dirCache = DIR_CATALOG.'../vqmod/vqcache/';
         foreach(glob($dirCache.'*.*') as $fileCache){ unlink($fileCache); }
         
         $this->model_blog_blog->install();
         $this->session->data['success']      = $this->data['success_install'];
         $this->session->data['attention']   = $this->data['after_install'];
         $this->redirect($this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL'));
      }
   }
   
   public function uninstall() {
      if (!$this->user->hasPermission('modify', 'blog/blog')) {
         $this->data = $this->load->language('blog/blog');
         $this->session->data['error'] = $this->data['error_permission']; 
         $this->redirect($this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL'));
      } else {      
         $this->load->model('blog/blog');
         
         if (file_exists(DIR_CATALOG.'../vqmod/xml/blog_manager.xml')) {
            rename(DIR_CATALOG.'../vqmod/xml/blog_manager.xml', DIR_CATALOG.'../vqmod/xml/blog_manager.xml_');
         }
         
         $dirSysCache = DIR_CACHE;
         foreach(glob($dirSysCache.'*.*') as $fileSysCache){ 
            if ($fileSysCache != DIR_CACHE . 'index.html') { unlink($fileSysCache); }
         }
         $dirCache = DIR_CATALOG.'../vqmod/vqcache/';
         foreach(glob($dirCache.'*.*') as $fileCache){ unlink($fileCache); }
         
         $this->model_blog_blog->uninstall();
         $this->redirect($this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'));   
      }
   }
}
?>
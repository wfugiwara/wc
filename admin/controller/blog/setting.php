<?php
class ControllerBlogSetting extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->model('blog/setting');
		$this->load->model('setting/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/setting');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/blog.css');
		
		$this->data['link_author']			 = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
		$this->data['link_copyright']		 = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
		$this->data['oc_footer']				= sprintf($this->language->get('oc_footer'), VERSION);
		
		$this->load->model('blog/article');
		$isAuthor = $this->model_blog_article->getAuthorByUser($this->user->getId());
		if (!$isAuthor) {
			$this->session->data['warning'] = $this->language->get('error_notauthor');
			$this->redirect($this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->model('blog/author');
		$blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
		if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; }; }
		
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('text_home'),
			'href'		=> $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('heading_title'),
			'href'		=> $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' <span class="separator">&#187;</span> '
		);
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('head_setting'),
			'href'		=> $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' <span class="separator">&#187;</span> '
		);

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateSetting()) {
			if (isset($this->request->post['articleAdmin'])) {
				//===
				$post_data = $this->request->post;

				$blogHomeDescription = (isset($this->request->post['blogHomeDescription'])) ? $this->request->post['blogHomeDescription'] : array();
            $blogExclude			= (isset($this->request->post['blogExclude'])) ? $this->request->post['blogExclude'] : array();
				$virDirExclude			= (isset($this->request->post['virDirExclude'])) ? $this->request->post['virDirExclude'] : array();
				$commentDisableCat	= (isset($this->request->post['commentDisableCat'])) ? $this->request->post['commentDisableCat'] : array();
				$commentApproveGroup	= (isset($this->request->post['commentApproveGroup'])) ? $this->request->post['commentApproveGroup'] : array();
				$commentAdminBadgeGroup	= (isset($this->request->post['commentAdminBadgeGroup'])) ? $this->request->post['commentAdminBadgeGroup'] : array();
				$commentBadgeGroup	= (isset($this->request->post['commentBadgeGroup'])) ? $this->request->post['commentBadgeGroup'] : array();
            $adminBlogColors     = (isset($this->request->post['adminBlogColors'])) ? $this->request->post['adminBlogColors'] : array();
				$commentBadgeColor   = (isset($this->request->post['commentBadgeColor'])) ? $this->request->post['commentBadgeColor'] : array();
				
				$post_data['blogHomeDescription']   = serialize($blogHomeDescription);
            $post_data['blogExclude']				= serialize($blogExclude);
				$post_data['virDirExclude']			= serialize($virDirExclude);
				$post_data['commentDisableCat']		= serialize($commentDisableCat);
				$post_data['commentApproveGroup']	= serialize($commentApproveGroup);
				$post_data['commentAdminBadgeGroup']		= serialize($commentAdminBadgeGroup);
				$post_data['commentBadgeGroup']		= serialize($commentBadgeGroup);
            $post_data['adminBlogColors']           = serialize($adminBlogColors);
				$post_data['commentBadgeColor']     = serialize($commentBadgeColor);
				
				$this->model_blog_setting->updateSetting($post_data);
				
				//=== Save some data at OpenCart setting
				$blogSettingConfig = array(
					'blogSetting_virDir'			 		=> $this->request->post['virDir'],
					'blogSetting_virDirName'			=> $this->request->post['virDirName'],
					'blogSetting_virDirExclude'		=> $virDirExclude,
					'blogSetting_relProductArticle'	=> $this->request->post['relProductArticle']
				);
				
				$this->model_setting_setting->editSetting('blogSetting', $blogSettingConfig);

				//===
				$this->session->data['success'] = $this->language->get('text_success_setting');
				$this->redirect($this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL')); 
			}
		}
		
		//== Menu
		$this->data['menu_home_href']		 = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_article_href']	 = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_category_href']	 = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_comment_href']	 = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_author_href']	 = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_setting_href']	 = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_about_href']		 = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token']		= $this->session->data['token'];
		$this->data['action']	= $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
		
		// Fallnback compatibility and transition for Blog home multi-language. Removed when BM reach v.1.4.2
		$this->data['blogNameValue'] = '';
		$this->data['blogKeywordValue'] = '';
		$this->data['blogDescriptionValue'] = '';
		
		//== Tab Setting
		$blogSettings = $this->model_blog_setting->getSettings();
		foreach ($blogSettings as $key => $value) { $this->data[$key . 'Value'] = $value; };
		
      //== Blog Home Description
      $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

      if (isset($this->request->post['blogHomeDescription'])) {
			$this->data['blogHomeDescriptionValues'] = $this->request->post['blogHomeDescription'];
		} elseif (isset($this->data['blogHomeDescriptionValue'])) {
			$this->data['blogHomeDescriptionValues'] = unserialize($this->data['blogHomeDescriptionValue']);
		} else {
			$this->data['blogHomeDescriptionValues'] = array();
		}
		
		//== Blog Home: Exclude Category
		$this->load->model('blog/category');
		$this->data['categories'] = $this->model_blog_category->getCategories(0);
		
		if (isset($this->request->post['blogExclude'])) {
			$this->data['blogExcludeValues'] = $this->request->post['blogExclude'];
		} elseif ($this->data['blogExcludeValue']) {
			$this->data['blogExcludeValues'] = unserialize($this->data['blogExcludeValue']);
		} else {
			$this->data['blogExcludeValues'] = array();
		}
		
		//== Categories: Virtual Directory Exclude
		if (isset($this->request->post['virDirExclude'])) {
			$this->data['virDirExcludeValues'] = $this->request->post['virDirExclude'];
		} elseif ($this->data['virDirExcludeValue']) {
			$this->data['virDirExcludeValues'] = unserialize($this->data['virDirExcludeValue']);
		} else {
			$this->data['virDirExcludeValues'] = array();
		}
		
		//== Comments: Disable Category
		if (isset($this->request->post['commentDisableCat'])) {
			$this->data['commentDisableCatValues'] = $this->request->post['commentDisableCat'];
		} elseif ($this->data['commentDisableCatValue']) {
			$this->data['commentDisableCatValues'] = unserialize($this->data['commentDisableCatValue']);
		} else {
			$this->data['commentDisableCatValues'] = array();
		}
		
		//== Comments: Customer Group Auto Approve
		$this->load->model('sale/customer_group');
		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		
		if (isset($this->request->post['commentApproveGroup'])) {
			$this->data['commentApproveGroupValues'] = $this->request->post['commentApproveGroup'];
		} elseif ($this->data['commentApproveGroupValue']) {
			$this->data['commentApproveGroupValues'] = unserialize($this->data['commentApproveGroupValue']);
		} else {
			$this->data['commentApproveGroupValues'] = array();
		}
      
      $this->load->model('user/user_group');		
    	$this->data['user_groups'] = $this->model_user_user_group->getUserGroups();
      //== Comments: Admin Group Badge
		if (isset($this->request->post['commentAdminBadgeGroup'])) {
			$this->data['commentBadgeGroupValues'] = $this->request->post['commentAdminBadgeGroup'];
		} elseif ($this->data['commentAdminBadgeGroupValue']) {
			$this->data['commentAdminBadgeGroupValues'] = unserialize($this->data['commentAdminBadgeGroupValue']);
		} else {
			$this->data['commentAdminBadgeGroupValues'] = array();
		}
		
		//== Comments: Admin Group Badge Color      
      if (isset($this->request->post['adminBlogColors'])) {
			$this->data['adminBlogColorsValues'] = $this->request->post['adminBlogColors'];
		} elseif (isset($this->data['adminBlogColorsValue'])) {
			$this->data['adminBlogColorsValues'] = unserialize($this->data['adminBlogColorsValue']);
		} else {
			$this->data['adminBlogColorsValues'] = array();
		}
      
		//== Comments: Customer Group Badge
		if (isset($this->request->post['commentBadgeGroup'])) {
			$this->data['commentBadgeGroupValues'] = $this->request->post['commentBadgeGroup'];
		} elseif ($this->data['commentBadgeGroupValue']) {
			$this->data['commentBadgeGroupValues'] = unserialize($this->data['commentBadgeGroupValue']);
		} else {
			$this->data['commentBadgeGroupValues'] = array();
		}
      
      //== Comments: Customer Group Badge Color
      if (isset($this->request->post['commentBadgeColor'])) {
			$this->data['commentBadgeColorValues'] = $this->request->post['commentBadgeColor'];
		} elseif (isset($this->data['commentBadgeColorValue'])) {
			$this->data['commentBadgeColorValues'] = unserialize($this->data['commentBadgeColorValue']);
		} else {
			$this->data['commentBadgeColorValues'] = array();
		}      
      
      //Feed and Sitemap Multi Stores
      $this->data['store'] = HTTP_CATALOG;
      $this->data['stores'] = array();			
      $this->load->model('setting/store');			
      $results = $this->model_setting_store->getStores();			
      foreach ($results as $result) {
         $this->data['stores'][] = array(
            'name' => $result['name'],
            'href' => $result['url']
         );
      }
      
		//== Error Handler
		$errorSettings = array('warning', 'tabAdmin', 'articleAdmin', 'tabCategory', 'articleCat', 'articleDesc', 'articleFeature', 'tabArticle', 'relProduct', 'relProductWH', 'tabComment', 'commentMinMax', 'tabSearch', 'searchLimit', 'searchGrid');
		foreach ($errorSettings as $errorSetting) {
			if (isset($this->error[$errorSetting])) {
				$this->data['error_'.$errorSetting] = $this->error[$errorSetting];
			} else {
				$this->data['error_'.$errorSetting] = '';
			}
		}
		if (isset($this->error['warning'])) {
			$this->data['warning'] = $this->error['warning'];
		} else {
			$this->data['warning'] = '';
		}
		
		$this->template = 'blog/setting.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function validateSetting() {
		if (!$this->user->hasPermission('modify', 'blog/setting')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['articleCat'])) {
			if (!$this->request->post['articleCat'] || $this->request->post['articleCat'] <= 0) {
				$this->error['articleCat'] = $this->language->get('error_limit');
			}
			if (!$this->request->post['articleDesc'] || $this->request->post['articleDesc'] <= 0) {
				$this->error['articleDesc'] = $this->language->get('error_limit');
			}
			if (!$this->request->post['articleFeatWidth'] || $this->request->post['articleFeatWidth'] <= 0 || !$this->request->post['articleFeatHeight'] || $this->request->post['articleFeatHeight'] <= 0) {
				$this->error['articleFeature'] = $this->language->get('error_size');
			}
			if ((isset($this->error['articleCat']) || isset($this->error['articleDesc']) || isset($this->error['articleFeatWidth'])) && !isset($this->error['warning'])) {
				$this->error['tabCategory'] = $this->language->get('error_tab');
			}
		}
		
		if (isset($this->request->post['relProduct'])) {
			if (!$this->request->post['relProduct'] || $this->request->post['relProduct'] <= 0) {
				$this->error['relProduct'] = $this->language->get('error_limit');
			}
			if (!$this->request->post['relProductWidth'] || $this->request->post['relProductWidth'] <= 0 || !$this->request->post['relProductHeight'] || $this->request->post['relProductHeight'] <= 0) {
				$this->error['relProductWH'] = $this->language->get('error_size');
			}
			if ((isset($this->error['relProduct']) || isset($this->error['relProductWH']) || isset($this->error['commentMinMax'])) && !isset($this->error['warning'])) {
				$this->error['tabArticle'] = $this->language->get('error_tab');
			}
		}
		
	  if (isset($this->request->post['commentMin']) || isset($this->request->post['commentMax'])) {
			if (!$this->request->post['commentMin'] || $this->request->post['commentMin'] <= 0 || !$this->request->post['commentMax'] || $this->request->post['commentMax'] <= 0) {
				$this->error['commentMinMax'] = $this->language->get('error_limit');
			}
			if (isset($this->error['commentMinMax']) && !isset($this->error['warning'])) {
				$this->error['tabComment'] = $this->language->get('error_tab');
			}
		}
		
		if (isset($this->request->post['searchLimit'])) {
			if (!$this->request->post['searchLimit'] || $this->request->post['searchLimit'] <= 0) {
				$this->error['searchLimit'] = $this->language->get('error_limit');
			}
			if (!$this->request->post['searchGrid'] || $this->request->post['searchGrid'] <= 0) {
				$this->error['searchGrid'] = $this->language->get('error_limit');
			}
			if ((isset($this->error['searchLimit']) || isset($this->error['searchGrid'])) && !isset($this->error['warning'])) {
				$this->error['tabSearch'] = $this->language->get('error_tab');
			}
		}
		
		if (isset($this->request->post['articleAdmin'])) {
			if (!$this->request->post['articleAdmin'] || $this->request->post['articleAdmin'] <= 0) {
				$this->error['articleAdmin'] = $this->language->get('error_limit');
			}
			if (isset($this->error['articleAdmin']) && !isset($this->error['warning'])) {
				$this->error['tabAdmin'] = $this->language->get('error_tab');
			}
		}
 
		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}
}
?>
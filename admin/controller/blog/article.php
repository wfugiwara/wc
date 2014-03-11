<?php
class ControllerBlogArticle extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/article');

		$this->getInfo();
		$this->getList();
	}
	
	public function insert() {
		$this->load->model('blog/setting');
		$this->load->model('blog/article');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/article');
		
      $url = '';			
			
      if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . $this->request->get['filter_author'];
		}
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
      if (isset($this->request->get['sort'])) {
         $url .= '&sort=' . $this->request->get['sort'];
      }
      if (isset($this->request->get['order'])) {
         $url .= '&order=' . $this->request->get['order'];
      }
      if (isset($this->request->get['page'])) {
         $url .= '&page=' . $this->request->get['page'];
      }
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_article->addArticle($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function update() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/article');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_article->editArticle($this->request->get['article_id'], $this->request->post);
			
			$url = '';			
			
         if (isset($this->request->get['filter_date_start'])) {
            $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
         }		
         if (isset($this->request->get['filter_date_end'])) {
            $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
         }
         if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
         }
         if (isset($this->request->get['filter_author'])) {
            $url .= '&filter_author=' . $this->request->get['filter_author'];
         }
         if (isset($this->request->get['filter_category'])) {
            $url .= '&filter_category=' . $this->request->get['filter_category'];
         }
         if (isset($this->request->get['filter_store'])) {
            $url .= '&filter_store=' . $this->request->get['filter_store'];
         }
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			if ($this->request->post['buttonClick'] == 'apply') {
				$this->redirect($this->url->link('blog/article/update', 'token=' . $this->session->data['token'] . '&article_id=' . $this->request->get['article_id'] . $url, 'SSL')); 
			} else {
				$this->redirect($this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function copy() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/article');
		
		$url = '';
		
      if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_author'])) {
         $url .= '&filter_author=' . $this->request->get['filter_author'];
      }		
      if (isset($this->request->get['filter_status'])) {
         $url .= '&filter_status=' . $this->request->get['filter_status'];
      }
      if (isset($this->request->get['filter_category'])) {
         $url .= '&filter_category=' . $this->request->get['filter_category'];
      }
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
      if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
			
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $article_id) {
				$this->model_blog_article->copyArticle($article_id);
			  }

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}
		
		if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_copy');
		}
		
		$this->getInfo();
		$this->getList();
	}
	
	public function delete() {
		 $this->load->model('blog/article');
		 $this->load->model('blog/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/article');

		$url = '';
		
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_author'])) {
         $url .= '&filter_author=' . $this->request->get['filter_author'];
      }		
      if (isset($this->request->get['filter_status'])) {
         $url .= '&filter_status=' . $this->request->get['filter_status'];
      }
      if (isset($this->request->get['filter_category'])) {
         $url .= '&filter_category=' . $this->request->get['filter_category'];
      }
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
      if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
			
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $article_id) {
				$this->model_blog_article->deleteArticle($article_id);
			  }

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		 if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_delete');
		}
		
		$this->getInfo();
		$this->getList();
	}

	private function getInfo() {
		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/blog.css');
		
		$this->data['link_author']			 = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
		$this->data['link_copyright']		 = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
		$this->data['oc_footer']				= sprintf($this->language->get('oc_footer'), VERSION);
		
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
			'text'		=> $this->language->get('head_article'),
			'href'		=> $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' <span class="separator">&#187;</span> '
		);
		
		$this->data['menu_home_href']		 = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_article_href']	 = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_category_href']	 = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_comment_href']	 = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_author_href']	 = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_setting_href']	 = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_about_href']		 = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
	}
	
	private function getList() {
		$blogSetting = $this->model_blog_setting->getSettings();
		
		$url = '';
      if (isset($this->request->get['filter_date_start'])) {
			$filter_date_start = $this->request->get['filter_date_start'];
         $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		} else {
			$filter_date_start = '';
		}

		if (isset($this->request->get['filter_date_end'])) {
			$filter_date_end = $this->request->get['filter_date_end'];
         $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		} else {
			$filter_date_end = '';
		}
		if (isset($this->request->get['filter_author'])) {
			$filter_author = $this->request->get['filter_author'];
			$url .= '&filter_author=' . $this->request->get['filter_author'];
		} else {
			$filter_author = null;
		}		
		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		} else {
			$filter_category = NULL;
		}
      if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		} else {
			$filter_store = 'all';
		}
	  
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
			$url .= '&sort=' . $this->request->get['sort'];
		} else {
			$sort = 'ad.title';
		}
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
			$url .= '&order=' . $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$this->data['insert']	= $this->url->link('blog/article/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['copy']	  = $this->url->link('blog/article/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete']	= $this->url->link('blog/article/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['action']	= $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['articles'] = array();

		$data = array(
         'sort'               => $sort,
			'filter_category'    => $filter_category,
			'filter_status'      => $filter_status,
			'filter_author'      => $filter_author,
         'filter_date_start'  => $filter_date_start, 
			'filter_date_end'    => $filter_date_end,
         'filter_store'       => $filter_store,
			'order'              => $order,
			'start'              => ($page - 1) * $blogSetting['articleAdmin'],
			'limit'              => $blogSetting['articleAdmin']
		);
		$article_total = $this->model_blog_article->getTotalArticles($data);
	
		$results = $this->model_blog_article->getArticles($data);
		$this->load->model('blog/category');
		$this->data['categories'] = $this->model_blog_category->getCategories(0);		
		$this->load->model('blog/author');
		$this->data['authors'] = $this->model_blog_author->getAuthors(0);
      $this->load->model('setting/store');			
      $this->data['stores'] = $this->model_setting_store->getStores();
		
		foreach ($results as $result) {
			$action = array();
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('blog/article/update', 'token=' . $this->session->data['token'] . '&article_id=' . $result['article_id'] . $url, 'SSL')
			);

			$article_info = $this->model_blog_article->getArticle($result['article_id']);
			$authorLevel = $this->model_blog_article->getAuthorLevel($this->user->getId());
         $articleStore = $this->model_blog_article->getArticleStores($result['article_id']);
			
			$authorArticle = $this->model_blog_article->getAuthor($result['article_id']);
			if (isset($authorArticle['user_id']) && $authorArticle['user_id'] == $this->user->getId()) { $ownArticle = 1; } else { $ownArticle = 0; }
			if (isset($authorArticle['user_id']) && $authorArticle['user_id'] != $this->user->getId()) { $otherArticle = 1; } else { $otherArticle = 0; }
			if ($authorLevel == 1) { $otherArticle = 1; } // 1 = admin ("Edit Other Article" permission still required)
			$category =  $this->model_blog_article->getArticleCategories($result['article_id']);
			$this->data['articles'][] = array(
				'article_id'		=> $result['article_id'],
				'ownArticle'		=> $ownArticle,
				'otherArticle'		=> $otherArticle,
				'title'				=> $result['title'],
				'author'				=> $result['author_id'],
				'category'			=> $category,
				'keyword'			=> $article_info['keyword'],
				'created'			=> date($this->language->get('date_format'), strtotime($result['created'])),
				'status'				=> $article_info['status'],
            'store'				=> $articleStore,
				'sort_order'		=> $result['sort_order'],
				'selected'			=> isset($this->request->post['selected']) && in_array($result['article_id'], $this->request->post['selected']),
				'action'				=> $action
			);
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['attention'])) {
			$this->data['attention'] = $this->session->data['attention'];
			unset($this->session->data['attention']);
		} else {
			$this->data['attention'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$url = '';

      if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . $this->request->get['filter_author'];
		}
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$this->data['sort_category'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a2c.category_id' . $url, 'SSL');
		$this->data['sort_author'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a.author_id' . $url, 'SSL');
		$this->data['sort_title'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=ad.title' . $url, 'SSL');
		$this->data['sort_created'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a.created' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a.status' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a.sort_order' . $url, 'SSL');
      $this->data['sort_store'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . '&sort=a2s.store_id' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . $this->request->get['filter_author'];
		}
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $article_total;
		$pagination->page = $page;
		$pagination->limit = $blogSetting['articleAdmin'];
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_date_start'] = $filter_date_start;
		$this->data['filter_date_end'] = $filter_date_end;
      $this->data['filter_category'] = $filter_category;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_author'] = $filter_author;
      $this->data['filter_store'] = $filter_store;
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['token'] = $this->session->data['token'];		
		$this->template = 'blog/article_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function getForm() {
		$blogSetting = $this->model_blog_setting->getSettings();
		$authorLevel = $this->model_blog_article->getAuthorLevel($this->user->getId());
		
		if (isset($this->request->get['article_id'])) {
			$authorArticle = $this->model_blog_article->getAuthor($this->request->get['article_id']);
			if (isset($authorArticle['user_id']) && $authorArticle['user_id'] == $this->user->getId()) { $this->data['ownArticle'] = 1; } else { $this->data['ownArticle'] = 0;}
			if (isset($authorArticle['user_id']) && $authorArticle['user_id'] != $this->user->getId()) { $this->data['otherArticle'] = 1; } else { $this->data['otherArticle'] = 0;}
		} else {
			$this->data['ownArticle'] = 0;
			$this->data['otherArticle'] = 0;
		}
		if ($authorLevel == 1) { $this->data['otherArticle'] = 1; } // 1 = admin ("Edit Other Article" permission still required)

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = array();
		}
		 if (isset($this->error['description'])) {
			$this->data['error_description'] = $this->error['description'];
		} else {
			$this->data['error_description'] = array();
		}
		
		$url = '';
			
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
      if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . $this->request->get['filter_author'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
      if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['token'] = $this->session->data['token'];
		
		if (!isset($this->request->get['article_id'])) {
			$this->data['action'] = $this->url->link('blog/article/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$this->data['update'] = '';
		} else {
			$this->data['action'] = $this->url->link('blog/article/update', 'token=' . $this->session->data['token'] . '&article_id=' . $this->request->get['article_id'] . $url, 'SSL');
			$this->data['update'] = 1;
		}
		$this->data['cancel'] = $this->url->link('blog/article', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['article_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$article_info = $this->model_blog_article->getArticle($this->request->get['article_id']);			
		}
		
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
      $this->load->model('setting/setting');
		$this->data['def_lang'] = $this->config->get('config_language');
		$this->data['seoSuffix'] = $blogSetting['seoSuffix'];
		
		if (isset($this->request->post['article_description'])) {
			$this->data['article_description'] = $this->request->post['article_description'];
		} elseif (isset($article_info)) {
			$this->data['article_description'] = $this->model_blog_article->getArticleDescriptions($article_info['article_id']);
		} else {
			$this->data['article_description'] = array();
		}
		
		if (isset($this->request->post['article_tag'])) {
			$this->data['article_tag'] = $this->request->post['article_tag'];
		} elseif (isset($article_info)) {
			$this->data['article_tag'] = $this->model_blog_article->getArticleTags($article_info['article_id']);
		} else {
			$this->data['article_tag'] = array();
		}
		
		if (isset($this->request->post['author'])) {
			$this->data['author'] = $this->model_blog_article->getAuthorByUser($this->user->getId());
			if ($authorLevel == 1 || $authorLevel == 2) { // 1 = admin, 2 = editor
				$this->data['authors'] = $this->model_blog_article->getAuthors();
			}
		} elseif (isset($article_info)) {
			$this->data['author'] = $this->model_blog_article->getAuthor($article_info['article_id']);
			if ($authorLevel == 1 || $authorLevel == 2) { 
				$this->data['authors'] = $this->model_blog_article->getAuthors();
			}
		} else {
			$this->data['author'] = $this->model_blog_article->getAuthorByUser($this->user->getId());
			if ($authorLevel == 1 || $authorLevel == 2) { 
				$this->data['authors'] = $this->model_blog_article->getAuthors();
			}
		}
		
		if (isset($this->request->post['created'])) {
			$this->data['created'] = $this->request->post['created'];
		} elseif (isset($article_info)) {
			$this->data['created'] = date('Y-m-d H:i', strtotime($article_info['created']));
		} else {
			$this->data['created'] = date('Y-m-d H:i');
		}
		
		if (isset($this->request->post['modified'])) {
			$this->data['modified'] = $this->request->post['modified'];
		} else {
			$this->data['modified'] = date('Y-m-d H:i');
		}
		
		if (isset($this->request->post['available'])) {
			$this->data['available'] = $this->request->post['available'];
		} elseif (isset($article_info)) {
			$this->data['available'] = $article_info['available'];
		} else {
			$this->data['available'] = date('Y-m-d', time() - 64800);
		}
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (isset($article_info)) {
			$this->data['keyword'] = $article_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (isset($article_info)) {
			$this->data['status'] = $article_info['status'];
		} else {
			$this->data['status'] = 0;
		}
		
		$this->load->model('tool/image');
		
		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (isset($article_info)) {
			$this->data['image'] = $article_info['image'];
		} else {
			$this->data['image'] = '';			
		}

		if (isset($article_info['image']) && file_exists(DIR_IMAGE . $article_info['image']) && is_file(DIR_IMAGE . $article_info['image'])) {
			$this->data['featuredImage'] = $this->model_tool_image->resize($article_info['image'], 100, 100);		
		} else {
			$this->data['featuredImage'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (isset($article_info)) {
			$this->data['sort_order'] = $article_info['sort_order'];
		} else {
			$this->data['sort_order'] = 0;
		}
		
		$this->load->model('blog/category');
		$this->data['categories'] = $this->model_blog_category->getCategories(0);
		if (isset($this->request->post['article_category'])) {
			$this->data['article_category'] = $this->request->post['article_category'];
		} elseif (isset($article_info)) {
			$this->data['article_category'] = $this->model_blog_article->getArticleCategories($article_info['article_id']);
		} else {
			$this->data['article_category'] = array();
		}
		
		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();
		if (isset($this->request->post['article_store'])) {
			$this->data['article_store'] = $this->request->post['article_store'];
		} elseif (isset($article_info)) {
			$this->data['article_store'] = $this->model_blog_article->getArticleStores($article_info['article_id']);
		} else {
			$this->data['article_store'] = array(0);
		}
		
		if (isset($this->request->post['article_related'])) {
			$this->data['article_related'] = $this->request->post['article_related'];
		} elseif (isset($article_info)) {
			$this->data['article_related'] = $this->model_blog_article->getArticleRelated($article_info['article_id']);
		} else {
			$this->data['article_related'] = array();
		}
		
		$this->load->model('catalog/category');
		$this->data['catProduct'] = $this->model_catalog_category->getCategories(0);
		
		if (isset($this->request->post['product_related'])) {
			$this->data['product_related'] = $this->request->post['product_related'];
		} elseif (isset($article_info)) {
			$this->data['product_related'] = $this->model_blog_article->getProductRelated($article_info['article_id']);
		} else {
			$this->data['product_related'] = array();
		}
		
		if (isset($this->request->post['article_layout'])) {
			$this->data['article_layout'] = $this->request->post['article_layout'];
		} elseif (isset($article_info)) {
			$this->data['article_layout'] = $this->model_blog_article->getArticleLayouts($article_info['article_id']);
		} else {
			$this->data['article_layout'] = array();
		}

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->template = 'blog/article_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function category() {
		$this->load->model('blog/article');
		$artRelated = $this->model_blog_article->getArticleRelated($this->request->get['article_id']);
		
		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}
		
		$article_info = array();
		$results = $this->model_blog_article->getArticlesByCategoryId($category_id);
		
		foreach ($results as $result) {
			if (!in_array($result['article_id'], $artRelated)) {
				$article_info[] = array(
					'article_id'	 => $result['article_id'],
					'title'			 => $result['title']
				);
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($article_info));
		} else {
			$this->response->setOutput(json_encode($article_info));
		}
	}
	
	public function related() {
		$this->load->model('blog/article');
		
		if (isset($this->request->post['article_related'])) {
			$articles = $this->request->post['article_related'];
		} else {
			$articles = array();
		}
	
		$article_data = array();
		
		foreach ($articles as $article_id) {
			$article_info = $this->model_blog_article->getArticle($article_id);
			
			if ($article_info) {
				$article_data[] = array(
					'article_id'	 => $article_info['article_id'],
					'title'			=> $article_info['title']
				);
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($article_data));
		} else {
			$this->response->setOutput(json_encode($article_data));
		}
	}
	
	public function catproduct() {
		$this->load->model('catalog/product');
		$this->load->model('blog/article');
		$prodRelated = $this->model_blog_article->getProductRelated($this->request->get['article_id']);
		
		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}
		
		$product_info = array();
		$results = $this->model_catalog_product->getProductsByCategoryId($category_id);
		
		foreach ($results as $result) {
			if (!in_array($result['product_id'], $prodRelated)) {
				$product_info[] = array(
					'product_id'	 => $result['product_id'],
					'name'			 => $result['name']
				);
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($product_info));
		} else {
			$this->response->setOutput(json_encode($product_info));
		}
	}
	
	public function relproduct() {
		$this->load->model('catalog/product');
		
		if (isset($this->request->post['product_related'])) {
			$products = $this->request->post['product_related'];
		} else {
			$products = array();
		}
	
		$product_data = array();
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				$product_data[] = array(
					'product_id'	 => $product_info['product_id'],
					'name'			=> $product_info['name']
				);
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($product_data));
		} else {
			$this->response->setOutput(json_encode($product_data));
		}
	}
	
	public function editStatus() {
		$this->load->model('blog/article');
		
		if (isset($this->request->post['article_id']) && isset($this->request->post['status'])) {
			$this->model_blog_article->updateArticleStatus($this->request->post['article_id'], $this->request->post['status']);
			$json['success']	= 1;
			$json['status']	= ($this->request->post['status']) ? 'enabled' : 'disabled';
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	public function editOrder() {
		$this->load->model('blog/article');
		
		if (isset($this->request->post['article_id']) && isset($this->request->post['sort_order'])) {
			if (preg_match('/^[0-9]+$/', $this->request->post['sort_order'])) {
				$this->model_blog_article->updateArticleOrder($this->request->post['article_id'], $this->request->post['sort_order']);
				$json['success']	= 1;
			} else {
				$json['error']		= 1;
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'blog/article')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['article_description'] as $language_id => $value) {
			if ((strlen(utf8_decode($value['title'])) < 3) || (strlen(utf8_decode($value['title'])) > 128)) {
				$this->error['title'][$language_id] = $this->language->get('error_title');
			}
		
			if (strlen(utf8_decode($value['description'])) < 3) {
				$this->error['description'][$language_id] = $this->language->get('error_description');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	private function validateSelectList() {
		if (!$this->user->hasPermission('modify', 'blog/article')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
 
		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}
}
?>
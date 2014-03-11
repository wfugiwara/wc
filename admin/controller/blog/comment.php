<?php
class ControllerBlogComment extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->load->model('blog/comment');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/comment');

		$this->getInfo();
		$this->getList();
	}
	
	public function edit() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->load->model('blog/comment');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/comment');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_comment->editComment($this->request->get['edit_id'], $this->request->post);
			
			$url = '';
			
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
				$this->redirect($this->url->link('blog/comment/edit', 'token=' . $this->session->data['token'] . '&edit_id=' . $this->request->get['edit_id'] . $url, 'SSL')); 
			} else {
				$this->redirect($this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function reply() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->load->model('blog/comment');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/comment');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_comment->replyComment($this->request->get['reply_id'], $this->request->post);
			
			$url = '';
			
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
				$this->redirect($this->url->link('blog/comment/edit', 'token=' . $this->session->data['token'] . '&edit_id=' . $this->request->get['reply_id'] . $url, 'SSL')); 
			} else {
				$this->redirect($this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function delete() {
		 $this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->load->model('blog/comment');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/comment');

		$url = '';
		if (isset($this->request->get['filter_status'])) {
			$status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$status = 2;
		}
		if (isset($this->request->get['art_id'])) {
			$art_id = $this->request->get['art_id'];
			$url .= '&art_id=' . $this->request->get['art_id'];
		} else {
			$art_id = '';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
			
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $comment_id) {
				$this->model_blog_comment->deleteComment($comment_id);
			  }

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		 if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_delete');
		}
		
		$this->getInfo();
		$this->getList();
	  }
	
	public function status() {
		$this->load->model('blog/article');
		$this->load->model('blog/setting');
		$this->load->model('blog/comment');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/comment');

		$url = '';
		if (isset($this->request->get['filter_status'])) {
			$status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$status = 2;
		}
		if (isset($this->request->get['art_id'])) {
			$art_id = $this->request->get['art_id'];
			$url .= '&art_id=' . $this->request->get['art_id'];
		} else {
			$art_id = '';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$status = $this->request->get['status'];
			
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $comment_id) {
				$this->model_blog_comment->commentStatus($comment_id, $status );
			  }

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_comment_status');
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
			'text'		=> $this->language->get('head_comment'),
			'href'		=> $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL'),
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
		$this->document->setTitle($this->language->get('heading_list') . ' - ' . $this->language->get('heading_title'));
		
		$blogSetting = $this->model_blog_setting->getSettings();
		
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
		if (isset($this->request->get['filter_status'])) {
			$status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$status = 2;
		}
		if (isset($this->request->get['art_id'])) {
			$art_id = $this->request->get['art_id'];
			$url .= '&art_id=' . $this->request->get['art_id'];
		} else {
			$art_id = '';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$this->data['delete']		= $this->url->link('blog/comment/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
		$this->data['approve']		= $this->url->link('blog/comment/status', 'status=1&token=' . $this->session->data['token'] . $url, 'SSL');	
		$this->data['unapprove']	= $this->url->link('blog/comment/status', 'status=0&token=' . $this->session->data['token'] . $url, 'SSL');	
		
		$this->data['status_all']			= $this->url->link('blog/comment', '&token=' . $this->session->data['token'] . $url . '&filter_status=2', 'SSL');	
		$this->data['status_approve']		= $this->url->link('blog/comment', '&token=' . $this->session->data['token'] . $url . '&filter_status=1', 'SSL');	
		$this->data['status_unapprove']	= $this->url->link('blog/comment', '&token=' . $this->session->data['token'] . $url . '&filter_status=0', 'SSL');	
		
		$this->data['token']		= $this->session->data['token'];	

		$this->data['comments']	= array();
		
		$data = array(
			'status'	=> $status,
			'art_id'	=> $art_id,
			'start'		=> ($page - 1) * $blogSetting['articleAdmin'],
			'limit'		=> $blogSetting['articleAdmin']
		);
		
		$results = $this->model_blog_comment->getComments($data);
		
		$url = '';
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		foreach ($results as $result) {
			$article	 = $this->model_blog_article->getArticle($result['article_id']);
			$parent	 = $this->model_blog_comment->getParentComment($result['comment_id']);
			
			if (isset($parent['name'])) {
				$parentName = $parent['name'];
			} else {
				$parentName = '';
			}
			
			if ($result['staff_id']) {
				$badge		= 'Backend Group: ' . $this->model_blog_comment->getStaffGroup($result['staff_id']);
				$badgeClass	= 'admin-group ' . str_replace(' ','_',$this->model_blog_comment->getStaffGroup($result['staff_id']));
			} else {
				$custGroupReply = $this->model_blog_comment->getCustomerGroup($result['customer_id']);
				$groupBadgeReply = explode(',',$blogSetting['commentBadgeGroup']);
				if ($custGroupReply && in_array($custGroupReply['groupId'], $groupBadgeReply)) {
					$badge = 'Site Group: ' .$custGroupReply['groupName'];
					$badgeClass	= 'front-group ' . str_replace(' ','_',$custGroupReply['groupName']); 
				} else {
					$badge = '';
					$badgeClass	= ''; 
				}
			}
			
			$this->data['comments'][] = array (
				'comment_id'	=> $result['comment_id'],
				'badge'			=> $badge,
				'badgeClass'	=> $badgeClass,
				'article'		=> $article['title'],
				'art_link'		=> $this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url . '&art_id=' . $result['article_id'], 'SSL'),
				'in_reply'		=> $parentName,
				'name'			=> $result['name'],
				'email'			=> $result['email'],
				'website'		=> $result['website'],
				'created'		=> date($this->language->get('date_time_format'), strtotime($result['created'])),
				'comment'		=> nl2br($result['content']),
				'status'			=> $result['status'],
				'selected'		=> isset($this->request->post['selected']) && in_array($result['comment_id'], $this->request->post['selected']),
				'reply'			=> $this->url->link('blog/comment/reply', 'token=' . $this->session->data['token'] . $url . '&reply_id=' . $result['comment_id'], 'SSL'),
				'edit'			=> $this->url->link('blog/comment/edit', 'token=' . $this->session->data['token'] . $url . '&edit_id=' . $result['comment_id'], 'SSL')
			);
		}
		
		$comment_total = $this->model_blog_comment->getTotalComments();
		
		$pagination = new Pagination();
		$pagination->total = $comment_total;
		$pagination->page = $page;
		$pagination->limit = $blogSetting['articleAdmin'];
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		$this->template = 'blog/comment_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function getForm() {
		$this->document->setTitle($this->language->get('heading_list') . ' - ' . $this->language->get('heading_title'));
		
		$blogSetting = $this->model_blog_setting->getSettings();
		
		$url = '';
		if (isset($this->request->get['filter_status'])) {
			$status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$status = 2;
		}
		if (isset($this->request->get['art_id'])) {
			$art_id = $this->request->get['art_id'];
			$url .= '&art_id=' . $this->request->get['art_id'];
		} else {
			$art_id = '';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$this->data['cancel'] = $this->url->link('blog/comment', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['reply_id'])) {
			$this->data['action'] = $this->url->link('blog/comment/reply', 'token=' . $this->session->data['token'] . '&reply_id=' . $this->request->get['reply_id'] . $url, 'SSL');
			$data_id = $this->request->get['reply_id']; //getComment as parent data
			$this->data['isReply'] = 1;
		} elseif (isset($this->request->get['edit_id'])) {
			$this->data['action'] = $this->url->link('blog/comment/edit', 'token=' . $this->session->data['token'] . '&edit_id=' . $this->request->get['edit_id'] . $url, 'SSL');
			$data_id = $this->request->get['edit_id']; //getComment to edit data
			$this->data['isReply'] = 0;
		} else {
			$this->redirect($this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['comment'] = array();
		$result	 = $this->model_blog_comment->getComment($data_id);
		$article	= $this->model_blog_article->getArticle($result['article_id']);

		$this->load->model('blog/author');
		$user		= $this->model_blog_author->getUser($this->user->getId());
		
		if (isset($this->request->post['name'])) {
			$result_name = $this->request->post['name'];
		} elseif (isset($result['name']) && isset($this->request->get['edit_id'])) {
			$result_name = $result['name'];
		} elseif (isset($this->request->get['reply_id'])) {
			$result_name = $user['firstname'].' '.$user['lastname'];
		} else {
			$result_name = '';
		}
		
		if (isset($this->request->post['email'])) {
			$result_email = $this->request->post['email'];
		} elseif (isset($result['email']) && isset($this->request->get['edit_id'])) {
			$result_email = $result['email'];
		} elseif (isset($this->request->get['reply_id'])) {
			$result_email = $user['email'];
		} else {
			$result_email = '';
		}
		
		if (isset($this->request->post['content'])) {
			$result_content = $this->request->post['content'];
		} elseif (isset($result['content']) && isset($this->request->get['edit_id'])) {
			$result_content = $result['content'];
		} else {
			$result_content = '';
		}
		
		$this->data['comment'] = array (
			'comment_id'		 => $result['comment_id'],
			'article_id'		 => $result['article_id'],
			'article'			 => $article['title'],
			'name'				 => $result_name,
			'email'				 => $result_email,
			'website'			 => $result['website'],
			'created'			 => date($this->language->get('date_time_format'), strtotime($result['created'])),
			'comment'			 => $result_content,
			'status'				 => $result['status'],
			'name_inreply'		=> $result['name'],
			'email_inreply'	=> $result['email'],
			'website_inreply'	=> $result['website'],
			'comment_inreply'	=> nl2br($result['content']),
		);
		
		$errors = array('name', 'email', 'content');
		foreach ($errors as $error) {
			if (isset($this->error[$error])) {
				$this->data['error_' . $error] = $this->error[$error];
			} else {
				$this->data['error_' . $error] = '';
			}
		}
		
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
		
		$this->template = 'blog/comment_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function editStatus() {
		$this->load->model('blog/comment');
		
		if (isset($this->request->post['comment_id']) && isset($this->request->post['status'])) {
			$this->model_blog_comment->updateCommentStatus($this->request->post['comment_id'], $this->request->post['status']);
			$json['success']	= 1;
			$json['status']	= ($this->request->post['status']) ? 'approve' : 'unapprove';
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	private function validateSelectList() {
		if (!$this->user->hasPermission('modify', 'blog/comment')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
 
		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'blog/comment')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ((strlen(utf8_decode($this->request->post['name'])) < 3) || (strlen(utf8_decode($this->request->post['name'])) > 25)) {
			$this->error['name'] = $this->language->get('error_from_name');
		}
		if ((strlen(utf8_decode($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
				$this->error['email'] = $this->language->get('error_from_email');
		 }
		if ((strlen(utf8_decode($this->request->post['content'])) < 25) || (strlen(utf8_decode($this->request->post['content'])) > 1500)) {
			$this->error['content'] = $this->language->get('error_from_content');
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
}
?>
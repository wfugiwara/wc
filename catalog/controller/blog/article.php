<?php  
class ControllerBlogArticle extends Controller {
	private $error = array(); 
	
	public function index() {
      // Redirect page if Blog Manager is not installed
		if (mysql_num_rows( mysql_query("SHOW TABLES LIKE '". DB_PREFIX ."blog_setting'")) != '1') { $this->redirect($this->url->link('common/home')); }
      
		if (isset($this->request->get['article_id'])) {
			$article_id = $this->request->get['article_id'];
		} else {
			$this->redirect($this->url->link('blog/category/home'));
		}
		
		$this->load->model('blog/setting');
		$this->load->model('blog/article');
		$this->load->model('blog/category');
		$this->load->model('blog/helper');
		$this->data = $this->language->load('blog/blog');
		
		$this->document->addLink($this->url->link('blog/article', 'article_id=' . $this->request->get['article_id']), 'canonical');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_custom.css')) { // use for customize
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_custom.css');
		} elseif (file_exists(DIR_TEMPLATE . 'default/stylesheet/blog_custom.css')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_custom.css');
		}
		
		$blogSetting = $this->model_blog_setting->getSettings();		
		
		$this->data['breadcrumbs'] = array();
			$this->data['breadcrumbs'][] = array(
				'text'		=> $this->language->get('text_home'),
				'href'		=> $this->url->link('common/home'),
				'separator' => false
			);
		
		if (isset($this->request->get['category_id'])) {
			 $parts		= explode('_', (string)$this->request->get['category_id']);

			if (!isset($blogSetting['virDir']) || $blogSetting['virDir']) {
				if (isset($blogSetting['virDirExclude']) && $blogSetting['virDirExclude']) {
					$excludeCat = unserialize($blogSetting['virDirExclude']);
				} else {
					$excludeCat = array();
				}
				
				if (!in_array($parts[0], $excludeCat)) {
					$this->data['breadcrumbs'][] = array(
						'text'		=> ucfirst($blogSetting['virDirName']),
						'href'		=> $this->url->link('blog/category/home'),
						'separator' => $this->language->get('text_separator')
					);
				}				
			}
			if (!$blogSetting['virDir']) {
					$this->data['breadcrumbs'][] = array(				
						'text'		=> $this->language->get('text_blog'),
						'href'		=> $this->url->link('blog/category/home'),
						'separator' => $this->language->get('text_separator')
					);
				}
			
			$path = '';
			
			foreach (explode('_', $this->request->get['category_id']) as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
				
				$categoryData = $this->model_blog_category->getCategory($path_id);
				if ($categoryData) {
					$this->data['breadcrumbs'][] = array(
						'text'		=> $categoryData['name'],
						'href'		=> $this->url->link('blog/category', 'category_id=' . $path),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
		} elseif (!$blogSetting['virDir']) {
			$this->data['breadcrumbs'][] = array(				
				'text'		=> $this->language->get('text_blog'),
				'href'		=> $this->url->link('blog/category/home'),
				'separator' => $this->language->get('text_separator')
			);
		} else {
			$this->data['breadcrumbs'][] = array(
				'text'		=> ucfirst($blogSetting['virDirName']),
				'href'		=> $this->url->link('blog/category/home'),
				'separator' => $this->language->get('text_separator')
			);
		}

		$articleData = $this->model_blog_article->getArticle($article_id);
		
		if ($articleData) {
			$url = '';
			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}
			
			$this->data['breadcrumbs'][] = array(
				'text'		=> $articleData['title'],
				'href'		=> $this->url->link('blog/article', $url . '&article_id=' . $article_id),
				'separator' => $this->language->get('text_separator')
			);
			
			$this->document->setTitle($articleData['title']);
			$this->document->setKeywords($articleData['meta_keyword']);
			$this->document->setDescription($articleData['meta_description']);
			
			$this->data['heading_title'] = $articleData['title'];
         
         $imageWidth = $blogSetting['articleFeatWidth'];
         $imageHeight = $blogSetting['articleFeatHeight'];
			$this->load->model('tool/image');
			$this->data['image'] = $this->model_tool_image->resize($articleData['image'], $imageWidth, $imageHeight);
			
			$catArticle = array();
			$catDisabled = array();
			$catDatas = $this->model_blog_article->getCategoriesByArticle($articleData['article_id']);
			foreach ($catDatas as $catData) {
				$catArticle[] = '<a href="' . $this->url->link('blog/category', 'category_id=' . $catData['category_id']) . '">'. $catData['name'] . '</a>';
				$catDisabled[]	= $catData['category_id'];
			}
			
			if (isset($blogSetting['artInfoName'])) {
				$art_infoName = sprintf($this->language->get('text_art_infoName'), $articleData['author']);
			} else {
				$art_infoName = '';
			}
			if (isset($blogSetting['artInfoCategory'])) {
				$art_infoCategory = sprintf($this->language->get('text_art_infoCategory'), implode(", ", $catArticle));
			} else {
				$art_infoCategory = '';
			}
			if (isset($blogSetting['artInfoDate'])) {
				$art_InfoDate = sprintf($this->language->get('text_art_InfoDate'), $this->model_blog_helper->date_format($articleData['created'], 'dfl'));
			} else {
				$art_InfoDate = '';
			}
						
			if ($blogSetting['commentStatus']) {
				$commentCatDisabled = unserialize($blogSetting['commentDisableCat']);
			  if (array_intersect($catDisabled, $commentCatDisabled)) {
					$commentStatus = 0;
					$heading_comment = '';
					$comments = '';				
				} else {
					$commentStatus = $blogSetting['commentStatus'];
					$totalComments = $this->model_blog_article->getTotalCommentsByArticleId($this->request->get['article_id']);
					if ($totalComments) {
						$heading_comment = sprintf($this->language->get('text_comments'), $totalComments);
						$comments = sprintf($this->language->get('text_comments'), $totalComments);
					} else {
						$heading_comment = $this->language->get('text_comment');
						$comments = sprintf($this->language->get('text_comments'), $totalComments);
					}
				}
				
			} else { 
				$commentStatus = 0;
				$heading_comment = '';
				$comments = '';  
			}
			
			$totalReplies = $this->model_blog_article->getTotalRepliesByArticleId($this->request->get['article_id']);
			if ($totalReplies) {
				$replies = sprintf($this->language->get('text_replies'), $totalReplies);
			} else {
				$replies = '';
			}
			
			$this->data['title']					= $articleData['title'];
			$this->data['link']					= $this->url->link('blog/article', $url . '&article_id=' . $article_id);
			$this->data['art_infoName']		= $art_infoName;
			$this->data['art_infoCategory']	= $art_infoCategory;
			$this->data['art_infoDate']		= $art_InfoDate;
			$this->data['art_infoComment']	= isset($blogSetting['artInfoComment']) ? $blogSetting['artInfoComment'] : false;
			$this->data['art_infoUpdate']		= isset($blogSetting['artInfoUpdate']) ? $blogSetting['artInfoUpdate'] : false;
			$this->data['modified']				= $this->model_blog_helper->date_format($articleData['modified'], 'dfl');
			
			$this->data['heading_comment']	= $heading_comment;
			$this->data['comments']				= $comments;
			$this->data['replies']				= $replies;
			$this->data['description']			= str_replace('<!--more-->','',html_entity_decode($articleData['description'], ENT_QUOTES, 'UTF-8'));
			$this->data['artRelateds']			= $this->model_blog_article->getRelatedArticle($articleData['article_id']);
			
			$this->data['guestCommentDisallow']	= ($blogSetting['guestComment'] == '2' && !$this->customer->isLogged()) ? true : false;
			$this->data['text_login_comment']	= sprintf($this->language->get('text_login_comment'), $this->url->link('account/login', '', 'SSL'));
		  
			$this->data['relProductRelated']		= $blogSetting['relProductRelated'];
			$this->data['prodRelateds']			= array();
			$prodRelateds								= $this->model_blog_article->getRelatedProduct($articleData['article_id']);
			$this->data['prodPerRow']				= $blogSetting['relProduct'];
			
			$this->load->model('tool/image');		 
			foreach ($prodRelateds as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $blogSetting['relProductWidth'], $blogSetting['relProductHeight']);
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', $blogSetting['relProductWidth'], $blogSetting['relProductHeight']);
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
            if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}
				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}
				$this->data['prodRelateds'][] = array(
					'product_id'	=> $result['product_id'],
					'status'	      => $result['status'],
					'thumb'			=> $image,
					'name'			=> $result['name'],
               'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price'			=> $price,
					'special'		=> $special,
               'tax'         => $tax,
					'rating'			=> $rating,
					'reviews'		=> sprintf($this->language->get('text_reviews'), $result['reviews']),
					'href'			=> $this->url->link('product/product', 'product_id=' . $result['product_id']),
				);
			}
			
			$tagsList = array();
			$results = $this->model_blog_article->getArticleTags($articleData['article_id']);
			foreach ($results as $result) {
				$tagsList[] = '<a href="' . $this->url->link('product/search', 'filter_tag=' . $result['tag']) . '" title="'.$result['tag'].'">'. $result['tag'] . '</a>';
			}
			$this->data['tags'] = implode(", ", $tagsList);
			
			$this->data['socMedia']			= $blogSetting['socMedia'];
			$this->data['pubID']				= $blogSetting['pubID'];
			$this->data['socMedCode']		= html_entity_decode($blogSetting['socMedCode'], ENT_QUOTES, 'UTF-8');
			
			$this->data['article_id']		= $article_id;
			$this->data['customerID']		= $this->customer->getId();
			$this->data['customerName']	= $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
			$this->data['customerMail']	= $this->customer->getEmail();
			$this->data['commentStatus']	= $commentStatus;
			
			if ( (!$blogSetting['commentCaptha'] == 'disabled') || ($blogSetting['commentCaptha'] == 'guest' && !$this->customer->isLogged()) || ($blogSetting['commentCaptha'] == 'visitor') || ($blogSetting['commentCaptha'] == 'nondefault' && (!$this->customer->isLogged() || $this->customer->getCustomerGroupId() == $this->config->get('config_customer_group_id')) ) ) {
				$this->data['commentCaptha']	= 1;
			} else {
				$this->data['commentCaptha']	= 0;
			}
			
			if ($blogSetting['commentDefApprove']) {
				$autoApprove = 1;
			} else {
				$autoApproves = unserialize($blogSetting['commentApproveGroup']);
				if (in_array($this->customer->getCustomerGroupId(), $autoApproves)) {
					$autoApprove = 1;
				} else {
					$autoApprove = 0;
				}
			}
			$this->data['autoApprove']	= $autoApprove;
			
			if(!isset($this->session->data['BlogArticle' . $article_id])) {
				$this->model_blog_article->updateViewed($article_id);
				$this->session->data['BlogArticle' . $article_id] = 1;
			}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/blog/article.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/blog/article.tpl';
			} else {
				$this->template = 'default/template/blog/article.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
			
			  $this->response->setOutput($this->render());
		 } else {
			$this->data['breadcrumbs'][] = array(
				'text'		=> $this->language->get('text_error'),
				'href'		=> $this->url->link('blog/article', 'article_id=' . $article_id),
				'separator' => $this->language->get('text_separator')
			);
			
			$this->document->setTitle($this->language->get('text_error_art'));
			$this->data['heading_title'] = $this->language->get('text_error_art');
			$this->data['text_error'] = $this->language->get('text_error_art');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
					
			  $this->response->setOutput($this->render());
		 }
	}
	
	public function comment() {
		$this->load->model('blog/setting');
		$this->load->model('blog/article');
		$this->load->model('blog/helper');
		$this->data = $this->language->load('blog/blog');
		
		$blogSetting = $this->model_blog_setting->getSettings();

		if (isset($this->request->get['cmt_page'])) { $page = $this->request->get['cmt_page']; } else { $page = 1; }
		$limit = $blogSetting['commentLimit'];
		
		$this->data['comments'] = array();
		$this->data['guestCommentDisallow']		= ($blogSetting['guestComment'] == '2' && !$this->customer->isLogged()) ? true : false;
		
		if(isset($this->request->get['art_id'])) {
			$article_id = $this->request->get['art_id'];
		} else {
			$article_id = $this->request->get['article_id'];
		}
		
		$results = $this->model_blog_article->getCommentsByArticleId($article_id, ($page - 1) * $limit, $limit, $blogSetting['commentOrder']);
		
		foreach ($results as $result) {
			$replyComments = array();
			$replyDatas = $this->model_blog_article->getReplyComments($result['comment_id']);
			
			foreach ($replyDatas as $replyData) {
				if ($replyData['staff_id']) {
					$adminGroupReply = $this->model_blog_article->getStaffGroup($replyData['staff_id']);
               $groupAdminBadgeReply = unserialize($blogSetting['commentAdminBadgeGroup']);
               if ($adminGroupReply && in_array($adminGroupReply['groupId'], $groupAdminBadgeReply)) {
                  $badgeReply = $adminGroupReply['groupName']; 
                  if (isset($blogSetting['adminBlogColors']) && isset($blogSetting['commentAdminBadgeGroup'])) {
                     $badgeAdminColors	= unserialize($blogSetting['adminBlogColors']);
                     $badgeReplyColor1	= $badgeAdminColors[$adminGroupReply['groupId']]['adminBadgeColor'];
						}
                     if (isset($blogSetting['adminBlogColors']) && !empty($badgeReplyColor1)) {
                        $badgeReplyColor  = $badgeReplyColor1;
                     } else {
                        $badgeReplyColor  = 'FF0000';
                     }
					} else {
                  $badgeReply = 0;
                  $badgeReplyColor = '';
               }
				} else {
					$custGroupReply = $this->model_blog_article->getCustomerGroup($replyData['customer_id']);
               $groupBadgeReply = unserialize($blogSetting['commentBadgeGroup']);
					if ($custGroupReply && in_array($custGroupReply['groupId'], $groupBadgeReply)) {
						$badgeReply = $custGroupReply['groupName']; 
                  if (isset($blogSetting['commentBadgeColor']) && isset($blogSetting['commentBadgeGroup'])) {
                     $badgeColors	= unserialize($blogSetting['commentBadgeColor']);
                     $badgeReplyColor2	= $badgeColors[$custGroupReply['groupId']]['color'];
                  }
                     if (isset($blogSetting['commentBadgeColor']) && !empty($badgeReplyColor2)) {
                        $badgeReplyColor = $badgeReplyColor2;
                     } else {
                        $badgeReplyColor = '0555C6';                     
                     }
					} else { 
						$badgeReply = 0; 
                   $badgeReplyColor = '';
					}
				}
				
				$replyComments[] = array(
					'comment_id'	=> $replyData['comment_id'],
					'badge'			=> $badgeReply,
               'badgeColor'   => $badgeReplyColor,
					'name'			=> $replyData['name'],
					'avatar'			=> $this->model_blog_helper->getGravatar($result['email'], $blogSetting['commentAvatar']),
					'website'		=> $replyData['website'],
					'content'		=> nl2br($replyData['content']),
					'created'		=> $this->model_blog_helper->date_format($replyData['created'], 'dtf')
				);
			}

		$custGroup = $this->model_blog_article->getCustomerGroup($result['customer_id']);
		$groupBadge = unserialize($blogSetting['commentBadgeGroup']);
		if ($custGroup && in_array($custGroup['groupId'], $groupBadge)) {
         $badge = $custGroup['groupName']; 
         if (isset($blogSetting['commentBadgeColor']) && !empty($groupBadge)) {
            $badgeColors	= unserialize($blogSetting['commentBadgeColor']);
            $badgeCommentColor1 = $badgeColors[$custGroup['groupId']]['color'];
         }
            if (isset($blogSetting['commentBadgeColor']) && !empty($badgeCommentColor1)) {
               $badgeCommentColor = $badgeCommentColor1;
            } else {
               $badgeCommentColor = '0555C6';
            }
      } else {
         $badgeCommentColor = '';
         $badge = 0; 
      }
      $badgeColors	= unserialize($blogSetting['commentBadgeColor']);
		
		  $this->data['comments'][] = array(
			'comment_id'	   => $result['comment_id'],
			'badge'			   => $badge,
         'badgeColor'      => $badgeCommentColor,
			'replyComments'	=> $replyComments,
			'name'			   => $result['name'],
			'avatar'			   => $this->model_blog_helper->getGravatar($result['email'], $blogSetting['commentAvatar']),
			'website'		   => $result['website'],
			'content'		   => nl2br($result['content']),
			'created'		   => $this->model_blog_helper->date_format($result['created'], 'dtf')
		  );
		}
		
		$commentsTotal = $this->model_blog_article->getTotalCommentsByArticleId($article_id);
			
		$pagination = new Pagination();
		$pagination->total = $commentsTotal;
		$pagination->page = $page;
		$pagination->limit = $limit; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/article/comment', 'art_id=' . $article_id . '&cmt_page={page}');
			
		$this->data['pagination'] = $pagination->render();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/blog/comment.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/blog/comment.tpl';
		} else {
			$this->template = 'default/template/blog/comment.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
	
	public function write() {
		$this->load->model('blog/setting');
		$this->load->model('blog/article');
		$this->data = $this->language->load('blog/blog');
		
		$blogSetting = $this->model_blog_setting->getSettings();
		
		$json = array();
		
		if ((strlen(utf8_decode($this->request->post['name'])) < 2) || (strlen(utf8_decode($this->request->post['name'])) > 25)) {
			$json['error']['name'] = $this->language->get('error_name');
		}
		if ((strlen(utf8_decode($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$json['error']['email'] = $this->language->get('error_email');
		}
		if ((strlen(utf8_decode($this->request->post['content'])) < $blogSetting['commentMin']) || (strlen(utf8_decode($this->request->post['content'])) > $blogSetting['commentMax'])) {
			$json['error']['content'] = sprintf($this->language->get('error_content'), $blogSetting['commentMin'], $blogSetting['commentMax']);
		}
		if ( (!$blogSetting['commentCaptha'] == 'disabled') || ($blogSetting['commentCaptha'] == 'guest' && !$this->customer->isLogged()) || ($blogSetting['commentCaptha'] == 'visitor') || ($blogSetting['commentCaptha'] == 'nondefault' && (!$this->customer->isLogged() || $this->customer->getCustomerGroupId() == $this->config->get('config_customer_group_id')) ) ) {
			if (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
				$json['error']['captcha'] = $this->language->get('error_captcha');
			}
		}
		if (isset($json['error'])) {
			$json['error']['common'] = $this->language->get('error_common');
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && !isset($json['error'])) {
			$data = array();
			
			if ($blogSetting['commentDefApprove']) {
				$status = 1;
			} else {
				if (isset($blogSetting['commentApproveGroup'])) {
					$groupApprove = unserialize($blogSetting['commentApproveGroup']);
					if (in_array($this->customer->getCustomerGroupId(), $groupApprove)) {
						$status = 1;
					} else {
						$status = 0;
					}
				} else {
					$status = 0;
				}
			}
			
			$data['customer_id']	 = $this->customer->getId();
			$data['status']		 = $status;
			
			$this->model_blog_article->addComment($this->request->get['article_id'], array_merge($this->request->post, $data));
			
			if($status == 1) {
				$json['success'] = $this->language->get('text_success');
			} else {
				$json['success'] = $this->language->get('text_approval');
			}
			
			$articleComment = $this->model_blog_article->getArticle($this->request->get['article_id']);
         $weburls = $this->config->get('config_url');
         $commentLink = $this->url->link('blog/article', 'article_id=' . $articleComment['article_id']);
			if(isset($blogSetting['emailNotify']) && $blogSetting['emailNotify']) {
				$sendTo		= $blogSetting['emailNotify'];
				$subject		= sprintf($this->language->get('text_mail_subject'), $this->config->get('config_name'), $articleComment['title']);			
			
				//HTML Mail Start
				$template = new Template();
				
				$template->data['commentTitle'] = sprintf($this->language->get('text_mail_subject'), $this->config->get('config_name'), $articleComment['title']);
				
				$template->data['commentGreeting']	  = sprintf($this->language->get('text_mail_greeting'), $weburls, $this->config->get('config_name'), $this->config->get('config_name'));
				$template->data['text_mail_article']	= $this->language->get('text_mail_article');
				$template->data['commentArticle']		= sprintf($this->language->get('text_mail_article1'), $commentLink, $articleComment['title'], $articleComment['title']);
				$template->data['text_mail_name']		= $this->language->get('text_mail_name');
				$template->data['commentName']			= html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8');
				$template->data['text_mail_mail']		= $this->language->get('text_mail_mail');
				$template->data['commentMail']			= sprintf($this->language->get('text_mail_mail1'), $this->request->post['email'], $this->request->post['email']);
				$template->data['text_mail_url']		 = $this->language->get('text_mail_url');
				$template->data['commentUrl']			 = sprintf($this->language->get('text_mail_url1'), $this->request->post['website'], $this->request->post['website'], $this->request->post['website']);
				$template->data['text_mail_message']	= $this->language->get('text_mail_message');
				$template->data['commentMessage']		= html_entity_decode($this->request->post['content'], ENT_QUOTES, 'UTF-8');				
				$template->data['text_mail_footer']	 = $this->language->get('text_mail_footer');
				$template->data['commentFooter1']		= sprintf($this->language->get('text_mail_footer1'), $commentLink, $commentLink, $commentLink);
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/blog/mail.tpl')) {
					$html = $template->fetch($this->config->get('config_template') . '/template/blog/mail.tpl');
				} else {
					$html = $template->fetch('default/template/blog/mail.tpl');
				}
				//HTML Mail END

				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');				
				$mail->setTo($sendTo);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject($subject);
				$mail->setHtml($html);
				$mail->send();
			}
			
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) {
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}
}
?>
<?php
class ModelBlogArticle extends Model {
	public function addArticle($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article SET author_id = '" . (int)$data['author_id'] . "', image = '" . $this->db->escape($data['image']) . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', available = '" . $this->db->escape($data['available']) . "', created = '" . $this->db->escape($data['created']) . "', modified = '" . $this->db->escape($data['modified']) . "'");

		$article_id = $this->db->getLastId(); 
			
		foreach ($data['article_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_description SET article_id = '" . (int)$article_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		if (isset($data['article_category'])) {
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_category SET article_id = '" . (int)$article_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		
		if (isset($data['article_store'])) {
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_store SET article_id = '" . (int)$article_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		if (isset($data['article_related'])) {
			foreach ($data['article_related'] as $related_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_related SET article_id = '" . (int)$article_id . "', related_id = '" . (int)$related_id . "'");
			}
		}
		
		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_product_related SET article_id = '" . (int)$article_id . "', product_id = '" . (int)$product_id . "'");
			}
		}

		if (isset($data['article_layout'])) {
			foreach ($data['article_layout'] as $store_id => $layout) {
				if ($layout) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_layout SET article_id = '" . (int)$article_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
		
		foreach ($data['article_tag'] as $language_id => $value) {
			if ($value) {
				$tags = explode(',', $value);
				
				foreach ($tags as $tag) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_tag SET article_id = '" . (int)$article_id . "', language_id = '" . (int)$language_id . "', tag = '" . $this->db->escape(trim($tag)) . "'");
				}
			}
		}
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'blog_article_id=" . (int)$article_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('blog_article');
	}
	
	public function editArticle($article_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_article SET author_id = '" . (int)$data['author_id'] . "', image = '" . $this->db->escape($data['image']) . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', available = '" . $this->db->escape($data['available']) . "', created = '" . $this->db->escape($data['created']) . "' , modified = '" . $this->db->escape($data['modified']) . "' WHERE article_id = '" . (int)$article_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_description WHERE article_id = '" . (int)$article_id . "'");
					
		foreach ($data['article_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_description SET article_id = '" . (int)$article_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int)$article_id . "'");
		
		if (isset($data['article_category'])) {
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_category SET article_id = '" . (int)$article_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_store WHERE article_id = '" . (int)$article_id . "'");
		
		if (isset($data['article_store'])) {
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_store SET article_id = '" . (int)$article_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_related WHERE article_id = '" . (int)$article_id . "'");
		
		if (isset($data['article_related'])) {
			foreach ($data['article_related'] as $related_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_related SET article_id = '" . (int)$article_id . "', related_id = '" . (int)$related_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_product_related WHERE article_id = '" . (int)$article_id . "'");
		
		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_product_related SET article_id = '" . (int)$article_id . "', product_id = '" . (int)$product_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_layout WHERE article_id = '" . (int)$article_id . "'");

		if (isset($data['article_layout'])) {
			foreach ($data['article_layout'] as $store_id => $layout) {
				if ($layout) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_to_layout SET article_id = '" . (int)$article_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_tag WHERE article_id = '" . (int)$article_id. "'");
		
		foreach ($data['article_tag'] as $language_id => $value) {
			if ($value) {
				$tags = explode(',', $value);
			
				foreach ($tags as $tag) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_article_tag SET article_id = '" . (int)$article_id . "', language_id = '" . (int)$language_id . "', tag = '" . $this->db->escape(trim($tag)) . "'");
				}
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_article_id=" . (int)$article_id . "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'blog_article_id=" . (int)$article_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('blog_article');
	}
	
	public function copyArticle($article_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_article_id=" . (int)$article_id . "') AS keyword, (SELECT name FROM " . DB_PREFIX . "blog_author at WHERE at.author_id = a.author_id) AS author FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) WHERE a.article_id = '" . (int)$article_id . "' AND ad.language_id = '" . (int)((method_exists($this->language, 'getId')) ? (int)$this->language->getId() : (int)$this->config->get('config_language_id')) . "'");
		
		if ($query->num_rows) {
			$data = array();
			$data = $query->row;
			
			$data['status']      = '0';
			$data['keyword']     = '';
			$data['author_id']   = '';
			$data['created']     = date('Y-m-d H:i');
			$data['modified']    = date('Y-m-d H:i');
			$data['available']   = date('Y-m-d');
			
			$data = array_merge($data, array('article_description' => $this->getArticleDescriptions($article_id)));	
			$data = array_merge($data, array('article_category' => $this->getArticleCategories($article_id)));
			$data = array_merge($data, array('article_store' => $this->getArticleStores($article_id)));
			$data = array_merge($data, array('article_related' => $this->getArticleRelated($article_id)));
			$data = array_merge($data, array('product_related' => $this->getProductRelated($article_id)));
			$data = array_merge($data, array('article_tag' => $this->getArticleTags($article_id)));
			$data = array_merge($data, array('article_layout' => $this->getArticleLayouts($article_id)));
			
			$this->addArticle($data);
		}
	}
	
	public function deleteArticle($article_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_description WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_store WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_related WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_product_related WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_to_layout WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_article_tag WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_comment WHERE article_id = '" . (int)$article_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_article_id=" . (int)$article_id . "'");
		
		$this->cache->delete('blog_article');
	}
	
	public function getArticle($article_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_article_id=" . (int)$article_id . "') AS keyword, (SELECT name FROM " . DB_PREFIX . "blog_author at WHERE at.author_id = a.author_id) AS author FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) WHERE a.article_id = '" . (int)$article_id . "' AND ad.language_id = '" . (int)((method_exists($this->language, 'getId')) ? (int)$this->language->getId() : (int)$this->config->get('config_language_id')) . "'");
		
		return $query->row;
	}
	
	public function getArticles($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id)";

			if (!empty($data['filter_category'])) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "blog_article_to_category a2c ON (a.article_id = a2c.article_id)";			
			}

			$sql .= " WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'";

         if ($data['filter_store'] != 'all') {
				$sql .= " AND a2s.store_id = '" . (int)$data['filter_store'] . "'";
			}
				
			if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
				$sql .= " AND a.status = '" . (int)$data['filter_status'] . "'";
			}
			
			if (!empty($data['filter_category'])) {
				if (!empty($data['filter_sub_category'])) {
					$implode_data = array();
					
					$implode_data[] = "category_id = '" . (int)$data['filter_category'] . "'";
					
					$this->load->model('blog/category');
					
					$categories = $this->model_blog_category->getCategories($data['filter_category']);
					
					foreach ($categories as $category) {
						$implode_data[] = "a2c.category_id = '" . (int)$category['category_id'] . "'";
					}
					
					$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
				} else {
					$sql .= " AND a2c.category_id = '" . (int)$data['filter_category'] . "'";
				}
			}
			
         if (!empty($data['filter_author'])) {					
            $sql .= " AND a.author_id = '" . (int)$data['filter_author'] . "'";
         }
			if (!empty($data['filter_date_start'])) {
            $sql .= " AND DATE(a.created) >= '" . $this->db->escape($data['filter_date_start']) . "'";
         }
         if (!empty($data['filter_date_end'])) {
            $sql .= " AND DATE(a.created) <= '" . $this->db->escape($data['filter_date_end']) . "'";
         }			
			
			$sort_data = array(
				'ad.title',
				'a2c.category_id',
            'a2s.store_id',
				'a.author_id',
				'a.created',
				'a.status',
				'a.sort_order'
			);
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY ad.title";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}		

				if ($data['limit'] < 1) {
					$data['limit'] = 12;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
			
			$query = $this->db->query($sql);
			
			return $query->rows;
		} else {
			$article_data = $this->cache->get('blog_article.' . $this->config->get('config_language_id'));
		
			if (!$article_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ad.title");
	
				$article_data = $query->rows;
			
				$this->cache->set('blog_article.' . $this->config->get('config_language_id'), $article_data);
			}	
	
			return $article_data;			
		}
	}
	
	public function getArticleDescriptions($article_id) {
		$article_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_description WHERE article_id = '" . (int)$article_id . "'");

		foreach ($query->rows as $result) {
			$article_description_data[$result['language_id']] = array(
				'title'				   => $result['title'],
				'meta_keyword'	      => $result['meta_keyword'],
				'meta_description'   => $result['meta_description'],
				'description'        => $result['description']
			);
		}
		
		return $article_description_data;
	}
	
	public function getAuthor($article_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author at LEFT JOIN " . DB_PREFIX . "blog_article a ON (at.author_id = a.author_id) WHERE article_id = '" . (int)$article_id . "'");
		
		return $query->row;
	}
	
	public function getArticleAuthor($article_id) {
		$article_author_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article WHERE author_id = '" . (int)$article_id . "'");
		
		foreach ($query->rows as $result) {
			$article_author_data[] = $result['author_id'];
		}
		
		return $article_author_data;
	}
	
	public function getAuthors() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author ORDER BY name ASC");
		
		return $query->rows;
	}
	
	public function getAuthorByUser($user_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author WHERE user_id = '" . (int)$user_id . "'");
		
		return $query->row;
	}
	
	public function getAuthorLevel($user_id) {
		$query = $this->db->query("SELECT author_group_id FROM " . DB_PREFIX . "blog_author WHERE user_id = '" . (int)$user_id . "'");
		
		return $query->row['author_group_id'];
	}
	
	public function getArticleCategories($article_id) {
		$article_category_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_to_category WHERE article_id = '" . (int)$article_id . "'");
		
		foreach ($query->rows as $result) {
			$article_category_data[] = $result['category_id'];
		}

		return $article_category_data;
	}
	
	public function getArticleStores($article_id) {
		$article_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_to_store WHERE article_id = '" . (int)$article_id . "'");

		foreach ($query->rows as $result) {
			$article_store_data[] = $result['store_id'];
		}
		
		return $article_store_data;
	}
	
	public function getArticleRelated($article_id) {
		$article_related_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_related WHERE article_id = '" . (int)$article_id . "'");
		
		foreach ($query->rows as $result) {
			$article_related_data[] = $result['related_id'];
		}
		
		return $article_related_data;
	}
	
	public function getProductRelated($article_id) {
		$product_related_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_product_related WHERE article_id = '" . (int)$article_id . "'");
		
		foreach ($query->rows as $result) {
			$product_related_data[] = $result['product_id'];
		}
		
		return $product_related_data;
	}
	
	public function getArticleTags($article_id) {
		$article_tag_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_tag WHERE article_id = '" . (int)$article_id . "'");
		
		$tag_data = array();
		
		foreach ($query->rows as $result) {
			$tag_data[$result['language_id']][] = $result['tag'];
		}
		
		foreach ($tag_data as $language => $tags) {
			$article_tag_data[$language] = implode(', ', $tags);
		}
		
		return $article_tag_data;
	}
	
	public function getArticlesByCategoryId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_category a2c ON (a.article_id = a2c.article_id) WHERE ad.language_id = '" . (int)((method_exists($this->language, 'getId')) ? (int)$this->language->getId() : (int)$this->config->get('config_language_id')) . "' AND a2c.category_id = '" . (int)$category_id . "' ORDER BY ad.title ASC");
		
		return $query->rows;
	}

	public function getArticleLayouts($article_id) {
		$article_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_to_layout WHERE article_id = '" . (int)$article_id . "'");
		
		foreach ($query->rows as $result) {
			$article_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $article_layout_data;
	}
	
	public function getTotalArticles($data = array()) {
      $sql = "SELECT COUNT(DISTINCT a.article_id) AS total FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_category a2c ON (a.article_id = a2c.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id)";
      
      $sql .= " WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'";
      if ($data['filter_store'] != 'all') {
         $sql .= " AND a2s.store_id = '" . (int)$data['filter_store'] . "'";
      }
				
      if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
         $sql .= " AND a.status = '" . (int)$data['filter_status'] . "'";
      }
      
      if (!empty($data['filter_category'])) {
         if (!empty($data['filter_sub_category'])) {
            $implode_data = array();
            
            $implode_data[] = "category_id = '" . (int)$data['filter_category'] . "'";
            
            $this->load->model('blog/category');
            
            $categories = $this->model_blog_category->getCategories($data['filter_category']);
            
            foreach ($categories as $category) {
               $implode_data[] = "a2c.category_id = '" . (int)$category['category_id'] . "'";
            }
            
            $sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
         } else {
            $sql .= " AND a2c.category_id = '" . (int)$data['filter_category'] . "'";
         }
      }
			
      if (!empty($data['filter_author'])) {					
         $sql .= " AND a.author_id = '" . (int)$data['filter_author'] . "'";
      }
      if (!empty($data['filter_date_start'])) {
         $sql .= " AND DATE(a.created) >= '" . $this->db->escape($data['filter_date_start']) . "'";
      }
      if (!empty($data['filter_date_end'])) {
         $sql .= " AND DATE(a.created) <= '" . $this->db->escape($data['filter_date_end']) . "'";
      }
      
      $query = $this->db->query($sql);
      
      return $query->row['total'];
   }
	
	public function updateArticleStatus($article_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_article SET status = '" . (int)$status . "' WHERE article_id = '" . (int)$article_id . "'");				
	}
	
	public function updateArticleOrder($article_id, $sort_order) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_article SET sort_order = '" . (int)$sort_order . "' WHERE article_id = '" . (int)$article_id . "'");				
	}
}
?>
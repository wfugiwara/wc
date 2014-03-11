<?php
class ModelBlogArticle extends Model {
   public function getArticle($article_id) {
      $query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_article_id=" . (int)$article_id . "') AS keyword, (SELECT name FROM " . DB_PREFIX . "blog_author at WHERE at.author_id = a.author_id) AS author FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id) WHERE a.article_id = '" . (int)$article_id . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a.status = '1' AND a.available <= NOW() AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
      
      return $query->row;
   }
   
   public function getArticles($data = array()) {
      $cache = md5(http_build_query($data));
      
      $article_data = $this->cache->get('blog_article.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $cache);
      
      if (!$article_data) {
         $sql = "SELECT * FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id)";
         
         if (!empty($data['filter_tag'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "blog_article_tag at ON (a.article_id = at.article_id)";         
         }
         
         $sql .= " WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a.status = '1' AND a.available <= NOW() AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'"; 
         
         if (!empty($data['filter_category_id'])) {
            $sql .= " AND a.article_id IN (SELECT a2c.article_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE a2c.category_id = '" . (int)$data['filter_category_id'] . "')";
         }
         
         if (isset($data['exclude_category']) && is_array($data['exclude_category']) && !empty($data['exclude_category'])) {
            $implode_data = array();

				foreach ($data['exclude_category'] as $category_id) {
					$implode_data[] = "a2c.category_id != '" . (int)$category_id . "'";
				}
				
				$sql .= " AND a.article_id IN (SELECT a2c.article_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE " . implode(' AND ', $implode_data) . ")";         
         }
         
         if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
            $sql .= " AND (";
            
            if (!empty($data['filter_name'])) {
               $implode = array();
               
               $words = explode(' ', $data['filter_name']);
               
               foreach ($words as $word) {
                  $implode[] = "LCASE(ad.title) LIKE '%" . $this->db->escape(utf8_strtolower($word, 'UTF-8')) . "%' OR LCASE(ad.description) LIKE '%" . $this->db->escape(utf8_strtolower($word, 'UTF-8')) . "%'";         
               }
               
               if ($implode) {
                  $sql .= " " . implode(" OR ", $implode) . "";
               }
            }
            
            if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
               $sql .= " OR ";
            }
            
            if (!empty($data['filter_tag'])) {
               $implode = array();

               $words = explode(' ', $data['filter_tag']);

               foreach ($words as $word) {
                  $implode[] = "LCASE(at.tag) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_tag'], 'UTF-8')) . "%' AND at.language_id = '" . (int)$this->config->get('config_language_id') . "'";
               }

               if ($implode) {
                  $sql .= " " . implode(" OR ", $implode) . "";
               }
            }
            
            $sql .= ")";
         }
         
         if (isset($data['article_order'])){
            if ($data['article_order'] == 'sortAsc' || $data['article_order'] == 'sortDesc' ) {
               $sortby = 'a.sort_order';
            } elseif ($data['article_order'] == 'viewAsc' || $data['article_order'] == 'viewDesc' ) {
               $sortby = 'a.viewed';
            } else {
               $sortby = 'a.created';
            }
            if ($data['article_order'] == 'sortAsc' || $data['article_order'] == 'dateAsc' || $data['article_order'] == 'viewAsc') {
               $order = 'ASC';
            } else {
               $order = 'DESC';
            }
            
            $sql .= " ORDER BY " . $this->db->escape($sortby) . " " . $this->db->escape($order);
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
         
         $article_data = array();
         
         $query = $this->db->query($sql);
         foreach ($query->rows as $result) {
            $article_data[$result['article_id']] = $this->getArticle($result['article_id']);
         }
         
         $this->cache->set('blog_article.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $cache, $article_data);
      }
      
      return $article_data;
   }
   
   public function getCategoriesByArticle($article_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_to_category a2c LEFT JOIN " . DB_PREFIX . "blog_category_description cd ON (a2c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "blog_category c ON (a2c.category_id = c.category_id) LEFT JOIN " . DB_PREFIX . "blog_category_to_store c2s ON (a2c.category_id = c2s.category_id) WHERE a2c.article_id = '" . (int)$article_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c.status = '1' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

      return $query->rows;
   }
   
   public function getRelatedArticle($article_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_related ar LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (ar.related_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article a ON (ar.related_id = a.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (ar.related_id = a2s.article_id) WHERE ar.article_id = '" . (int)$article_id . "' AND a.status = '1' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
      
      return $query->rows;
   }
   
   public function getRelatedProduct($article_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_product_related WHERE article_id = '" . (int)$article_id . "'");
      
      $product_data = array();
      $this->load->model('catalog/product');
      
      foreach ($query->rows as $result) {
         $product_data[] = $this->model_catalog_product->getProduct($result['product_id']);
      }
      
      return $product_data;
   }
   
   public function getRelatedArticleAtProduct($product_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_product_related pr LEFT JOIN " . DB_PREFIX . "blog_article a ON (pr.article_id = a.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id) WHERE pr.product_id = '" . (int)$product_id . "' AND a.status = '1' AND a.available <= NOW() AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
      
      $article_data = array();
      
      foreach ($query->rows as $result) {
         $article_data[] = $this->getArticle($result['article_id']);
      }
      
      return $article_data;
   }
   
   public function getArticleTags($article_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_tag WHERE article_id = '" . (int)$article_id . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");

      return $query->rows;
   }
   
   public function getProductLayoutId($article_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_article_to_layout WHERE article_id = '" . (int)$article_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
      
      if ($query->num_rows) {
         return $query->row['layout_id'];
      } else {
         return  $this->config->get('config_layout_product');
      }
   }
   
   public function getTotalArticles($data = array()) {
      $sql = "SELECT COUNT(DISTINCT a.article_id) AS total FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (a.article_id = ad.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id) WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a.status = '1' AND a.available <= NOW() AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
      
      if (isset($data['filter_category_id']) && $data['filter_category_id']) {
         $sql .= " AND a.article_id IN (SELECT a2c.article_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE a2c.category_id = '" . (int)$data['filter_category_id'] . "')";
      }
      
      if (isset($data['exclude_category']) && is_array($data['exclude_category']) && !empty($data['exclude_category'])) {
         $implode_data = array();
         
         foreach ($data['exclude_category'] as $category_id) {
            $implode_data[] = "a2c.category_id != '" . (int)$category_id . "'";
         }
         
         $sql .= " AND a.article_id IN (SELECT a2c.article_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE " . implode(' AND ', $implode_data) . ")";         
      }
      
      $query = $this->db->query($sql);
      
      return $query->row['total'];
   }
   
   public function updateViewed($article_id) {
      $this->db->query("UPDATE " . DB_PREFIX . "blog_article SET viewed = (viewed + 1) WHERE article_id = '" . (int)$article_id . "'");
   }
   
   // Comment
   public function addComment($article_id, $data) {
      $this->db->query("INSERT INTO " . DB_PREFIX . "blog_comment SET parent_id = '" . (int)$data['parent_id'] . "', customer_id = '" . (int)$this->customer->getId() . "', article_id = '" . (int)$article_id . "', name = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', website = '" . $this->db->escape($data['website']) . "', content = '" . $this->db->escape($data['content']) . "', status = '" . (int)$data['status'] . "', created = NOW()");
   }

   public function getComment($comment_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_article_description ad ON (c.article_id = ad.article_id) WHERE comment_id = '" . (int)$comment_id . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "'");
      
      return $query->row;
   }
   
   public function getComments ($data = array()) {
      $sql = "SELECT * FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON c.article_id = a2s.article_id WHERE c.status = '1' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

      if (isset($data['exclude_category'])  && is_array($data['exclude_category']) && !empty($data['exclude_category'])) {
         $implode_data = array();
         
         foreach ($data['exclude_category'] as $category_id) {
            $implode_data[] = "a2c.category_id != '" . (int)$category_id . "'";
         }
         
         $sql .= " AND c.article_id IN (SELECT a2c.article_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE " . implode(' AND ', $implode_data) . ")";         
      }
      
      $sql .= "ORDER BY c.created DESC";
      
      if (isset($data['limit'])) {
         $data['start'] = 0;

         if ($data['limit'] < 1) {
            $data['limit'] = 5;
         }   
      
         $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
      }
      
      $comment_data = array();
      
      $query = $this->db->query($sql);
      foreach ($query->rows as $result) {
         $comment_data[$result['comment_id']] = $this->getComment($result['comment_id']);
      }
      
      return $comment_data;
   }
   
   public function getCommentsByArticleId($article_id, $start = 0, $limit = 100, $order = 'ASC') {
      $query = $this->db->query("SELECT c.comment_id, c.parent_id, c.customer_id, c.name, c.email, c.website, c.content, c.staff_id, c.created FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_article a ON (c.article_id = a.article_id) WHERE a.article_id = '" . (int)$article_id . "' AND c.status = '1' AND a.status = '1' AND c.parent_id = '0' AND a.available <= NOW() ORDER BY c.created " . $this->db->escape($order) . " LIMIT " . (int)$start . "," . (int)$limit);
      
      return $query->rows;
   }
   
   public function getReplyComments($comment_id, $order = 'ASC') {
      $query = $this->db->query("SELECT c.comment_id, c.parent_id, c.customer_id, c.name, c.email, c.website, c.content, c.staff_id, c.created FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_article a ON (c.article_id = a.article_id) WHERE c.parent_id = '" . (int)$comment_id . "' AND c.status = '1' ORDER BY c.created " . $this->db->escape($order) . " LIMIT 0,   100");
      
      return $query->rows;
   }
   
   public function getTotalCommentsByArticleId($article_id) {
      $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_article a ON (c.article_id = a.article_id) WHERE a.article_id = '" . (int)$article_id . "' AND c.parent_id = '0' AND c.status = '1' AND a.status = '1' AND a.available <= NOW()");
      
      return $query->row['total'];
   }
   
   public function getTotalRepliesByArticleId($article_id) {
      $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_comment WHERE article_id = '" . (int)$article_id . "' AND parent_id != '0' AND status = '1'");
      
      return $query->row['total'];
   }
   
   public function getCustomerGroup($customer_id) {
      if($this->tableCheck('customer_group', 'name')) {
         // if exist mean <= 1.5.2.x
         $query = $this->db->query("SELECT cg.customer_group_id as groupId, cg.name as groupName FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id) WHERE c.customer_id = '" . (int)$customer_id . "'");
      } else {
         // if NOT exist mean >= 1.5.3
         $query = $this->db->query("SELECT cgd.customer_group_id as groupId, cgd.name as groupName FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (c.customer_group_id = cgd.customer_group_id) WHERE c.customer_id = '" . (int)$customer_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
      }
      
      if (isset($query->row)) {
         return $query->row;
      } else {
         return 0;
      }
   }
   
   public function getStaffGroup($user_id) {
      $query = $this->db->query("SELECT ug.user_group_id as groupId, ug.name as groupName FROM " . DB_PREFIX . "user u LEFT JOIN " . DB_PREFIX . "user_group ug ON (u.user_group_id = ug.user_group_id) WHERE u.user_id = '" . (int)$user_id . "'");
      
      if (isset($query->row)) {
         return $query->row;
      } else {
         return 0;
      }
   }
   public function getStaffGroups($user_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user u LEFT JOIN " . DB_PREFIX . "user_group ug ON (u.user_group_id = ug.user_group_id) WHERE u.user_id = '" . (int)$user_id . "'");
      
      return $query->row;
	}
   public function getStaff($user_id) {
		$query = $this->db->query("SELECT *, CONCAT(u.firstname, ' ', u.lastname) AS name, u.email as email FROM " . DB_PREFIX . "blog_author ba LEFT JOIN " . DB_PREFIX . "user u ON (ba.user_id = u.user_id) WHERE ba.user_id = '" . (int)$user_id . "'");

		return $query->row;
	}
   
   public function getTags($limit = 20) {
      $tag        = array();
      $total      = array();
      $tagsData   = array();
      $product_tag_data = array();
      
      if($this->tableCheck('product_description', 'tag')) { // if exist mean >= 1.5.4
         // Exclude product tags. OpenCart v1.5.4 database change not supported by this feature - for a while.
         $blogTags      = $this->db->query("SELECT tag, Count(tag) AS total FROM " . DB_PREFIX . "blog_article_tag bat LEFT JOIN " . DB_PREFIX . "blog_article ba ON ba.article_id = bat.article_id LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON bat.article_id = a2s.article_id WHERE ba.status = '1' AND bat.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "' GROUP BY tag ORDER BY RAND() LIMIT " . (int)$limit);
         
         
         $tagsData = array();
         if ($blogTags->rows) {
            foreach ($blogTags->rows as $row){
               $tag[]      = $row['tag'];
               $totals[]   = $row['total'];
            }
            
            $tagsData = array_combine($tag, $totals);
         }
         
         return $tagsData;
         
      } else { // if NOT exist mean <= 1.5.3.1
         $query = $this->db->query("SELECT tag, Count(tag) AS total FROM ( SELECT tag FROM " . DB_PREFIX . "product_tag pt LEFT JOIN " . DB_PREFIX . "product p ON p.product_id = pt.product_id WHERE p.status = '1' AND pt.language_id = '" . (int)$this->config->get('config_language_id') . "' UNION ALL SELECT tag FROM " . DB_PREFIX . "blog_article_tag bat LEFT JOIN " . DB_PREFIX . "blog_article ba ON ba.article_id = bat.article_id LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON bat.article_id = a2s.article_id WHERE ba.status = '1' AND bat.language_id = '" . (int)$this->config->get('config_language_id') . "' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "') all_total GROUP BY tag ORDER BY RAND() LIMIT " . (int)$limit);
         
         $tagsData = array();
         if ($query->rows) {
            foreach ($query->rows as $row){
               $tag[]      = $row['tag'];
               $totals[]   = $row['total'];
            }
            
            $tagsData = array_combine($tag, $totals);
         }

         return $tagsData;
      }
      
   }

   public function getArchive($group) {
      $sql = "SELECT";
      
      if ($group == 'year') {
         $sql .= " YEAR(created) as value";
      } else {
         //$sql .= " MONTHNAME(created) as value";
         $sql .= " MONTH(created) as value";
      }
      
      $sql .= " FROM " . DB_PREFIX . "blog_article ba LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (ba.article_id = a2s.article_id) WHERE ba.status = '1' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
      
      if ($group != 'year') {
         $sql .= " AND YEAR(created) = " . $group . "";
      }
      
      if ($group == 'year') {
         $sql .= " GROUP BY YEAR(created)";
      } else {
         $sql .= " GROUP BY MONTH(created)";
      }
      
      $sql .= " ORDER BY created DESC";
      
      $query = $this->db->query($sql);
      
      return $query->rows;
   }
   
   public function getArchiveArticle($group, $total = 0, $data = array()) {
      $sql = "SELECT DISTINCT ";
      
      if ($total) { //assuming only year input use this
         $sql .= " a.article_id FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_to_category a2c ON (a.article_id = a2c.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id) WHERE a.status = '1' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND YEAR(a.created) = " . $group . " AND a.available <= NOW()";
      } else {
         $sql .= " a.article_id FROM " . DB_PREFIX . "blog_article a LEFT JOIN " . DB_PREFIX . "blog_article_to_category a2c ON (a.article_id = a2c.article_id) LEFT JOIN " . DB_PREFIX . "blog_article_to_store a2s ON (a.article_id = a2s.article_id) WHERE a.status = '1' AND a2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND MONTH(a.created) = '" . $group . "' AND a.available <= NOW()";
      }
      
      
      if (!empty($data['exclude'])) {
         $implode_data = array();
         $categories = explode(',',$data['exclude']);
         
         foreach ($categories as $category_id) {
            $implode_data[] = "a2c.category_id != '" . (int)$category_id . "'";
         }
         
         $sql .= " AND a2c.category_id IN (SELECT a2c.category_id FROM " . DB_PREFIX . "blog_article_to_category a2c WHERE " . implode(' AND ', $implode_data) . ")";
      }
      

      $sql .= " ORDER BY a.created DESC LIMIT 0,50";
      
      if ($total) {
         $query = $this->db->query($sql);
      
         return $query->rows;
      } else {
         $article_data = array();
            
         $query = $this->db->query($sql);
         foreach ($query->rows as $result) {
            $article_data[$result['article_id']] = $this->getArticle($result['article_id']);
         }
         
         return $article_data;
      }
   }
   
   public function tableCheck($table, $column) {
      $query = mysql_query("SHOW COLUMNS FROM `" . DB_PREFIX . $table ."` LIKE '" . $column . "'");
      $exist = (mysql_num_rows($query))?TRUE:FALSE;
      
      if ($exist){
         return true;
      } else {
         return false;
      }
   }
}
?>
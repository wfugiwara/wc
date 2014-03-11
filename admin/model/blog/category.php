<?php
class ModelBlogCategory extends Model {
	public function addCategory($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category SET parent_id = '" . (int)$data['parent_id'] . "', image = '" . $this->db->escape($data['image']) . "', sort_order = '" . (int)$data['sort_order'] . "', article_order = '" . $this->db->escape($data['article_order']) . "', width = '" . (int)$data['width'] . "', height = '" . (int)$data['height'] . "', desc_limit = '" . (int)$data['desc_limit'] . "', status = '" . (int)$data['status'] . "', suffix = '" . $this->db->escape($data['suffix']) . "', category_col = '" . $this->db->escape($data['category_col']) . "', created = CURDATE(), modified = CURDATE()");
	
		$category_id = $this->db->getLastId();
		
		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'blog_category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('blog_category');
	}
	
	public function editCategory($category_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_category SET parent_id = '" . (int)$data['parent_id'] . "', image = '" . $this->db->escape($data['image']) . "', sort_order = '" . (int)$data['sort_order'] . "', article_order = '" . $this->db->escape($data['article_order']) . "', width = '" . (int)$data['width'] . "', height = '" . (int)$data['height'] . "', desc_limit = '" . (int)$data['desc_limit'] . "', status = '" . (int)$data['status'] . "', suffix = '" . $this->db->escape($data['suffix']) . "', category_col = '" . $this->db->escape($data['category_col']) . "', modified = CURDATE() WHERE category_id = '" . (int)$category_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_description WHERE category_id = '" . (int)$category_id . "'");
		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_to_store WHERE category_id = '" . (int)$category_id . "'");
		if (isset($data['category_store'])) {		
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "blog_category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_category_id=" . (int)$category_id. "'");
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'blog_category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('blog_category');
	}
	
	public function copyCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_category_id=" . (int)$category_id . "') AS keyword FROM " . DB_PREFIX . "blog_category WHERE category_id = '" . (int)$category_id . "'");
		
		if ($query->num_rows) {
			$data = array();
			$data = $query->row;
			
			$data['status'] = '0';
			$data['keyword'] = '';
			
			$data = array_merge($data, array('category_description' => $this->getCategoryDescriptions($category_id)));	
			$data = array_merge($data, array('category_store' => $this->getCategoryStores($category_id)));
			$data = array_merge($data, array('category_layout' => $this->getCategoryLayouts($category_id)));
			
			$this->addCategory($data);
		}
	}
	
	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_description WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_to_store WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_category_id=" . (int)$category_id . "'");
		
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "blog_category WHERE parent_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteCategory($result['category_id']);
		}
		
		$this->cache->delete('blog_category');
	} 
	
	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_category_id=" . (int)$category_id . "') AS keyword FROM " . DB_PREFIX . "blog_category WHERE category_id = '" . (int)$category_id . "'");
		
		return $query->row;
	}
	
	public function getCategories($parent_id) {
		$category_data = $this->cache->get('blog_category.' . $this->config->get('config_language_id') . '.' . $parent_id);
	
		if (!$category_data) {
			$category_data = array();
		
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category c LEFT JOIN " . DB_PREFIX . "blog_category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
			foreach ($query->rows as $result) {
				$category_data[] = array(
					'category_id'	=> $result['category_id'],
					'name'			=> $this->getPath($result['category_id'], $this->config->get('config_language_id')),
					'status'			=> $result['status'],
					'sort_order'	=> $result['sort_order']
				);
			
				$category_data = array_merge($category_data, $this->getCategories($result['category_id']));
			}	
	
			$this->cache->set('blog_category.' . $this->config->get('config_language_id') . '.' . $parent_id, $category_data);
		}
		
		return $category_data;
	}
	
	public function getPath($category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "blog_category c LEFT JOIN " . DB_PREFIX . "blog_category_description cd ON (c.category_id = cd.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
		$category_info = $query->row;
		
		if ($category_info['parent_id']) {
			return $this->getPath($category_info['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $category_info['name'];
		} else {
			return $category_info['name'];
		}
	}
	
	public function getCategoryDescriptions($category_id) {
		$category_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category_description WHERE category_id = '" . (int)$category_id . "'");
		
		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = array(
				'name'				   => $result['name'],
				'meta_keyword'	      => $result['meta_keyword'],
				'meta_description'   => $result['meta_description'],
				'description'		   => $result['description']
			);
		}
		
		return $category_description_data;
	}
	
	public function getCategoryStores($category_id) {
		$category_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category_to_store WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}
		
		return $category_store_data;
	}

	public function getCategoryLayouts($category_id) {
		$category_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		
		foreach ($query->rows as $result) {
			$category_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $category_layout_data;
	}
	
	public function updateCategoryStatus($category_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_category SET status = '" . (int)$status . "' WHERE category_id = '" . (int)$category_id . "'");				
	}
	
	public function updateCategoryOrder($category_id, $sort_order) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_category SET sort_order = '" . (int)$sort_order . "' WHERE category_id = '" . (int)$category_id . "'");				
	}
}
?>
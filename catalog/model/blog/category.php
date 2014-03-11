<?php
class ModelBlogCategory extends Model {
   public function getCategory($category_id) {
      $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "blog_category c LEFT JOIN " . DB_PREFIX . "blog_category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "blog_category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");
      
      return $query->row;
   }
   
   public function getCategories($parent_id = 0, $data = array()) {
      $sql = "SELECT * FROM " . DB_PREFIX . "blog_category c LEFT JOIN " . DB_PREFIX . "blog_category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "blog_category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' AND c.sort_order <> '-1'";
      
      if (!empty($data['exclude'])) {
         $implode_data = array();
         $categories = explode(',',$data['exclude']);
         
         foreach ($categories as $category_id) {
            $implode_data[] = "cd.category_id != '" . (int)$category_id . "'";
         }
         
         $sql .= " AND cd.category_id IN (SELECT cd.category_id FROM " . DB_PREFIX . "blog_category_description cd WHERE " . implode(' AND ', $implode_data) . ")";    
      }

      $sql .= " ORDER BY c.sort_order, LCASE(cd.name)";
      
      $query = $this->db->query($sql);
      
      return $query->rows;
   }
   
   public function getCategoryLayoutId($category_id) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_category_to_layout WHERE category_id = '" . (int)$category_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
      
      if ($query->num_rows) {
         return $query->row['layout_id'];
      } else {
         return $this->config->get('config_layout_category');
      }
   }
}
?>
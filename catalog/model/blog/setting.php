<?php
class ModelBlogSetting extends Model {
   public function getSettings() {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_setting");
      
      $data = array();
      foreach ($query->rows as $result) {
         $data[$result['key']] = $result['value'];
      }
      
      return $data;
   }
}
?>
<?php
class ModelBlogSetting extends Model {
   public function updateSetting($data) {
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting");

      foreach ($data as $key => $value) {
         $this->db->query("INSERT INTO " . DB_PREFIX . "blog_setting SET `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
      }
   }
   
   public function getSettings() {
      $data = array();
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_setting");
      
      foreach ($query->rows as $result) {
         $data[$result['key']] = $result['value'];
      }
   
      return $data;
   }
}
?>
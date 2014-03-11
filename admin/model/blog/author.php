<?php
class ModelBlogAuthor extends Model {
   public function addAuthor($data) {
      $this->db->query("INSERT INTO " . DB_PREFIX . "blog_author SET author_group_id = '" . (int)$data['author_group_id'] . "', user_id = '" . (int)$data['user_id'] . "', name = '" . $this->db->escape($data['addAuthor']) . "'");
   }
   
   public function editAuthor($data) {
      $this->db->query("UPDATE " . DB_PREFIX . "blog_author SET name = '" . $this->db->escape($data['renAuthor']) . "' WHERE author_id = '" . (int)$data['author_id'] . "'");
   }
   
   public function getAuthors() {
      $query = $this->db->query("SELECT a.author_id, a.user_id, a.name, CONCAT(u.firstname, ' ', u.lastname) AS fullname, (SELECT name FROM " . DB_PREFIX . "blog_author_group ag WHERE ag.author_group_id = a.author_group_id) AS groupname FROM " . DB_PREFIX . "blog_author a LEFT JOIN " . DB_PREFIX . "user u ON (a.user_id = u.user_id)");
      
      return $query->rows;
   }
   
   public function getUser($user_id) {
      $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "user` WHERE user_id = '" . (int)$user_id . "'");
   
      return $query->row;
   }
   
   public function getUsers() {
      $implode_data = array();
      $authors = $this->getAuthors();
      
      if ($authors) { 
         foreach ($authors as $author) { $implode_data[] = "user_id != '" . (int)$author['user_id'] . "'"; }
         $except = " WHERE " . implode(' AND ', $implode_data) . " AND status = '1' "; } else { $except = " WHERE status = '1'"; 
      }
         
      $query = $this->db->query("SELECT user_id, CONCAT(firstname, ' ', lastname) AS fullname FROM " . DB_PREFIX . "user " . $except . "");
      
      return $query->rows;
   }
   
   public function getAuthorGroups() {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author_group ORDER BY author_group_id DESC");
      
      return $query->rows;
   }
   
   public function delAuthor($author_id) {
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_author WHERE author_id = '" . (int)$author_id . "'");
   }
   
   public function getPermissions() {
      $data = array(); 
      
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_author_group");
      
      foreach ($query->rows as $result) {
         $data[] = array(
            'name'         => $result['name'],
            'permission'   => $result['permission']
         );
      }

      return $data;
   }
   
   public function editPermissions($datas) {
      foreach ($datas as $data) {
         $this->db->query("UPDATE " . DB_PREFIX . "blog_author_group SET permission = '" . $this->db->escape(serialize($data['permission'])) . "' WHERE name = '" . $this->db->escape($data['name']) . "'");
      }
   }
   
   public function getPermissionByUser($user_id) {
      $query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "blog_author ba LEFT JOIN " . DB_PREFIX . "blog_author_group bg ON (ba.author_group_id = bg.author_group_id) WHERE ba.user_id = '" . (int)$user_id . "'");
      
      if (isset($query->row['permission'])) {
         return $query->row['permission'];
      }
   }
   
   public function checkAdminUser() {
      $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_author WHERE author_group_id = '1'");
      
      return $query->row['total'];
   }
   
   public function checkAdminUserId() {
      $query = $this->db->query("SELECT author_id FROM " . DB_PREFIX . "blog_author WHERE author_group_id = '1'");
      
      return $query->row;
   }
}
?>
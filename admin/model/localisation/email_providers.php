<?php
class ModelLocalisationEmailProviders extends Model {
	public function install() {
		if(mysql_num_rows(mysql_query("SHOW TABLES LIKE '".DB_PREFIX."email_providers'"))==0) {
			$sql = "CREATE TABLE ".DB_PREFIX."email_providers (
					id INT NOT NULL ,
					email_providers BLOB NULL,
					PRIMARY KEY (id));";
			$query = $this->db->query($sql);
			$data = '"yahoo.com", "google.com", "hotmail.com", "gmail.com", "me.com", "aol.com", "mac.com", "live.com", "comcast.net", "googlemail.com", "msn.com", "google.co.uk", "hotmail.co.uk", "yahoo.co.uk", "live.co.uk", "facebook.com", "verizon.net", "sbcglobal.net", "att.net", "gmx.com", "mail.com"';
			$sql = "INSERT INTO ".DB_PREFIX."email_providers SET email_providers = '".$this->db->escape($data)."'";
			$query = $this->db->query($sql);
		}
	}
	
	public function getProviders() {
		$sql = "SELECT * FROM ".DB_PREFIX."email_providers";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	public function updateProviders($data) {
		print_r($data);
		$sql = "UPDATE ".DB_PREFIX."email_providers  SET email_providers = '".$this->db->escape($data['email_providers'])."' WHERE id = 0";
		$query = $this->db->query($sql);
		return $query->row;
	}
}
?>
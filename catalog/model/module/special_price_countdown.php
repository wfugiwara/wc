<?php
class ModelModuleSpecialPriceCountDown extends Model {
	
	public function getSpecialPriceEndData($product_id) {
		if ($this->customer->isLogged()){
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = 0;
		}
		
		$sql = "SELECT date_end FROM " . DB_PREFIX . "product_special 
				WHERE product_id ='" . $product_id . "' AND date_start <= NOW() AND date_end >= NOW() ORDER BY priority ";
		if ($customer_group_id){
			$sql .= " AND customer_group_id ='" . $customer_group_id . "'";
		}
		
		$sql .= "LIMIT 0,1";
		
		$query = $this->db->query($sql);
		
		if ($query->num_rows){
			return $query->row['date_end'];
		} else {
			return 0;
		}		
			
	}	
}
?>
<?php
class ModelLocalisationServiceAvailability extends Model {
	public function getServiceAvailability($country_id,$zone_id){
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "zone_to_geo_zone WHERE country_id = '" . (int)$country_id . "' AND geo_zone_id = '" . (int)$this->config->get('service_availability_geo_zone_id') . "' AND (zone_id = '" . (int)$zone_id . "' OR zone_id = '0')");
		
		return $query->row['total'];
	}	
}
?>

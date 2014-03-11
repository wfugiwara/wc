<?php
################################################################################################
#  Customer Import / Export from CSV for Opencart 1.5.x From HostJars opencart.hostjars.com  #
################################################################################################

class ModelToolCustomers extends Model {
	
	public function addCustomer($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', password = '" . $this->db->escape(md5($data['password'])) . "', newsletter = '" . (int)$data['newsletter'] . "', customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "', status = '". (int)$data['status'] . "' , date_added = NOW()");
		 
		$customer_id = $this->db->getLastId();
			
		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "'");
	
		$address_id = $this->db->getLastId();
	
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
	
		if (!$this->config->get('config_customer_approval')) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET approved = '1' WHERE customer_id = '" . (int)$customer_id . "'");
		}
	}
	
	public function editCustomer($customer_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "',  telephone = '" . $this->db->escape($data['telephone']) . "',cpf = '" . $this->db->escape($data['cpf']) . "',cnpj = '" . $this->db->escape($data['cnpj']) . "',razao_social = '" . $this->db->escape($data['razao_social']) . "',inscricao_estadual = '" . $this->db->escape($data['inscricao_estadual']) . "',ddd = '" . $this->db->escape($data['ddd']) . "', data_nascimento = '" . $this->db->escape($dataparts[2]."-".$dataparts[1]."-".$dataparts[0]) . "',ddd2 = '" . $this->db->escape($data['ddd2']) . "', telephone2 = '" . $this->db->escape($data['telephone2']) . "',  sexo = '" . $this->db->escape($data['sexo']) . "', placa1 = '" . $this->db->escape($data['placa1']) . "',placa2 = '" . $this->db->escape($data['placa2']) . "', fax = '" . $this->db->escape($data['fax']) . "', status = '" . (int)$data['status'] . "' WHERE customer_id = '" . (int)$customer_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$customer_id . "'");
      	$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', numero = '" . $this->db->escape($address['numero']) . "', complemento = '" . $this->db->escape($address['complemento']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "'");
      	$address_id = $this->db->getLastId();
      	$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function getCustomers() {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "address a ON (c.customer_id = a.customer_id)";
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	
	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT DISTINCT customer_id FROM " . DB_PREFIX . "customer WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		return (isset($query->row['customer_id'])) ? $query->row['customer_id'] : 0;
	}
	
	public function getCountryIdByName($country_name) {
		$query = $this->db->query('SELECT country_id FROM ' . DB_PREFIX . "country WHERE name = '" . ucfirst($this->db->escape($country_name)) . "'");
		if ($query->num_rows) {
			return $query->row['country_id'];
		} else {
			return 0;
		}
	}
	
	public function getCountry($country_id) {
		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$country_id . "'");
		if ($query->num_rows){
			return $query->row['name'];
		} else {
			return '';
		}
	}
	
	public function getZoneIdByName($zone_name) {
		$query = $this->db->query('SELECT zone_id FROM ' . DB_PREFIX . "zone WHERE name = '" . ucfirst($this->db->escape($zone_name)) . "' AND status = 1");
		if ($query->num_rows) {
			return $query->row['zone_id'];
		} else {
			return 0;
		}
	}
	
	public function getZone($zone_id, $country_id) {
		$sql = "SELECT name FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$zone_id . "'";
		$query = $this->db->query($sql);
		if ($query->num_rows){
			return $query->row['name'];
		} else {
			return '';
		}
	}
	
	public function export($fields) {
		
		$customers = $this->getCustomers();
		
		$fields['export'][] = 'customer_id';
		
		//ensures only a single customer is exporter with the first address
		if(isset($fields['single_address']) && $fields['single_address'] == 'on') {
			$existing = array();
			for($i = 0; $i <= count($customers); $i++) {
				if(!isset($existing[$customers[$i]['customer_id']])) {
					$existing[$customers[$i]['customer_id']] = 1;
				} else {
					unset($customers[$i]);
				}
			}
		}		
		//headings
		 $output = str_replace("placa1","",str_replace("placa2","",implode(";", $fields['export']) . "\n")) ;
		//$output .= str_replace("placa2","renavam2",$output);
		foreach ($customers as $customer) {
			$customer_output = array();
			//load extra stuff into customer array
			if ($customer['country_id']) {
				$customer['country_id'] = $this->getCountry($customer['country_id']);
				if ($customer['zone_id']) {
					$customer['zone_id'] = $this->getZone($customer['zone_id'], $customer['country_id']);
				}
			}
			//loop over desired fields and print each one
			$customer_data = array();
			foreach ($fields['export'] as $field) {
				if (isset($customer[$field])) {
					$customer_output[] = '"' . $customer[$field] . '"';
				} else {
					$customer_output[] = '';
				}
			}
			$output .= implode(";", $customer_output) . "\n";
			
		}
		$output .= "\n";
		

		return utf8_decode($output);	
	}
}
?>
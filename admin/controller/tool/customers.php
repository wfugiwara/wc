<?php 
################################################################################################
#  Customer Import / Export from CSV for Opencart 1.5.x From HostJars opencart.hostjars.com  #
################################################################################################

class ControllerToolCustomers extends Controller { 
	private $error = array();
	private $field_names = array();
	
	public function index() {		
		$this->load->language('tool/customers');
		$this->load->model('setting/setting');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		//field mappings from input to OpenCart
		$field_map = array(
			'customers_field_firstname' => 'firstname',
			'customers_field_lastname' 	=> 'lastname',
			'customers_field_email'		=> 'email',
			'customers_field_ddd' 	=> 'ddd',
			'customers_field_telephone' => 'telephone',
			'customers_field_fax' 		=> 'fax',
			'customers_field_password' 	=> 'password',
			'customers_field_newsletter' => 'newsletter',
			'customers_field_company' 	=> 'company',
			
			'customers_field_cpf' 	=> 'cpf',
			'customers_field_cnpj' 	=> 'cnpj',
			'customers_field_razao_social' 	=> 'razao_social',
			'customers_field_inscricao_estadual' 	=> 'inscricao_estadual',
			'customers_field_data_nascimento' 	=> 'data_nascimento',
			'customers_field_ddd2' 	=> 'ddd2',
			'customers_field_telephone2' 	=> 'telephone2',
			'customers_field_sexo' 	=> 'sexo',
			// 'customers_field_placa1' 	=> 'placa1',
			// 'customers_field_placa2' 	=> 'placa2',
			
			
			'customers_field_address_1' => 'address_1',
			'customers_field_numero' => 'numero',
			'customers_field_address_2' => 'address_2',
			'customers_field_postcode' 	=> 'postcode',
			'customers_field_country_id' => 'country_id',
			'customers_field_zone_id' 	=> 'zone_id',
			'customers_field_city' 		=> 'city',
			'customers_field_status' 		=> 'status',
		);
		
		$settings = array();
		//set the correct OpenCart based field names for all products
		foreach ($field_map as $postfield => $ocvalue) {
			if (isset($this->request->post[$postfield])) {
				$this->field_names[$ocvalue] = $this->request->post[$postfield];
				//add each field setting to settings array
			}
			$this->data[$postfield] = '';
		}
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			
			//save the current settings
			$settings = $this->request->post;
			foreach ($settings as $key => $value) {
				$settings[$key] = serialize($value);
			}
			$this->model_setting_setting->editSetting('customer_import', $settings);
			
			if (is_uploaded_file($this->request->files['import']['tmp_name'])) {
				$content = file_get_contents($this->request->files['import']['tmp_name']);
			} else {
				$content = false;
			}
			
			if ($content) {
				$this->csvImport($this->request->files['import']['tmp_name']);
				
				$this->session->data['success'] = $this->language->get('text_success');
				
				$this->redirect($this->url->link('tool/customers', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->error['warning'] = $this->language->get('error_empty');
			}
		}
		
		//define language items from language file
		$language = array(
			'heading_title',
			'text_select_all',
			'text_unselect_all',
			'entry_import',
			'entry_export',
			'entry_ignore_fields',
			'entry_contains',
			'entry_column',
			'entry_value',
			'entry_tab',
			'entry_delimiter',
			'entry_single_address',
			'entry_single_address_help',
			'button_export',
			'button_import',
			'tab_general',
			'text_field_oc_title',
			'text_field_csv_title',
			'text_field_firstname',
			'text_field_lastname',
			'text_field_email',
			'text_field_telephone',
			'text_field_fax',
			'text_field_password',
			'text_field_newsletter',
			'text_field_company',
			'text_field_address_1',
			'text_field_address_2',
			'text_field_postcode',
			'text_field_city',
			'text_field_country_id',
			'text_field_zone_id',
			'text_field_status',
			'text_password_help',
			'text_documentation',
			'tab_import',
			'tab_export',
		);
		
		//load each language item
		foreach ($language as $text) {
			$this->data[$text] = $this->language->get($text);
		}
		
		//load any existing settings and set correct values
		$settings = $this->model_setting_setting->getSetting('customer_import');
		foreach ($settings as $key => $value) {
			if($value != '') {
				$this->data[$key] = $value ? unserialize($value) : $value;
			} else {
				$this->data[$key] = '';
			}
		}
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('tool/customers', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		$this->data['import'] = $this->url->link('tool/customers', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['export'] = $this->url->link('tool/customers/export', 'token=' . $this->session->data['token'], 'SSL');

		$table_data = array(
			'firstname',
			'lastname',
			'email',
			'ddd',
			'telephone',

			'fax',
			'ip',
			'date_added',
			'company',
			
			'cpf',
			'cnpj',
			'razao_social',
			'inscricao_estadual',
			'data_nascimento',
			'ddd2',
			'telephone2',
			'sexo',
			// 'placa1',
			// 'placa2',
			
			'address_1',
			'numero',
			'address_2',
			'postcode',
			'city',
			'country_id',
			'zone_id',
			'status'
		);
			
		$this->data['tables'] = $table_data;
		
		$this->template = 'tool/customers.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	public function export() {
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			
			$this->response->addheader('Pragma: public');
			$this->response->addheader('Expires: 0');
			$this->response->addheader('Content-Description: File Transfer');
			$this->response->addheader('Content-Type: application/octet-stream');
			$this->response->addheader('Content-Disposition: attachment; filename=customers.csv');
			$this->response->addheader('Content-Transfer-Encoding: binary');
			
			$this->load->model('tool/customers');
			$this->response->setOutput($this->model_tool_customers->export($this->request->post));
		} else {
			return $this->forward('error/permission');
		}
	}
	
	public function csvImport($file, $delim=",") {

		$this->load->model('setting/setting');
		$this->load->model('tool/customers');
		$this->load->model('sale/customer');
		
		//load any existing settings and set correct values
		$settings = $this->model_setting_setting->getSetting('customer_import');
		foreach ($settings as $key => $value) {
			if($value != '') {
				$settings[$key] = $value ? unserialize($value) : $value;
			}
		}
		
		//get the delimiter and use the set one
		if(isset($settings['customer_import_delimiter']) && $settings['customer_import_delimiter'] != '') {
			//if tab, assign it to actual tab not /t
			if ($settings['customer_import_delimiter'] == '\t') {
				$settings['customer_import_delimiter'] = "\t";
			}
			$delim = $settings['customer_import_delimiter'];
		}
		
		
		//table driven fields
		$customer_data = array(
			'store_id' => 0,
			'firstname' => '',
			'lastname' => '',
			'email' => '',
			'telephone' => '',
			'fax' => '',
			'password' => '',
			'newsletter' => 0,
			'customer_group_id' => 0,
			'company' => '',
			'address_1' => '',
			'address_2' => '',
			'postcode' => '',
			'city' => '',
			'country_id' => 223,
			'zone_id' => '',
			'status' => 1
		);
		
	    $fh = fopen($file, 'r');

		// Get headings
		$headings = fgetcsv($fh, 0, $delim);
		$num_cols = count($headings);
	    $num_rows = 0;

	    //Read the file as csv
	    while (($row = fgetcsv($fh, 0, $delim)) !== FALSE) {

			//skip product if broken row (although broken row probably means broken whole file)
			if (count($row) != $num_cols) {
	    		continue;
	    	}
	    	
			$raw_data = array(); // will contain product from csv
	    	$customer = array();  // will contain new customer to add
	    	$raw_data = array_combine($headings, $row);

	    	//if the customer contains a skip value, skip the customer
	    	if(isset($settings['customer_import_ignore_field']) && isset($settings['customer_import_ignore_value'])) {
	    		if(isset($settings['customer_import_ignore_field']) && isset($this->field_names[$settings['customer_import_ignore_field']]) && isset($raw_data[$this->field_names[$settings['customer_import_ignore_field']]]) && $raw_data[$this->field_names[$settings['customer_import_ignore_field']]] == $settings['customer_import_ignore_value']) {
	    			continue;
	    		}
	    	}
	    	
	    	//turn country name into country id
	    	if (isset($raw_data[$this->field_names['country_id']])) {
	    		$country_id = $this->model_tool_customers->getCountryIdByName($raw_data[$this->field_names['country_id']]);
	    		if (!$country_id) {
	    			  //create country?
	    			  unset($raw_data[$this->field_names['country_id']]);
	    		} else {
		    		$raw_data[$this->field_names['country_id']] = $country_id;
	    		}
	    	}
	    	//turn zone name into zone id
	    	if (isset($raw_data[$this->field_names['zone_id']])) {
		    	$zone_id = $this->model_tool_customers->getZoneIdByName($raw_data[$this->field_names['zone_id']]);
    		    if (!$zone_id) {
		    		//create zone?
		    		unset($raw_data[$this->field_names['zone_id']]);
		    	} else {
		    		$raw_data[$this->field_names['zone_id']] = $zone_id;
		    	}
    		}
    		
			// loop over customer_data array adding product table data
			foreach ($customer_data as $field => $default_value) {
				if (isset($this->field_names[$field]) && isset($raw_data[$this->field_names[$field]])) {
					$customer[$field] = $raw_data[$this->field_names[$field]];
				}
				else {
					$customer[$field] = $default_value;
				}
			}
			
			//Allow for true/false, on/off, enable/dissable and yes/no in the below fields
			if(isset($customer['newsletter'])) {
				$customer['newsletter'] = preg_match('/(no|^n$|false|off|disable|0)/is', $customer['newsletter']) ? 0 : 1;
			}
			if(isset($customer['status'])) {
				$customer['status'] = preg_match('/(no|^n$|false|off|disable|0)/is', $customer['status']) ? 0 : 1;
			}
			
	        // Is this an update?
	        $update_id = 0;
	        
        	if (isset($customer['email']) && ($customer['email'] != '')) {
        		$update_value = $customer['email'];
        		$update_id = $this->model_tool_customers->getCustomerByEmail($update_value);
        	}
        	

 	        //EXISTING PRODUCT:
 	        if ($update_id) {
        		$this->model_tool_customers->editCustomer($update_id, $customer);
 	        } else {
 	        	//NEW PRODUCT
        		$this->model_tool_customers->addCustomer($customer);
        		$this->total_items_added++;
	       	}	
	       	//ADD THE CUSTOMER
	       	$num_rows++;
	       	
	    }

	    fclose($fh);

	    return $num_rows;
	}
	
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/customers')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}		
	}
}
?>
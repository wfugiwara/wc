<?php
#####################################################################################
#  Module Order Feed for Opencart 1.5.x From HostJars opencart.hostjars.com 		#
#####################################################################################

class ModelFeedOrderFeed extends Model {

	public function createCSV($data) {
		
		//define each setting
		$settings = array(
			'order_feed_status',
			'order_feed_sum_from',
			'order_feed_date_from',
			'order_feed_order_from',
			'order_feed_sum_to',
			'order_feed_date_to',
			'order_feed_order_to',
			'order_feed_export',
		);
		
		//generate the blank settings array for each setting
		foreach ($settings as $setting) {
			if (!isset($data[$setting])) {
				$data[$setting] = '';
			}	
		}
		
		$output = '';

		$this->load->model('sale/order');
		
		$orders = $this->getOrdersFiltered($data);
		
		foreach ($orders as $ord) {
			$order = $this->model_sale_order->getOrder($ord['order_id']);
			$products = $this->model_sale_order->getOrderProducts($order['order_id']);
			$totals = $this->model_sale_order->getOrderTotals($order['order_id']);	
			$order['shipping_cost'] = '';
			foreach ($totals as $total) {
				if ($total['code'] == 'shipping') {
					$order['shipping_cost'] = $total['value'];
				}
			}
			
			
			foreach ($products as $product) {
				$options = $this->model_sale_order->getOrderOptions($order['order_id'], $product['order_product_id']);
				$option = array('OptionName'=>'', 'OptionValue'=>'');

				$option['OptionName'] = '';
				$option['OptionValue'] = '';
				foreach ($options as $opt) {
					if($option['OptionName'] == '') {
						$option['OptionName'] = $opt['name'];
					} else {
						$option['OptionName'] .= '|' . $opt['name'];
					}
					if($option['OptionValue'] == '') {
						$option['OptionValue'] = $opt['value'];
					} else {
						$option['OptionValue'] .= '|' . $opt['value'];
					}
				}
				//Headings
				if ($output == '') {
					foreach ($order as $key=>$value) {
						$output .= "Order_" . $key . ";";
					}
					foreach ($product as $key=>$value) {
						$output .= "Product_" . $key . ";";
					}
					$output .= "Option_Name;Option_Value\n" ;
				}
				$novo = str_replace("placa1","renavam",str_replace("placa2","renavam2",$output)) ;
				$output = $novo;
				$output .= $this->outputCSV($order, $product, $option);
			}
		}
		
		return $output;
	}
	
	private function outputCSV($order, $product, $option) {
		$row = array();
		foreach ($order as $key => $value) {
			$value = str_replace('"', '""', $value);
			$row["Order_" . $key] = '"' . $value . '"';
		}
		foreach ($product as $key => $value) {
			$value = str_replace('"', '""', $value);
			$row["Product_" . $key] = '"' . $value . '"';
		}
		foreach ($option as $key => $value) {
			$value = str_replace('"', '""', $value);
			$row["Product_Option_" . $key] = '"' . $value . '"';
		}
		$result = join(";", $row);
		$result .= "\n";
		return utf8_decode($result);
	}
	
	public function getOrdersFiltered($data) {
		$sql = "SELECT o.order_id, CONCAT(o.firstname, ' ', o.lastname) AS customer, (SELECT os.name FROM " . DB_PREFIX . "order_status os WHERE os.order_status_id = o.order_status_id AND os.language_id = '" . (int)$this->config->get('config_language_id') . "') AS status, o.total, o.currency_code, o.currency_value, o.date_added, o.date_modified FROM `" . DB_PREFIX . "order` o";
		$where = false;
		
		if ($data['order_feed_date_from'] != '' && $data['order_feed_date_to'] != '') {
			$sql .= " WHERE o.date_added BETWEEN '" . $this->db->escape($this->getSqlDate($data['order_feed_date_from'])) . "' AND '" . $this->db->escape($this->getSqlDate($data['order_feed_date_to'])) . "'";
			$where = true;
		}

		if ($data['order_feed_sum_from'] != '' && $data['order_feed_sum_to'] != '') {
			if($where) {
				$sql .= " AND ";
			} else {
				$sql .= " WHERE ";
				$where = true;
			}
			$sql .= "o.total BETWEEN '" . (float)$data['order_feed_sum_from'] . "' AND '" . (float)$data['order_feed_sum_to'] . "'";
		}
		
		if ($data['order_feed_order_from'] != '' && $data['order_feed_order_to'] != '') {
			if($where) {
				$sql .= " AND ";
			} else {
				$sql .= " WHERE ";
				$where = true;
			}
			$sql .= " o.order_id BETWEEN '" .(int)($data['order_feed_order_from']) . "' AND '" . (int)$data['order_feed_order_to'] . "'";
		}
		
		if ($data['order_feed_status'] != '') {
			if($where) {
				$sql .= " AND ";
			} else {
				$sql .= " WHERE ";
				$where = true;
			}
			$sql .= " o.order_status_id = '" . $this->db->escape($data['order_feed_status']) . "'";
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	private function getSqlDate($date) {
		$date = date("Y-m-d H:i:s", strtotime($date));
		return $date;
	}
	
}
?>
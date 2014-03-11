<?php
//-----------------------------------------
// Author: Qphoria@gmail.com
// Web: http://www.OpenCartGuru.com/
//-----------------------------------------
class ControllerProductOptionPriceUpdate extends Controller {

	private static function opu_custom_sort($a,$b) {
          return $a['quantity']>$b['quantity'];
    }

	public function updatePrice() {

		file_put_contents(DIR_LOGS . 'opu_debug.txt', print_r($this->request->post, 1));

		$this->load->model('catalog/product');

		$price = 0;

		# Check product id and get price without formatting
		if (!isset($this->request->post['product_id'])) { return; }

		$quantity = 1;

		// Comment out this line to disable qty update
		$quantity = (isset($this->request->post['quantity'])) ? (int)$this->request->post['quantity'] : 1;
		//

		$product_id = $this->request->post['product_id'];

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if (!$product_info ) { return; }

		if (method_exists($this->document, 'addBreadcrumb')) { //1.4.x
			$price = (float)$product_info['price'];

			$discount = (float)$this->model_catalog_product->getProductDiscount($product_id);
			if ($discount) {
				$price = (float)$discount;
			}

			$special = $this->model_catalog_product->getProductSpecial($product_id);
			if ($special) {
				$special = (float)$special;
			} else {
				$special = 0;
			}

		} else { //1.5.x
			$price = $product_info['price'];
			$special = $product_info['special'];

			$discounts = $this->model_catalog_product->getProductDiscounts($product_id);

			$discount_order = array();

			foreach ($discounts as $key => $value) {
				$discount_order[$key] = $value['quantity'];
			}

			array_multisort($discount_order, SORT_DESC, $discounts);

			foreach ($discounts as $discount) {
				if ($quantity >= $discount['quantity']) {
					$price = $discount['price'];
					break;
				}
			}
		}

		$basePrice = $price;
		$baseSpecial = $special;

		// Option discount by same special factor
		$disc_factor = 0;
		if ($baseSpecial) {
			$disc_factor = ((float)$baseSpecial / (float)$basePrice);
		}

		// AceShop Support
		if (isset($this->request->post['option_oc']) && is_array($this->request->post['option_oc'])) {
			$post_option = $this->request->post['option_oc'];
		} elseif (isset($this->request->post['option']) && is_array($this->request->post['option'])) {
			$post_option = $this->request->post['option'];
		}


		# Get product options and add it to the current price
		$oneTimePrice = 0;
		if (!empty($post_option)) {
			foreach ($post_option as $option_id => $option_value_id) {
				if (is_array($option_value_id)) {
					$opts = "'" . implode("','", $option_value_id) . "'";
					# Remove product id allows it to work with GMO in 1.4.x Not sure of sideeffects on normal options
					//$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id IN (" . $opts . ") AND product_id = '" . (int)$product_id . "'");
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id IN (" . $opts . ")");
				} else {
					# Remove product id allows it to work with GMO in 1.4.x Not sure of sideeffects on normal options
					//$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$option_value_id . "' AND product_id = '" . (int)$product_id . "'");
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$option_value_id . "'");
				}

				if ($query->num_rows) {
					foreach ($query->rows as $qr) {
						$prfx = (isset($qr['prefix'])) ? $qr['prefix'] : $qr['price_prefix'];
						$option_price = $qr['price'];

						$base_option_price = $option_price;
						
						// Only discount if options boost is installed and prfx is +
						//if ($prfx == '+' && $disc_factor && file_exists(DIR_SYSTEM . '../catalog/controller/product/options_boost.inc.php')) {
						if ($disc_factor && file_exists(DIR_SYSTEM . '../catalog/controller/product/options_boost.inc.php')) {
							$option_price *= $disc_factor;
						}

						// Support for "Customer Group Discount" mod for option discounts
						if (method_exists($this->customer, 'getOptionDiscount')) {
							$option_query = $this->db->query("SELECT option_id FROM " . DB_PREFIX . "product_option WHERE product_option_id = '" . (int)$option_id . "'");
							if ($option_query->num_rows) {
								$option_discount = $this->customer->getOptionDiscount($option_query->row['option_id']);
								file_put_contents(DIR_LOGS . 'opu_cgd_debug.txt', print_r($option_discount, 1));
								if ($option_discount) {
									$option_price = (float)$option_price * (float)$option_discount;
								}
							}
						}

						if ($prfx == '-') {
							$price -= (float)$option_price;
							if ($special) { $special -= (float)$option_price; }
						} elseif ($prfx == '*') {
							$price += $basePrice * (float)$option_price;
							if ($special) { $special += $baseSpecial * (float)$option_price; }
						} elseif ($prfx == '%') {
							$price += $basePrice * (float)($option_price/100);
							if ($special) { $special += $baseSpecial * (float)($option_price/100); }
						} elseif ($prfx == '=') {
							$price = (float)($base_option_price);
							if ($special) { $special = (float)($option_price); }
						} elseif ($prfx == '1') {
							$price += (float)$option_price;
							if ($special) { $special += (float)$option_price; }
							$oneTimePrice += (float)$option_price;
						} else { // +
							$price += (float)$option_price;
							if ($special) { $special += (float)$option_price; }
						}
					}
				}
			}
		}

		if ($quantity-1 != 0) {
			$oneTimePrice *= ($quantity-1);
		} else {
			$oneTimePrice = 0;
		}
		$raw_price = $price * $quantity - $oneTimePrice;
		$raw_special = $special * $quantity - $oneTimePrice;

		$price = $this->currency->format($this->tax->calculate($raw_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->currency->getCode(), FALSE, TRUE);
		if ($special) {
			$special = $this->currency->format($this->tax->calculate($raw_special, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->currency->getCode(), FALSE, TRUE);
			$tax = $this->currency->format($raw_special, $this->currency->getCode(), FALSE, TRUE);
		} else {
			$tax = $this->currency->format($raw_price, $this->currency->getCode(), FALSE, TRUE);
		}


$data = array();
$data['price'] = $price;
$data['special'] = $special;
$data['tax'] = $tax;
file_put_contents(DIR_LOGS . 'opu_output.txt', print_r($data, 1));

		//$this->response->setOutput($price, $this->config->get('config_compression'));
		if (!method_exists($this->tax, 'getRates')) { //v1.5.1.2 or earlier
			$this->load->library('json');
			//$this->response->setOutput(Json::encode($data));
			print Json::encode($data); // compatible with ayelshop
		} else {
			//$this->response->setOutput(json_encode($data));
			print json_encode($data); // compatible with ayelshop
		}

		//$this->response->setOutput(json_encode($data));

		exit;

	}

}
?>
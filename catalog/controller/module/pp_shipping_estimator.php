<?php

class ControllerModulePpShippingEstimator extends Controller {

    public function index() {
        if ($this->config->get('pp_shipping_estimator_status') && isset($this->request->get['product_id'])) {
            $this->language->load('module/pp_shipping_estimator');


            $this->data['heading_title'] = $this->language->get('heading_title');
            $this->data['text_shipping'] = $this->language->get('text_shipping');
            $this->data['text_select'] = $this->language->get('text_select');

            $this->data['text_auto_quote'] = $this->language->get('text_auto_quote');
            $this->data['text_auto_quote_cost_free'] = $this->language->get('text_auto_quote_cost_free');
            $this->data['text_auto_quote_cost_lowest'] = $this->language->get('text_auto_quote_cost_lowest');
            
            $this->data['text_wrong_region']= $this->language->get('text_wrong_region');
            $this->data['text_other_methods']= $this->language->get('text_other_methods');
            
            $this->data['entry_country'] = $this->language->get('entry_country');
            $this->data['entry_zone'] = $this->language->get('entry_zone');
            $this->data['entry_postcode'] = $this->language->get('entry_postcode');

            $this->data['button_quote'] = $this->language->get('button_simular');
            $this->data['button_shipping'] = $this->language->get('button_shipping');

            $this->data['show_as_module'] = $this->config->get('pp_shipping_estimator_show_mode');
            
            
            

            if (isset($this->session->data['shipping_country_id'])) {

                $this->data['pp_shipping_estimator_country_id'] = $this->session->data['shipping_country_id'];
            } elseif (isset($this->session->data['pp_shipping_estimator_country_id'])) {

                $this->data['pp_shipping_estimator_country_id'] = $this->session->data['pp_shipping_estimator_country_id'];
            } else {

                $this->data['pp_shipping_estimator_country_id'] = $this->config->get('pp_shipping_estimator_country_id');
            }


            if (isset($this->session->data['shipping_zone_id'])) {

                $this->data['pp_shipping_estimator_zone_id'] = $this->session->data['shipping_zone_id'];
                
            } elseif (isset($this->session->data['pp_shipping_estimator_zone_id'])) {

                $this->data['pp_shipping_estimator_zone_id'] = $this->session->data['pp_shipping_estimator_zone_id'];
                
            } else {

                $this->data['pp_shipping_estimator_zone_id'] = $this->config->get('pp_shipping_estimator_zone_id');
        
            }

            if (isset($this->session->data['shipping_postcode'])) {

                $this->data['pp_shipping_estimator_postcode'] = $this->session->data['shipping_postcode'];
                
            } elseif (isset($this->session->data['pp_shipping_estimator_postcode'])) {

                $this->data['pp_shipping_estimator_postcode'] = $this->session->data['pp_shipping_estimator_postcode'];
                
            } else {

                $this->data['pp_shipping_estimator_postcode'] = $this->config->get('pp_shipping_estimator_postcode');
        
            }
 

            if (isset($this->session->data['shipping_methods'])) {
                $this->data['shipping_methods'] = $this->session->data['shipping_methods'];
            } else {
                $this->data['shipping_methods'] = array();
            }

            if (isset($this->session->data['shipping_method']['code'])) {
                $this->data['code'] = $this->session->data['shipping_method']['code'];
            } else {
                $this->data['code'] = '';
            }

            $this->data['auto_quote'] = FALSE;

            if ($this->config->get('pp_shipping_estimator_auto_quote')) {

                $this->data['auto_quote'] = $this->autoQuote($this->data['pp_shipping_estimator_country_id'], $this->data['pp_shipping_estimator_zone_id'], $this->data['pp_shipping_estimator_postcode']);

            }else{
                
                $this->data['auto_quote'] = FALSE;
 
            }


            $this->load->model('localisation/country');
            $this->data['countries'] = $this->model_localisation_country->getCountries();

            $this->data['current_country'] = FALSE;
            $this->data['current_zone'] = FALSE;

            if ($this->data['pp_shipping_estimator_country_id']) {

                foreach ($this->data['countries'] as $country) {

                    if ($country['country_id'] == $this->data['pp_shipping_estimator_country_id']) {

                        $this->data['current_country'] = $country['name'];

                    }
                }
            }


            if ($this->data['pp_shipping_estimator_zone_id']) {

                $this->load->model('localisation/zone');

                $zone = $this->model_localisation_zone->getZone($this->data['pp_shipping_estimator_zone_id']);

                if ($zone) {

                    $this->data['current_zone'] = $zone['name'];
                }
            }

            $this->data['country_required'] = $this->config->get('pp_shipping_estimator_show_country_field');
            $this->data['zone_required'] = $this->config->get('pp_shipping_estimator_show_zone_field');
            $this->data['postcode_required'] = $this->config->get('pp_shipping_estimator_show_postcode_field');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/shipping_simulator.tpl')) {

                $this->template = $this->config->get('config_template') . '/template/module/shipping_simulator.tpl';
            } else {

                $this->template = 'default/template/module/pp_shipping_estimator.tpl';
            }

            $this->render();
        }
    }

    private function autoQuote($country_id, $zone_id, $postcode = null) {

        $this->load->model('catalog/product');
        
        $auto_quote = false;
 
        if (!$this->model_catalog_product->getProductOptions($this->request->get['product_id'])) {
    
            $product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
 
            $cart_prods = $this->cart->getProducts();

            $this->cart->clear();

            $this->cart->add($this->request->get['product_id'],$product_info['minimum']);

            if ($country_id && $zone_id) {
                
               $version = substr(VERSION, 0,5);
 
               if ($version == '1.5.1' && VERSION != '1.5.1.3'){
                   
                     $this->tax->setZone($country_id, $zone_id);
                     
               }else{
          
                    $this->tax->setShippingAddress($country_id, $zone_id); 
               }
          
            }

            $quote_data = $this->getQuoteData($country_id, $zone_id, $postcode);

            if ($quote_data) {
                
                $auto_quote['lowest']  = false;

                $this->session->data['shipping_methods'] = $quote_data;

                $auto_quote['shipping_methods'] = $quote_data;

                foreach ($quote_data as $shipping) {

                    foreach ($shipping['quote'] as $shipping_quote) {

                        if (!$auto_quote['lowest'] || $shipping_quote['cost'] < $auto_quote['lowest']['cost']) {

                            $auto_quote['lowest'] = $shipping_quote;
                        }
                    }
                }
            }  

            $this->cart->clear();

            foreach ($cart_prods as $p_data) {

                $options = array();

                foreach ($p_data['option'] as $option) {

                    if ($option['product_option_value_id']) {

                        $options[$option['product_option_id']] = $option['product_option_value_id'];
                    } elseif ($option['option_value']) {

                        $options[$option['product_option_id']] = $option['option_value'];
                    }
                }
                $this->cart->add($p_data['product_id'], $p_data['quantity'], $options);
            }
        }
        
        return $auto_quote;
        
    }

    public function quote() {

        $this->language->load('module/pp_shipping_estimator');

        $json = array();
        $json['error'] = false;

        $this->validateQuote($json);

        if (!$json['error']) {

            $cart_prods = $this->cart->getProducts();

            $this->cart->clear();

            $options = isset($this->request->post['option']) ? array_filter($this->request->post['option']) : array();

            $this->cart->add($this->request->post['product_id'], $this->request->post['quantity'], $options);

            $vars = $this->loadPostVars();

            if ($vars['country_id'] && $vars['zone_id']) {
       
               $version = substr(VERSION, 0,5);
 
               if ($version == '1.5.1' && VERSION != '1.5.1.3'){
                   
                     $this->tax->setZone($vars['country_id'], $vars['zone_id']);
                     
               }else{
          
                    $this->tax->setShippingAddress($vars['country_id'], $vars['zone_id']); 
               }
    
            }

            $quote_data = $this->getQuoteData($vars['country_id'], $vars['zone_id'], $vars['postcode']);

            if ($quote_data) {

                $this->session->data['shipping_methods'] = $quote_data;

                $json['shipping_methods'] = $quote_data;
            } else {

                $json['error'] = true;
                $json['text_error'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
            }

            $json['text_success'] = sprintf($this->language->get('text_success'), $this->request->post['quantity']);

            $this->cart->clear();

            foreach ($cart_prods as $p_data) {

                $options = array();

                foreach ($p_data['option'] as $option) {

                    if ($option['product_option_value_id']) {

                        $options[$option['product_option_id']] = $option['product_option_value_id'];
                    } elseif ($option['option_value']) {

                        $options[$option['product_option_id']] = $option['option_value'];
                    }
                }
                $this->cart->add($p_data['product_id'], $p_data['quantity'], $options);
            }
        }


        $this->response->setOutput(json_encode($json));
    }
 
    private function validateQuote(&$json) {

        $country_required = $this->config->get('pp_shipping_estimator_show_country_field');
        $zone_required = $this->config->get('pp_shipping_estimator_show_zone_field');
        $postcode_required = $this->config->get('pp_shipping_estimator_show_postcode_field');

        $product_id = isset($this->request->post['product_id']) ? $this->request->post['product_id'] : '';

        if (!$product_id) {

            $json['error'] = true;
            $json['text_error'] = $this->language->get('error_product');
            return;
        }

        $quantity = isset($this->request->post['quantity']) ? $this->request->post['quantity'] : '';

        if (!$quantity) {

            $json['error'] = true;
            $json['text_error'] = $this->language->get('error_quantity');
            return;
        }


        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProduct($product_id);


        if ($product_info['minimum'] > $quantity) {
            $json['error'] = true;
            $json['text_error'] = sprintf($this->language->get('error_minimum'), $product_info['name'], $product_info['minimum']);
            return;
        }


        $product_options = $this->model_catalog_product->getProductOptions($product_id);

        foreach ($product_options as $product_option) {

            $post_option = isset($this->request->post['option'][$product_option['product_option_id']]) ? $this->request->post['option'][$product_option['product_option_id']] : '';

            if ($product_option['required'] && !$post_option) {

                $json['error'] = true;
                $json['text_error'] = $this->language->get('error_option');
                return;
            }
        }


        $country_id = isset($this->request->post['country_id']) ? $this->request->post['country_id'] : '';

        if (!$country_id && $country_required) {

            $json['error'] = true;
            $json['text_error'] = $this->language->get('error_country');
            return;
        }

        $zone_id = isset($this->request->post['zone_id']) ? $this->request->post['zone_id'] : '';

        if ($zone_id == '' && $zone_required) {

            $json['error'] = true;
            $json['text_error'] = $this->language->get('error_zone');
            return;
        }

        $postcode = isset($this->request->post['postcode']) ? $this->request->post['postcode'] : '';

        $postcode_invalid = ((strlen(utf8_decode($postcode)) < 2) || (strlen(utf8_decode($postcode)) > 10));

        if ((!$postcode && $postcode_required) || ($postcode_invalid && $postcode_required)) {

            $json['error'] = true;
            $json['text_error'] = $this->language->get('error_postcode');
            return;
        }
    }

    private function validateCalculate(&$json) {

        $this->validateQuote($json);

        if (!$json['error']) {

            $shipping_method = isset($this->request->post['shipping_method']) ? $this->request->post['shipping_method'] : '';

            if (!$shipping_method) {

                $json['error'] = true;
                $json['text_error'] = $this->language->get('error_shipping');
            } else {

                $shipping = explode('.', $this->request->post['shipping_method']);

                if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {

                    $json['error'] = true;
                    $json['text_error'] = $this->language->get('error_shipping');
                }
            }
        }
    }

    private function getQuoteData($country_id = '', $zone_id = '', $postcode = '') {


        if ($country_id) {

            $this->load->model('localisation/country');
            $country_info = $this->model_localisation_country->getCountry($country_id);
        }
        if (isset($country_info)) {

            $country = $country_info['name'];
            $iso_code_2 = $country_info['iso_code_2'];
            $iso_code_3 = $country_info['iso_code_3'];
            $address_format = $country_info['address_format'];
        } else {

            $country = '';
            $iso_code_2 = '';
            $iso_code_3 = '';
            $address_format = '';
        }

        if ($zone_id) {

            $this->load->model('localisation/zone');
            $zone_info = $this->model_localisation_zone->getZone($zone_id);
        }

        if (isset($zone_info)) {

            $zone = $zone_info['name'];
            $code = $zone_info['code'];
        } else {

            $zone = '';
            $code = '';
        }


        if ($country_id) {

            $this->session->data['pp_shipping_estimator_country_id'] = $country_id;
            $this->session->data['country_id'] = $country_id;
        }
        if ($zone_id) {

            $this->session->data['pp_shipping_estimator_zone_id'] = $zone_id;
            $this->session->data['zone_id'] = $zone_id;
        }
        if ($postcode) {

            $this->session->data['pp_shipping_estimator_postcode'] = $postcode;
            $this->session->data['postcode'] = $postcode;
        }
//            $this->session->data['pp_shipping_estimator_country_id'] = $country_id;
//            $this->session->data['pp_shipping_estimator_zone_id'] = $zone_id;
//            $this->session->data['pp_shipping_estimator_postcode'] = $postcode;
//            
//            
//            $this->session->data['country_id'] = $country_id;
//            $this->session->data['zone_id'] = $zone_id;
//            $this->session->data['postcode'] = $postcode;

        $address_data = array(
            'firstname' => '',
            'lastname' => '',
            'company' => '',
            'address_1' => '',
            'address_2' => '',
            'postcode' => $postcode,
            'city' => '',
            'zone_id' => $zone_id,
            'zone' => $zone,
            'zone_code' => $code,
            'country_id' => $country_id,
            'country' => $country,
            'iso_code_2' => $iso_code_2,
            'iso_code_3' => $iso_code_3,
            'address_format' => $address_format
        );

        $quote_data = array();

        $this->load->model('setting/extension');

        $results = $this->model_setting_extension->getExtensions('shipping');

        foreach ($results as $result) {

            if ($this->config->get($result['code'] . '_status')) {

                $this->load->model('shipping/' . $result['code']);

                $quote = $this->{'model_shipping_' . $result['code']}->getQuote($address_data);

                if ($quote) {
                    $quote_data[$result['code']] = array(
                        'title' => $quote['title'],
                        'quote' => $quote['quote'],
                        'sort_order' => $quote['sort_order'],
                        'error' => $quote['error']
                    );
                }
            }
        }

        $sort_order = array();

        foreach ($quote_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $quote_data);


        return $quote_data;
    }

    private function loadPostVars() {

        $vars = array();

        if (isset($this->request->post['country_id'])) {

            $vars['country_id'] = $this->request->post['country_id'];
        } elseif ($this->config->get('pp_shipping_estimator_country_id')) {

            $vars['country_id'] = $this->config->get('pp_shipping_estimator_country_id');
        } else {

            $vars['country_id'] = '';
        }

        if (isset($this->request->post['zone_id'])) {

            $vars['zone_id'] = $this->request->post['zone_id'];
        } elseif ($this->config->get('pp_shipping_estimator_zone_id')) {

            $vars['zone_id'] = $this->config->get('pp_shipping_estimator_zone_id');
        } else {

            $vars['zone_id'] = '';
        }

        if (isset($this->request->post['postcode'])) {

            $vars['postcode'] = $this->request->post['postcode'];
        } elseif ($this->config->get('pp_shipping_estimator_postcode')) {

            $vars['postcode'] = $this->config->get('pp_shipping_estimator_postcode');
        } else {

            $vars['postcode'] = '';
        }

        return $vars;
    }

    public function calculate() {

        $this->language->load('module/pp_shipping_estimator');

        $cart_prods = $this->cart->getProducts();

        $json = array();

        $json['error'] = false;

        $this->validateCalculate($json);

        if (!$json['error']) {

            $options = isset($this->request->post['option']) ? array_filter($this->request->post['option']) : array();

            $this->cart->add($this->request->post['product_id'], $this->request->post['quantity'], $options);

            if (!$json['error']) {

                $vars = $this->loadPostVars();

            if ($vars['country_id'] && $vars['zone_id']) {
       
               $version = substr(VERSION, 0,5);
 
               if ($version == '1.5.1' && VERSION != '1.5.1.3'){
                   
                     $this->tax->setZone($vars['country_id'], $vars['zone_id']);
                     
               }else{
          
                    $this->tax->setShippingAddress($vars['country_id'], $vars['zone_id']); 
               }
    
            }


                $quote_data = $this->getQuoteData($vars['country_id'], $vars['zone_id'], $vars['postcode']);

                if ($quote_data) {

                    $this->session->data['shipping_methods'] = $quote_data;
                    $json['shipping_methods'] = $quote_data;
                } else {

                    $json['error'] = true;
                    $json['text_error'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
                }


                $shipping = explode('.', $this->request->post['shipping_method']);

                $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];

                $this->session->data['success'] = $this->language->get('text_shipping_success');

                $json['redirect'] = $this->url->link('checkout/cart', '', 'SSL');
            }

            if ($json['error']) {

                $this->cart->clear();

                foreach ($cart_prods as $p_data) {

                    $options = array();

                    foreach ($p_data['option'] as $option) {

                        if ($option['product_option_value_id']) {

                            $options[$option['product_option_id']][] = $option['product_option_value_id'];
                        } elseif ($option['option_value']) {

                            $options[$option['product_option_id']] = $option['option_value'];
                        }
                    }
                    $this->cart->add($p_data['product_id'], $p_data['quantity'], $options);
                }
            }
        }

        $this->response->setOutput(json_encode($json));
    }

    public function zone() {
        $output = '<option value="">' . $this->language->get('text_select') . '</option>';

        $this->load->model('localisation/zone');

        $results = array();

        if (isset($this->request->get['country_id']) && $this->request->get['country_id']) {

            $results = $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']);
        }
        foreach ($results as $result) {
            $output .= '<option value="' . $result['zone_id'] . '"';

            if (isset($this->request->get['zone_id']) && ($this->request->get['zone_id'] == $result['zone_id'])) {
                $output .= ' selected="selected"';
            }

            $output .= '>' . $result['name'] . '</option>';
        }

        if (empty($results) || !$results) {
            $output .= '<option value="0">' . $this->language->get('text_none') . '</option>';
        }

        $this->response->setOutput($output);
    }

}

?>
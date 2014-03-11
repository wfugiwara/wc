<?php 
 
/**
 * OpenStock controller class
 * 
 * Created by James Allsup / Welford Media
 * www.welfordmedia.co.uk / support.welfordmedia.co.uk
 */
class ControllerOpenstockOpenstock extends Controller {
    public function optionStatus(){   
        $this->language->load('module/openstock'); 		

        $json = array();

        if(!$this->request->post['var'] || !$this->request->post['product_id'])
        {
            $json['error'] = $this->language->get('text_id_missing');
        }else{
            $this->load->model('openstock/openstock');
            $this->load->model('catalog/product');
            
            $product_info   = $this->model_catalog_product->getProduct((int)$this->request->post['product_id']);
            $var_info       = $this->model_openstock_openstock->getRelation($this->request->post['var'], $this->request->post['product_id']);
            
            if($var_info != false){
                if(empty($var_info)) {
                        $json['error'] = $this->language->get('combination_not_avail');
                }else{
                    
                    /**
                     * Calculate the discounts based on qty
                     */

                    $discounts      = $this->model_openstock_openstock->getOptionDiscounts($this->request->post['product_id'], $var_info['id']);

                    if(!empty($discounts)){
                        $discountsArray = array(); 

                        foreach ($discounts as $discount) {
                                $discountsArray[] = $discount['qty'] . $this->language->get('text_discount') . $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                        }
                        
                        $var_info['discount'] = $discountsArray;
                    }else{
                        $var_info['nodiscount'] = $this->language->get('text_nodiscount');
                    }
                    
                    /* create a thumb image and also a scaled main image */
                    $this->load->model('tool/image'); 

                    if(!empty($var_info['image']))
                    {
                        $var_info['pop'] = $this->model_tool_image->resize($var_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
                    }else{
                        $var_info['pop'] = '';
                    }
                    if(!empty($var_info['image']))
                    {
                        $var_info['thumb'] = $this->model_tool_image->resize($var_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                    }else{
                        $var_info['thumb'] = '';
                    }
                    
                    $json['data']   = $var_info;
                    
                    if(($var_info['stock'] > 0 || $var_info['subtract'] == 0) && $var_info['active'] == 1)
                    {
                        if($var_info['subtract'] == 0 || $this->config->get('config_stock_display') == 0)
                        {
                            $json['success']            = $this->language->get('text_in_stock_avail');
                        }else{
                            $json['success']            = sprintf($this->language->get('text_in_stock'), $var_info['stock'] );
                        }
                    }elseif($var_info['active'] != 1){
                        $json['notactive'] = $this->language->get('combination_not_avail');
                    }else{
                        $json['nostockcheckout'] = $this->config->get('config_stock_checkout');
                        $json['nostock'] = $product_info['stock_status'];
                    }
                }
            }else{
                $json['error'] = $this->language->get('text_id_missing');
            }
        }

        $this->response->setOutput(json_encode($json));
    }
}
?>
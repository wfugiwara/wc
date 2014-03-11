<?php   
/**
 * OpenStock model class
 * 
 * Created by James Allsup / Welford Media
 * www.welfordmedia.co.uk / support.welfordmedia.co.uk
 */
class ModelOpenstockOpenstock extends Model
{    
    public function getRelation($var, $product_id){
        $sql = "
            SELECT * 
            FROM `" . DB_PREFIX . "product_option_relation` 
                WHERE `var` = '".$var."' 
                AND `product_id` = '".$product_id."' 
            LIMIT 1";
        $option_qry = $this->db->query($sql);
        
        if($option_qry->num_rows)
        {
            $this->load->model('catalog/product');
            $product                    = $this->model_catalog_product->getProduct($product_id);
            $product_var                = $option_qry->row;
            
            /* add the formatted price and tax price to the return data */
            if($product_var['price'] != 0)
            {
                $original_price             = $product_var['price'] ;
            }else{
                /* default the price to the product main price if its zero */
                $original_price             = $product['price'] ;
            }

            $product_var['original']        = $original_price;
            $product_var['originaltax']     = $this->currency->format($this->tax->calculate($original_price, $product['tax_class_id'], $this->config->get('config_tax')));
            /*
             * get the customer group price if available
             */
            if ($this->customer->isLogged()) {
                    $customer_group_id = $this->customer->getCustomerGroupId();
            } else {
                    $customer_group_id = $this->config->get('config_customer_group_id');
            }
            
            $sql2 = "
                SELECT `price`
                FROM `" . DB_PREFIX . "product_option_relation_group_price` 
                    WHERE `product_option_relation_id` = '".(int)$product_var['id']."' 
                    AND `product_id` = '".(int)$product_id."' 
                    AND `customer_group_id` = '".(int)$customer_group_id."' 
                ORDER BY `price` ASC
                LIMIT 1";
            
            $option_qry2 = $this->db->query($sql2);
            
            if($option_qry2->num_rows)
            {
                if($option_qry2->row['price'] != 0)
                {
                    $original_price = $option_qry2->row['price'];
                }
            }
            
            $product_var['price']       = $this->currency->format($original_price);
            $product_var['pricetax']    = $this->currency->format($this->tax->calculate($original_price, $product['tax_class_id'], $this->config->get('config_tax')));
            
            return $product_var;
        }else{
            return false; 
        }
    }
    
    public function getProductOptionStocks($pId){
        $SQL = "
            SELECT `" . DB_PREFIX . "product_option_value`.`product_option_value_id`, `" . DB_PREFIX . "option_value_description`.`name`
            FROM
                `" . DB_PREFIX . "product_option_value`,
                `" . DB_PREFIX . "option_value_description`,
                `" . DB_PREFIX . "option_value`,
                `" . DB_PREFIX . "option`
            WHERE
                `" . DB_PREFIX . "product_option_value`.`product_id` = '".$pId."'
            AND
                `" . DB_PREFIX . "product_option_value`.`option_value_id` = `" . DB_PREFIX . "option_value_description`.`option_value_id`
            AND
                `" . DB_PREFIX . "option_value`.`option_value_id` = `" . DB_PREFIX . "product_option_value`.`option_value_id`
            AND
                `" . DB_PREFIX . "option`.`option_id` = `" . DB_PREFIX . "option_value`.`option_id`
            ORDER BY `" . DB_PREFIX . "option`.`sort_order`, `" . DB_PREFIX . "option_value`.`sort_order` ASC";
        $options_qry = $this->db->query($SQL);

        $optionValues = array();
        foreach($options_qry->rows as $row)
        {
            $optionValues[$row['product_option_value_id']] = $row['name'];
        }

        $SQL = "SELECT * FROM `" . DB_PREFIX . "product_option_relation` WHERE `product_id` = '".$pId."' ORDER BY `var` ASC";
        $mix_qry = $this->db->query($SQL);

        $optionsStockArray = array();

        foreach($mix_qry->rows as $row)
        {            
            $options = explode(':', $row['var']);
            $combi = '';
            foreach($options as $k=>$v)
            {
                $combi .= $optionValues[$v] .' > ';
            }

            $optionsStockArray[$row['id']] = array(
                'id'            => $row['id'],
                'sku'           => $row['sku'],
                'product_id'    => $row['product_id'],
                'combi'         => $combi,
                'stock'         => $row['stock'],
                'active'        => $row['active'],
                'var'           => $row['var'],
                'subtract'      => $row['subtract'],
                'price'         => $row['price'],
                'opts'          => $optionValues
            );
        }

        return $optionsStockArray;
    }  
    
    public function calcOptions($pId){
        $SQL = "SELECT `" . DB_PREFIX . "product_option_value`.`product_option_value_id`, `" . DB_PREFIX . "product_option_value`.`option_id`
            FROM
                `" . DB_PREFIX . "product_option_value`,
                `" . DB_PREFIX . "option_value_description`,
                `" . DB_PREFIX . "option_value`,
                `" . DB_PREFIX . "option`
            WHERE
                `" . DB_PREFIX . "product_option_value`.`product_id` = '".$pId."'
            AND
                ((`" . DB_PREFIX . "option`.`type` = 'radio') OR (`" . DB_PREFIX . "option`.`type` = 'select') OR (`" . DB_PREFIX . "option`.`type` = 'image'))
            AND
                `" . DB_PREFIX . "product_option_value`.`option_value_id` = `" . DB_PREFIX . "option_value_description`.`option_value_id`
            AND
                `" . DB_PREFIX . "option_value`.`option_value_id` = `" . DB_PREFIX . "product_option_value`.`option_value_id`
            AND
                `" . DB_PREFIX . "option`.`option_id` = `" . DB_PREFIX . "option_value`.`option_id`
            ORDER BY `" . DB_PREFIX . "option`.`sort_order`, `" . DB_PREFIX . "option_value`.`sort_order` ASC";

        $options_qry = $this->db->query($SQL);
        $unique_grp = array();
        foreach($options_qry->rows as $row)
        {                    
            if(!array_key_exists($row['option_id'], $unique_grp))
            {
                $unique_grp[$row['option_id']] = array();
            }

            $unique_grp[$row['option_id']][] = $row['product_option_value_id'];
        }

        $newArray = array();
        $i = 0;
        foreach($unique_grp as $key => $grp)
        {
            $newArray[$i] = $grp;
            $i++;
        }

        $final = array();

        if(!empty($newArray))
        {
            foreach($newArray[0] as $k1 => $v1)
            {
                if(!empty($newArray[1]))
                {
                    foreach($newArray[1] as $k2 => $v2)
                    {
                        if(!empty($newArray[2]))
                        {
                            foreach($newArray[2] as $k3 => $v3)
                            {
                                if(!empty($newArray[3]))
                                {
                                    foreach($newArray[3] as $k4 => $v4)
                                    {
                                        if(!empty($newArray[4]))
                                        {
                                            foreach($newArray[4] as $k5 => $v5)
                                            {
                                                if(!in_array($v1.':'.$v2.':'.$v3.':'.$v4.':'.$v5, $final))
                                                {
                                                    $final[] = $v1.':'.$v2.':'.$v3.':'.$v4.':'.$v5;
                                                }
                                            }
                                        }else{
                                            if(!in_array($v1.':'.$v2.':'.$v3.':'.$v4, $final))
                                            {
                                                $final[] = $v1.':'.$v2.':'.$v3.':'.$v4;
                                            }
                                        }
                                    }
                                }else{
                                    if(!in_array($v1.':'.$v2.':'.$v3, $final))
                                    {
                                        $final[] = $v1.':'.$v2.':'.$v3;
                                    }
                                }
                            }
                        }else{
                            if(!in_array($v1.':'.$v2, $final))
                            {
                                $final[] = $v1.':'.$v2;
                            }
                        }
                    }
                }else{
                    if(!in_array($v1, $final))
                    {
                        $final[] = $v1;
                    }
                }
            }
        }

        return $final;
    }

    public function getOptionDiscounts($product_id, $relation_id) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $sql = "SELECT * FROM " . DB_PREFIX . "product_option_relation_discount_price WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND qty > 1 AND product_option_relation_id = '".(int)$relation_id."' ORDER BY qty ASC, price ASC";
        $query = $this->db->query($sql);

        return $query->rows;
    }
}
?>
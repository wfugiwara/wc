<?php
class ModelCatalogAlphabeticallyProducts extends model{    
    
    public function getproductsalphabetically(){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description ORDER BY name ASC");
        return $query->rows;
    }
    
    public function get_selected_products($char,$start,$limit){        
        if($char==''){
            $query = $this->db->query("SELECT *
FROM `". DB_PREFIX ."product` AS p
INNER JOIN `". DB_PREFIX ."product_description` AS d ON d.product_id = p.product_id WHERE (d.name like '0%' or d.name like '1%' or d.name like '2%' or d.name like '3%' or d.name like '4%' or d.name like '5%' or d.name like '6%' or d.name like '7%' or d.name like '8%' or d.name like '9%') ORDER BY d.name asc limit ".$start.",".$limit);            
            return $query->rows;
        } else {
        $query = $this->db->query("SELECT *
FROM `". DB_PREFIX ."product` AS p
INNER JOIN `". DB_PREFIX ."product_description` AS d ON d.product_id = p.product_id WHERE (d.name LIKE '".strtoupper($char)."%' OR d.name LIKE '".strtolower($char)."%') ORDER BY d.name asc limit ".$start.",".$limit);
        return $query->rows;
        }
    }
}
?>
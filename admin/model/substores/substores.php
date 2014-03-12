<?php

class ModelSubstoresSubstores extends Model {
    
    public function getSubstores() {
        
        $strSQL = 'SELECT * FROM ' . DB_PREFIX . 'store';
        $objResult = $this->db->query($strSQL);
        
        return $objResult->rows;
    }
}

?>
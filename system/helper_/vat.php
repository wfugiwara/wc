<?php
function vat_validation($tax_id){ 
        $cpf = preg_replace( "@[./-]@", "", $tax_id );
        for( $i = 0; $i < 10; $i++ ){ 
        if ( $cpf ==  str_repeat( $i , 11) or !preg_match("@^[0-9]{11}$@", $cpf ) or $cpf == "12345678909" )                    return false;                
                        if ( $i < 9 ) $soma[]  = $cpf{$i} * ( 10 - $i ); 
                $soma2[] = $cpf{$i} * ( 11 - $i );                       
        } 
        
        if(((array_sum($soma)% 11) < 2 ? 0 : 11 - ( array_sum($soma)  % 11 )) != $cpf{9})return false; 
                return ((( array_sum($soma2)% 11 ) < 2 ? 0 : 11 - ( array_sum($soma2) % 11 )) != $cpf{10}) ? false : true; 
}
?>
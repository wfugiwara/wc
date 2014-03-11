<?php
class ControllerModuleAlphabeticallyProducts extends Controller{
    
    protected function index(){
        
        $this->language->load('module/AlphabeticallyProducts');
        $this->load->model('catalog/AlphabeticallyProducts');
        $this->data['heading_title'] = $this->language->get('heading_title');      

        $this->data['href'] = HTTP_SERVER . 'index.php?route=product/AlphabeticallyProducts&char=';       
            
            if(file_exists(DIR_TEMPLATE.$this->config->get('config_template').'template/module/AlphabeticallyProducts.tpl')){
                $this->template = $this->config->get('config_template').'template/module/AlphabeticallyProducts.tpl';
            } else {
                $this->template = 'default/template/module/AlphabeticallyProducts.tpl';
            }
            $this->render();
        }
}
?>
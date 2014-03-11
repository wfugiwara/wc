<?php
class ControllerCatalogQuickEdit extends Controller { 
    private $error = array();
    
    public function index() {

      $this->load->language('catalog/quick_edit');
      $this->document->setTitle($this->language->get('heading_title'));
      $this->load->model('catalog/category');
      $this->data['heading_title'] = $this->language->get('heading_title');

      $this->data['default_type_id'] = 1;
      $this->data['price_types_array'] = array(
        array('id' => 1, 'text' => $this->language->get('option_price_direct')),
        array('id' => 2, 'text' => $this->language->get('option_price_percent')),
      );
      
      $this->data['text_select_all'] = $this->language->get('text_select_all');
      $this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
      
      $this->data['entry_price_adjust'] = $this->language->get('entry_price_adjust');
      $this->data['entry_price_type'] = $this->language->get('entry_price_type');
      $this->data['entry_price_round'] = $this->language->get('entry_price_round');

      $this->data['entry_category'] = $this->language->get('entry_category');
       $this->data['text_support'] = $this->language->get('text_support');
      $this->data['button_update'] = $this->language->get('text_update');

      $this->data['price_adjust'] = $this->data['price_round'] = 0;

      $this->data['categories_array'] = $this->model_catalog_category->getCategories(0);
      array_unshift($this->data['categories_array'], array('category_id' => 0, 'name' => $this->language->get('checkbox_all_categories')) );

      
      if (isset($this->session->data['error'])) {
        $this->data['error_warning'] = $this->session->data['error'];
        unset($this->session->data['error']);
      } elseif (isset($this->error['warning'])) {
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
        'text'      => $this->language->get('text_home'),
        'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),            
        'separator' => false
      );

      $this->data['breadcrumbs'][] = array(
        'text'      => $this->language->get('heading_title'),
        'href'      => $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
      );
      
      $this->data['quick_edit'] = $this->url->link('catalog/quick_edit/process', 'token=' . $this->session->data['token'], 'SSL');

      $this->template = 'catalog/quick_edit.tpl';
      $this->children = array(
        'common/header',
        'common/footer'
      );
              
      $this->response->setOutput($this->render());
    }

    public function process() {
      $this->load->language('catalog/quick_edit');

      $error = false;
      if( !isset($this->request->post['price_adjust']) || empty($this->request->post['price_adjust']) ) {
        $this->session->data['error'] = $this->language->get('error_price_input');
        $error = true;
      }

      if( !isset($this->request->post['price_type']) || empty($this->request->post['price_type']) ) {
        $this->session->data['error'] = $this->language->get('error_price_type');
        $error = true;
      }

      if( $error ) {
        $this->redirect($this->url->link('catalog/quick_edit', 'token=' . $this->session->data['token'], 'SSL'));
      }

      $msg = '';

      if( !isset($this->request->post['all_categories']) && isset($this->request->post['product_category']) ) {
        foreach($this->request->post['product_category'] as $product_category) {
          $msg = $this->update($product_category);
        }
      } else {
        $msg = $this->update();
      }

      $this->cache->delete('*');
      $this->session->data['success'] = $msg;
      $this->redirect($this->url->link('catalog/quick_edit', 'token=' . $this->session->data['token'], 'SSL'));
    }

    private function update($category_id = 0) {
      $this->load->language('catalog/quick_edit');
      $this->load->model('catalog/product');

      $categories_array = array();

      if( !empty($category_id) ) {
        $tmp_array = $this->model_catalog_product->getProductsByCategoryId($category_id);
        foreach($tmp_array as $value) {
          $categories_array[$value['product_id']] = $value['product_id'];
        }
      }

      $round = isset($this->request->post['price_round'])?(int)$this->request->post['price_round']:0;
      $round /= 100;

      switch($this->request->post['price_type']) {
        case 2:
          $factor = round($this->request->post['price_adjust']/100,2);
          $sql_update = "price = round(price+(price * '" . (float)$factor . "'), 0) + '" . $round . "'";
          $msg = round($this->request->post['price_adjust'],2) . '%';
          break;
        default:
          $factor = round($this->request->post['price_adjust'],2);
          $sql_update = "price = round(price+('" . (float)$factor . "'), 0) + '" . $round . "'";
          $msg = $factor;
          break;
      }

      if( !empty($categories_array) ) {
       $sql_update .= " where product_id in (" . implode(',', $categories_array) . ")";
      }

      $this->db->query("update " . DB_PREFIX . "product SET " . $sql_update);
      return sprintf($this->language->get('success_quick_edit'), $msg, $round);
    }
  }
?>

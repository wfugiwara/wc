<?php
class ControllerModuleBlogcomment extends Controller {
   private $error = array(); 
   
   public function index() {
      $this->load->model('setting/setting');
      $this->data = $this->load->language('module/blogcomment');

      $this->document->addStyle('view/stylesheet/blog_module.css');
      $this->document->setTitle($this->language->get('heading_module'));
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
         $this->model_setting_setting->editSetting('blogcomment', $this->request->post);      

         $this->session->data['success'] = $this->language->get('text_success');

         if ($this->request->post['buttonClick'] == 'apply') {
            $this->redirect($this->url->link('module/blogcomment', 'token=' . $this->session->data['token'], 'SSL'));
         } else {
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
         }
      }
      
       if (isset($this->error['warning'])) {
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
      if (isset($this->error['image'])) {
         $this->data['error_image'] = $this->error['image'];
      } else {
         $this->data['error_image'] = array();
      }
      
        $this->data['breadcrumbs'] = array();
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
         );
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('text_module'),
         'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' <span class="separator">&#187;</span> '
         );
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('heading_module'),
         'href'      => $this->url->link('module/blogcomment', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' <span class="separator">&#187;</span> '
         );
      
      $this->data['action'] = $this->url->link('module/blogcomment', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

      $this->data['modules'] = array();
      
      if (isset($this->request->post['blogcomment_module'])) {
         $this->data['modules'] = $this->request->post['blogcomment_module'];
      } elseif ($this->config->get('blogcomment_module')) { 
         $this->data['modules'] = $this->config->get('blogcomment_module');
      }            
      
      $this->load->model('design/layout');
      $this->data['layouts'] = $this->model_design_layout->getLayouts();

      $this->template = 'module/blogcomment.tpl';
      $this->children = array(
         'common/header',
         'common/footer'
      );
            
      $this->response->setOutput($this->render());
   }
   
   private function validate() {
      if (!$this->user->hasPermission('modify', 'module/blogcomment')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      if (isset($this->request->post['blogcomment_module'])) {
         foreach ($this->request->post['blogcomment_module'] as $key => $value) {
            if (!$value['image_width'] || !$value['image_height']) {
               $this->error['image'][$key] = $this->language->get('error_image');
            }
         }
      }      
      
      if (!$this->error) {
         return true;
      } else {
         return false;
      }   
   }
}
?>
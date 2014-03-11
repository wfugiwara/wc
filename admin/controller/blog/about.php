<?php
class ControllerBlogAbout extends Controller {
   private $error = array();
 
   public function index() {
      $this->data = $this->load->language('blog/blog');
      $this->data = $this->load->language('blog/about');

      $this->document->setTitle($this->language->get('heading_title'));
      $this->document->addStyle('view/stylesheet/blog.css');
      
      $this->load->model('blog/author');
      $blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
      if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; }; }
      
      $this->data['breadcrumbs'] = array();
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => false
      );
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('heading_title'),
         'href'      => $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('head_about'),
         'href'      => $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );
      
      //== Menu
      $this->data['menu_home_href']       = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_article_href']    = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_category_href']    = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_comment_href']    = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_author_href']       = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_setting_href']    = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_about_href']       = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
      
      //==Dev Info
      $this->data['link_author']          = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
      $this->data['link_author2']         = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_url']);
      $this->data['link_documentation']   = sprintf($this->data['text_link'], $this->data['dev_url_docs'], '', $this->data['heading_title'] . ' ' . $this->data['text_documentation']);
      $this->data['link_support']         = sprintf($this->data['text_link'], $this->data['dev_url_support'], '', $this->data['text_support']);
      $this->data['link_copyright']       = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
      $this->data['oc_footer']            = sprintf($this->language->get('oc_footer'), VERSION);
      
      $this->data['token']          = $this->session->data['token'];
      
      if (isset($this->session->data['warning'])) {
          $this->data['warning'] = $this->session->data['warning'];
         unset($this->session->data['warning']);
      } else {
         $this->data['warning'] = '';
      }
      if (isset($this->session->data['error'])) {
          $this->data['warning'] = $this->session->data['error'];
         unset($this->session->data['error']);
      } else {
         $this->data['warning'] = '';
      }
      
      $this->template = 'blog/about.tpl';
      $this->children = array(
         'common/header',
         'common/footer',
      );
      
      $this->response->setOutput($this->render());
   }
   
   public function version() {
      $this->data = $this->load->language('blog/blog');
      $currentVersion = $this->language->get('product_version');
      
      if (isset($this->request->get['product'])) { $prodName = $this->request->get['product']; } else { $prodName = 'BlogManager'; }
      $checkVersion = 'http://www.echothemes.com/assets/version/' . $prodName . '.xml';
      
      $curl = curl_init();
      curl_setopt($curl, CURLOPT_URL, $checkVersion);
      curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
      $returnData = curl_exec($curl);
      $returnCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
      curl_close($curl);
      
      if ($returnCode == 200) { // Succeeded
         $data = simplexml_load_string($returnData);
         if ($data->version == $currentVersion || $data->version <= $currentVersion) {
            $statusClass   = 'green';
            $statusText    = $this->language->get('text_noupdate');
            $changelogDesc = '';
         } elseif ($data->version >= $currentVersion) {
            $statusClass   = 'orange';
            $statusText    = $this->language->get('text_update');
            $changelogDesc = $data->changelog;
         } else {
            $statusClass   = 'red';
            $statusText      = $this->language->get('text_missupdate');
            $changelogDesc = '';
         }
      } else { 
         $statusClass   = 'red';
         $statusText    = $this->language->get('text_failconnect');
         $changelogDesc = '';
      }

      $output = '<span class="version ' . $statusClass . '">' . $statusText . '</span>';
      if ($changelogDesc) {
         $output .= '<div id="updateChangelog">' . $changelogDesc . '</div>';
      }
      
      if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
         $this->load->library('json');
         $this->response->setOutput(Json::encode($output));
      } else {
         $this->response->setOutput(json_encode($output));
      }
   }
}
?>
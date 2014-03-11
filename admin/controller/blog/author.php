<?php
class ControllerBlogAuthor extends Controller {
   private $error = array();
 
   public function index() {
      $this->load->model('blog/author');
      $this->data = $this->load->language('blog/blog');
      $this->data = $this->load->language('blog/author');

      $this->document->setTitle($this->language->get('heading_title'));
      $this->document->addStyle('view/stylesheet/blog.css');
      
      $this->data['link_author']          = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
      $this->data['link_copyright']       = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
      $this->data['oc_footer']            = sprintf($this->language->get('oc_footer'), VERSION);
      
      $adminAvailable = $this->model_blog_author->checkAdminUser();
      $this->data['adminAvailable'] = $adminAvailable;
      
      $this->load->model('blog/article');
      $isAuthor = $this->model_blog_article->getAuthorByUser($this->user->getId());
      if (!$isAuthor && $adminAvailable) {
         $this->session->data['warning'] = $this->language->get('error_notauthor');
      } else {
         $blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
         if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; } }
      }

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
         'text'      => $this->language->get('head_author'),
         'href'      => $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );

      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateAuthor()) {
         if (isset($this->request->post['addAuthor'])) {
            $this->model_blog_author->addAuthor($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_addAuthor');
         }
         if (isset($this->request->post['renAuthor'])) {
            $this->model_blog_author->editAuthor($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_modifAuthor');
         }
         if (isset($this->request->post['delAuthor'])) {
            foreach ($this->request->post['delAuthor'] as $author_id) {
               $this->model_blog_author->delAuthor($author_id);
            }

            $this->session->data['success'] = $this->language->get('text_success_modifAuthor');
         }
         if (isset($this->request->post['permBlog'])) {
            $permBlog = array();
            if (isset($this->request->post['permAuthor'])) { $permAuthor = $this->request->post['permAuthor']; } else { $permAuthor = ''; }
               $permBlog[] = array(
                  'name'         => 'Author',
                  'permission'   => $permAuthor
               );
            if (isset($this->request->post['permEditor'])) { $permEditor = $this->request->post['permEditor']; } else { $permEditor = ''; }
            $permBlog[] = array(
               'name'         => 'Editor',
               'permission'   => $permEditor
            );
            if (isset($this->request->post['permAdmin'])) { $permAdmin = $this->request->post['permAdmin']; } else { $permAdmin = ''; }
            if (isset($this->request->post['permAdmin'])) {
               $permBlog[] = array(
                  'name'         => 'Admin',
                  'permission'   => $permAdmin
               );
            }
            
            $this->model_blog_author->editPermissions($permBlog);

            $this->session->data['success'] = $this->language->get('text_success_modifGroup');
         }
         
         $this->redirect($this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL')); 
      }
      
      if (isset($this->error['warning'])) {
         $this->data['error_warning'] = $this->error['warning'];
      } else {
         $this->data['error_warning'] = '';
      }
      if (isset($this->session->data['attention'])) {
         $this->data['attention'] = $this->session->data['attention'];
         unset($this->session->data['attention']);
      } else {
         $this->data['attention'] = '';
      }
      if (isset($this->session->data['success'])) {
         $this->data['success'] = $this->session->data['success'];
         unset($this->session->data['success']);
      } else {
         $this->data['success'] = '';
      }
      
      //== Menu
      $this->data['menu_home_href']       = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_article_href']    = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_category_href']    = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_comment_href']    = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_author_href']    = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_setting_href']    = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_about_href']       = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
      
      $this->data['action'] = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      
      //== Tab Author
      $this->data['authors']          = $this->model_blog_author->getAuthors();
      $this->data['users']          = $this->model_blog_author->getUsers();
      $this->data['authorGroups']    = $this->model_blog_author->getAuthorGroups();
      
      $this->data['permGroups']      = $this->model_blog_author->getPermissions();
      
      //== Error Handle
      $errorSettings = array(
         'tabAuthors', 'selectUser', 'addAuthor', 'renAuthor', 'delAdmin'
      );
      foreach ($errorSettings as $errorSetting) {
         if (isset($this->error[$errorSetting])) {
            $this->data['error_'.$errorSetting] = $this->error[$errorSetting];
         } else {
            $this->data['error_'.$errorSetting] = '';
         }
      }
      
      $formSettings = array('addAuthor', 'renAuthor');
      foreach ($formSettings as $formSetting) {
         if (isset($this->request->post[$formSetting])) {
            $this->data[$formSetting.'Value'] = $this->request->post[$formSetting];
         } else {
            $this->data[$formSetting.'Value'] = '';
         }
      }
      
      $this->template = 'blog/author.tpl';
      $this->children = array(
         'common/header',
         'common/footer',
      );
      
      $this->response->setOutput($this->render());
   }
   
   private function validateAuthor() {
      if (!$this->user->hasPermission('modify', 'blog/author')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      $authors          = $this->model_blog_author->getAuthors();
      $adminAvailable    = $this->model_blog_author->checkAdminUser();
      $adminUserId      = $this->model_blog_author->checkAdminUserId();
      
      if (isset($this->request->post['addAuthor'])) {
         if (!isset($this->request->post['user_id'])) {
            $this->error['selectUser'] = $this->language->get('error_user');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         }
         
         if ((strlen(utf8_decode($this->request->post['addAuthor'])) < 3) || (strlen(utf8_decode($this->request->post['addAuthor'])) > 28)) {
            $this->error['addAuthor'] = $this->language->get('error_author');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         } else {
            foreach ($authors as $author) {
               if (strtolower($author['name']) == strtolower($this->request->post['addAuthor'])) {
                  $this->error['addAuthor'] = $this->language->get('error_author_exist');
                  $this->error['tabAuthors'] = $this->language->get('error_tab');
               }
            }
         }
      }
      
      if (isset($this->request->post['renAuthor'])) {
         if ((strlen(utf8_decode($this->request->post['renAuthor'])) < 3) || (strlen(utf8_decode($this->request->post['renAuthor'])) > 28)) {
            $this->error['renAuthor'] = $this->language->get('error_author');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         } else {
            foreach ($authors as $author) {
               if (strtolower($author['name']) == strtolower($this->request->post['renAuthor'])) {
                  $this->error['renAuthor'] = $this->language->get('error_author_exist');
                  $this->error['tabAuthors'] = $this->language->get('error_tab');
               }
            }
         }
      }
      
      if (isset($this->request->post['delAuthor'])) {
         if ($adminAvailable == 1 && array_intersect($this->request->post['delAuthor'], $adminUserId)) {
            $this->error['delAdmin'] = $this->language->get('error_lastadmin');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
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
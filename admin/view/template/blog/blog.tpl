<?php echo $header; ?>
<div id="content">
   <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
         <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
   </div>
   
   <div class="container">
      <div id="et-header">
         <span class="em-header"><img src="view/image/blog/blog_manager.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></span>
         
         <ul>
            <li><a href="<?php echo $menu_home_href; ?>" class="active"><?php echo $text_menu_home; ?></a></li>
            <li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
            <li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
            <li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
            <?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
               <li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
            <?php } ?>
            <?php if (isset($haspermission_editSetting)) { ?>
               <li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
            <?php } ?>
            <!--<li><a href="<?php echo $menu_about_href; ?>"><?php echo $text_menu_about; ?></a></li>-->
         </ul>
      </div>
      <?php if ($warning) { ?>
         <div class="warning">
            <?php echo $warning; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <?php if ($success) { ?>
         <div class="success">
            <?php echo $success; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <?php if ($success_attention) { ?>
         <div class="attention">
            <?php echo $success_attention; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <div id="et-content">
         <h2><?php echo $text_welcome; ?></h2>
         <table class="form blogHome">
            <tr>
               <td>
                  <a href="<?php echo $this->url->link('blog/article/insert', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/article-add.png" /><br/><?php echo $text_article_add;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/article.png" /><br/><?php echo $text_article_list;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/category/insert', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/category-add.png" /><br/><?php echo $text_category_add;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/category.png" /><br/><?php echo $text_category_list;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/comment.png" /><br/><?php echo $text_comment_list;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/user.png" /><br/><?php echo $text_author_list;?></div>
                  </a>
                  <a href="<?php echo $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL'); ?>">
                     <div class="iconHome"><img alt="" src="view/image/blog/setting.png" /><br/><?php echo $text_setting;?></div>
                  </a>
               </td>
               <td>
                  <table class="resume">
                     <tr>
                        <td><?php echo $text_res_article1; ?></td>
                        <td>: <?php echo $text_res_article2; ?></td>
                     </tr>
                     <tr>
                        <td><?php echo $text_res_comment1; ?></td>
                        <td>: <?php echo $text_res_comment2; ?></td>
                     </tr>
                     <tr>
                        <td><?php echo $text_res_category1; ?></td>
                        <td>: <?php echo $text_res_category2; ?></td>
                     </tr>
                     <tr>
                        <td><?php echo $text_res_author1; ?></td>
                        <td>: <?php echo $text_res_author2; ?></td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>         
      </div>      
      <div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
   </div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<?php echo $footer; ?>
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
            <li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
            <li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
            <li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
            <li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
            <?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
               <li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
            <?php } ?>
            <?php if (isset($haspermission_editSetting)) { ?>
               <li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
            <?php } ?>
            <!--<li><a href="<?php echo $menu_about_href; ?>" class="active"><?php echo $text_menu_about; ?></a></li>-->
         </ul>
      </div>
      <?php if ($warning) { ?>
         <div class="warning">
            <?php echo $warning; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <div id="et-content">
         <table class="form blogAbout">
            <tr>
               <td><?php echo $text_name; ?></td>
               <td>: <?php echo $heading_title; ?></td>
            </tr>
            <tr>
               <td><?php echo $text_version; ?></td>
               <td>: <?php echo $product_version; ?> <span id="versionStatus"><a onclick="checkVersion();"><?php echo $text_version_check; ?></a></span></td>
            </tr>
            <tr>
               <td><?php echo $text_author; ?></td>
               <td>: <?php echo $dev_name; ?></td>
            </tr>
            <tr>
               <td><?php echo $text_author_url; ?></td>
               <td>: <?php echo $link_author2; ?></td>
            </tr>
            <tr>
               <td>&nbsp;</td>
               <td></td>
            </tr>
            <tr>
               <td><?php echo $text_documentation; ?></td>
               <td>: <?php echo $link_documentation; ?></td>
            </tr>
            <tr>
               <td><?php echo $text_support; ?></td>
               <td>: <?php echo $link_support; ?></td>
            </tr>
            <?php if (isset($haspermission_editSetting)) { ?>
               <tr>
                  <td>&nbsp;</td>
                  <td></td>
               </tr>
               <tr>
                  <td><?php echo $text_uninstall; ?></td>
                  <td><a href="<?php echo $this->url->link('blog/blog/uninstall', 'token=' . $this->session->data['token'], 'SSL'); ?>" class="button"><?php echo $text_uninstall; ?></a></td>
               </tr>
            <?php } ?>
         </table>
      </div>
      
      <div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
   </div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript"><!--
function checkVersion() {
   $.ajax({
      url: 'index.php?route=blog/about/version&token=<?php echo $token; ?>&product=BlogManager',
      type: 'POST',
      dataType: 'json',
      beforeSend: function() {
         $('#versionStatus').addClass('loading');
      },
      success: function(data) {
         setTimeout(function(){
            $('#versionStatus').html(data).removeClass('loading');
         },750);
      }
   });
}
//--></script>
<?php echo $footer; ?>
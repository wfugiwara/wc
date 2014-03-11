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
            <li><a href="<?php echo $menu_comment_href; ?>" class="active"><?php echo $text_menu_comment; ?></a></li>
            <?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
               <li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
            <?php } ?>
            <?php if (isset($haspermission_editSetting)) { ?>
               <li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
            <?php } ?>
            <!--<li><a href="<?php echo $menu_about_href; ?>" class="active"><?php echo $text_menu_about; ?></a></li>-->
         </ul>
      </div>
      <?php if ($error_warning) { ?>
         <div class="warning">
            <?php echo $error_warning; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <?php if ($success) { ?>
         <div class="success">
            <?php echo $success; ?>
            <img class="close" alt="" src="view/image/blog/close.png" />
         </div>
      <?php } ?>
      <div id="et-content">
         <?php if (isset($haspermission_editComment) || isset($haspermission_replyComment)) { ?>
         <div class="heading">
            <?php if(isset($this->request->get['reply_id'])) { ?>
               <h2><?php echo $heading_reply; ?></h2>
            <?php } else { ?>
               <h2><?php echo $heading_edit; ?></h2>
            <?php } ?>
            <div class="buttons">
               <a onclick="buttonSave();" class="button"><?php echo $button_save; ?></a>
               <a onclick="buttonApply();" class="button"><?php echo $button_apply; ?></a>
               <a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a>
            </div>
         </div>

         <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" name="commentform">
         <div style="padding-top:15px; overflow:hidden;">
            <div class="commentStatus">
               <table class="form">
                  <tr>
                     <td><?php echo $entry_article; ?></td>
                     <td><a href="<?php echo HTTP_CATALOG . 'index.php?route=blog/article&article_id='.$comment['article_id'].''; ?>" target="_blank"><?php echo $comment['article']; ?></a></td>
                  </tr>
                  <?php if($isReply) { ?>
                     <tr>
                        <td colspan="2">
                           <b><?php echo $entry_inreply; ?></b>
                           <div style="margin:7px 0 0 10px; width:270px; word-wrap:break-word;">
                              <?php echo $comment['name_inreply']; ?><br/>
                              <span class="darkGray"><?php echo $comment['email_inreply']; ?><br/><?php echo $comment['website_inreply']; ?></span><br/><br/>
                              <?php echo $comment['comment_inreply']; ?><br/><br/>
                              <span class="darkGray small" style="display:block; text-align:right;"><?php echo $comment['created']; ?></span>
                           </div>
                           <input type="hidden" name="article_id" value="<?php echo $comment['article_id']; ?>" />
                        </td>
                     </tr>
                  <?php } else { ?>
                     <tr>
                        <td><?php echo $entry_created; ?></td>
                        <td><?php echo $comment['created']; ?></td>
                     </tr>
                     <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td class="select_125">
                           <select name="status">
                              <?php if ($comment['status']) { ?>
                                 <option value="1" selected="selected"><?php echo $text_approve; ?></option>
                                 <option value="0"><?php echo $text_unapprove; ?></option>
                              <?php } else { ?>
                                 <option value="1"><?php echo $text_approve; ?></option>
                                 <option value="0" selected="selected"><?php echo $text_unapprove; ?></option>
                              <?php } ?>
                           </select>
                        </td>
                     </tr>
                  <?php } ?>
               </table>
            </div>
            <div class="commentContent">
               <table class="form">
                  <tr>
                     <td><?php echo $entry_name; ?></td>
                     <td class="input_200">
                        <?php if($isReply) { ?>
                           <span class="darkGray"><?php echo $comment['name']; ?></span>
                           <input type="hidden" name="name" value="<?php echo $comment['name']; ?>" />
                        <?php } else { ?>
                           <input type="text" name="name" value="<?php echo $comment['name']; ?>" />
                        <?php } ?>
                        <?php if (isset($error_name)) { ?><span class="error"><?php echo $error_name; ?></span><?php } ?>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_mail; ?></td>
                     <td class="input_200">
                        <?php if($isReply) { ?>
                           <span class="darkGray"><?php echo $comment['email']; ?></span>
                           <input type="hidden" name="email" value="<?php echo $comment['email']; ?>" />
                        <?php } else { ?>
                           <input type="text" name="email" value="<?php echo $comment['email']; ?>" />
                        <?php } ?>
                        <?php if (isset($error_email)) { ?><span class="error"><?php echo $error_email; ?></span><?php } ?>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_site; ?></td>
                     <td class="input_200"><input type="text" name="website" value="<?php echo $comment['website']; ?>" /></td>
                  </tr>
                  <tr>
                     <td colspan="2">
                        <textarea rows="12" cols="50" style="width:98%;" name="content"><?php echo $comment['comment']; ?></textarea>
                        <?php if (isset($error_content)) { ?><span class="error"><?php echo $error_content; ?></span><?php } ?>
                     </td>
                  </tr>
               </table>
            </div>
         </div>
         <input type="hidden" name="buttonClick" value="">
         </form>
         <?php } else { ?>
            <div class="attention">
               <?php echo $error_nopermission; ?>
            </div>
         <?php } ?>
      </div>
      
      <div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
   </div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript">
function buttonSave() {document.commentform.buttonClick.value='save';$('#form').submit();}
function buttonApply() {document.commentform.buttonClick.value='apply';$('#form').submit();}
</script>

<?php echo $footer; ?>
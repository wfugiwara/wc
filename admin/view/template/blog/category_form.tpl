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
            <li><a href="<?php echo $menu_category_href; ?>" class="active"><?php echo $text_menu_category; ?></a></li>
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
         <?php if (isset($haspermission_editCategory)) { ?>
            <div class="heading">
               <?php if(isset($this->request->get['category_id'])) { ?>
                  <h2><?php echo $heading_edit; ?> <span style="font-size:16px; margin-left:5px;">: <?php echo isset($category_description[1]) ? $category_description[1]['name'] : ''; ?></span></h2>
               <?php } else { ?>
                  <h2><?php echo $heading_insert; ?></h2>
               <?php } ?>
               <div class="buttons">
                  <a onclick="buttonSave();" class="button"><?php echo $button_save; ?></a>
                  <?php if ($update) { ?><a onclick="buttonApply();" class="button"><?php echo $button_apply; ?></a> <?php } ?>
                  <a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a>
               </div>
            </div>
            
            <div id="tabs" class="vtabs">
               <a href="#tabGeneral"><?php echo $tab_general; ?></a>
               <a href="#tabData"><?php echo $tab_data; ?></a>
               <a href="#tabDesign"><?php echo $tab_design; ?></a>
            </div>
            
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" name="categoryform">
            <div id="tabGeneral" class="vtabs-content">
               <?php if (count($languages) > '1') { ?>
                  <div id="languages" class="htabs">
                     <?php foreach ($languages as $language) { ?>
                        <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                     <?php } ?>
                  </div>
               <?php } ?>
               <?php foreach ($languages as $language) { ?>
                  <div id="language<?php echo $language['language_id']; ?>" class="<?php echo $language['code']; ?>">
                     <table class="form">
                        <tr>
                           <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                           <td class="input_350"><input type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" />
                              <?php if (isset($error_name[$language['language_id']])) { ?>
                                 <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                              <?php } ?>
                           </td>
                        </tr>
                        <tr>
                           <td><?php echo $entry_meta_keyword; ?></td>
                           <td><textarea name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea></td>
                        </tr>
                        <tr>
                           <td><?php echo $entry_meta_description; ?></td>
                           <td><textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
                        </tr>
                        <tr>
                           <td colspan="2"><p><?php echo $entry_description; ?></p>
                           <textarea name="category_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea></td>
                        </tr>
                     </table>
                  </div>
               <?php } ?>
            </div>
            
            <div id="tabData" class="vtabs-content">
               <table class="form">
                  <tr>
                     <td><?php echo $entry_status; ?></td>
                     <td>
                        <select name="status">
                           <?php if ($status) { ?>
                              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                              <option value="0"><?php echo $text_disabled; ?></option>
                           <?php } else { ?>
                              <option value="1"><?php echo $text_enabled; ?></option>
                              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                           <?php } ?>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_parent; ?></td>
                     <td>
                        <select name="parent_id">
                           <option value="0"><?php echo $text_none; ?></option>
                           <?php foreach ($categories as $category) { ?>
                              <?php if ($category['category_id'] == $parent_id) { ?>
                                 <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                              <?php } else { ?>
                                 <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                              <?php } ?>
                           <?php } ?>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_keyword; ?></td>
                     <td class="input_350"><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_art_order; ?></td>
                     <td class="select_175">
                        <select name="article_order">                        
                           <option value="sortAsc" <?php if ($article_order == 'sortAsc') { echo 'selected="selected"'; } ?>><?php echo $entry_order_asc; ?></option>
                           <option value="sortDesc" <?php if ($article_order == 'sortDesc') { echo 'selected="selected"'; } ?>><?php echo $entry_order_desc; ?></option>
                           <option value="dateAsc" <?php if ($article_order == 'dateAsc') { echo 'selected="selected"'; } ?>><?php echo $entry_date_asc; ?></option>
                           <option value="dateDesc" <?php if ($article_order == 'dateDesc' || $article_order == '') { echo 'selected="selected"'; } ?>><?php echo $entry_date_desc; ?></option>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_image_featured; ?></td>
                     <td class="input_35">
                        <input type="text" name="width" value="<?php echo $width; ?>" />
                        x
                        <input type="text" name="height" value="<?php echo $height; ?>" />
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_char_limit; ?></td>
                     <td class="input_35"><input type="text" name="desc_limit" value="<?php echo $desc_limit; ?>" /></td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_category_image; ?></td>
                     <td>
                        <div class="featuredImage">
                           <a onclick="image_upload('featuredImage', 'thumbFeatured');"><img src="<?php echo $featuredImage; ?>" alt="" id="thumbFeatured" /></a>
                           <input type="hidden" name="image" value="<?php echo $image; ?>" id="featuredImage" />
                           <a onclick="image_upload('featuredImage', 'thumbFeatured');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
                           <a onclick="$('#thumbFeatured').attr('src', '<?php echo $no_image; ?>'); $('#featuredImage').attr('value', '');"><?php echo $text_clear; ?></a>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_store; ?></td>
                     <td>
                        <div class="scrollbox">
                           <?php $class = 'even'; ?>
                           <div class="<?php echo $class; ?>">
                              <?php if (in_array(0, $category_store)) { ?>
                                 <input type="checkbox" name="category_store[]" value="0" checked="checked" />
                                 <?php echo $text_default; ?>
                              <?php } else { ?>
                                 <input type="checkbox" name="category_store[]" value="0" />
                                 <?php echo $text_default; ?>
                              <?php } ?>
                           </div>
                           <?php foreach ($stores as $store) { ?>
                              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                              <div class="<?php echo $class; ?>">
                                 <?php if (in_array($store['store_id'], $category_store)) { ?>
                                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                    <?php echo $store['name']; ?>
                                 <?php } else { ?>
                                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" />
                                    <?php echo $store['name']; ?>
                                 <?php } ?>
                              </div>
                           <?php } ?>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_sort_order; ?></td>
                     <td class="input_25"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" /></td>
                  </tr>
               </table>
            </div>
            
            <div id="tabDesign" class="vtabs-content">
               <table class="form">
                  <tr>
                     <td><?php echo $entry_class_suffix; ?></td>
                     <td class="input_165"><input type="text" name="suffix" value="<?php echo $suffix; ?>" /></td>
                  </tr>
                  <tr>
                     <td><?php echo $entry_category_col; ?></td>
                     <td class="select_175">
                        <select name="category_col">
                           <option value="" <?php if(!isset($category_col) || $category_col == ''){ echo 'selected="selected"'; } ?>><?php echo $text_blogcol1; ?></option>
                           <option value="blogCol2 imageBlock equalHeight" <?php if (strpos($category_col, 'blogCol2') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol2; ?></option>
                           <option value="blogCol3 imageBlock equalHeight" <?php if (strpos($category_col, 'blogCol3') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol3; ?></option>
                           <option value="blogCol4 imageBlock equalHeight" <?php if (strpos($category_col, 'blogCol4') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol4; ?></option>
                        </select>                           
                     </td>
                  </tr>
               </table>
               <table class="blogList">
                  <thead>
                     <tr>
                        <td class="left"><?php echo $entry_store; ?></td>
                        <td class="left"><?php echo $entry_layout; ?></td>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td class="left"><?php echo $text_default; ?></td>
                        <td class="left">
                           <select name="category_layout[0][layout_id]">
                              <option value=""></option>
                              <?php foreach ($layouts as $layout) { ?>
                                 <?php if (isset($category_layout[0]) && $category_layout[0] == $layout['layout_id']) { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                 <?php } else { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                 <?php } ?>
                              <?php } ?>
                           </select>
                        </td>
                     </tr>
                  </tbody>
                  <?php foreach ($stores as $store) { ?>
                  <tbody>
                     <tr>
                        <td class="left"><?php echo $store['name']; ?></td>
                        <td class="left">
                           <select name="category_layout[<?php echo $store['store_id']; ?>][layout_id]">
                              <option value=""></option>
                              <?php foreach ($layouts as $layout) { ?>
                                 <?php if (isset($category_layout[$store['store_id']]) && $category_layout[$store['store_id']] == $layout['layout_id']) { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                 <?php } else { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                 <?php } ?>
                              <?php } ?>
                           </select>
                        </td>
                     </tr>
                  </tbody>
                  <?php } ?>
               </table>
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

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
   filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
   filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
   filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
   filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
   filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
   filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
$('#languages a').tabs();
function buttonSave() {document.categoryform.buttonClick.value='save';$('#form').submit();}
function buttonApply() {document.categoryform.buttonClick.value='apply';$('#form').submit();}

function image_upload(field, thumb) {
   $('#dialog').remove();
   
   $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
   
   $('#dialog').dialog({
      title: '<?php echo $text_select_image; ?>',
      close: function (event, ui) {
         if ($('#' + field).attr('value')) {
            $.ajax({
               url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
               dataType: 'text',
               success: function(data) {
                  $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
               }
            });
         }
      },   
      bgiframe: false,
      width: 800,
      height: 400,
      resizable: false,
      modal: false
   });
};

var keyword = $("input[name=keyword]");
$(".<?php echo $def_lang; ?> input[name^='category_description']").keyup(function(){
   var seoUrl = $(this).val();
   seoUrl = seoUrl.replace(/^\s+|\s+$/g, '');
   seoUrl = seoUrl.toLowerCase();
   
   var from = "àáäâèéëêìíïîòóöôùúüûñcçcllštžýnrrd·/_,:;";
   var to   = "aaaaeeeeiiiioooouuuuncccllstzynrrd------";
   for (var i=0, l=from.length ; i<l ; i++) {
      seoUrl = seoUrl.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
   }
   
   seoUrl = seoUrl.replace(/[^a-z0-9 -]/g, '').replace(/\s+/g, '-').replace(/-+/g, '-');

   // return SEO url;
   keyword.val(seoUrl);       
});
//--></script> 
<?php echo $footer; ?>
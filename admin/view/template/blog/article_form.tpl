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
            <li><a href="<?php echo $menu_article_href; ?>" class="active"><?php echo $text_menu_article; ?></a></li>
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
         <?php if (isset($haspermission_editOwnArticle) && $ownArticle || isset($haspermission_editOtherArticle) && $otherArticle || isset($haspermission_addArticle)) { ?>
         <div class="heading">
            <?php if(isset($authors) && isset($this->request->get['article_id'])) { ?>
               <h2><?php echo $heading_edit; ?> <span style="font-size:16px; margin-left:5px;">: <?php echo isset($article_description[1]) ? $article_description[1]['title'] : ''; ?></span></h2>
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
            <a href="#tabLinks"><?php echo $tab_links; ?></a>
            <a href="#tabDesign"><?php echo $tab_design; ?></a>
         </div>
         
         <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" name="articleform">
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
                        <td><span class="required">*</span> <?php echo $entry_title; ?></td>
                        <td class="input_350"><input type="text" name="article_description[<?php echo $language['language_id']; ?>][title]" size="100" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['title'] : ''; ?>" />
                           <?php if (isset($error_title[$language['language_id']])) { ?>
                              <span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
                           <?php } ?>
                        </td>
                     </tr>
                     <tr>
                        <td><?php echo $entry_meta_keyword; ?></td>
                        <td><textarea name="article_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea></td>
                     </tr>
                     <tr>
                        <td><?php echo $entry_meta_description; ?></td>
                        <td><textarea name="article_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
                     </tr>
                     <tr>
                        <td colspan="2"><p><span class="required">*</span> <?php echo $entry_description; ?></p>
                        <?php if (isset($error_description[$language['language_id']])) { ?>
                           <span class="error"><?php echo $error_description[$language['language_id']]; ?></span>
                        <?php } ?>
                        <textarea name="article_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['description'] : ''; ?></textarea>
                        </td>
                     </tr>
                     <tr>
                        <td><?php echo $entry_tag; ?></td>
                        <td class="input_350"><input type="text" name="article_tag[<?php echo $language['language_id']; ?>]" value="<?php echo isset($article_tag[$language['language_id']]) ? $article_tag[$language['language_id']] : ''; ?>" /></td>
                     </tr>
                  </table>
               </div>
            <?php } ?>
         </div>
         
         <div id="tabData" class="vtabs-content">
            <table class="form">
               <tr>
                  <td><?php echo $entry_status; ?></td>
                  <td class="select_90"><select name="status">
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
                  <td><?php echo $entry_keyword; ?></td>
                  <td class="input_350"><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
               </tr>
               <?php if(isset($authors)) { ?>
                  <tr>
                     <td><?php echo $entry_author; ?></td>
                     <td>
                        <?php if (isset($author['author_id'])) { ?>
                           <?php echo $author['name']; ?>
                           <input type="hidden" name="author_id" value="<?php echo $author['author_id']; ?>">
                        <?php } else { echo ' - '; }?>
                     </td>
                  </tr>
                  <?php if (isset($haspermission_changeAuthor)) { ?>
                     <tr>
                        <td><?php echo $entry_assign_author; ?></td>
                        <td class="select_175">
                           <select name="author_id">
                              <?php foreach ($authors as $result) { ?>
                                 <?php if (isset($author['author_id']) && $author['author_id'] == $result['author_id']) {?>
                                    <option value="<?php echo $result['author_id']; ?>" selected="selected"><?php echo $result['name']; ?></option>
                                 <?php } else { ?>
                                    <option value="<?php echo $result['author_id']; ?>"><?php echo $result['name']; ?></option>
                                 <?php } ?>
                              <?php } ?>
                           </select>
                        </td>
                     </tr>
                  <?php } ?>
               <?php } else { ?>
                  <tr>
                     <td><?php echo $entry_author; ?></td>
                     <td>
                        <?php echo $author['name']; ?>
                        <input type="hidden" name="author_id" value="<?php echo $author['author_id']; ?>">
                     </td>
                  </tr>
               <?php } ?>
               <tr>
                  <td><?php echo $entry_created; ?></td>
                  <td class="input_120"><input class="datetime" type="text" name="created" value="<?php echo $created; ?>" /></td>
               </tr>
               <tr>
                  <td><?php echo $entry_modified; ?></td>
                  <td class="input_120"><input class="datetime" type="text" name="modified" value="<?php echo $modified; ?>" /></td>
               </tr>
               <tr>
                  <td><?php echo $entry_available; ?></td>
                  <td class="input_80"><input class="date" type="text" name="available" value="<?php echo $available; ?>" /></td>
               </tr>
               <tr>
                  <td><?php echo $entry_featured_image; ?></td>
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
                  <td><?php echo $entry_sort_order; ?></td>
                  <td class="input_25"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
               </tr>
            </table>
         </div>
         
         <div id="tabLinks" class="vtabs-content">
            <table class="form">
               <tr>
                  <td><?php echo $entry_categories; ?></td>
                  <td><div class="scrollbox">
                     <?php $class = 'odd'; ?>
                     <?php foreach ($categories as $category) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <div class="<?php echo $class; ?>">
                        <?php if (in_array($category['category_id'], $article_category)) { ?>
                           <input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                           <?php echo $category['name']; ?>
                        <?php } else { ?>
                           <input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" />
                           <?php echo $category['name']; ?>
                        <?php } ?>
                        </div>
                     <?php } ?>
                     </div>
                     <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                  </td>
               </tr>
               <tr>
                  <td><?php echo $entry_store; ?></td>
                  <td><div class="scrollbox">
                        <?php $class = 'even'; ?>
                        <div class="<?php echo $class; ?>">
                           <?php if (in_array(0, $article_store)) { ?>
                              <input type="checkbox" name="article_store[]" value="0" checked="checked" />
                              <?php echo $text_default; ?>
                           <?php } else { ?>
                              <input type="checkbox" name="article_store[]" value="0" />
                              <?php echo $text_default; ?>
                           <?php } ?>
                        </div>
                        <?php foreach ($stores as $store) { ?>
                           <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                           <div class="<?php echo $class; ?>">
                              <?php if (in_array($store['store_id'], $article_store)) { ?>
                                 <input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                 <?php echo $store['name']; ?>
                              <?php } else { ?>
                                 <input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" />
                                 <?php echo $store['name']; ?>
                              <?php } ?>
                           </div>
                        <?php } ?>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td><?php echo $entry_related; ?></td>
                  <td>
                     <table>
                        <tr>
                           <td style="padding:0 0 5px;" colspan="3" class="select_min175">
                              <select id="category" style="margin-bottom: 5px;" onchange="getArticles();">
                                 <?php foreach ($categories as $category) { ?>
                                    <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                                 <?php } ?>
                              </select>
                           </td>
                        </tr>
                        <tr>
                           <td style="padding:0;">
                              <select multiple="multiple" id="article" size="10" style="width:245px; height:150px;"></select>
                           </td>
                           <td style="vertical-align: middle;">
                              <input type="button" value="--&gt;" onclick="addRelated();" />
                              <br />
                              <input type="button" value="&lt;--" onclick="removeRelated();" />
                           </td>
                           <td style="padding:0;">
                              <select multiple="multiple" id="related" size="10" style="width:245px; height:150px;"></select>
                           </td>
                        </tr>
                     </table>
                     <div id="article_related">
                        <?php foreach ($article_related as $related_id) { ?>
                           <input type="hidden" name="article_related[]" value="<?php echo $related_id; ?>" />
                        <?php } ?>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td><?php echo $entry_related_product; ?></td>
                  <td>
                     <table>
                        <tr>
                           <td style="padding:0 0 5px;" colspan="3" class="select_min175">
                              <select id="categoryProduct" style="margin-bottom: 5px;" onchange="getProducts();">
                                 <?php foreach ($catProduct as $catProduct) { ?>
                                    <option value="<?php echo $catProduct['category_id']; ?>"><?php echo $catProduct['name']; ?></option>
                                 <?php } ?>
                              </select>
                           </td>
                        </tr>
                        <tr>
                           <td style="padding:0;">
                              <select multiple="multiple" id="product" size="10" style="width:245px; height:150px;"></select>
                           </td>
                           <td style="vertical-align: middle;">
                              <input type="button" value="--&gt;" onclick="addRelProduct();" />
                              <br />
                              <input type="button" value="&lt;--" onclick="removeRelProduct();" />
                           </td>
                           <td style="padding:0;">
                              <select multiple="multiple" id="relProduct" size="10" style="width:245px; height:150px;"></select>
                           </td>
                        </tr>
                     </table>
                     <div id="product_related">
                        <?php foreach ($product_related as $related_id) { ?>
                           <input type="hidden" name="product_related[]" value="<?php echo $related_id; ?>" />
                        <?php } ?>
                     </div>
                  </td>
               </tr>
            </table>
         </div>
         
         <div id="tabDesign" class="vtabs-content">
            <table class="list">
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
                        <select name="article_layout[0][layout_id]">
                           <option value=""></option>
                           <?php foreach ($layouts as $layout) { ?>
                              <?php if (isset($article_layout[0]) && $article_layout[0] == $layout['layout_id']) { ?>
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
                     <td class="left"><select name="article_layout[<?php echo $store['store_id']; ?>][layout_id]">
                           <option value=""></option>
                           <?php foreach ($layouts as $layout) { ?>
                              <?php if (isset($article_layout[$store['store_id']]) && $article_layout[$store['store_id']] == $layout['layout_id']) { ?>
                                 <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                              <?php } else { ?>
                                 <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                              <?php } ?>
                           <?php } ?>
                        </select></td>
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
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
   dateFormat: 'yy-mm-dd',
   timeFormat: 'h:m'
});
$('#languages a').tabs(); 
function buttonSave() {document.articleform.buttonClick.value='save';$('#form').submit();}
function buttonApply() {document.articleform.buttonClick.value='apply';$('#form').submit();}
//--></script>
<script type="text/javascript"><!--
function addRelated() {
   $('#article :selected').each(function() {
      $(this).remove();
      
      $('#related option[value=\'' + $(this).attr('value') + '\']').remove();
      $('#related').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
      $('#article_related input[value=\'' + $(this).attr('value') + '\']').remove();
      $('#article_related').append('<input type="hidden" name="article_related[]" value="' + $(this).attr('value') + '" />');
   });
}
function removeRelated() {
   $('#related :selected').each(function() {
      $(this).remove();
      
      $('#article option[value=\'' + $(this).attr('value') + '\']').remove();
      $('#article').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
      $('#article_related input[value=\'' + $(this).attr('value') + '\']').remove();
   });
}
function getArticles() {
   $('#article option').remove();
   <?php if (isset($this->request->get['article_id'])) {?> var article_id = '<?php echo $this->request->get['article_id'] ?>'; <?php } else { ?> var article_id = 0; <?php } ?>
   
   $.ajax({
      url: 'index.php?route=blog/article/category&token=<?php echo $token; ?>&article_id=' + article_id + '&category_id=' + $('#category').attr('value'),
      dataType: 'json',
      success: function(data) {
         for (i = 0; i < data.length; i++) {
            if (data[i]['article_id'] == article_id) { continue; }
             $('#article').append('<option value="' + data[i]['article_id'] + '">' + data[i]['title'] + '</option>');
         }
      }
   });
}
function getRelated() {
   $('#related option').remove();
   
   $.ajax({
      url: 'index.php?route=blog/article/related&token=<?php echo $token; ?>',
      type: 'POST',
      dataType: 'json',
      data: $('#article_related input'),
      success: function(data) {
         $('#article_related input').remove();
         for (i = 0; i < data.length; i++) {
             $('#related').append('<option value="' + data[i]['article_id'] + '">' + data[i]['title'] + '</option>');
            $('#article_related').append('<input type="hidden" name="article_related[]" value="' + data[i]['article_id'] + '" />');
         } 
      }
   });
}
// == //
function addRelProduct() {
   $('#product :selected').each(function() {
      $(this).remove();
      
      $('#relProduct option[value=\'' + $(this).attr('value') + '\']').remove();
      $('#relProduct').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
      $('#product_related input[value=\'' + $(this).attr('value') + '\']').remove();
      $('#product_related').append('<input type="hidden" name="product_related[]" value="' + $(this).attr('value') + '" />');
   });
}
function removeRelProduct() {
   $('#relProduct :selected').each(function() {
      $(this).remove();
      
      $('#product option[value=\'' + $(this).attr('value') + '\']').remove();
      $('#product').append('<option value="' + $(this).attr('value') + '">' + $(this).text() + '</option>');
      $('#product_related input[value=\'' + $(this).attr('value') + '\']').remove();
   });
}
function getProducts() {
   $('#product option').remove();
   <?php if (isset($this->request->get['article_id'])) {?> var article_id = '<?php echo $this->request->get['article_id'] ?>'; <?php } else { ?> var article_id = 0; <?php } ?>
   
   $.ajax({
      url: 'index.php?route=blog/article/catproduct&token=<?php echo $token; ?>&article_id=' + article_id + '&category_id=' + $('#categoryProduct').attr('value'),
      dataType: 'json',
      success: function(data) {
         for (i = 0; i < data.length; i++) {
             $('#product').append('<option value="' + data[i]['product_id'] + '">' + data[i]['name'] + '</option>');
         }
      }
   });
}
function getRelProducts() {
   $('#relProduct option').remove();
   
   $.ajax({
      url: 'index.php?route=blog/article/relproduct&token=<?php echo $token; ?>',
      type: 'POST',
      dataType: 'json',
      data: $('#product_related input'),
      success: function(data) {
         $('#product_related input').remove();
         for (i = 0; i < data.length; i++) {
             $('#relProduct').append('<option value="' + data[i]['product_id'] + '">' + data[i]['name'] + '</option>');
            $('#product_related').append('<input type="hidden" name="product_related[]" value="' + data[i]['product_id'] + '" />');
         } 
      }
   });
}

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

getArticles();
getRelated();
getProducts();
getRelProducts();

var keyword = $("input[name=keyword]");
var endUrl = '<?php echo $seoSuffix; ?>';
$(".<?php echo $def_lang; ?> input[name^='article_description']").keyup(function(){
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
   keyword.val(seoUrl + endUrl);       
});
//--></script>
<?php echo $footer; ?>
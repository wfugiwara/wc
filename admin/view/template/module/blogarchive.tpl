<?php echo $header; ?>
<div id="content">
   <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
         <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
   </div>

   <div class="box">
      <div class="heading">
         <h1><?php echo $heading_module; ?></h1>
         <div class="buttons">
            <a onclick="buttonSave();" class="button"><?php echo $button_save; ?></a>
            <a onclick="buttonApply();" class="button"><?php echo $button_apply; ?></a>
            <a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a>
            <a onclick="addModule();" class="button add"><?php echo $button_add_module; ?></a>
         </div>
      </div>
      <div class="line"></div>
      
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
      
      <div class="content">
         <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" name="blogModule">
            <table id="module" class="blogList">
               <thead>
                  <tr>
                     <td class="center dataCat"><?php echo $entry_data; ?></td>
                     <td class="center"><?php echo $entry_design; ?></td>
                     <td class="center status"><?php echo $entry_status; ?></td>
                     <td class="del"></td>
                  </tr>
               </thead>
               <?php $module_row = 0; ?><?php $class = 'odd'; ?>
               <?php foreach ($modules as $module) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <tbody id="module-row<?php echo $module_row; ?>" class="<?php echo $class; ?>">
                     <tr>
                        <td class="center">
                           <table class="left" width="100%">
                              <tr>
                                 <td class="entry"><?php echo $entry_sort_order; ?></td>
                                 <td><input type="text" name="blogarchive_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" /></td>
                              </tr>
                              <tr>
                                 <td><?php echo $entry_count; ?></td>
                                 <td>
                                    <select name="blogarchive_module[<?php echo $module_row; ?>][count]">
                                       <?php if ($module['count']) { ?>
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
                                 <td><?php echo $entry_exclude; ?></td>
                                 <td class="input_125"><input type="text" name="blogarchive_module[<?php echo $module_row; ?>][exclude]" value="<?php echo (isset($module['exclude']) && $module['exclude']) ? $module['exclude'] : ''; ?>" /></td>
                              </tr>
                           </table>
                        </td>
                        <td class="center design">
                           <table class="left" width="100%">
                              <tr>
                                 <td class="entry"><?php echo $entry_layout; ?></td>
                                 <td>
                                    <select name="blogarchive_module[<?php echo $module_row; ?>][layout_id]">
                                       <?php foreach ($layouts as $layout) { ?>
                                          <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                             <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                          <?php } else { ?>
                                             <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                          <?php } ?>
                                       <?php } ?>
                                    </select>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="entry"><?php echo $entry_position; ?></td>
                                 <td>
                                    <select name="blogarchive_module[<?php echo $module_row; ?>][position]">
                                       <?php if ($module['position'] == 'content_top') { ?>
                                          <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                       <?php } else { ?>
                                          <option value="content_top"><?php echo $text_content_top; ?></option>
                                       <?php } ?>
                                       <?php if ($module['position'] == 'content_bottom') { ?>
                                          <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                       <?php } else { ?>
                                          <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                       <?php } ?>
                                       <?php if ($module['position'] == 'column_left') { ?>
                                          <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                       <?php } else { ?>
                                          <option value="column_left"><?php echo $text_column_left; ?></option>
                                       <?php } ?>
                                       <?php if ($module['position'] == 'column_right') { ?>
                                          <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                       <?php } else { ?>
                                          <option value="column_right"><?php echo $text_column_right; ?></option>
                                       <?php } ?>
                                    </select>
                                 </td>
                              </tr>
                              <tr>
                                 <td><?php echo $entry_suffix; ?></td>
                                 <td class="input_165"><input type="text" name="blogarchive_module[<?php echo $module_row; ?>][suffix]" value="<?php echo $module['suffix']; ?>" /></td>
                              </tr>
                           </table>
                        </td>
                        <td class="center">
                           <select name="blogarchive_module[<?php echo $module_row; ?>][status]">
                              <?php if ($module['status']) { ?>
                                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                 <option value="0"><?php echo $text_disabled; ?></option>
                              <?php } else { ?>
                                 <option value="1"><?php echo $text_enabled; ?></option>
                                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                              <?php } ?>
                           </select>
                        </td>
                        <td class="center">
                           <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" title="Remove Module"><img class="remove" alt="" src="view/image/blog/del.png" alt="remove"/></a>
                        </td>
                     </tr>
                  </tbody>
                  <?php $module_row++; ?>
               <?php } ?>
               <tfoot>
                  <tr>
                     <td colspan="7"></td>
                  </tr>
               </tfoot>
            </table>
            <input type="hidden" name="buttonClick" value="">
         </form>
      </div>
   </div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {   
   html   = '<tbody id="module-row' + module_row + '">';
   html += '   <tr>';
   html += '      <td class="center">';
   html += '         <table class="left" width="100%">';
   html += '            <tr>';
   html += '               <td class="entry"><?php echo $entry_sort_order; ?></td>';
   html += '               <td><input type="text" name="blogarchive_module[' + module_row + '][sort_order]" value="" /></td>';
   html += '            </tr>';
   html += '            <tr>';
   html += '               <td><?php echo $entry_count; ?></td>';
   html += '               <td>';
   html += '                  <select name="blogarchive_module[' + module_row + '][count]">';
   html += '                     <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
   html += '                     <option value="0"><?php echo $text_disabled; ?></option>';
   html += '                  </select>';
   html += '               </td>';
   html += '            </tr>';
   html += '            <tr>';
   html += '               <td><?php echo $entry_exclude; ?></td>';
   html += '               <td class="input_125"><input type="text" name="blogarchive_module[' + module_row + '][exclude]" value="" /></td>';
   html += '            </tr>';
   html += '         </table>';
   html += '      </td>';
   html += '      <td class="center design">';
   html += '         <table class="left" width="100%">';
   html += '            <tr>';
   html += '               <td class="entry"><?php echo $entry_layout; ?></td>';
   html += '               <td>';
   html += '                  <select name="blogarchive_module[' + module_row + '][layout_id]">';
                           <?php foreach ($layouts as $layout) { ?>
   html += '                     <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
                           <?php } ?>
   html += '                  </select>';
   html += '               </td>';
   html += '            </tr>';
   html += '            <tr>';
   html += '               <td class="entry"><?php echo $entry_position; ?></td>';
   html += '               <td><select name="blogarchive_module[' + module_row + '][position]">';
   html += '                  <option value="content_top"><?php echo $text_content_top; ?></option>';
   html += '                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
   html += '                  <option value="column_left"><?php echo $text_column_left; ?></option>';
   html += '                  <option value="column_right"><?php echo $text_column_right; ?></option>';
   html += '               </select></td>';
   html += '            </tr>';
   html += '            <tr>';
   html += '               <td><?php echo $entry_suffix; ?></td>';
   html += '               <td class="input_165"><input type="text" name="blogarchive_module[<?php echo $module_row; ?>][suffix]" value="boxPlain" /></td>';
   html += '            </tr>';
   html += '         </table>';
   html += '      </td>';
   html += '      <td class="center">';
   html += '         <select name="blogarchive_module[' + module_row + '][status]">';
   html += '               <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
   html += '               <option value="0"><?php echo $text_disabled; ?></option>';
   html += '         </select>';
   html += '      </td>';
   html += '      <td class="center">';
   html += '         <a onclick="$(\'#module-row' + module_row + '\').remove();" title="Remove Module"><img class="remove" alt="" src="view/image/blog/del.png" alt="remove"/></a>';
   html += '      </td>';
   html += '   </tr>';
   html += '</tbody>';
   
   $('#module tfoot').before(html);
   
   module_row++;
}
//--></script>
<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript">
function buttonSave() {document.blogModule.buttonClick.value='save';$('#form').submit();}
function buttonApply() {document.blogModule.buttonClick.value='apply';$('#form').submit();}
</script>
<?php echo $footer; ?>
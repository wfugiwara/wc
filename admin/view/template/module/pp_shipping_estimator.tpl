<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/shipping.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div style="font-weight: bold;"><?php echo $title_basic; ?><hr/></div>
                <table class="form">
                    <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td><select style="min-width: 100px;" name="pp_shipping_estimator_status">
                                <?php if ($pp_shipping_estimator_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_default_country; ?></td>
                        <td><select style="min-width: 100px;" name="pp_shipping_estimator_country_id"  onchange="$('select[name=\'pp_shipping_estimator_zone_id\']').load('index.php?route=module/pp_shipping_estimator/zone&token=<?php echo $token; ?>&country_id=' + this.value);">
                                <option value="" selected="selected"><?php echo $text_none; ?></option>
                                <?php foreach ($countries as $country) { ?>
                                    <?php if ($country['country_id'] == $pp_shipping_estimator_country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_default_zone; ?></td>
                        <td><select style="min-width: 100px;" name="pp_shipping_estimator_zone_id">
                                <?php echo $zones; ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_default_postcode; ?></td>
                        <td><input type="text" name="pp_shipping_estimator_postcode" value="<?php echo $pp_shipping_estimator_postcode; ?>" />
                        </td>
                    </tr>
                    <tr>
                                 <td><?php echo $entry_auto_quote; ?></td>
                        <td>
                            <?php if ($pp_shipping_estimator_auto_quote) { ?>
                                <input type="radio" checked="checked" name="pp_shipping_estimator_auto_quote" value="1"/><?php echo $text_enabled; ?>
                                <input type="radio"  name="pp_shipping_estimator_auto_quote" value="0"/><?php echo $text_disabled; ?>
                            <?php } else { ?>
                                <input type="radio"  name="pp_shipping_estimator_auto_quote" value="1"/><?php echo $text_enabled; ?>
                                <input type="radio" checked="checked" name="pp_shipping_estimator_auto_quote" value="0"/><?php echo $text_disabled; ?>
                            <?php } ?>
                        </td>
                    </tr>
                        <tr>
                            <td><?php echo $entry_show_mode; ?></td>
                        <td>
                            <?php if ($pp_shipping_estimator_show_mode) { ?>
                                <input type="radio" checked="checked" name="pp_shipping_estimator_show_mode" value="1"/><?php echo $text_show_module; ?>
                                <input type="radio"  name="pp_shipping_estimator_show_mode" value="0"/><?php echo $text_show_product; ?>
                            <?php } else { ?>
                                <input type="radio"  name="pp_shipping_estimator_show_mode" value="1"/><?php echo $text_show_module; ?>
                                <input type="radio" checked="checked" name="pp_shipping_estimator_show_mode" value="0"/><?php echo $text_show_product; ?>
                            <?php } ?>
                        </td>
                    </tr>
                </table>
                <?php echo $text_tip_layout; ?>
                <table id="module" class="list">
                    <thead>
                        <tr>
                            <td class="left"><?php echo $entry_layout; ?></td>
                            <td class="left"><?php echo $entry_position; ?></td>
                            <td class="left"><?php echo $entry_status; ?></td>
                            <td class="right"><?php echo $entry_sort_order; ?></td>
                            <td></td>
                        </tr>
                    </thead>
 			<?php if ($version == '1.5.0') { ?>
			    <?php $module_row = 0; ?>
			    <?php foreach ($modules as $module) { ?>
				<tbody id="module-row<?php echo $module_row; ?>">
				    <tr>
					<td class="left"><select name="pp_shipping_estimator_<?php echo $module_row; ?>_layout_id">
						<?php foreach ($layouts as $layout) { ?>
						    <?php if ($layout['layout_id'] == ${'pp_shipping_estimator_' . $module . '_layout_id'}) { ?>
							<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
						    <?php } else { ?>
							<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
						    <?php } ?>
						<?php } ?>
					    </select></td>
					<td class="left"><select name="pp_shipping_estimator_<?php echo $module_row; ?>_position">
						<?php if (${'pp_shipping_estimator_' . $module . '_position'} == 'content_top') { ?>
	    					<option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
						<?php } else { ?>
	    					<option value="content_top"><?php echo $text_content_top; ?></option>
						<?php } ?>  
						<?php if (${'pp_shipping_estimator_' . $module . '_position'} == 'content_bottom') { ?>
	    					<option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
						<?php } else { ?>
	    					<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
						<?php } ?>     
						<?php if (${'pp_shipping_estimator_' . $module . '_position'} == 'column_left') { ?>
	    					<option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
						<?php } else { ?>
	    					<option value="column_left"><?php echo $text_column_left; ?></option>
						<?php } ?>
						<?php if (${'pp_shipping_estimator_' . $module . '_position'} == 'column_right') { ?>
	    					<option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
						<?php } else { ?>
	    					<option value="column_right"><?php echo $text_column_right; ?></option>
						<?php } ?>
					    </select></td>
					<td class="left"><select name="pp_shipping_estimator_<?php echo $module_row; ?>_status">
						<?php if (${'pp_shipping_estimator_' . $module . '_status'}) { ?>
	    					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
	    					<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
	    					<option value="1"><?php echo $text_enabled; ?></option>
	    					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					    </select></td>
					<td class="right"><input type="text" name="pp_shipping_estimator_<?php echo $module_row; ?>_sort_order" value="<?php echo ${'pp_shipping_estimator_' . $module . '_sort_order'}; ?>" size="3" />
					
					</td>
					<td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
				    </tr>
				</tbody>
				  
				<?php $module_row++; ?>
			    <?php } ?>  
				  <input type="hidden" name="pp_shipping_estimator_module" value="<?php echo $pp_shipping_estimator_module; ?>" />
			<?php } else { ?>
			    <?php $module_row = 0; ?>
			    <?php foreach ($modules as $module) { ?>
	                        <tbody id="module-row<?php echo $module_row; ?>">
	                            <tr>
	                                <td class="left"><select name="pp_shipping_estimator_module[<?php echo $module_row; ?>][layout_id]">
						<?php foreach ($layouts as $layout) { ?>
						    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
							<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
						    <?php } else { ?>
							<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
						    <?php } ?>
						<?php } ?>
	                                    </select></td>
	                                <td class="left"><select name="pp_shipping_estimator_module[<?php echo $module_row; ?>][position]">
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
	                                    </select></td>
	                                <td class="left"><select name="pp_shipping_estimator_module[<?php echo $module_row; ?>][status]">
						<?php if ($module['status']) { ?>
	    					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
	    					<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
	    					<option value="1"><?php echo $text_enabled; ?></option>
	    					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
	                                    </select></td>
	                                <td class="right"><input type="text" name="pp_shipping_estimator_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
	                                <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
	                            </tr>
	                        </tbody>
				<?php $module_row++; ?>
			    <?php } ?>

			<?php } ?>
			<tfoot>
			    <tr>
				<td colspan="4"></td>
				<td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
			    </tr>
			</tfoot>
		    </table>
         
                <div style="font-weight: bold;"><?php echo $title_advanced; ?><hr/></div>
                <div style="padding: 10px ;"><?php echo $text_note; ?></div>
                <table class="form">
                    <tr>
                        <td><?php echo $entry_show_country_field; ?></td>  
                        <td>
                            <?php if ($pp_shipping_estimator_show_country_field) { ?>
                                <input type="radio" name="pp_shipping_estimator_show_country_field" value="1" checked="checked" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_country_field" value="0" /><?php echo $text_no; ?>
                            <?php } else { ?>
                                <input type="radio" name="pp_shipping_estimator_show_country_field" value="1" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_country_field" value="0" checked="checked" /><?php echo $text_no; ?>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_show_zone_field; ?></td>  
                        <td>
                            <?php if ($pp_shipping_estimator_show_zone_field) { ?>
                                <input type="radio" name="pp_shipping_estimator_show_zone_field" value="1" checked="checked" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_zone_field" value="0" /><?php echo $text_no; ?>
                            <?php } else { ?>
                                <input type="radio" name="pp_shipping_estimator_show_zone_field" value="1" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_zone_field" value="0" checked="checked" /><?php echo $text_no; ?>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_show_postcode_field; ?></td>  
                        <td>
                            <?php if ($pp_shipping_estimator_show_postcode_field) { ?>
                                <input type="radio" name="pp_shipping_estimator_show_postcode_field" value="1" checked="checked" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_postcode_field" value="0" /><?php echo $text_no; ?>
                            <?php } else { ?>
                                <input type="radio" name="pp_shipping_estimator_show_postcode_field" value="1" /><?php echo $text_yes; ?>
                                <input type="radio" name="pp_shipping_estimator_show_postcode_field" value="0" checked="checked" /><?php echo $text_no; ?>
                            <?php } ?>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<?php if ($version == '1.5.0') { ?>

    <script type="text/javascript"><!--
        var module_row = <?php echo $module_row; ?>;

        function addModule() {	
    	html  = '<tbody id="module-row' + module_row + '">';
    	html += '  <tr>';
    	html += '    <td class="left"><select name="pp_shipping_estimator_' + module_row + '_layout_id">';
    <?php foreach ($layouts as $layout) { ?>
			html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
    <?php } ?>
    		html += '    </select></td>';
    		html += '    <td class="left"><select name="pp_shipping_estimator_' + module_row + '_position">';
    		html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    		html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    		html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
    		html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
    		html += '    </select></td>';
    		html += '    <td class="left"><select name="pp_shipping_estimator_' + module_row + '_status">';
    		html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    		html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    		html += '    </select></td>';
    		html += '    <td class="right"><input type="text" name="pp_shipping_estimator_' + module_row + '_sort_order" value="" size="3" /></td>';
    		html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
    		html += '  </tr>';
    		html += '</tbody>';
    	
    		$('#module tfoot').before(html);
    	
    		module_row++;
    	    }

    	    $('#form').bind('submit', function() {
    		var module = new Array(); 

    		$('#module tbody').each(function(index, element) {
    		    module[index] = $(element).attr('id').substr(10);
    		});
    	
    		$('input[name=\'pp_shipping_estimator_module\']').attr('value', module.join(','));
    	    });
    	    //--></script>

<?php } else { ?>
    <script type="text/javascript"><!--
        var module_row = <?php echo $module_row; ?>;

        function addModule() {	
            html  = '<tbody id="module-row' + module_row + '">';
            html += '  <tr>';
            html += '    <td class="left"><select name="pp_shipping_estimator_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout) { ?>
		html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
    <?php } ?>
    	html += '    </select></td>';
    	html += '    <td class="left"><select name="pp_shipping_estimator_module[' + module_row + '][position]">';
    	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
    	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
    	html += '    </select></td>';
    	html += '    <td class="left"><select name="pp_shipping_estimator_module[' + module_row + '][status]">';
    	html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    	html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    	html += '    </select></td>';
    	html += '    <td class="right"><input type="text" name="pp_shipping_estimator_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
    	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
    	html += '  </tr>';
    	html += '</tbody>';
    	
    	$('#module tfoot').before(html);
    	
    	module_row++;
        }
        //--></script>
<?php } ?>
<?php echo $footer; ?> 
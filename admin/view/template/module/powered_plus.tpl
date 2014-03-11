<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div><!-- breadcrumb -->
		
	<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>	
	
	<div class="box">
		<div class="heading">
		  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
		  <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
		</div><!-- end of .heading -->

		<div class = "content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<table class = "form">
				<tr>
					<td colspan="2"><?php echo $description; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_align; ?><br /><span class = "help"><?php // echo $entry_align_description; ?></span></td>
					<td>
					<select name="pp_align">
						<option value="left" <?php echo $pp_align == 'left' ? 'selected="selected"' : ''; ?>><?php echo $entry_left; ?></option>
						<option value="center" <?php echo $pp_align == 'center' ? 'selected="selected"' : ''; ?>><?php echo $entry_center; ?></option>
						<option value="right" <?php echo $pp_align == 'right' ? 'selected="selected"' : ''; ?>><?php echo $entry_right; ?></option>
					</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_copyright; ?><br /><span class = "help"><?php // echo $entry_use_copyright_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[0]" value="y" <?php echo $pp_use[0] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[0]" value="Y" <?php echo $pp_use[0] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[0]" value="n" <?php echo $pp_use[0] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_shop_name; ?><br /><span class = "help"><?php // echo $entry_use_shop_name_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[1]" value="y" <?php echo $pp_use[1] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[1]" value="Y" <?php echo $pp_use[1] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[1]" value="n" <?php echo $pp_use[1] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_address; ?><br /><span class = "help"><?php // echo $entry_use_address_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[2]" value="y" <?php echo $pp_use[2] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[2]" value="Y" <?php echo $pp_use[2] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[2]" value="n" <?php echo $pp_use[2] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_phone; ?><br /><span class = "help"><?php // echo $entry_use_phone_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[3]" value="y" <?php echo $pp_use[3] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[3]" value="Y" <?php echo $pp_use[3] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[3]" value="n" <?php echo $pp_use[3] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_fax; ?><br /><span class = "help"><?php // echo $entry_use_fax_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[4]" value="y" <?php echo $pp_use[4] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[4]" value="Y" <?php echo $pp_use[4] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[4]" value="n" <?php echo $pp_use[4] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_mail; ?><br /><span class = "help"><?php // echo $entry_use_mail_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[5]" value="y" <?php echo $pp_use[5] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[5]" value="Y" <?php echo $pp_use[5] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[5]" value="n" <?php echo $pp_use[5] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_id; ?><br /><span class = "help"><?php echo $entry_use_id_description; ?></span></td>
					<td>
					<?php echo $yes; ?>&nbsp;<input type="radio" name="pp_use[6]" value="y" <?php echo $pp_use[6] == 'y' ? 'checked="checked"' : ''; ?> />
					<?php echo $yes_nl; ?>&nbsp;<input type="radio" name="pp_use[6]" value="Y" <?php echo $pp_use[6] == 'Y' ? 'checked="checked"' : ''; ?> />
					<?php echo $no; ?>&nbsp;<input type="radio" name="pp_use[6]" value="n" <?php echo $pp_use[6] == 'n' ? 'checked="checked"' : ''; ?> />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_my_text; ?><br /><span class = "help"><?php echo $entry_my_text_description; ?></span></td>
					<td>
					<textarea name="pp_text" rows="8" cols="100"><?php echo $pp_text; ?></textarea>
					</td>
				</tr>
			</table>
			</form>
		</div> <!-- end of .content -->
		
	</div><!-- end of .box -->

</div> <!-- end of #content -->

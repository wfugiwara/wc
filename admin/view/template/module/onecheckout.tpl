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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_style; ?></td>
            <td>
			<?php if ($onecheckout_style==1) { ?>
		  	<label><input type="radio" name="onecheckout_style" value="1" checked="checked" />&nbsp;<?php echo $text_one_column; ?></label>
			<?php } else { ?>
			<label><input type="radio" name="onecheckout_style" value="1" />&nbsp;<?php echo $text_one_column; ?></label>
			<?php } ?>
			<?php if ($onecheckout_style==2) { ?>
  			<label><input type="radio" name="onecheckout_style" value="2" checked="checked" />&nbsp;<?php echo $text_two_column; ?></label>
			<?php } else { ?>
			<label><input type="radio" name="onecheckout_style" value="2" />&nbsp;<?php echo $text_two_column; ?></label>
			<?php } ?>
			<?php if ($onecheckout_style==3 || !$onecheckout_style) { ?>
  			<label><input type="radio" name="onecheckout_style" value="3" checked="checked" />&nbsp;<?php echo $text_three_column; ?></label>
			<?php } else { ?>
			<label><input type="radio" name="onecheckout_style" value="3" />&nbsp;<?php echo $text_three_column; ?></label>
			<?php } ?>
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_check_register; ?></td>
            <td><select name="onecheckout_check_register">
                <?php if ($onecheckout_check_register) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>		  
		  <tr>
            <td><?php echo $entry_refresh_city; ?></td>
            <td><select name="onecheckout_refresh_city">
                <?php if ($onecheckout_refresh_city) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_refresh_postcode; ?></td>
            <td><select name="onecheckout_refresh_postcode">
                <?php if ($onecheckout_refresh_postcode) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_refresh_payment; ?></td>
            <td><select name="onecheckout_refresh_payment">
                <?php if ($onecheckout_refresh_payment) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_check_newsletter; ?></td>
            <td><select name="onecheckout_check_newsletter">
                <?php if ($onecheckout_check_newsletter) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_check_deliveryaddress; ?></td>
            <td><select name="onecheckout_check_deliveryaddress">
                <?php if ($onecheckout_check_deliveryaddress) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="onecheckout_status">
                <?php if ($onecheckout_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
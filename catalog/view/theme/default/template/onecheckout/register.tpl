<div id="reg-cpanle" class="divclear">
  <div class="left">
  	<span class="required">*</span> <?php echo $entry_password; ?><br />
  	<input type="password" name="password" value="" class="small-field" /><br />
  </div>
  <div class="right">
  	<span class="required">*</span> <?php echo $entry_confirm; ?> <br />
  	<input type="password" name="confirm" value="" class="small-field" /><br />
  </div>
  <div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;">
  <input type="checkbox" name="newsletter" value="1" id="newsletter"<?php if ($this->config->get('onecheckout_check_newsletter')) { ?> checked="checked"<?php } ?> />
  <label for="newsletter"><?php echo $entry_newsletter; ?></label>
  <br />
  <?php if ($shipping_required) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping"<?php if ($this->config->get('onecheckout_check_deliveryaddress')) { ?> checked="checked"<?php } ?> />
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <?php } else { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" style="display:none;" />
  <?php } ?>
  <br />
  </div>
<?php if ($text_agree) { ?>
<div class="buttons">  
    <input type="checkbox" name="agree" value="1" /><?php echo $text_agree; ?>
</div>
<?php } ?>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});

$('#payment-address input[name=\'password\']').live('blur', function() {
	valiform("payment","password","");
});

$('#payment-address input[name=\'password\']').live('focus', function() {
	errorremove("payment","password");
});

$('#payment-address input[name=\'confirm\']').live('blur', function() {
	valiform("payment","confirm",", #payment-address input[name=\'password\']");
});

$('#payment-address input[name=\'confirm\']').live('focus', function() {
	errorremove("payment","confirm");
});
//--></script> 
</div>
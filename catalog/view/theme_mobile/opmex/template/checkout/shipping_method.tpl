<div id="checkout-shipping_method">
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<fieldset data-role="controlgroup">
<p><?php echo $text_shipping_method; ?></p>
  <?php foreach ($shipping_methods as $shipping_method) { ?>
	  
  <?php if (!$shipping_method['error']) { ?>
 
  <?php foreach ($shipping_method['quote'] as $quote) { ?>
  	<?php if ($quote['code'] == $code || !$code) { ?>
      <?php $code = $quote['code']; ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked"  data-theme="a"/>
      <?php } else { ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>"  data-theme="a"/>
      <?php } ?>
    <label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
  <?php } ?>
  <?php } else { ?>
  <div class="error"><?php echo $shipping_method['error']; ?></div>
   <?php } ?>
  <?php } ?>
</fieldset>
<br />
<?php } ?>
<b><?php echo $text_comments; ?></b>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>
<br />
<input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-method" class="button" data-theme="a" />
</div>
<script type="text/javascript"><!--
$('#checkout-shipping_method').page();
//--></script> 
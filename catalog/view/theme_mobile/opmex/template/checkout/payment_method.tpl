<div id="checkout-payment_method">
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<fieldset data-role="controlgroup">
<legend><?php echo $text_payment_method; ?></legend>
<?php foreach ($payment_methods as $payment_method) { ?>
	<?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" data-theme="a" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" data-theme="a" />
      <?php } ?>
    <label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label>
	<?php } ?>
<?php } ?>
</fieldset>
<b><?php echo $text_comments; ?></b>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>
<br />
<br />
<?php if ($text_agree) { ?>
<fieldset data-role="controlgroup">
	<legend id="text_agree"><?php echo $text_agree; ?></legend>
    <?php if ($agree) { ?>
    <input type="checkbox" name="agree" value="1" checked="checked" id="agree" data-theme="a"/>
    <?php } else { ?>
    <input type="checkbox" name="agree" value="1" id="agree" data-theme="a" />
    <?php } ?>
    <label for="agree"><?php echo $text_i_agree; ?></label>
</fieldset>
<input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" data-theme="a" />
<?php } else { ?>
<input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" data-theme="a" />
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#text_agree a').removeAttr('href');
$('#text_agree a').removeAttr('class');
$('#text_agree a').attr("href","#agree_page");
$('#checkout-payment_method').page();
$('.fancybox').fancybox({
	width: 640,
	height: 480,
	autoDimensions: false
});
//--></script> 

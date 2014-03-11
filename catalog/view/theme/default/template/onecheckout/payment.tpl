<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><?php echo $text_payment_method; ?></p>
<table class="form">
  <?php foreach ($payment_methods as $payment_method) { ?>
  <tr>
    <td style="width: 1px;"><?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
  </tr>
  <?php } ?>
</table>
<?php } ?>
<h2 style="border-bottom:1px #000000 solid; padding-bottom:6px;font-family: Arial, Helvetica, sans-serif;font-weight: bold;font-size: 16px;color: #000000;"><?php echo $text_checkout_comment; ?></h2>
<p style="padding-top:10px;"><?php echo $text_comments; ?></p>
<textarea name="comment" rows="8" style="width: 90%;"><?php echo $comment; ?></textarea>
<br />
<script type="text/javascript"><!--
$('#payment-method textarea[name=\'comment\']').live('blur', function() {
	jQuery.post('index.php?route=onecheckout/payment/savecomment',$('#payment-method textarea[name=\'comment\']'));
});
//--></script> 
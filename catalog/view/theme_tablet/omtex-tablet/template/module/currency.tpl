<?php if (count($currencies) > 1) { ?>
<li>
<form id="currency_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
<div id="currency"><?php echo $text_currency; ?>&nbsp;&nbsp;
    <select onchange="currency_form_submit(this.value);" >
   <?php foreach ($currencies as $currency) { ?>
   <?php if ($currency['symbol_left']) { ?>
        <option value="<?php echo $currency['code'];?>" <?php if($currency_code == $currency['code']){ ?> selected="selected" <?php } ?>><?php echo $currency['symbol_left']; ?> </option>
        <?php } else if($currency['symbol_right']) {?>
         <option value="<?php echo $currency['code'];?>" <?php if($currency_code == $currency['code']){ ?> selected="selected" <?php } ?>><?php echo $currency['symbol_right']; ?> </option>
         <?php } }?>
      </select>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </div>
</form>
</li>
<?php } ?>
<script type="text/javascript">
function currency_form_submit(currency){
	$('input[name=\'currency_code\']').attr('value', currency);
	document.forms["currency_form"].submit();
}
</script>
<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
<h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
   <!-- <h2><?php echo $text_your_payment; ?></h2>-->
 	<?php echo $entry_tax; ?>
    <input type="text" name="tax" value="<?php echo $tax; ?>" />
       <fieldset data-role="controlgroup">
       <legend><?php echo $entry_payment; ?></legend>
    		  <?php if ($payment == 'cheque') { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" checked="checked"  data-theme="a"/>
              <?php } else { ?>
              <input type="radio" name="payment" value="cheque" id="cheque"  data-theme="a"/>
              <?php } ?>
              <label for="cheque"><?php echo $text_cheque; ?></label>
              <?php if ($payment == 'paypal') { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" checked="checked"  data-theme="a"/>
              <?php } else { ?>
              <input type="radio" name="payment" value="paypal" id="paypal"  data-theme="a"/>
              <?php } ?>
              <label for="paypal"><?php echo $text_paypal; ?></label>
              <?php if ($payment == 'bank') { ?>
              <input type="radio" name="payment" value="bank" id="bank" checked="checked"  data-theme="a"/>
              <?php } else { ?>
              <input type="radio" name="payment" value="bank" id="bank"  data-theme="a"/>
              <?php } ?>
              <label for="bank"><?php echo $text_bank; ?></label>
     	</fieldset>	  	
     <div class="payment" id="payment-cheque">
     <?php echo $entry_cheque; ?><br/>
     <input type="text" name="cheque" value="<?php echo $cheque; ?>" /><br />
     </div>
     <div class="payment" id="payment-paypal">
     <?php echo $entry_paypal; ?><br/>
     <input type="text" name="paypal" value="<?php echo $paypal; ?>" /><br />
     <?php echo $entry_bank_name; ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     </div>
     <div class="payment" id="payment-bank">
     <?php echo $entry_bank_name; ?><br/>
     <input type="text" name="bank_name" value="<?php echo $bank_name; ?>" /><br />
     <?php echo $entry_bank_branch_number; ?>
     <input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" /><br />
     <?php echo $entry_bank_swift_code; ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" /><br />
     <?php echo $entry_bank_account_name; ?>&nbsp;&nbsp;
     <input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" /><br />
     <?php echo $entry_bank_account_number; ?>
     <input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" /><br />
     </div>
<br/><br/><a href="<?php echo $back; ?>" class="button" rel="external" data-inline="true" data-role="button"  data-theme="a"><?php echo $button_back; ?></a>
<input type="submit" value="<?php echo $button_continue; ?>" data-theme="a" data-inline="true" class="button" />
</form>

</div> 
<?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	if ($('#cheque:checked').val() == 'cheque') {	       
	$('#payment-cheque').show();
	}
	if ($('#paypal:checked').val() == 'paypal') {	       
	$('#payment-paypal').show();
	}
	if ($('#bank:checked').val() == 'bank') {	       
	$('#payment-bank').show();
	}
	//$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 
<?php echo $footer; ?> 
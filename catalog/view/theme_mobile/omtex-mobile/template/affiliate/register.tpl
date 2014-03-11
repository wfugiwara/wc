</style>
<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<ul id="breadcrumbs-one">
    <?php 
    $total = count($breadcrumbs); 
    $i=0;
    foreach ($breadcrumbs as $breadcrumb) { 
        $i++;
        if($i==$total)
        {
    ?>
        <li><a class="current"><?php echo $breadcrumb['text']; ?></a></li>
    <?php 
        }else{
    ?>
      	<li><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a></li>
      <?php }
      } ?>
</ul>

<?php echo $content_top; ?>
<div data-role="content">
<h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <p><?php echo $text_account_already; ?></p>
  <p><?php echo $text_signup; ?></p>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
    <input type="text" name="firstname" <?php if ($firstname) { ?> value="<?php echo $firstname; ?>" <?php } ?> data-theme="c" placeholder="*<?php echo $entry_firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <div class="error"><?php echo $error_firstname; ?></div>
            <?php } ?>
      <input type="text" name="lastname" <?php if ($lastname) { ?> value="<?php echo $lastname; ?>" <?php } ?> placeholder="*<?php echo $entry_lastname; ?>"/>
            <?php if ($error_lastname) { ?>
            <div class="error"><?php echo $error_lastname; ?></div>
            <?php } ?>
      <input type="email" name="email" <?php if ($email) { ?> value="<?php echo $email; ?>" <?php } ?> placeholder="*<?php echo $entry_email; ?>" />
            <?php if ($error_email) { ?>
            <div class="error"><?php echo $error_email; ?></div>
            <?php } ?>
      <input type="tel" name="telephone" <?php if ($telephone) { ?> value="<?php echo $telephone; ?>"  <?php } ?> placeholder="*<?php echo $entry_telephone; ?>"/>
            <?php if ($error_telephone) { ?>
            <div class="error"><?php echo $error_telephone; ?></div>
            <?php } ?>
            
      <input type="tel" name="fax" <?php if ($fax) { ?> value="<?php echo $fax; ?>" <?php } ?> placeholder="<?php echo $entry_fax; ?>"/>
      
    <h2 style="margin:5px;"><?php echo $text_your_address; ?> </h2>
      <input type="text" name="company" <?php if ($company) { ?> value="<?php echo $company; ?>" <?php } ?> placeholder="<?php echo $entry_company; ?>" />
      
        <input type="url" name="website" <?php if ($website) { ?> value="<?php echo $website; ?>" <?php } ?> placeholder="<?php echo $entry_website; ?>" />
        <input type="text" name="address_1" <?php if ($address_1) { ?> value="<?php echo $address_1; ?>" <?php } ?>placeholder="*<?php echo $entry_address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <div class="error"><?php echo $error_address_1; ?></div>
            <?php } ?>
      <input type="text" name="address_2" <?php if ($address_2) { ?> value="<?php echo $address_2; ?>" <?php } ?> placeholder="<?php echo $entry_address_2; ?>" />
      <input type="text" name="city" <?php if ($city) { ?> value="<?php echo $city; ?>" <?php } ?> placeholder="*<?php echo $entry_city; ?>"/>
            <?php if ($error_city) { ?>
            <div class="error"><?php echo $error_city; ?></div>
            <?php } ?>
             
      <input type="text" name="postcode" <?php if ($postcode) { ?> value="<?php echo $postcode; ?>" <?php } ?>placeholder="<?php echo $entry_postcode; ?>"/><span id="postcode-required"  class="required">*</span>
            <?php if ($error_postcode) { ?>
            <div class="error"><?php echo $error_postcode; ?></div>
            <?php } ?><br />
             <span class="required">*</span> <?php echo $entry_country; ?>
         <select name="country_id"  data-native-menu="true">
              <option value="false"><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <div class="error"><?php echo $error_country; ?></div>
            <?php } ?><br />
          <span class="required">*</span> <?php echo $entry_zone; ?>
          <select name="zone_id" data-native-menu="true">
          <option value=""><?php echo $text_select; ?></option>
            </select>
            <?php if ($error_zone) { ?>
            <div class="error"><?php echo $error_zone; ?></div>
            <?php } ?>
    <h2><?php echo $text_payment; ?></h2>
    	<?php echo $entry_tax; ?>
        <input type="text" name="tax" <?php if ($postcode) { ?>  value="<?php echo $tax; ?>" <?php } ?> placeholder="<?php echo $tax; ?>" />
        <fieldset data-role="controlgroup">
       <legend><?php echo $entry_payment; ?></legend>
        	   <?php if ($payment == 'cheque') { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" />
              <?php } ?>
              <label for="cheque"><?php echo $text_cheque; ?></label>
              <?php if ($payment == 'paypal') { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" />
              <?php } ?>
              <label for="paypal"><?php echo $text_paypal; ?></label>
              <?php if ($payment == 'bank') { ?>
              <input type="radio" name="payment" value="bank" id="bank" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="bank" id="bank" />
              <?php } ?>
              <label for="bank"><?php echo $text_bank; ?></label>
        	</fieldset>
       <div class="form">
        <div class="payment" id="payment-cheque">
            <input type="text" name="cheque"  <?php if ($cheque) { ?> value="<?php echo $cheque; ?>" <?php } ?>  placeholder="<?php echo $entry_cheque; ?>"/>
        </div>
        <div class="payment" id="payment-paypal">
            <input type="text" name="paypal"  <?php if ($paypal) { ?> value="<?php echo $paypal; ?>" <?php } ?>   placeholder="<?php echo $entry_paypal; ?>"/>
        </div>
        <div class="payment" id="payment-bank">
            <input type="text" name="bank_name"  <?php if ($bank_name) { ?> value="<?php echo $bank_name; ?>"  <?php } ?>  placeholder="<?php echo $entry_bank_name; ?>" />
            <input type="text" name="bank_branch_number"  <?php if ($bank_branch_number) { ?> value="<?php echo $bank_branch_number; ?>" <?php } ?>   placeholder="<?php echo $entry_bank_branch_number; ?>"/>
            <input type="text" name="bank_swift_code"  <?php if ($bank_swift_code) { ?> value="<?php echo $bank_swift_code; ?>"  <?php } ?>  placeholder="<?php echo $entry_bank_swift_code; ?>"/>
            <input type="text" name="bank_account_name"  <?php if ($bank_account_name) { ?> value="<?php echo $bank_account_name; ?>" <?php } ?>   placeholder="<?php echo $entry_bank_account_name; ?>" />
            <input type="text" name="bank_account_number"  <?php if ($bank_account_number) { ?> value="<?php echo $bank_account_number; ?>"  <?php } ?>  placeholder="<?php echo $entry_bank_account_number; ?>"/>
        </div>
        </div>  
       <h2><?php echo $text_your_password; ?></h2>
  			<input type="password" name="password"  <?php if ($password) { ?> value="<?php echo $password; ?>"  <?php } ?>  placeholder="*<?php echo $entry_password; ?>"/>
            <?php if ($error_password) { ?>
            <div class="error"><?php echo $error_password; ?></div>
            <?php } ?>
        <input type="password" name="confirm"  <?php if ($confirm) { ?> value="<?php echo $confirm; ?>" <?php } ?>   placeholder="*<?php echo $entry_confirm; ?>"/>
            <?php if ($error_confirm) { ?>
            <div class="error"><?php echo $error_confirm; ?></div>
            <?php } ?>
    <?php if ($text_agree) { ?>
    <fieldset data-role="controlgroup">
	   <legend id="text_agree"><?php echo $text_agree; ?></legend>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" for="agree" />
        <label for="agree"><div id="text_i_agree"></div></label>
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" id="agree" />
        <label for="agree"><div id="text_i_agree"></div></label>
        <?php } ?>
        </fieldset>
        <input type="submit" value="<?php echo $button_continue; ?>" data-theme="a" class="button" />
    <?php } else { ?>
        <input type="submit" value="<?php echo $button_continue; ?>" data-theme="a" class="button" />
    <?php } ?></div>
  </form>
</div>  
<?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=affiliate/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');

//--></script> 
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
	//$('#payment-' + this.value ).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 640,
	height: 480,
	autoDimensions: false
});
//--></script>  
<?php echo $footer; ?>

<script type="text/javascript">
<?php $config_affiliate_id=$this->config->get('config_affiliate_id'); ?>
$('#text_agree a').removeAttr('href');
$('#text_agree a').removeAttr('class');
$('#text_agree a').attr("href","#agree_page");
$('#agree_page_text').load('index.php?route=information/information/info&information_id=<?php echo $config_affiliate_id; ?>');
</script>
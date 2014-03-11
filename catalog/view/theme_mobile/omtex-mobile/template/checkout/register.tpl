<div id="checkout-register">
<h2><?php echo $text_your_details; ?></h2>
<?php echo $entry_firstname; ?><span class="required">*</span><br />
<input type="text" name="firstname" value="" class="large-field" /><br />
<?php echo $entry_lastname; ?><span class="required">*</span><br />
<input type="text" name="lastname" value="" class="large-field" /><br />
<?php echo $entry_email; ?><span class="required">*</span><br />
<input type="text" name="email" value="" class="large-field" /><br />
<?php echo $entry_telephone; ?><span class="required">*</span><br />
<input type="text" name="telephone" value="" class="large-field" /><br />
<?php echo $entry_fax; ?><br />
<input type="text" name="fax" value="" class="large-field" /><br />
<h2><?php echo $text_your_password; ?><span class="required">*</span><br /></h2>
<input type="password" name="password" value="" class="large-field" placeholder="<?php echo $entry_password; ?>" /><br />
<input type="password" name="confirm" value="" class="large-field" placeholder="<?php echo $entry_confirm; ?>" /><br />
<h2><?php echo $text_your_address; ?></h2>
<?php echo $entry_company; ?><br />
<input type="text" name="company" value="" class="large-field" /><br />

<div style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
         <?php echo $entry_customer_group; ?><br />
         <?php foreach ($customer_groups as $customer_group) { ?>
            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />

            <?php } else { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />

            <?php } ?>
            <?php } ?>
        </div>
        
  <div id="company-id-display">
   <?php echo $entry_company_id; ?><span id="company-id-required" class="required">*</span><br />
    <input type="text" name="company_id" value="" class="large-field" />
  </div>

  <div id="tax-id-display">
   <?php echo $entry_tax_id; ?><span id="tax-id-required" class="required">*</span><br />
    <input type="text" name="tax_id" value="" class="large-field" />
  </div>


<?php echo $entry_address_1; ?><span class="required">*</span><br />
<input type="text" name="address_1" value="" class="large-field" /><br />
<?php echo $entry_address_2; ?><br />
<input type="text" name="address_2" value="" class="large-field" /><br />
<?php echo $entry_city; ?><span class="required">*</span><br />
<input type="text" name="city" value="" class="large-field" /><br />
<?php echo $entry_postcode; ?><span class="required" id="payment-postcode-required" >*</span><br />
<input type="text" name="postcode" value="" class="large-field" /><br />
<?php echo $entry_country; ?><span class="required">*</span>
<select name="country_id" class="large-field" data-native-menu="true">
    <option value=""><?php echo $text_select; ?></option>
    <?php foreach ($countries as $country) { ?>
    <?php if ($country['country_id'] == $country_id) { ?>
    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
    <?php } ?>
    <?php } ?>
  </select><br />
<?php echo $entry_zone; ?><span class="required">*</span>
<select name="zone_id" class="large-field" data-native-menu="true">
<option value=""><?php echo $text_select; ?></option>
</select><br />
<input type="checkbox" name="newsletter" value="1" id="newsletter" />
<label for="newsletter"><?php echo $entry_newsletter; ?></label>
<?php if ($shipping_required) { ?>
<input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
<label for="shipping"><?php echo $entry_shipping; ?></label>
<?php } ?>
<?php if ($text_agree) { ?>
<legend id="text_agree"><?php echo $text_agree; ?></legend>
<input type="checkbox" name="agree" value="1" id="agree"/>
<label for="agree"><?php echo $text_i_agree; ?></label>
<input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" data-theme="a" />
<?php } else { ?>
<input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" data-theme="a" />
<?php } ?>
</div>
<script type="text/javascript"><!--
$('#text_agree a').removeAttr('href');
$('#text_agree a').removeAttr('class');
$('#text_agree a').attr("href","#privacy_page");
$('#checkout-register').page();
$('#payment-address select[name=\'customer_group_id\']').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('#payment-address select[name=\'customer_group_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('#payment-address select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
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
			
			$('#payment-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#payment-address select[name=\'country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 640,
	height: 480,
	autoDimensions: false
});
//--></script>  
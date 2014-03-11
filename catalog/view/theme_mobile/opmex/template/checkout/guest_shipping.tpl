<div id="checkout-guest_shipping" class="form">
<?php echo $entry_firstname; ?><span class="required">*</span><br/>
<input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" /><br />
<?php echo $entry_lastname; ?><span class="required">*</span><br />
<input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" /><br />
<?php echo $entry_company; ?><br/>
<input type="text" name="company" value="<?php echo $company; ?>" class="large-field" /><br/>
<?php echo $entry_address_1; ?><span class="required">*</span><br/>
<input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" /><br />
<?php echo $entry_address_2; ?><br/>
<input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" /><br/>
<?php echo $entry_city; ?><span class="required">*</span><br/>
<input type="text" name="city" value="<?php echo $city; ?>" class="large-field" /><br />
<?php echo $entry_postcode; ?><span id="shipping-postcode-required" class="required">*</span><br/>
<input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" /><br />
<?php echo $entry_country; ?><span class="required">*</span>
<select name="country_id" class="large-field" onchange="refresh_zone();" data-native-menu="true" data-theme="a">
   <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($countries as $country) { ?>
        <?php if ($country['country_id'] == $country_id) { ?>
        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
        <?php } ?>
      </select><br />
<div id="shipping_zone_id">
  <?php echo $entry_zone; ?><span class="required">*</span>
<select name="zone_id" class="large-field" data-native-menu="true" data-theme="a">
   <option value=""><?php echo $text_select; ?></option>
      </select><br />    
</div>
<!--<?php echo $entry_zone; ?><span class="required">*</span>
<select name="zone_id" class="large-field" data-native-menu="true">
</select>-->
<br />
<input type="button" value="<?php echo $button_continue; ?>" id="button-guest-shipping" class="button" data-theme="a" />
</div>
<script type="text/javascript"><!--

$('#shipping-address select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
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
			
			$('#shipping-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#shipping-address select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$('#checkout-guest_shipping').page();
function refresh_zone(){
$('#shipping_zone_id span.ui-btn-text').html('<?php echo $text_select; ?>');
$('#shipping-address select[name=\'zone_id\']').empty();
//alert('Remove');
}
//--></script> 
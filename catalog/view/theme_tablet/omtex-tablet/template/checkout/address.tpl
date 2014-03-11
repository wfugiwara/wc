<style type="text/css">
#<?php echo $type; ?>-existing .ui-select .ui-btn-text, .ui-selectmenu .ui-btn-text  {
    display: block;
}
</style>
<div class="checkout-address">
<?php if ($addresses) { ?>
<input type="radio" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" checked="checked" />
<label for="<?php echo $type; ?>-address-existing"><?php echo $text_address_existing; ?></label>
<div id="<?php echo $type; ?>-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>

<?php } ?>
<p>
<input type="radio" name="<?php echo $type; ?>_address" value="new" id="<?php echo $type; ?>-address-new" />
<label for="<?php echo $type; ?>-address-new"><?php echo $text_address_new; ?></label>
</p>
<div id="<?php echo $type; ?>-new" style="display: none;">
<?php echo $entry_firstname; ?><span class="required">*</span><br />
<input type="text" name="firstname" value="" class="large-field" /><br />
<?php echo $entry_lastname; ?><span class="required">*</span><br />
<input type="text" name="lastname" value="" class="large-field" /><br />
<?php echo $entry_company; ?><br />
<input type="text" name="company" value="" class="large-field" /><br />
<?php echo $entry_address_1; ?><span class="required">*</span><br />
<input type="text" name="address_1" value="" class="large-field" /><br />
<?php echo $entry_address_2; ?><br />
<input type="text" name="address_2" value="" class="large-field" /><br />
<?php echo $entry_city; ?><span class="required">*</span><br />
<input type="text" name="city" value="" class="large-field" /><br />
<?php echo $entry_postcode; ?><span class="required">*</span><br />
<input type="text" name="postcode" value="" class="large-field" /><br />
<?php echo $entry_country; ?><span class="required">*</span>
<select name="country_id" class="large-field" onchange="$('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=' + this.value);" data-native-menu="true">
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
</div>
<a id="button-address" rel="external" data-role="button" data-theme="a"><?php echo $button_continue; ?></a>
</div>
<script type="text/javascript"><!--
$('.checkout-address').page();

$('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');

$('#<?php echo $type; ?>-address input[name=\'<?php echo $type; ?>_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#<?php echo $type; ?>-new').hide();
		$('#<?php echo $type; ?>-existing').show();
	} else {
		$('#<?php echo $type; ?>-new').show();
		$('#<?php echo $type; ?>-existing').hide();
	}
});
//--></script> 
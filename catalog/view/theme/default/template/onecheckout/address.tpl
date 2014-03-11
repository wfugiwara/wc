<script>
	
		$("input[name='postcode'] ").mask("99999-999");
	
		$('input[name="postcode"]').blur(function(){
			if ($('input[name="postcode"]').val().length != 0 ) {
				cep = $.trim($('input[name="postcode"]').val().replace('-', ''));
				$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
					if(resultadoCEP["resultado"] == "1"){
						$('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
						$('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
						$('input[name="city"]').val(unescape(resultadoCEP["cidade"]));
						$('select[name=\'zone_id\']').load('index.php?route=account/cadastro/estado_autocompletar&estado='+unescape(resultadoCEP["uf"]));			
					}else{
						alert("Endereço do cep não encontrado. Digite o endereço manualmente!");
					}
				});
			}	
		});

</script>
<?php if ($addresses) { ?>
<input type="radio" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" checked="checked" />
<label for="<?php echo $type; ?>-address-existing"><?php echo $text_address_existing; ?></label>
<div id="<?php echo $type; ?>-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
	<?php print_r($addresses); ?>
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['numero']; ?> <?php echo $address['complemento']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?> <?php echo $address['numero']; ?> <?php echo $address['complemento']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<p>
  <input type="radio" name="<?php echo $type; ?>_address" value="new" id="<?php echo $type; ?>-address-new" />
  <label for="<?php echo $type; ?>-address-new"><?php echo $text_address_new; ?></label>
</p>
<?php } ?>
<div id="<?php echo $type; ?>-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
  <table class="form">
    <tr>
      <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
      <td><input type="text" name="firstname" value="" class="large-field" /><br /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
      <td><input type="text" name="lastname" value="" class="large-field" /><br /></td>
    </tr>
	
    
	<?php if($version_int >= 1530 && $type == 'payment') { ?>
	<tr style="display: <?php echo ($company_id_display ? 'table-row' : 'none'); ?>;">
      <td><span style="display: <?php echo ($company_id_required ? 'inline' : 'none'); ?>;" class="required">*</span> <?php echo $entry_company_id; ?></td>
      <td><input type="text" name="company_id" value="" class="large-field" /><br /></td>
    </tr>
    <tr style="display: <?php echo ($tax_id_display ? 'table-row' : 'none'); ?>;">
      <td><span style="display: <?php echo ($tax_id_required ? 'inline' : 'none'); ?>;" class="required">*</span> <?php echo $entry_tax_id; ?></td>
      <td><input type="text" name="tax_id" value="" class="large-field" /><br /></td>
    </tr>
	<?php } ?>

	<tr>
      <td><span id="<?php echo $type; ?>-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
      <td><input type="text" name="postcode" value="" class="large-field" /><br /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> Endereço</td>
      <td><input type="text" name="address_1" value="" class="large-field" /><br /></td>
    </tr>
	<tr>
	  <td><span class="required">*</span> Número:</td>
	  <td>
	  <input type="text" name="numero" value="" /><br />
		
	  </td>
	</tr>
	
	<tr>
	  <td>Complemento: </td>
	  <td>
	  <input type="text" name="complemento" value="" />
	  </td>
	</tr> 
	
    <tr>
      <td><?php echo $entry_address_2; ?></td>
      <td><input type="text" name="address_2" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_city; ?></td>
      <td><input type="text" name="city" value="" class="large-field" /><br /></td>
    </tr>
    
    <tr>
      <td><span class="required">*</span> <?php echo $entry_country; ?></td>
      <td><select name="country_id" class="large-field">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($countries as $country) { ?>
          <?php if ($country['country_id'] == $country_id) { ?>
          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
          <?php } ?>
          <?php } ?>
        </select><br /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
      <td><select name="zone_id" class="large-field">
        </select><br /></td>
    </tr>
	<tr>
      <td>Referência</td>
      <td><input type="text" name="company" value="" class="large-field" /></td>
    </tr>
  </table>
</div>
<br />
<script type="text/javascript"><!--
$('#<?php echo $type; ?>-address select[name=\'country_id\']').bind('change', function() {
	getzone('<?php echo $type; ?>','<?php echo $zone_id; ?>');
});

getzone('<?php echo $type; ?>','<?php echo $zone_id; ?>');

$('#<?php echo $type; ?>-address select[name=\'address_id\']').live('change', function() {
		<?php echo $type; ?>methodid($('#<?php echo $type; ?>-address select[name=\'address_id\']').val());
});

$('#<?php echo $type; ?>-address select[name=\'zone_id\']').live('change', function() {
		<?php echo $type; ?>method($('#<?php echo $type; ?>-address select[name=\'country_id\']').val(), $('#<?php echo $type; ?>-address select[name=\'zone_id\']').val(), 1 , $('#<?php echo $type; ?>-address input[name=\'city\']').val(),$('#<?php echo $type; ?>-address input[name=\'postcode\']').val());
});

$('#<?php echo $type; ?>-address input[name=\'<?php echo $type; ?>_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#<?php echo $type; ?>-existing').hide();
		$('#<?php echo $type; ?>-new').show();
		<?php echo $type; ?>method($('#<?php echo $type; ?>-address select[name=\'country_id\']').val(), $('#<?php echo $type; ?>-address select[name=\'zone_id\']').val(), 1 , $('#<?php echo $type; ?>-address input[name=\'city\']').val(),$('#<?php echo $type; ?>-address input[name=\'postcode\']').val());
	} else {
		$('#<?php echo $type; ?>-existing').show();
		$('#<?php echo $type; ?>-new').hide();
		<?php echo $type; ?>methodid($('#<?php echo $type; ?>-address select[name=\'address_id\']').val());
		if($('#<?php echo $type; ?>-address .onecheckout-content .error'))
		  $('#<?php echo $type; ?>-address .onecheckout-content .error').remove();
	}
});

$('#<?php echo $type; ?>-address input[name=\'firstname\']').live('blur', function() {
	valiform<?php echo $type; ?>("firstname","");
});

$('#<?php echo $type; ?>-address input[name=\'firstname\']').live('focus', function() {
	errorremove<?php echo $type; ?>("firstname");
});

$('#<?php echo $type; ?>-address input[name=\'numero\']').live('blur', function() {
	valiform<?php echo $type; ?>("numero","");
});

$('#<?php echo $type; ?>-address input[name=\'numero\']').live('focus', function() {
	errorremove<?php echo $type; ?>("numero");
});

$('#<?php echo $type; ?>-address input[name=\'lastname\']').live('blur', function() {
	valiform<?php echo $type; ?>("lastname","");
});

$('#<?php echo $type; ?>-address input[name=\'lastname\']').live('focus', function() {
	errorremove<?php echo $type; ?>("lastname");
});

$('#<?php echo $type; ?>-address input[name=\'company\']').live('blur', function() {
	valiform<?php echo $type; ?>("company","");
});
<?php if($version_int >= 1530 && $type == 'payment') { ?>
$('#payment-address input[name=\'company_id\']').live('blur', function() {
	valiformpayment("company_id","");
});

$('#payment-address input[name=\'company_id\']').live('focus', function() {
	errorremovepayment("company_id");
});

$('#payment-address input[name=\'tax_id\']').live('blur', function() {
	valiformpayment("tax_id",", #payment-address select");
});

$('#payment-address input[name=\'tax_id\']').live('focus', function() {
	errorremovepayment("tax_id");
});
<?php } ?>
$('#<?php echo $type; ?>-address input[name=\'address_1\']').live('blur', function() {
	valiform<?php echo $type; ?>("address_1","");
});

$('#<?php echo $type; ?>-address input[name=\'address_1\']').live('focus', function() {
	errorremove<?php echo $type; ?>("address_1");
});

$('#<?php echo $type; ?>-address input[name=\'city\']').live('blur', function() {
	valiform<?php echo $type; ?>("city","");
<?php if($this->config->get('onecheckout_refresh_city')){ ?>
	<?php echo $type; ?>method($('#<?php echo $type; ?>-address select[name=\'country_id\']').val(), $('#<?php echo $type; ?>-address select[name=\'zone_id\']').val(), 1 , $('#<?php echo $type; ?>-address input[name=\'city\']').val(),$('#<?php echo $type; ?>-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#<?php echo $type; ?>-address input[name=\'city\']').live('focus', function() {
	errorremove<?php echo $type; ?>("city");
});

$('#<?php echo $type; ?>-address input[name=\'postcode\']').live('blur', function() {
	valiform<?php echo $type; ?>("postcode",", #<?php echo $type; ?>-address select");
<?php if($this->config->get('onecheckout_refresh_postcode')){ ?>
	<?php echo $type; ?>method($('#<?php echo $type; ?>-address select[name=\'country_id\']').val(), $('#<?php echo $type; ?>-address select[name=\'zone_id\']').val(), 1 , $('#<?php echo $type; ?>-address input[name=\'city\']').val(),$('#<?php echo $type; ?>-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#<?php echo $type; ?>-address input[name=\'postcode\']').live('focus', function() {
	errorremove<?php echo $type; ?>("postcode");
});

$('#<?php echo $type; ?>-address select[name=\'zone_id\']').live('focus', function() {
	errorremove<?php echo $type; ?>("zone_id");
});

$('#<?php echo $type; ?>-address select[name=\'country_id\']').live('focus', function() {
	errorremove<?php echo $type; ?>("country_id");
});

function valiform<?php echo $type; ?>(vname, othername){
	$.ajax({
		url: 'index.php?route=onecheckout/form/validate',
		type: 'post',
		data: $('#<?php echo $type; ?>-address input[name=\''+vname+'\']'+othername),
		dataType: 'json',
		success: function(json) {						
			if (json['error'][vname]) {
				errorremove<?php echo $type; ?>(vname);
				$('#<?php echo $type; ?>-address input[name=\''+vname+'\'] + br').after('<span id="error_'+vname+'" class="error">' + json['error'][vname] + '</span>');
			}
		}
	});	
}

function errorremove<?php echo $type; ?>(vname) {
	if($('#<?php echo $type; ?>-address #error_'+vname)){
		$('#<?php echo $type; ?>-address #error_'+vname).remove();
	}
}
//--></script> 
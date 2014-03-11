<script>		  
		// mascara	
			  $("input[name='data_nascimento'] ").mask("99/99/9999");
			  $("input[name='ddd'] ").mask("(99)");
			  $("input[name='telephone'] ").mask("99999999?9",{placeholder:" "});
			  $("input[name='telephone2'] ").mask("99999999?9",{placeholder:" "}); 
			  $("input[name='ddd2'] ").mask("(99)");
			  $("input[name='postcode'] ").mask("99999-999");
			 // $("input[name='placa1'] ").mask("aaa-9999");
			 // $("input[name='placa2'] ").mask("aaa-9999");
			  $("#cpf").mask("999.999.999-99");
			  $("#cnpj").mask("99.999.999/9999-99");
			  if ($("input[name='postcode'] ").val()==""){  
				  $('#esconde_1').hide();
			  }		
	$('input[name="postcode"]').blur(function(){
		$('#esconde_1').fadeIn('slow');
		cep = $.trim($('input[name="postcode"]').val().replace('-', ''));
		$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
			if(resultadoCEP["resultado"] == "1"){
				$('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
				$('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
				$('input[name="city"]').val(unescape(resultadoCEP["cidade"]));						$('select[name=\'zone_id\']').load('index.php?route=account/register/estado_autocompletar&estado='+unescape(resultadoCEP["uf"]));			
			}else{
				alert("Endereço do cep não encontrado. Digite o endereço manualmente!");
			}
		});
	});

</script>  
  <div class="left">
  	<span class="required">*</span> <?php echo $entry_firstname; ?><br />
  	<input type="text" name="firstname" value="<?php echo $firstname; ?>" class="small-field" /><br />
  </div>
  
  
  <div class="right">
  	<span class="required">*</span> <?php echo $entry_lastname; ?><br />
  	<input type="text" name="lastname" value="<?php echo $lastname; ?>" class="small-field" /><br />
  </div>  
    <div class="divclear">
  	<br />
	
	
  	<span class="required">*</span> <?php echo $entry_email; ?><br />
  	<input type="text" name="email" value="<?php echo $email; ?>" id="email" class="large-field" />
	<br />
	<br />
	
	
	<span class="required">*</span> Confime o e-mail<br />
  	<input type="text" name="confirm_email" id="confirm-email" value="" class="large-field" />
	<br />
	<br />
		
	<script>
		// Alteração para comparar e-mail 
		$('input[name=\'confirm_email\']').blur( function() {
			if ( $("#confirm-email").val() != $("#email").val() ){
				alert('O e-mail digitado não esta igual ao digitado no campo acima.');
				$("#email").focus();
			}
			return false;
		});
		
		$('.pessoa_fisica').show();
		$('.pessoa_juridica').hide();
		$("#placa2").hide();
		/* formul?rio de cria??o de conta */
		$('#juridica').click( function() {
			$("#cpf").val("");
		    $('.pessoa_fisica').hide();
			$('.pessoa_juridica').show();
			//$("#placa2").show();
			
		});
		$('#fisica').click( function() {
			$("#cnpj").val("");
			$('.pessoa_fisica').show();
			$('.pessoa_juridica').hide();
			//$("#placa2").hide();
		});      
  </script>  
	
	<span class="required">*</span>Sexo:<br />  
	<input type="radio" name="sexo" value="m"  id="masculino"/> <label for="masculino">Masculino</label> <input type="radio" name="sexo" value="f"  id="feminino"/> <label for="feminino">Feminino </label><span id="sexo"></span>
	<br />
	<br />
	
	<span class="required">*</span> Data de Nascimento:<br />  
	<input type="text" name="data_nascimento" value="" class="large-field" />
	<br />
	<br />
	
	
	Tipo:<br />			
	<input type="radio" name="pessoa" id="fisica" checked value="fisica">
	<label for="fisica">Pessoa Física </label>
	<input type="radio" id="juridica" name="pessoa" value="juridica">
	<label for="juridica">Pessoa Juridica</label>
	<br />
	<br />
	
	
	<div class="pessoa_fisica">
		<span class="required">*</span> CPF:<br />
		<input type="text" name="cpf"  id="cpf" value=""  class="large-field" /> 
		<br />
		<br />	
	
	</div>
	
	
	<div class="pessoa_juridica">
	
		<span class="required">*</span>  CNPJ:<br />
		<input type="text" name="cnpj"  id="cnpj" value="" class="large-field" /> 
		<br />
		<br />
		
		
		<span class="required">*</span> Razão Social:<br />
		<input type="text" name="razao_social" value=""class="large-field" /> 
		<br />
		<br />
	

		Inscrição Estadual:<br />
		<input type="text" name="inscricao_estadual" value="" class="large-field" /> 
		<br />
		<br />
	</div>
	<?php 
	/*
	<div class="left">
		<span class="required">*</span> Renavam<br />
		<input type="text" name="placa1" value="<?php echo $placa1; ?>" maxlength="11" class="small-field"  /><br />
	</div>
	
	
	<div class="right" id="placa2">
		Renavam 2<br />
		<input type="text" name="placa2" value="<?php echo $placa2; ?>" maxlength="11" class="small-field" /><br />
	</div>
	*/ 
	?>
	<div class="divclear"></div>
	<br />	
	
	<span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />
	<input type="text" name="postcode" value="" class="large-field" />
	<br />
	<br />

	
    <div id="esconde_1">
	
		<span class="required">*</span> Endereço:<br />
		<input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" />
		<br />
		<br />

		
		<div class="left">
			<span class="required">*</span> Numero<br />
			<input type="text" name="numero" value=""  class="small-field" /><br />
		</div>
		
		
		<div class="right">
			Complemento:<br />
			<input type="text" name="complemento" value="" class="small-field" />
		</div>
		<br />
		<div class="divclear"></div>
		<br />
		
		
		Bairro:<br />
		<input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" />
		<br />
		<br />
		 
		 
		<span class="required">*</span> <?php echo $entry_city; ?><br />
		<input type="text" name="city" value="<?php echo $city; ?>" class="small-field" />
		<br />
		<br />

		
		<span class="required">*</span> <?php echo $entry_country; ?><br />
		<select name="country_id" class="large-field">
			<option value=""><?php echo $text_select; ?></option>
			<?php foreach ($countries as $country) { ?>
			<?php if ($country['country_id'] == $country_id) { ?>
			<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
			<?php } ?>
			<?php } ?>
		</select>
		<br />
		<br />
		
		
		<span class="required">*</span> <?php echo $entry_zone; ?><br />
		<select name="zone_id" class="large-field">
		</select>
				
    </div>
  
    <br />
  
  <div class="left">
	
  	<span class="required">*</span> <?php echo $entry_telephone; ?><br />
	<input type="text" name="ddd" size="2" maxlength="2" style="width:30px;min-width:30px;" value="<?php echo $ddd; ?>" /> 
  	<input type="text" name="telephone" maxlength="9" value="<?php echo $telephone; ?>" class="small-field" style="width:100px;" />
	<br />
  </div>
  
  
  <div class="right">
  	Celular<br />
	<input type="text" name="ddd2" size="2" maxlength="2" style="width:30px;min-width:30px;" value="<?php echo $ddd2; ?>" /> 	
    <input type="text" name="telephone2" maxlength="9" value="<?php echo $telephone2; ?>" class="small-field" style="width:100px;" /><br />
  </div>
  <br />
  <div class="divclear"></div>
  	<br />
  	<br />
	
	<?php /* campos adicionais para não erro erro em modulo externo */ ?>
	<input type="hidden" name="fax" value="" /> 
	<input type="hidden" name="company" value="" /> 
	
	
	<?php if ($guest_checkout) { ?>
	<input type="checkbox" name="account" value="1" id="account"<?php if ($this->config->get('onecheckout_check_register')) { ?> checked="checked"<?php } ?> />
	<label for="account"><?php echo $text_reg; ?></label>
	<br />
	<br />
	<?php } else { ?>
	<input type="checkbox" name="account" value="1" id="account" checked="checked" style="display:none;" />
	<?php } ?>	
  </div>
<?php if($version_int >= 1530) { ?>
<script type="text/javascript"><!--
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
<?php } ?>	
<script type="text/javascript"><!--
$('#payment-address select[name=\'country_id\']').bind('change', function() {
	getzone('payment','<?php echo $zone_id; ?>');
});
getzone('payment','<?php echo $zone_id; ?>');

$('#payment-address select[name=\'zone_id\']').live('change', function() {
	if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')){
		shippingmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());		
	}
	paymentmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());
});

$('#shipping-address select[name=\'zone_id\']').live('change', function() {
	shippingmethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());
});

$('#payment-address input[name=\'firstname\']').live('blur', function() {
	valiform("payment","firstname","");
});

$('#payment-address input[name=\'firstname\']').live('focus', function() {
	errorremove("payment","firstname");
});

$('#payment-address input[name=\'lastname\']').live('blur', function() {
	valiform("payment","lastname","");
});

$('#payment-address input[name=\'lastname\']').live('focus', function() {
	errorremove("payment","lastname");
});

$('#payment-address input[name=\'email\']').live('blur', function() {
	valiform("payment","email","");
});

$('#payment-address input[name=\'email\']').live('focus', function() {
	errorremove("payment","email");
});

$('#payment-address input[name=\'data_nascimento\']').live('blur', function() {
	valiform("payment","data_nascimento","");
});

$('#payment-address input[name=\'data_nascimento\']').live('focus', function() {
	errorremove("payment","data_nascimento");
});

$('#payment-address input[name=\'cpf\']').live('blur', function() {
	valiform("payment","cpf","");
});

$('#payment-address input[name=\'cpf\']').live('focus', function() {
	errorremove("payment","cpf");
});

$('#payment-address input[name=\'cnpj\']').live('blur', function() {
	valiform("payment","cpf","");
});

$('#payment-address input[name=\'cnpj\']').live('focus', function() {
	errorremove("payment","cpf");
});

$('#payment-address input[name=\'razao_social\']').live('blur', function() {
	valiform("payment","razao_social","");
});

$('#payment-address input[name=\'razao_social\']').live('focus', function() {
	errorremove("payment","razao_social");
});
/*
$('#payment-address input[name=\'placa1\']').live('blur', function() {
	valiform("payment","placa1","");
});

$('#payment-address input[name=\'placa1\']').live('focus', function() {
	errorremove("payment","placa1");
});
*/

$('#payment-address input[name=\'sexo\']').live('click', function() {
	valiform("payment","sexo","");
});

$('#payment-address input[name=\'sexo\']').live('click', function() {
	errorremove("payment","sexo");
});



$('#payment-address input[name=\'company_id\']').live('blur', function() {
	valiform("payment","company_id",", #payment-address select");
});

$('#payment-address input[name=\'company_id\']').live('focus', function() {
	errorremove("payment","company_id");
});

$('#payment-address input[name=\'tax_id\']').live('blur', function() {
	valiform("payment","tax_id",", #payment-address select");
});

$('#payment-address input[name=\'tax_id\']').live('focus', function() {
	errorremove("payment","tax_id");
});

$('#payment-address input[name=\'address_1\']').live('blur', function() {
	valiform("payment","address_1","");
});

$('#payment-address input[name=\'address_1\']').live('focus', function() {
	errorremove("payment","address_1");
});


$('#payment-address input[name=\'numero\']').live('blur', function() {
	valiform("payment","numero","");
});

$('#payment-address input[name=\'numero\']').live('focus', function() {
	errorremove("payment","numero");
});

$('#payment-address input[name=\'telephone\']').live('blur', function() {
	valiform("payment","telephone","");
});

$('#payment-address input[name=\'telephone\']').live('focus', function() {
	errorremove("payment","telephone");
});

$('#payment-address input[name=\'city\']').live('blur', function() {
	valiform("payment","city","");
<?php if($this->config->get('onecheckout_refresh_city')){ ?>
	if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')){
		shippingmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());		
	}
	paymentmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#payment-address input[name=\'city\']').live('focus', function() {
	errorremove("payment","city");
});

$('#payment-address input[name=\'postcode\']').live('blur', function() {
	valiform("payment","postcode",", #payment-address select");
<?php if($this->config->get('onecheckout_refresh_postcode')){ ?>
	if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')){
		shippingmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());		
	}
	paymentmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#payment-address input[name=\'postcode\']').live('focus', function() {
	errorremove("payment","postcode");
});

$('#payment-address select[name=\'zone_id\']').live('focus', function() {
	errorremove("payment","zone_id");
});

$('#payment-address select[name=\'country_id\']').live('focus', function() {
	errorremove("payment","country_id");
});

$('#shipping-address input[name=\'firstname\']').live('blur', function() {
	valiform("shipping","firstname","");
});

$('#shipping-address input[name=\'firstname\']').live('focus', function() {
	errorremove("shipping","firstname");
});

$('#shipping-address input[name=\'lastname\']').live('blur', function() {
	valiform("shipping","lastname","");
});

$('#shipping-address input[name=\'cpf\']').live('blur', function() {
	valiform("shipping","cpf","");
});

$('#shipping-address input[name=\'lastname\']').live('focus', function() {
	errorremove("shipping","lastname");
});

$('#payment-address input[name=\'company\']').live('blur', function() {
	valiform("payment","company","");
});

$('#shipping-address input[name=\'company\']').live('blur', function() {
	valiform("shipping","company","");
});


$('#shipping-address input[name=\'address_1\']').live('blur', function() {
	valiform("shipping","address_1","");
});

$('#shipping-address input[name=\'address_1\']').live('focus', function() {
	errorremove("shipping","address_1");
});

$('#shipping-address input[name=\'numero\']').live('blur', function() {
	valiform("shipping","numero","");
});

$('#shipping-address input[name=\'numero\']').live('focus', function() {
	errorremove("shipping","numero");
});



$('#shipping-address input[name=\'city\']').live('blur', function() {
	valiform("shipping","city","");
<?php if($this->config->get('onecheckout_refresh_city')){ ?>
	shippingmethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#shipping-address input[name=\'city\']').live('focus', function() {
	errorremove("shipping","city");
});

$('#shipping-address input[name=\'postcode\']').live('blur', function() {
	valiform("shipping","postcode",", #shipping-address select");
<?php if($this->config->get('onecheckout_refresh_postcode')){ ?>
	shippingmethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());
<?php } ?>
});

$('#shipping-address input[name=\'postcode\']').live('focus', function() {
	errorremove("shipping","postcode");
});

$('#shipping-address select[name=\'zone_id\']').live('focus', function() {
	errorremove("shipping","zone_id");
});

$('#shipping-address select[name=\'country_id\']').live('focus', function() {
	errorremove("shipping","country_id");
});

function valiform(layout, vname, othername){
	$.ajax({
		url: 'index.php?route=onecheckout/form/validate',
		type: 'post',
		data: $('#'+layout+'-address input[name=\''+vname+'\']'+othername),
		dataType: 'json',
		success: function(json) {						
			if (json['error'][vname]) {
				errorremove(layout, vname);
				$('#'+layout+'-address input[name=\''+vname+'\'] + br').after('<span id="error_'+vname+'" class="error">' + json['error'][vname] + '</span>');
			}
		}
	});	
}

function errorremove(layout, vname) {
	if($('#'+layout+'-address #error_'+vname)){
		$('#'+layout+'-address #error_'+vname).remove();
	}
}
//--></script> 
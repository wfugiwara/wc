<?php if ($teste) { ?>
<div class="warning"><?php echo $text_teste; ?></div>
<?php } ?>
<?php
$order_info  = $this->model_checkout_order->getOrder($this->session->data['order_id']);
$valor_total = number_format($order_info['total'],2);
$valor_total = str_replace(".","",$valor_total);
?>
<div class="checkout-heading"><?php echo $text_barra; ?> </div>
<form method="post" id="form-cielo" action="">
	<center>
	<table border="0" style="width:700px">
		<tr>
			<td>
				<div style="width:700px;text-align:center">
				<? if ($this->config->get('entry_cartao_visae') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/visae.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_visae_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="visae"  />
				</div>
				<? }?>
				<? if ($this->config->get('cielo_cartao_visa') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/visa.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_visa_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="visa"  />
				</div>
				<? }?>
				<? if ($this->config->get('cielo_cartao_mastercard') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/mastercard.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_mastercard_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="mastercard" />
				</div>
				<? }?>
				<? if ($this->config->get('cielo_cartao_diners') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/diners.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_diners_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="diners" />
				</div>
				<? }?>
				<? if ($this->config->get('cielo_cartao_discover') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/discover.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_discover_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="discover" />
				</div>
				<? }?>
				<? if ($this->config->get('cielo_cartao_elo') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="<?php echo HTTP_IMAGE;?>cielo/elo.jpg" /><br />
					<input onchange="javascript:fn_pagamento(this.value,'<?php echo $this->config->get('cielo_elo_parcelas');?>');" type="radio" id="bandeira" name="bandeira" value="elo" />
				</div>
				<? }?>
				</div>
				<br clear="all" /><br clear="all" />
			</td>
		</tr>
		<tr>
			<td id="parcelas"><td>
		</tr>
	</table>
	</center>
	<br /><br />
	<input type="hidden" name="valor_total" value="<?php echo $valor_total;?>" />
	<input type="hidden" name="pedido" value="<?php echo $this->session->data['order_id'];?>" />
	<div class="buttons">
		<div class="center" style="text-align: center;">
		 <input id="button-confirm" type="button" value="<?php echo $text_pagamento; ?>" class="button" onclick="cielo_confirm();" />
		</div>
	</div>
	<div id="cielo-popin" style="display:none;"></div>
<p style="text-align:center"><?php echo $text_info; ?></p>
<script type="text/javascript"><!--
var fn_pagamento = function(bandeira,parcelas) {
	$.ajax({
		url: 'index.php?route=payment/cielo/parcelamento&bandeira='+bandeira+'&parcelas='+parcelas,
		type: 'GET',
		cache: false,
		dataType: 'html',
		success: function(data) {$('#parcelas').html(data);}
	});
};

var cielo_confirm = function() {
	$.ajax({
		url: 'index.php?route=payment/cielo/processar',
		type: 'post',
		data: $('#form-cielo input[name=\'bandeira\']:checked, #form-cielo input[name=\'formaPagamento\']:checked, #form-cielo input[name=\'valor_total\'], #form-cielo input[name=\'pedido\']'),
		dataType: 'json',
		timeout: 40000,
		beforeSend: function() {
			$('#button-confirm').attr('disabled', true);
			$('#cielo-popin')
				.empty()
				.append('<p>Não feche esta janela, estamos processando seu pedido</p><div class="wait" style="text-align:center;"><img src="catalog/view/theme/default/image/loading.gif" alt="" /></div>')
				.dialog({height: 200, width: 400, modal: true,  buttons: {}, title: 'Processamento de pedido com cartão'});
			$('.ui-icon-closethick').parent().css({'display':'none'});
		},
		complete: function() {
			$('#cielo-popin > .wait').remove();
		},
		success: function(json) {
			if (json['url']) {
				$('#cielo-popin')
					.empty()
					.append('<p class="success" style="display: none;">Você será redirecionado ao site seguro da Cielo. Caso isso não ocorra automaticamente, clique no botão abaixo.</p>')
					.dialog({buttons:[
						{	text: 'Ir ao site da Cielo',
							click: function() {
								location = json['url'];}
						}
					]});
				location = json['url'];	
				$('.success').fadeIn('slow');
			} else {
				$('#cielo-popin')
					.empty()
					.append('<p class="warning" style="display: none;">Ocorreu um erro, por favor tente novamente ou escolha outra forma de pagamento.</p>')
					.dialog({height: 300, buttons:[
						{	text: 'Retornar',
							click: function() {
								$('#button-confirm').attr('disabled', false);
								$('#cielo-popin').empty().dialog('close');}
						}
					]});
				$('.warning').fadeIn('slow');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$('#cielo-popin')
				.empty()
				.append('<p class="warning" style="display: none;">Ocorreu um erro, por favor tente novamente ou escolha outra forma de pagamento.</p>')
				.dialog({height: 300, buttons:[
					{	text: 'Retornar',
						click: function() {
							$('#button-confirm').attr('disabled', false);
							$('#cielo-popin').empty().dialog('close');}
					}
				]});
			$('.warning').fadeIn('slow');
		}
	});
};
//--></script>
</form>
<?php if ($teste) { ?>
<div class="warning"><?php echo $text_teste; ?></div>
<?php } ?>
<?php
$order_info  = $this->model_checkout_order->getOrder($this->session->data['order_id']);
$valor_total = number_format($order_info['total'],2);
$valor_total = str_replace(".","",$valor_total);
?>
<div class="checkout-heading"><?php echo $text_barra; ?> </div>
<form method="post" action="index.php?route=payment/cielo/processar" >
	<center>
	<table border="0" style="width:700px>
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
				<br><br>
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
		<div class="right">
		 <input id="button-confirm" type="submit" value="<?php echo $text_pagamento; ?>" class="button" />
		</div>
	</div>
</form>
<p style="text-align:center"><?php echo $text_info; ?></p>
<script type="text/javascript">
function fn_pagamento(bandeira,parcelas) {
	$.ajax({
		url: 'index.php?route=payment/cielo/parcelamento&bandeira='+bandeira+'&parcelas='+parcelas,
		type: 'GET',
		cache: false,
		dataType: 'html',
		success: function(data) {$('#parcelas').html(data);}
	});
}
</script>
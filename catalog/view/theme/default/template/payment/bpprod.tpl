<script type="text/javascript" src="app/braspag/tabs.js"></script>
<script type="text/javascript" src="app/braspag/mascara.js"></script>
<script type="text/javascript" src="app/braspag/loja5prod.js"></script>
<?php
function MoedaOk($valor){
return number_format($valor, 2, '.', '');
}
$pedido_id = $pedido['order_id'];
$total_pedido = $pedido['total'];
//gera as formas de pagar
$option = "";
$option .= "<option value='12'>Pagamento a vista de R$ ".MoedaOk($total_pedido)."</option>";
?>
<input type="hidden" value="<?php echo $pedido_id;?>" id="id_pedido">
<input type="hidden" value="" id="bandeira_id">

<div class="buttons_bras" id="tela_pg_pagamento">
<div id="tabs" class="htabs">
<?php if($ativa_cartao=='sim'){?><a href="#tab-cartao" class="selected" style="display: inline;">Cart&atilde;o de Cr&eacute;dito</a><?php } ?>
<?php if($ativa_boleto=='sim'){?><a href="#tab-boleto" style="display: inline;" class="">Boleto Banc&aacute;rio</a><?php } ?>
</div>
	
<?php if($ativa_cartao=='sim'){?>
<span id="tab-cartao">
<br>
<table style="width:100%;padding: 10px 10px 10px 10px;">
<tr>
<td style="width:60%">
<center>
<b>Selecione o Cart&atilde;o de Pagamento:</b><br>
<?php 
foreach($cc AS $ccc){
?>
<a href="javascript:void(0);" onclick="CartaoBras(<?php echo $ccc;?>)"><img src="app/braspag/images/<?php echo $ccc;?>.gif" border="0"></a>
<?php } ?>
</center>
</td>
<td style="width:40%">

<table id="pagamento_parcelado" style="display:none">
<tr><td width="40%"><b>Bandeira:</b></td><td><span id="meio_parcelado_titulo"></span></td></tr>
<tr><td><b>Titular:</b></td><td><input onkeypress="return up(this)" onkeyup="return up(this)" style="width:300px;" type="text" name="cc_nome" id="cc_nome" value=""></td></tr>
<tr><td><b>Cart&atilde;o:</b></td><td><input onkeypress="return isNumberKey(event)" style="width:150px;" maxlength="16" type="text" name="cc_num" id="cc_num" value=""></td></tr>
<tr><td><b>Validade:</b></td><td><input style="width:50px;" class="data_val" maxlength="7" type="text" name="cc_val" id="cc_val" value=""></td></tr>
<tr><td><b>Cod. Seguran&ccedil;a:</b></td><td><input style="width:50px;" maxlength="4" type="text" name="cc_cod" id="cc_cod" value=""></td></tr>
<tr><td><b>Pagamento:</b></td><td>
<select style="width:250px;" id="lista_cartao_pg">
<option value="" selected>Selecione</option>
<?php echo $option;?>
</select>
</td></tr>
<tr><td></td><td><a class="button" href="javascript:void(0);" onclick="PagarCartao()" id="button-confirm">Confirmar!</a></td></tr>
</table>

</td>
</tr>
</table>
</span>
<?php } ?>

<?php if($ativa_boleto=='sim'){?>
<span id="tab-boleto">
<br>
<table style="width:100%;padding: 10px 10px 10px 10px;">
<tr>
<td style="width:60%">
<center><b>Pagamento com Boleto Banc&aacute;rio</b><br>
<img src="app/braspag/images/boleto.png" border="0">
</center>
</td>
<td style="width:40%">
<table id="pagamento_avista" style="display:">
<tr><td><b>Pagamento:</b></td><td>
<select style="width:250px;" id="lista_boleto_pg">
<option value="" selected>Selecione</option>
<?php echo $option;?>
</select>
</td></tr>
<tr><td></td><td><a class="button" href="javascript:void(0);" onclick="PagarBoleto()" id="button-confirm">Confirmar!</a></td></tr>
</table>

</td>
</tr>
</table>
</span>
<?php } ?>
</div>

<span id="tela_pg_aguarde" style="display:none;">
<div class="buttons_bras" style="padding: 10px 10px 10px 10px;">
<h3>Aguarde o resultado da transa&ccedil;&atilde;o...</h3>
</div>
</span>

<script>
function CartaoBras(meio){
//mostra o form
$("#pagamento_parcelado").show();
$("#meio_parcelado_titulo").html('<img src="app/braspag/images/'+meio+'.gif" border="0">');
$("#bandeira_id").val(meio);
}
function BancoBras(meio){
//mostra o form
$("#pagamento_banco").show();
$("#meio_banco_titulo").html('<img src="app/braspag/images/'+meio+'.png" border="0">');
}
</script>


<?php if ($text_information) { ?>
<div class="information"><?php echo $text_information; ?></div>
<?php } ?>
<form action="<?php echo $action; ?>" method="post" id="payment">
	<!-- campos obrigatórios -->
	<input type="hidden" name="email_loja" value="<?php echo $email_loja; ?>" />
	<input type="hidden" name="tipo_integracao" value="PAD" />
	<input type="hidden" name="frete" value="<?php echo $shipping_total; ?>" />
	
	<?php
	$i = 1;
	foreach ($products as $product) {
		$options_names = '';
		$model = ($product['model'] != '') ? $product['model'].'-' : '';
		
		foreach ($product['option'] as $option) { 
			$options_names .= '/'.$option['name'];
		}?>
		
		<input type="hidden" name="produto_codigo_<?php echo $i;?>" value="<?php echo $product['product_id'];?>" />
		<input type="hidden" name="produto_descricao_<?php echo $i;?>" value="<?php echo $model.$product['name'].$options_names;?>" />
		<input type="hidden" name="produto_qtde_<?php echo $i;?>" value="<?php echo $product['quantity'];?>" />
		<input type="hidden" name="produto_valor_<?php echo $i;?>" value="<?php echo $product['value'];?>" />
		<?php 
		$i++;
	}?>
	
	<!-- campos opcionais -->
	<input type="hidden" name="id_pedido" value="<?php echo $id_pedido; ?>" />
	<input type="hidden" name="url_retorno" value="<?php echo $url_retorno; ?>" />
	<input type="hidden" name="redirect" value="true" />
	
	<?php if($discount_total != 0) { ?>
	<input type="hidden" name="desconto" value="<?php echo $discount_total; ?>" />
	<?php } ?>
	
	<!-- dados pessoais -->
	<?php if($enviar_dados_cliente){ ?>
	<input type="hidden" name="nome" value="<?php echo $nome; ?>" />
	<input type="hidden" name="email" value="<?php echo $email; ?>" />
	<input type="hidden" name="telefone" value="<?php echo $telephone; ?>" />
	<input type="hidden" name="endereco" value="<?php echo $endereco; ?>" />
	<input type="hidden" name="bairro" value="<?php echo $bairro; ?>" />
	<input type="hidden" name="cidade" value="<?php echo $cidade; ?>" />
	<input type="hidden" name="cep" value="<?php echo $cep; ?>" />
	<input type="hidden" name="estado" value="<?php echo $estado; ?>" />
	<?php } ?>
</form>
<div class="buttons">
  <div class="right"><a id="button-confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>   
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
	$.ajax({
		type: 'GET',
		url: 'index.php?route=payment/pagamento_digital/confirm',
		beforeSend: function() {
			$('#button-confirm').attr('disabled', true);
			
			$('#payment').before('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		success: function() {
			$('#payment').submit();
		}
	});
});
//--></script>
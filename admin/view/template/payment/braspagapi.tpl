<?php echo $header; ?>
<?php
$meios_cartao = array(0=>'Amex 2P',72=>'Diners',73=>'Amex',1=>'Visa TEF',2=>'Amex TEF',3=>'RedeCard WebService',28=>'Visa EDI',30=>'Mastercard TEF',31=>'Diners TEF',34=>'Visa Moset 1',41=>'Hipercard',71=>'Visa',120=>'Mastercard',126=>'Elo');
$meios_boleto = array(33=>'Boleto Itau Cobranca Automatica',35=>'Boleto Unibanco',36=>'Boleto Bradesco',37=>'Boleto Itau',40=>'Boleto Banco do Brasil',998=>'Nenhum');
$meios_debito = array(6=>'Debito Bradesco (CNAB 400)',7=>'Debito Banco do Brasil Febraban',9=>'Debito CEF Febraban',17=>'Debito HSBC Febraban',18=>'Debito Itau',32=>'Debito  Bradesco Febraban',38=>'Debito Itau Febraban');
?>
<script type="text/javascript" src="http://jquerypriceformat.com/js/jquery.price_format.1.8.js"></script>
<script>
$(function(){
$('.dinheiro').priceFormat({
    prefix: '',
    thousandsSeparator: ''
});
});
</script>

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
	
	
	<div id="tabs" class="htabs">
	<!--<a href="#tab-pedidos" style="display: inline;" class="selected">Pedidos</a>-->
	<a href="#tab-configuracoes" class="" style="display: inline;">Configura&ccedil;&otilde;es</a>
	</div>
	
	<div id="tab-configuracoes">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">

		 <tr>
            <td>Nome do M&oacute;dulo:<span class="help">Nome que sera mostrado ao cliente na lista de meios de pagamento.</span></td>
            <td><input type="text" name="braspagapi_nome" value="<?php echo $braspagapi_nome; ?>" size="70" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td><input class="dinheiro" type="text" name="braspagapi_total" value="<?php echo $braspagapi_total; ?>" /></td>
          </tr> 
		  

		  
          <tr>
            <td><?php echo $entry_geo_zone; ?><span class="help">Locais em que o meio de pagamento ser&aacute; aceito.</span></td>
            <td><select name="braspagapi_geo_zone_id">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $braspagapi_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?><span class="help">Se quer ativar o m&oacute;dulo em sua loja.</span></td>
            <td><select name="braspagapi_status">
                <?php if ($braspagapi_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?><span class="help">Ordem do mesmo a mostrar na lista de meios de pagamento de sua loja.</span></td>
            <td><input type="text" name="braspagapi_sort_order" value="<?php echo $braspagapi_sort_order; ?>" size="1" /></td>
          </tr>
		   <tr>
            <td>Ambiente:<span class="help">De acordo seu uso.</span></td>
            <td><select name="braspagapi_ambiente">
                <?php if ($braspagapi_ambiente==1) { ?>
                <option value="1" selected="selected">Homologacao</option>
                <option value="0">Produ&ccedil;&atilde;o</option>
                <?php } else { ?>
                <option value="1">Homologacao</option>
                <option value="0" selected="selected">Produ&ccedil;&atilde;o</option>
                <?php } ?>
              </select></td>
          </tr>

		  <tr>
            <td>MerchantID:<br /><span class="help">Fornecida pela Braspag.</span></td>
            <td><input type="text" name="braspagapi_chave" value="<?php echo $braspagapi_chave; ?>" size="70" /></td>
          </tr>

		  <tr>
            <td><?php echo $entry_order_status; ?><br /><span class="help">Status padr&atilde;o que os pedidos seram criados e aguardando o pagamento.</span></td>
            <td><select name="braspagapi_order_status_id">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $braspagapi_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  
		  <tr>
            <td>Status Autorizado:<br /><span class="help">Status padr&atilde;o que os pedidos autorizandos sem captura.</span></td>
            <td><select name="braspagapi_autorizado">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $braspagapi_autorizado) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  
		  <tr>
            <td>Status Aprovado:<br /><span class="help">Status padr&atilde;o que os pedidos aprovado com captura.</span></td>
            <td><select name="braspagapi_aprovado">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $braspagapi_aprovado) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  
		  <tr>
            <td>Status Cancelado/Negado:<br /><span class="help">Status padr&atilde;o que os pedidos cancelados ou negados.</span></td>
            <td><select name="braspagapi_cancelado">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $braspagapi_cancelado) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>

		  <tr>
            <td>Boleto Ativo:<br /></td>
            <td>
				<select name="braspagapi_bo">
                <?php foreach ($meios_boleto as $id => $nome) { ?>
                <?php if ($id==$braspagapi_bo) { ?>
                <option value="<?php echo $id; ?>" selected="selected"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } else { ?>
                <option value="<?php echo $id; ?>"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } ?>
                <?php } ?>
				</select>
			  
			  </td>
          </tr>
		  
		   <tr>
            <td>Debito Ativo:<br /></td>
            <td>
				<select name="braspagapi_de[]" size="10" multiple>
                <?php foreach ($meios_debito as $id => $nome) { ?>
                <?php if (in_array($id,$braspagapi_de)) { ?>
                <option value="<?php echo $id; ?>" selected="selected"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } else { ?>
                <option value="<?php echo $id; ?>"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } ?>
                <?php } ?>
				</select>
			  
			  </td>
          </tr>
		  
		  
		  <tr>
            <td>Cart&otilde;es Ativos:<br /></td>
            <td>
				<select name="braspagapi_cc[]" size="10" multiple>
                <?php foreach ($meios_cartao as $id => $nome) { ?>
                <?php if (in_array($id,$braspagapi_cc)) { ?>
                <option value="<?php echo $id; ?>" selected="selected"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } else { ?>
                <option value="<?php echo $id; ?>"><?php echo $id; ?> - <?php echo $nome; ?></option>
                <?php } ?>
                <?php } ?>
				</select>
			  
			  </td>
          </tr>


        </table>
      </form>
	 </div>
	 
	<div id="tab-pedidos">
	 
	 
	 <!--<table class="list">
          <thead>
            <tr>
              <td style="text-align: center;" width="70">Pedido</td>
              <td class="left" width="70">Total</td>
              <td class="left" width="70">Pago</td>
              <td class="right" width="80">Bandeira</td>
              <td class="left" width="70">Parcela(s)</td>
              <td class="left" width="160">TID</td>
			  <td class="left" width="250">LR</td>
			  <td class="left" width="170">Resposta</td>
			  <td class="left" width="100">CPF</td>
			  <td class="left" width="100">Telefone</td>
			  <td class="left" width="100">Data</td>
              <td class="right" width="70"></td>
            </tr>
          </thead>
          <tbody>

		<?php 
		if(count($pedidos_cielo)>=1){
		foreach($pedidos_cielo AS $pedido){
		?>
        <tr>
              <td style="text-align: center;"><?php echo $pedido['idOrder'];?></td>
              <td class="left"><?php echo $pedido['totalOrder'];?></td>
			  <td class="left"><?php echo $pedido['totalPaid'];?></td>
			  <td class="right"><?php echo strtoupper($pedido['ccMethod']);?></td>
			  <td class="right"><?php echo $pedido['numParcelas'];?></td>
			  <td class="right"><?php echo $pedido['tidCielo'];?></td>
              <td class="left"><?php echo getLrCielo($pedido['lrCielo']);?></td>
              <td class="left"><?php echo getStatusCielo($pedido['statusCielo']);?></td>
              <td class="right"><?php echo $pedido['cpfCustomer'];?></td>
              <td class="left"><?php echo $pedido['telCustomer'];?></td>
              <td class="left"><?php echo date('d/m/Y',$pedido['dateOrder']);?></td>
              <td class="right"><a href="javascript:abrir('<?php echo $link_consulta;?>&pedido=<?php echo $pedido['idOrder'];?>');">Consultar</a></td>
        </tr>
		<?php } } ?>

        </tbody>
        </table>
		 <div class="pagination"><?php echo $pagination; ?></div>
	 
	 </div>-->

<script type="text/javascript">
<!--
$('#tabs a').tabs();
function isNumberKey(evt){
          var charCode = (evt.which) ? evt.which : event.keyCode;
          if (charCode != 46 && charCode > 31 
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
}
function abrir(URL) {
 
  var width = 600;
  var height = 500;
 
  var left = 99;
  var top = 99;
 
  window.open(URL,'janela', 'width='+width+', height='+height+', top='+top+', left='+left+', scrollbars=yes, status=no, toolbar=no, location=no, directories=no, menubar=no, resizable=no, fullscreen=no');
 
}
//-->
</script>
<?php
function getStatusCielo($status) {
			
			switch($status)
			{
				case "0": $status = "Aguardando Pagamento";
						break;
				case "1": $status = "Em andamento";
						break;
				case "2": $status = "Autenticada";
						break;
				case "3": $status = "Nao autenticada";
						break;
				case "4": $status = "Autorizada";
						break;
				case "5": $status = "Nao autorizada";
						break;
				case "6": $status = "Aprovada";
						break;
				case "8": $status = "Nao capturada";
						break;
				case "9": $status = "Cancelada";
						break;
				case "10": $status = "Em autenticacao";
						break;
				default: $status = "n/a";
						break;
			}
			
			return $status;
}
		
function getLrCielo($lrcod){
			
			switch($lrcod)
			{
				case "00": 
				$lrcod = "00 - Transacao autorizada";
				break;
				case "01":
				case "04":
				case "07":
				case "41":
				case "62":
				case "63":
				$lrcod = $lrcod." - Transacao referida/com restricao pelo emissor (Contate o emissor de seu cartao)";
				break;
				case "05": 
				$lrcod = "05 - Transacao nao autorizada";
				break;
				case "12": 
				case "82": 
				$lrcod = $lrcod." - Transacao invalida";
				break;
				case "13": 
				$lrcod = "13 - Valor invalido";
				break;
				case "14": 
				$lrcod = "14 - Cartao invalido";
				break;
				case "15": 
				$lrcod = "15 - Emissor invalido";
				break;
				case "51": 
				$lrcod = "51 - Saldo insuficiente";
				break;
				case "54": 
				$lrcod = "54 - Cartao vencido";
				break;
				case "57": 
				case "58":
				$lrcod = $lrcod." - Transacao nao permitida";
				break;
				case "78":
				$lrcod = "78 - Cartao nao desbloqueado (Contate o emissor de seu cartao)";
				break;
				case "91":
				$lrcod = "91 - Banco indisponivel";
				break;
				case "AC":
				$lrcod = "AC - Cartao de debito tentando seu usado como credito.";
				break;
				default:
				$lrcod = $lrcod;
			}
			
			return $lrcod;
}
?>

    </div>
  </div>
</div>
<?php echo $footer; ?> 
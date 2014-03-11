<?php echo $header; ?>
<?php echo $column_left; ?>
<?php echo $column_right; ?>
<?php
$meios_braspag = array(0=>'Amex',1=>'Visa',2=>'Amex',3=>'RedeCard',28=>'Visa',30=>'Mastercard',31=>'Diners',34=>'Visa',41=>'Hipercard',71=>'Visa',120=>'Mastercard',33=>'Boleto Itau',35=>'Boleto Unibanco',36=>'Boleto Bradesco',37=>'Boleto Itau',40=>'Boleto BB',6=>'Debito Bradesco',7=>'Debito BB',9=>'Debito CEF',17=>'Debito HSBC',18=>'Debito Itau',32=>'Debito Bradesco',38=>'Debito Itau');
$lista_de_status_braspag = array(0=>'Confirmado',1=>'Autorizado',2=>'Negado',3=>'Negado',4=>'Negado (Inativo)',5=>'Negado (Desativado)',6=>'Aguar. Resposta',7=>'Desqualificado',8=>'Erro Interno');
$lista_ciclos = array(1=>'Mensalidade',6=>'Semestralidade',12=>'Anualidade');
?>
<div id="content">
<h1>Seu pedido foi cadastrado com sucesso!<br>Obrigado por comprar em nossa loja!</h1>
<br><br>
<h2>Detalhes da Transa&ccedil;&atilde;o #<?php echo $ped['order_id'];?></h2>

<?php
foreach($registros AS $item){
?>
<div class="order-list">
    <div class="order-id"><b>FaturaID:</b> #<?php echo $item['idPedido'];?>/<?php echo $item['numPag'];?></div>
    <div class="order-status"><b>Status:</b> <?php echo $lista_de_status_braspag[$item['statusPagamento']];?></div>
    <div class="order-content">
      <div><b>Data Fatura/D&eacute;bito:</b> <?php echo $item['dataDebito'];?><br>
        <b><?php echo $lista_ciclos[$registro['periodicidade']];?>:</b> <?php echo $item['numPag'];?></div>
      <div><b>Meio de Pagamento:</b> <?php echo $meios_braspag[$registro['codPagamento']];?><br>
        <b>Total a Pagar/Debitar:</b> R$ <?php echo number_format($item['valorPago'], 2, '.', '');?></div>
      <div class="order-info"><a href="index.php?route=account/order/info&amp;order_id=<?php echo $item['idPedido'];?>"><img src="catalog/view/theme/default/image/info.png" alt="View" title="View"></a></div>
    </div>
</div>
<?php
}
?>

</div>

<?php echo $footer; ?>
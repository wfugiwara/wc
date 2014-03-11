<?php echo $header; ?>

<?php if ($error_warning) { ?>

<div class="warning"><?php echo $error_warning; ?></div>

<?php } ?>

<?php echo $column_left; ?><?php echo $column_right; ?>

<div id="content"><?php echo $content_top; ?>

  <div class="breadcrumb">

    <?php foreach ($breadcrumbs as $breadcrumb) { ?>

    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>

    <?php } ?>

  </div>

  <h1><?php echo $heading_title;?></h1>

  

  <?php if(count($parceiros)>=1){?>

  <p>Selecione abaixo o parceiro desejado para gerar seu cupom de desconto.</p>

   

  <table class="list">

  <thead>

  <tr>

  <td width="100"></td>

  <td>Empresa</td>

  <td>Desconto</td>

  </tr>

  </thead>

  <?php

  foreach($parceiros AS $key=>$cat){

  ?>

  <tbody>

  <tr>

  <td width="100"><a href="index.php?route=account/gera_voucher/parceiro&par=<?php echo $cat['idPar']; ?>&nome=<?php echo $cat['nomePar']; ?>"><img src="image/<?php echo $cat['imagemPar'];?>" width="100"></a></td>

  <td><a href="index.php?route=account/gera_voucher/parceiro&par=<?php echo $cat['idPar']; ?>&nome=<?php echo $cat['nomePar']; ?>"><?php echo $cat['nomePar']; ?></a></td>

  <td><b><?php echo $cat['valVoucher']; ?>%</b> de desconto</td>

  </tr>

  </tbody>

  <?php

  }

  ?>

  </table>

  

  <?php }else{ ?>

  <p>Nenhum parceiro para esta categoria.</p>

  <?php } ?>

  

  <?php echo $content_bottom; ?></div>

<?php echo $footer; ?>
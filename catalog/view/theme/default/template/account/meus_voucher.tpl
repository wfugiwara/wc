<?php echo $header; ?>

<script language="JavaScript">
function abrir(URL) {
 
  var width = 800;
  var height = 350;
 
  var left = 99;
  var top = 99;
 
  window.open(URL,'janela', 'width='+width+', height='+height+', top='+top+', left='+left+', scrollbars=yes, status=no, toolbar=no, location=no, directories=no, menubar=no, resizable=no, fullscreen=no');
 
}
</script>
 
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
  <h1>Meus Vouchers</h1>
  <table class="list">
  <thead>
  <tr>
  <td width="50">ID</td>
  <td width="100"></td>
  <td>Empresa</td>
  <td>Endere&ccedil;o</td>
  <td width="100">Desconto</td>
  <td width="100">Data</td>
  <td width="100"></td>
  </tr>
  </thead>
  <tbody>
  <?php
  foreach($cupons AS $key=>$c){
  ?>
  <tr>
  <td width="50">#<?php echo $c['idCupon'];?></td>
  <td><img src="image/<?php echo $c['imagemPar'];?>" width="100"></td>
  <td><?php echo $c['nomePar'];?></td>
  <td><?php echo nl2br($c['det']);?></td>
  <td width="100"><?php echo $c['valCupon'];?>%</td>
  <td width="100"><?php echo date('d/m/Y',$c['dataCupon']);?></td>
  <td><button onclick="abrir('index.php?route=account/meus_vouchers/imprimir&cupom=<?php echo $c['idCupon'];?>');">Imprimir #<?php echo $c['idCupon'];?></button></td>
  </tr>
  <?php
  }
  ?>
  </tbody>
  </table>
  
  
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
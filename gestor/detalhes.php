<?php
include("dados.php");
include("../app/braspag/loja5.php");
if(!isset($_SESSION['braspagapi_email']) && !isset($_SESSION['braspagapi_id'])){
@header("Location: index.php");
}
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Lista de Faturas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="js/bootstrap.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body>

<?php include("menu.php");?>

    <div class="container">
<?php
$ped = DetalhesPedidoBrasPag((int)base64_decode($_GET['token']));
?>
<h4>Detalhes do Pedido #<?php echo (int)base64_decode($_GET['token']);?> | <span class="label label-<?php echo $cores_braspag[$ped['statusPedido']];?>"><?php echo $lista_de_status_braspag[$ped['statusPedido']];?></span></h4>
<table class="table table-bordered">
  <thead>
    <tr>
	  <th style="width:50px;">#</th>
      <th style="width:50px;">FaturaID</th>
	  <th style="width:70px;">Pago</th>
      <th style="width:200px;">Status Braspag (Por item)</th>
	  <th style="width:100px;">Total a Pagar</th>
	  <th style="width:150px;">D&eacute;bito (Aproximado)</th>
	  <th>Log</th>

    </tr>
  </thead>
  <tbody>
<?php 
$query = $db->query("SELECT * FROM `braspag_itens` WHERE idPedido = '".(int)base64_decode($_GET['token'])."' ORDER BY numPag ASC");
$res = $query->rows;
foreach($res AS $linha){
?>
    <tr class="<?php echo $cores_braspag[$linha['statusPagamento']];?>">
	  <td><?php echo $linha['numPag'];?></td>
	  
      <td><?php echo $linha['idPedido'];?>/<?php echo $linha['numPag'];?></td>
	  <td>
	  <?php 
	  if($linha['pago']=='SIM'){
	  echo '<span class="label label-success">'.$linha['pago'].'</span>';
	  }else{
	  echo '<span class="label label-warning">'.$linha['pago'].'</span>';
	  }
	  ?>
	  </td>
      <td> <span class="label label-<?php echo $cores_braspag[$linha['statusPagamento']];?>"><?php echo $lista_de_status_braspag[$linha['statusPagamento']];?></span></td>
	  <td><?php echo number_format($linha['valorPago'], 2, '.', '');?></td>
	  <td><?php echo $linha['dataDebito'];?></td>
      <td><?php echo $linha['dadosPag'];?></td>

    </tr>
<?php } ?>
  </tbody>
</table>
<a href="pedidos.php">- Voltar aos Pedidos</a>

      <footer>
      </footer>

    </div> <!-- /container -->

  </body>
</html>
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
    <title>Logs de Consulta API - Braspag</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery.dataTables.js"></script>
<script src="js/DT_bootstrap.js"></script>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/DT_bootstrap.css" rel="stylesheet">
<link href="css/menu.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">

<style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
</style>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body>

<?php include("menu.php");?>

    <div class="container">
<h4>Logs de Consulta API Braspag</h4>
<table class="table table-bordered" id="tabela_logs" style="font-size:12px;">
  <thead>
    <tr>
      <th style="width:50px;"></th>
      <th>Data Consulta</th>
	  <th style="width:150px;">Pedido</th>
	  <th style="width:150px;">Num. Pagamento</th>
	  <th style="width:100px;">Pago</th>
	  <th>Log</th>
    </tr>
  </thead>
  <tbody>
<?php 
$sql = "SELECT * FROM `braspag_cron` AS a,`braspag_itens` AS b WHERE a.pedido=b.idPedido AND a.numpg=b.numPag ORDER BY a.id DESC";
$query = $db->query($sql);
$res = $query->rows;
foreach($res AS $linha){
?>
    <tr>
      <td><?php echo $linha['id'];?></td>
	  <td><?php echo $linha['data_hora'];?></td>
      <td><?php echo $linha['pedido'];?></td>
	  <td><?php echo $linha['numpg'];?></td>
	  <td>
	  <?php 
	  if($linha['pago']=='SIM'){
	  echo '<span class="label label-success">'.$linha['pago'].'</span>';
	  }else{
	  echo '<span class="label label-warning">'.$linha['pago'].'</span>';
	  }
	  ?>
	  </td>
	  <td><?php echo $linha['dadosPag'];?></td>
    </tr>
<?php } ?>
  </tbody>
</table>

<script>
$(document).ready(function() {
	var oTable = $('#tabela_logs').dataTable( {
		"aaSorting": [[ 0, "desc" ]],
		"sPaginationType": "bootstrap",
		"sWrapper": "dataTables_wrapper form-inline",
		"aoColumns": [ 
			null,
			null,
			null,
			null,
			null,
			null
		    ]
	})
});
</script>

      <footer>
      </footer>

    </div> <!-- /container -->

  </body>
</html>
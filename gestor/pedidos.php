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
    <title>Gestor de Pedidos - Braspag</title>
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
<h4>Lista de Pedidos</h4>
<table class="table table-bordered" id="tabela_pedidos" style="font-size:12px;">
  <thead>
    <tr>
      <th style="width:50px;">Pedido</th>
      <th>Cliente</th>
	  <th style="width:100px;">Total (Cheio)</th>
	  <th style="width:90px;">Ciclo</th>
	  <th style="width:90px;">Inicio</th>
	  <th style="width:90px;">Fim</th>
	  <th style="width:100px;">Meio</th>
	  <th style="width:150px;">Ultimo Status</th>
	  <th style="width:80px;"></th>
    </tr>
  </thead>
  <tbody>
<?php 
$sql = "SELECT * FROM `".DB_PREFIX."order` AS a,`braspag_pedidos` AS b WHERE a.order_id=b.idPedido ORDER BY b.idPedido DESC";
$query = $db->query($sql);
$res = $query->rows;
foreach($res AS $linha){
?>
    <tr>
      <td><?php echo $linha['idPedido'];?></td>
      <td><?php echo strtoupper($linha['firstname']);?> <?php echo strtoupper($linha['lastname']);?></td>
	  <td><?php echo number_format($linha['total'], 2, '.', '');?></td>
      <td><?php echo QualPeriodicidadeBraspag($linha['periodicidade']);?></td>
	  <td><?php echo $linha['dataInicio'];?></td>
      <td><?php echo $linha['dataFim'];?></td>
	  <td><?php echo $meios_braspag[$linha['codPagamento']];?></td>
      <td><span class="label label-<?php echo $cores_braspag[$linha['statusPedido']];?>"><?php echo $lista_de_status_braspag[$linha['statusPedido']];?></span></td>
	  <td><a href="detalhes.php?token=<?php echo base64_encode($linha['idPedido']);?>" class="btn btn-small btn-primary">Detalhes</a></td>
    </tr>
<?php } ?>
  </tbody>
  	<tfoot>
		<tr>
		<th><input type="text" id="filtro_id" placeholder="ID" class="input-mini"></th>
		<th><input type="text" id="filtro_nome" placeholder="Cliente" class="input-xlarge"></th>
		<th></th>
		<th><input type="text" id="filtro_ciclo" placeholder="Ciclo" class="input-mini"></th>
		<th></th>
		<th></th>
		<th>
		<select id="filtro_meio" class="input-small">
		<option value='' selected>Todos</option>
		<?php
		foreach($meios_braspag AS $meio){
		echo "<option value='".$meio."'>".$meio."</option>";
		}
		?>
		</select>
		</th>
		<th>
		<select id="filtro_status" class="input-medium">
		<option value='' selected>Todos</option>
		<?php
		foreach($lista_de_status_braspag AS $meio){
		echo "<option value='".$meio."'>".$meio."</option>";
		}
		?>
		</select>
		</th>
		<th></th>
	</tfoot>
</table>

<script>
$(document).ready(function() {
	var oTable = $('#tabela_pedidos').dataTable( {
		"aaSorting": [[ 0, "desc" ]],
		//"bStateSave": true,
		//"sDom": "<'row'<'span6'>l>t<'row'<'span6'i><'span6'p>>",
		"sPaginationType": "bootstrap",
		"sWrapper": "dataTables_wrapper form-inline",
		"aoColumns": [ 
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null
		    ]
	})
	
	$('#filtro_id').keyup( function () { oTable.fnFilter( $(this).val(), 0 );} );
	$('#filtro_nome').keyup( function () { oTable.fnFilter( $(this).val(), 1 );} );
	$('#filtro_ciclo').keyup( function () { oTable.fnFilter( $(this).val(), 3 );} );
	$('#filtro_meio').change( function () { oTable.fnFilter( $(this).val(), 6 );} );
	$('#filtro_status').change( function () { oTable.fnFilter( $(this).val(), 7 );} );
	
});
</script>

      <footer>
      </footer>

    </div> <!-- /container -->

  </body>
</html>
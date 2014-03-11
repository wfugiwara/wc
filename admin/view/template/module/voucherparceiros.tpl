<?php echo $header; ?>
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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
	
	<div id="tabs" class="htabs">
	
	<a href="#tab-cupons" id="cupons">Cupons Gerados</a>
	<a href="#tab-categorias" id="categorias">Categorias</a>
	<a href="#tab-prod" id="prod">Produtos Validos</a>
	<a href="#tab-parceiros" id="parceiros">Parceiros</a>
	<a href="#tab-ends" id="ends">Enderecos de Parceiros</a>
	<a href="#tab-status" id="status">Config. de Status</a>
	</div>
	
	<div id="tab-prod">
	
	<form action="<?php echo $action;?>" method="post" enctype="multipart/form-data" id="form">
	<input type="hidden" name="tipo" value="produto">
	<table>
	<tr><td>Produto:</td><td>
	<select name="produto">
	<?php if ($produtos) { ?>
            <?php 
			foreach ($produtos as $cat) { 
			?>
			<option value="<?php echo $cat['product_id'];?>"><?php echo $cat['name'];?></option>
			<?php } ?>
	<?php } ?>
	</select>
	</td></tr>
	<input type="hidden" name="acao" value="add">
	</table>
	<input type="submit" value="Salvar" name="salvar">
	</form>
	<h2>Lista de Produtos Validos</h2>
	<table class="list">
	<thead>
    <tr>
	<td width="1" style="text-align: center;">ID</td>
	<td width="1" style="text-align: center;">Produto</td>
	<td width="1" style="text-align: center;"></td>
	</tr>
	</thead>
	<tbody>
	<?php if ($produtosv) { ?>
            <?php foreach ($produtosv as $cat) { ?>
	<tr>
	<td width="1" style="text-align: center; width: 50px;"><?php echo $cat['product_id'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['name'];?></td>
	<td width="1" style="text-align: center; width:120px;"> <a onclick="return confirm('Tem certeza em remover o produto valido <?php echo $cat['name'];?>?');" href="<?php echo $action;?>&tab=prod&id_remover=<?php echo $cat['idPv'];?>&acao=remover">[remover]</a></td>
	</tr>
			<?php } ?>
	<?php } ?>
	</tbody>
	</table>
	</div>
	
	<div id="tab-cupons">
	
	<h2>Lista de Cupons Gerados</h2>
	<table class="list">
	<thead>
    <tr>
	<td width="1" style="text-align: center;">ID</td>
	<td width="1" style="text-align: center;">Parceiro</td>
	<td width="1" style="text-align: center;">Cliente</td>
	<td width="1" style="text-align: center;">Voucher</td>
	<td width="1" style="text-align: center;">Endereco</td>
	<td width="1" style="text-align: center;">Data</td>
	</tr>
	</thead>
	<tbody>
	<?php if ($cupons) { ?>
            <?php foreach ($cupons as $cat) { ?>
	<tr>
	<td width="1" style="text-align: center; width: 50px;"><?php echo $cat['idCupon'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['nomePar'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['customer_id'];?> - <?php echo $cat['firstname'];?> <?php echo $cat['lastname'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['valCupon'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['det'];?></td>
	<td width="1" style="text-align: center;"><?php echo date('d/m/Y H:s:i',$cat['dataCupon']);?></td>
	</tr>
			<?php } ?>
	<?php } ?>
	</tbody>
	</table>
	</div>
	
	
    <div id="tab-categorias">
	
	<form action="<?php echo $action;?>" method="post" enctype="multipart/form-data" id="form">
	<?php
	$nome = "";
	$subid = 0;
	$id=0;
	if(isset($_GET['acao']) && $_GET['acao']=='editar' && $_GET['tab']=='categorias'){
	$nome = $_GET['nome'];
	$subid = $_GET['subid'];
	$id = $_GET['id'];
	?>
	<h2>Editar Categoria</h2>
	<input type="hidden" name="cat_id" value="<?php echo $_GET['id'];?>">
	<input type="hidden" name="acao" value="editar">
	<?php }else{ ?>
	<h2>Adicionar Categoria</h2>
	<input type="hidden" name="acao" value="add">
	<?php } ?>
	<input type="hidden" name="tipo" value="categoria">
	<table>
	<tr><td>Nome:</td><td><input type="text" name="categoria" value="<?php echo $nome;?>"></td></tr>
	<input type="hidden" name="sub" value="0">
	</table>
	<input type="submit" value="Salvar" name="salvar">
	</form>
	<h2>Lista de Categorias</h2>
	<table class="list">
	<thead>
    <tr>
	<td width="1" style="text-align: center;">ID</td>
	<td width="1" style="text-align: center;">Categoria</td>
	<td width="1" style="text-align: center;"></td>
	</tr>
	</thead>
	<tbody>
	<?php if ($categorias) { ?>
            <?php foreach ($categorias as $cat) { ?>
	<tr>
	<td width="1" style="text-align: center; width: 50px;"><?php echo $cat['id'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['nome'];?></td>
	<td width="1" style="text-align: center; width:120px;"><a href="<?php echo $action;?>&tab=categorias&id=<?php echo $cat['id'];?>&subid=<?php echo $cat['idsub'];?>&nome=<?php echo $cat['nome'];?>&acao=editar">[editar]</a> <a onclick="return confirm('Tem certeza em remover a categoria <?php echo $cat['nome'];?>?');" href="<?php echo $action;?>&tab=categorias&id_remover=<?php echo $cat['id'];?>&acao=remover">[remover]</a></td>
	</tr>
			<?php } ?>
	<?php } ?>
	</tbody>
	</table>
	</div>
	
	
	<div id="tab-ends">
	
	<form action="<?php echo $action;?>" method="post" enctype="multipart/form-data" id="form">
	<?php
	$end = "";
	$parid = 0;
	$id=0;

	if(isset($_GET['acao']) && $_GET['acao']=='editar' && $_GET['tab']=='ends'){
	$parid = $_GET['parid'];
	$id = $_GET['id'];
	$end = base64_decode($_GET['end']);
	?>
	<h2>Editar Endereco Parceiro</h2>
	<input type="hidden" name="end_id" value="<?php echo $_GET['id'];?>">
	<input type="hidden" name="acao" value="editar">
	<?php }else{ ?>
	<h2>Adicionar Endereco Parceiro</h2>
	<input type="hidden" name="acao" value="add">
	<?php } ?>
	<input type="hidden" name="tipo" value="ends">
	<table>
	<tr><td>Parceiro:</td><td>
	<select name="parceiro">
	<?php if ($parceiros) { ?>
            <?php 
			foreach ($parceiros as $cat) { 
			?>
			<option value="<?php echo $cat['id'];?>"<?php echo ($parid==$cat['id']) ? ' selected':'';?>><?php echo $cat['nome'];?></option>
			<?php } ?>
	<?php } ?>
	</select>
	</td></tr>
	<tr><td>Endereco/Detalhes:</td><td><textarea name="end" rows="4" cols="35"><?php echo $end;?></textarea></td></tr>

	</table>
	<input type="submit" value="Salvar endereco" name="salvar">
	</form>
	<h2>Lista de Enderecos Parceiros</h2>
	<table class="list">
	<thead>
    <tr>
	<td width="1" style="text-align: center;">ID</td>
	<td width="1" style="text-align: center;">Parceiro</td>
	<td width="1" style="text-align: center;">Endereco</td>
	<td width="1" style="text-align: center;"></td>
	</tr>
	</thead>
	<tbody>
	<?php if ($ends) { ?>
            <?php foreach ($ends as $cat) { ?>
	<tr>
	<td width="1" style="text-align: center; width: 50px;"><?php echo $cat['id'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['nome_par'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['end'];?></td>
	<td width="1" style="text-align: center; width:120px;"><a href="<?php echo $action;?>&tab=ends&id=<?php echo $cat['id'];?>&parid=<?php echo $cat['id_par'];?>&end=<?php echo base64_encode($cat['end']);?>&acao=editar">[editar]</a> <a onclick="return confirm('Tem certeza em remover o endereco de parceiro <?php echo $cat['nome_par'];?>?');" href="<?php echo $action;?>&tab=ends&id_remover=<?php echo $cat['id'];?>&acao=remover">[remover]</a></td>
	</tr>
			<?php } ?>
	<?php } ?>
	</tbody>
	</table>
	</div>
	
	
	<div id="tab-parceiros">
	
	<form action="<?php echo $action;?>" method="post" enctype="multipart/form-data" id="form">
	<?php
	$logo = "no_image.jpg";
	$config_logo = "no_image.jpg";
	$nome = "";
	$catid = 0;
	$id=0;
	$valor='';

	if(isset($_GET['acao']) && $_GET['acao']=='editar' && $_GET['tab']=='parceiros'){
	$nome = $_GET['nome'];
	$catid = $_GET['catid'];
	$id = $_GET['id'];
	$valor = $_GET['valor'];

	$logo = $_GET['imagem'];
	$config_logo = $_GET['imagem'];
	?>
	<h2>Editar Parceiro</h2>
	<input type="hidden" name="par_id" value="<?php echo $_GET['id'];?>">
	<input type="hidden" name="acao" value="editar">
	<?php }else{ ?>
	<h2>Adicionar Parceiro</h2>
	<input type="hidden" name="acao" value="add">
	<?php } ?>
	<input type="hidden" name="tipo" value="parceiro">
	<table>
	<tr><td>Nome:</td><td><input type="text" name="parceiro" value="<?php echo $nome;?>"></td></tr>
	<tr><td>Categoria:</td><td>
	<select name="categoria">
	<?php if ($categorias) { ?>
            <?php 
			foreach ($categorias as $cat) { 
			?>
			<option value="<?php echo $cat['id'];?>"<?php echo ($catid==$cat['id']) ? ' selected':'';?>><?php echo $cat['nome'];?></option>
			<?php } ?>
	<?php } ?>
	</select>
	</td></tr>
	<tr>
              <td>Logomarca</td>
              <td><div class="image"><img width="100" height="100" src="../image/<?php echo $logo; ?>" alt="" id="thumb-logo" />
                  <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="logo" />
                  <br />
                  <a onclick="image_upload('logo', 'thumb-logo');">Enviar</a></div></td>
    </tr>
	<tr><td>Voucher % (0.00):</td><td><input type="text" name="valor" value="<?php echo $valor; ?>"></td></tr>

	</table>
	<input type="submit" value="Salvar" name="salvar">
	</form>
	<h2>Lista de Parceiros</h2>
	<table class="list">
	<thead>
    <tr>
	<td width="1" style="text-align: center;">ID</td>
	<td width="1" style="text-align: center;">Nome</td>
	<td width="1" style="text-align: center;">Categoria</td>
	<td width="1" style="text-align: center;">Logo</td>
	<td width="1" style="text-align: center;">% Voucher</td>

	<td width="1" style="text-align: center;"></td>
	</tr>
	</thead>
	<tbody>
	<?php if ($parceiros) { ?>
            <?php foreach ($parceiros as $cat) { ?>
	<tr>
	<td width="1" style="text-align: center; width: 50px;"><?php echo $cat['id'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['nome'];?></td>
	<td width="1" style="text-align: center;"><?php echo $cat['categoria'];?></td>
	<td width="1" style="text-align: center;"><img width="100" height="100" src="../image/<?php echo $cat['imagem'];?>"></td>
	<td width="1" style="text-align: center;"><?php echo $cat['valor'];?></td>

	<td width="1" style="text-align: center; width:120px;"><a href="<?php echo $action;?>&tab=ends&id=<?php echo $cat['id'];?>">[enderecos]</a> <a href="<?php echo $action;?>&tab=parceiros&id=<?php echo $cat['id'];?>&catid=<?php echo $cat['categoriaid'];?>&nome=<?php echo $cat['nome'];?>&imagem=<?php echo $cat['imagem'];?>&valor=<?php echo $cat['valor'];?>&end=<?php echo base64_encode($cat['end']);?>&acao=editar">[editar]</a> <a onclick="return confirm('Tem certeza em remover o parceiro <?php echo $cat['nome'];?>?');" href="<?php echo $action;?>&tab=parceiros&id_remover=<?php echo $cat['id'];?>&acao=remover">[remover]</a></td>
	</tr>
			<?php } ?>
	<?php } ?>
	</tbody>
	</table>
	</div>
	
	
	<div id="tab-status">
	<form action="<?php echo $action;?>" method="post" enctype="multipart/form-data" id="form">
	<table>
	 <tr>
            <td>Status usar Voucher:<br /><span class="help">Status de pedidos inicial para que clientes possam ter acesso a gerar Voucher.</span></td>
            <td><select name="voucherparceiros_status">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['name'] == $voucherparceiros_status) { ?>
                <option value="<?php echo $order_status['name']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['name']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
              <td>Logomarca Principal</td>
			  <?php
			  if(!isset($voucherparceiros_logo) || empty($voucherparceiros_logo)){
			  $voucherparceiros_logo = 'no_image.jpg';
			  }
			  ?>
              <td><div class="image"><img width="100" height="100" src="../image/<?php echo $voucherparceiros_logo; ?>" alt="" id="thumb-logop" />
                  <input type="hidden" name="voucherparceiros_logo" value="<?php echo $voucherparceiros_logo; ?>" id="logop" />
                  <br />
                  <a onclick="image_upload('logop', 'thumb-logop');">Enviar</a></div></td>
          </tr>
		  <tr>
		  <td></td>
		  <td><input type="submit" value="Salvar" name="salvar"></td>
		  </tr>
	</table>
	</form>
	</div>
	

    </div>
  </div>
</div>
<script type="text/javascript">
$('#tabs a').tabs();
<?php if(isset($_GET['tab'])){?>
$('#<?php echo $_GET['tab'];?>').trigger('click');
<?php } ?>
</script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Enviar logomarca de Parceiro',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img width="100" height="100" src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<?php echo $footer; ?>
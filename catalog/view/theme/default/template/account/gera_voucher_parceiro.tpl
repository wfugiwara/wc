<?php 

echo $header; 

?>

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

  

  <?php

  if($total_cliente>=1){

  ?>

  <p>Olá <strong><?php echo $cliente;?></strong>, em nosso banco de dados j&aacute; existe um voucher gerado para este parceiro, <a href="index.php?route=account/meus_vouchers">clique aqui</a> e veja os vouches que voc&ecirc; j&aacute; possui.</p>

  

  <?php } ?>

  

  <script>

  function validar(dados){

  if(dados.end.value==''){

  alert('selecione o endereco para qual deseja gera o voucher!');

  return false;

  }

  if(confirm('deseja solicitar o voucher escolhido?')){

  return true;

  }else{

  return false;

  }

  return true;

  }

  </script>

  

  <form onsubmit="return validar(this);" action="index.php?route=account/gera_voucher/salvar" method="post" enctype="multipart/form-data">

  <input type="hidden" name="parceiro" value="<?php echo $parceiro['idPar'];?>">

  <input type="hidden" name="cliente" value="<?php echo $cliente_id;?>">

    <table class="form">

	  <tr>

        <td><b>Parceiro:</b></td>

        <td><img width="100" src="image/<?php echo $parceiro['imagemPar'];?>"></td>

      </tr>

      <tr>

        <td><b>Parceiro:</b></td>

        <td><?php echo $parceiro['nomePar'];?></td>

      </tr>



      <tr>

        <td><b>Desconto:</b></td>

        <td><?php echo $parceiro['valVoucher'];?>% de desconto</td>

      </tr>

	  <tr>

        <td><b>Cliente:</b></td>

        <td><?php echo $cliente;?></td>

      </tr>

	  	  <tr>

        <td><b>Endere&ccedil;o:</b></td>

        <td><select name="end">

		<option value=''>-- Selecione --</option>

		<?php

		foreach($ends AS $k=>$v){

		echo "<option value='".$v['idL']."'>".$v['det']."</option>";

		}

		?>

		</select>

		</td>

      </tr>



    </table>

    <div class="buttons">

      <div class="right"><input type="submit" value="Solicitar Voucher" class="button" />

      </div>

    </div>

  </form>

  

  <?php echo $content_bottom; ?></div>

<?php echo $footer; ?>
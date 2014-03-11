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

  <h1>Gerar Voucher</h1>

  

  <?php if($pedido_validos>=1){?>

  <p>Na WeCare Auto qualidade e economia são preocupações constantes. Solicite a qualquer momento um voucher com descontos especiais que nossos Parceiros garantiram pra você.</p>

  

  <ul class="voucher">

  <?php

  foreach($categorias AS $key=>$cat){

  ?>

   <li><a href="index.php?route=account/gera_voucher/parceiros&cat=<?php echo $cat['idCat']; ?>&nome=<?php echo $cat['nomeCat']; ?>"><?php echo $cat['nomeCat']; ?></a></li>

  <?php

  }

  ?>

  </ul>

  

  <?php }else{ ?>

  <p>Para visualizar e utilizar a ferramenta de Voucher, é necessário ter efetuado a compra de um pacote de serviços WeCare Auto na loja.</p>

  <?php } ?>

  

  <?php echo $content_bottom; ?></div>

<?php echo $footer; ?>
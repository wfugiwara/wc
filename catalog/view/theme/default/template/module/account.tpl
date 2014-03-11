<div class="box">

  <div class="box-heading"><!--<?php echo $heading_title; ?>--></div>

  <div class="box-content menuConta">

    <ul>

      <?php if (!$logged) { ?>

      <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a> / <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>

      <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>

      <?php } ?>

      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>

      <?php if ($logged) { ?>

      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>

      <li><a href="<?php echo $password; ?>">Alterar senha</a></li>

      <?php } ?>

      <li><a href="<?php echo $address; ?>">Alterar endereços</a></li>

      <!--<li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>-->

      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>

      <!--<li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>-->

      <li><a href="<?php echo $return; ?>">Minhas devoluções</a></li>

      <!--<li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>-->
      
      <!--<li><a href="https://www.wecareauto.com.br/index.php?route=account/gera_voucher">Gerar Voucher</a></li>
      <li><a href="https://www.wecareauto.com.br/index.php?route=account/meus_vouchers">Meus Vouchers</a></li>-->

      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>

      <?php if ($logged) { ?>

      <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>

      <?php } ?>

    </ul>

  </div>

</div>


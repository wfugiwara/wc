<div data-role="content">
	<div data-role="collapsible" data-collapsed="true" data-theme="x" data-content-theme="z">
		<h3><?php echo $heading_title; ?></h3>
		<ul data-role="listview" data-theme="x" data-dividertheme="z">
      <?php if (!$logged) { ?>
      <li><a href="<?php echo $login; ?>" rel="external"><?php echo $text_login; ?></a></li>
      <li><a href="<?php echo $register; ?>" rel="external"><?php echo $text_register; ?></a></li>
      <li><a href="<?php echo $forgotten; ?>" rel="external"><?php echo $text_forgotten; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $account; ?>" rel="external"><?php echo $text_account; ?></a></li>
      <?php if ($logged) { ?>
      <li><a href="<?php echo $edit; ?>" rel="external"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>" rel="external"><?php echo $text_password; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $wishlist; ?>" rel="external"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $order; ?>" rel="external"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>" rel="external"><?php echo $text_download; ?></a></li>
      <li><a href="<?php echo $return; ?>" rel="external"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $transaction; ?>" rel="external"><?php echo $text_transaction; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>" rel="external"><?php echo $text_newsletter; ?></a></li>
      <?php if ($logged) { ?>
      <li><a href="<?php echo $logout; ?>" rel="external"><?php echo $text_logout; ?></a></li>
      <?php } ?>
    </ul>
	</div>
</div>    
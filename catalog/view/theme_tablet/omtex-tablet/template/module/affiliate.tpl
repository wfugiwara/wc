<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
<li data-role="list-divider"><?php echo $heading_title; ?></li>      
      <?php if (!$logged) { ?>
      <li><a href="<?php echo $login; ?>" rel="external"><?php echo $text_login; ?></a></li>
      <li> <li><a href="<?php echo $register; ?>" rel="external"><?php echo $text_register; ?></a></li></li>
      <li><a href="<?php echo $forgotten; ?>" rel="external"><?php echo $text_forgotten; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $account; ?>" rel="external"><?php echo $text_account; ?></a></li>
      <?php if ($logged) { ?>
      <li><a href="<?php echo $edit; ?>" rel="external"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>" rel="external"><?php echo $text_password; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $payment; ?>" rel="external"><?php echo $text_payment; ?></a></li>
      <li><a href="<?php echo $tracking; ?>" rel="external"><?php echo $text_tracking; ?></a></li>
      <li><a href="<?php echo $transaction; ?>" rel="external"><?php echo $text_transaction; ?></a></li>
      <?php if ($logged) { ?>
      <li><a href="<?php echo $logout; ?>" rel="external"><?php echo $text_logout; ?></a></li>
      <?php } ?>
    </ul>

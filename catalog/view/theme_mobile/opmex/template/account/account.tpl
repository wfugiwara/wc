<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <!--<h2><?php echo $heading_title; ?></h2>-->
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <ul data-role="listview" style="margin-top:10px;"  data-theme="a">
  <li data-role="list-divider"><?php echo $text_my_account; ?></li>
  <li><a href="<?php echo $edit; ?>" rel="external"><?php echo $text_edit; ?></a></li>
  <li><a href="<?php echo $password; ?>" rel="external"><?php echo $text_password; ?></a></li>
  <li><a href="<?php echo $address; ?>" rel="external"><?php echo $text_address; ?></a></li>
  <!--<li><a href="<?php echo $wishlist; ?>" rel="external"><?php echo $text_wishlist; ?></a></li>-->
  <li data-role="list-divider"><?php echo $text_my_orders; ?></li>
  <li><a href="<?php echo $order; ?>" rel="external"><?php echo $text_order; ?></a></li>
  <!--<li><a href="<?php echo $download; ?>" rel="external"><?php echo $text_download; ?></a></li>-->
  <?php if ($reward) { ?>
  <li><a href="<?php echo $reward; ?>" rel="external"><?php echo $text_reward; ?></a></li>
  <?php } ?>
  <li><a href="<?php echo $return; ?>" rel="external"><?php echo $text_return; ?></a></li>
  <!--<li><a href="<?php echo $transaction; ?>" rel="external"><?php echo $text_transaction; ?></a></li>-->
  <li data-role="list-divider"><?php echo $text_my_newsletter; ?></li>
  <li><a href="<?php echo $newsletter; ?>" rel="external"><?php echo $text_newsletter; ?></a></li>
  <li data-role="list-divider"><?php echo $text_logout; ?></li>
  <li><a href="index.php?route=account/logout" rel="external" ><?php echo $text_logout; ?></a></li>
  </ul>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 

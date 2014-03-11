<?php echo $header; ?>
<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <!--<h1><?php echo $heading_title; ?></h1>-->
  <ul data-role="listview" style="margin-top:10px;">
  <li data-role="list-divider"><?php echo $text_my_account; ?></li>
  <li><a href="<?php echo $edit; ?>" rel="external"><?php echo $text_edit; ?></a></li>
  <li><a href="<?php echo $password; ?>" rel="external"><?php echo $text_password; ?></a></li>
  <li><a href="<?php echo $payment; ?>" rel="external"><?php echo $text_payment; ?></a></li>
  <li data-role="list-divider"><?php echo $text_my_tracking; ?></li>
  <li><a href="<?php echo $tracking; ?>" rel="external"><?php echo $text_tracking; ?></a></li>
  <li data-role="list-divider"><?php echo $text_my_transactions; ?></li>
  <li><a href="<?php echo $transaction; ?>" rel="external"><?php echo $text_transaction; ?></a></li>
  <li data-role="list-divider"><?php echo $text_logout; ?></li>
  <li><a href="index.php?route=affiliate/logout" rel="external" ><?php echo $text_logout; ?></a></li>
  </ul>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 

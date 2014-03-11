<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <h2><?php echo $heading_title; ?></h2>
  <?php if ($returns) { ?>
  <ul data-role="listview">
  <?php foreach ($returns as $return) { ?>
  <li>
  <a href="<?php echo $return['href']; ?>" rel="external">
  <h3>
  <b><?php echo $text_return_id; ?></b> #<?php echo $return['return_id']; ?>
  <b><?php echo $text_status; ?></b> <?php echo $return['status']; ?>
  <b><?php echo $text_date_added; ?></b> <?php echo $return['date_added']; ?>
  </h3>
  <p>
  <b><?php echo $text_order_id; ?></b> <?php echo $return['order_id']; ?>
  <b><?php echo $text_customer; ?></b> <?php echo $return['name']; ?>
  </p>
  </a>
  </li>
  <?php } ?>
  </ul>
  <br/>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <br/><br/>
  <?php echo $text_empty; ?>
  <br/><br/>
  <?php } ?>
<a href="<?php echo $continue; ?>" class="button" data-role="button" data-theme="a" rel="external"><?php echo $button_continue; ?></a>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
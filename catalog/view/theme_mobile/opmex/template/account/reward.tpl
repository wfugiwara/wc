<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <?php echo $text_total; ?><b> <?php echo $total; ?></b>
  
  <?php if ($rewards) { ?>
  <ul data-role="listview">
  <!--<?php echo $column_date_added; ?>
  <?php echo $column_description; ?>
  <?php echo $column_points; ?>-->
  
      <?php foreach ($rewards  as $reward) { ?>
      <li>
      <h3><?php echo $column_points; ?><?php echo $reward['points']; ?>&nbsp;&nbsp;<?php echo $reward['date_added']; ?></h3>
      <p><?php if ($reward['order_id']) { ?>
      <a href="<?php echo $reward['href']; ?>" rel="external"><?php echo $reward['description']; ?></a>
      <?php } else { ?>
      <?php echo $reward['description']; ?>
      <?php } ?>
      </p>
     <div class="pagination"><?php echo $pagination; ?></div>
      </li>
      <?php } ?>
      </ul>
   <?php } else { ?>
   	<br/><br/>
    <?php echo $text_empty; ?>
   	<br/><br/>
   <?php } ?>

     <a href="<?php echo $continue; ?>" class="button" data-role="button" data-theme="a" rel="external"><?php echo $button_continue; ?></a>

</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
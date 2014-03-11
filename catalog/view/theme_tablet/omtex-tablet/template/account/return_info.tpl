<?php echo $header; ?>
<div data-role="content">
 <ul id="breadcrumbs-one">
    <?php 
    $total = count($breadcrumbs); 
    $i=0;
    foreach ($breadcrumbs as $breadcrumb) { 
        $i++;
        if($i==$total)
        {
    ?>
        <li><a class="current"><?php echo $breadcrumb['text']; ?></a></li>
    <?php 
        }else{
    ?>
      	<li><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a></li>
      <?php }
      } ?>
</ul>

<?php echo $column_left; ?>
<div id="column-center">
<?php echo $content_top; ?>
   <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <h4><?php echo $text_return_detail; ?></h4>
  <?php echo $text_return_id; ?>: #<?php echo $return_id; ?>
  <?php echo $text_date_added; ?>: <?php echo $date_added; ?>
  <?php echo $text_order_id; ?>: #<?php echo $return_id; ?>
  <?php echo $text_date_ordered; ?>: <?php echo $date_ordered; ?>
   
  <h3><?php echo $text_product; ?></h3>
         <?php echo $column_product; ?>: <?php echo $product; ?><br/>
        <?php echo $column_model; ?>: <?php echo $model; ?><br/>
        <?php echo $column_quantity; ?>: <?php echo $quantity; ?><br/>
 <br/>
 <?php echo $column_reason; ?>: <?php echo $reason; ?>
 <br/>
 <?php echo $column_opened; ?>: <?php echo $opened; ?>
 <br/>
 <?php echo $column_action; ?>: <?php echo $action; ?>
 <?php if ($comment) { ?>
 <br/>
 <?php echo $text_comment; ?>: <?php echo $comment; ?>
 <?php } ?>
  <?php if ($histories) { ?>
  <h2><?php echo $text_history; ?></h2>
 	  <ul data-role="listview">
      <?php foreach ($histories as $history) { ?>
      <li><p><?php echo $column_date_added; ?>: <?php echo $history['date_added']; ?><br/>
      <?php echo $column_status; ?>: <?php echo $history['status']; ?><br/>
      <?php echo $column_comment; ?>: <?php echo $history['comment']; ?><br/>
      </p></li>
      <?php } ?>
      </ul>
  <?php } ?>
<a href="<?php echo $continue; ?>" class="button" data-role="button" rel="external" data-theme="a"><?php echo $button_continue; ?></a>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?> 
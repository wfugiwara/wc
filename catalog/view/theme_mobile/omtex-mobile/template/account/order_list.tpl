<?php echo $header; ?>
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

<?php echo $content_top; ?>
<div data-role="content">
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <?php if ($orders) { ?>
  <ul data-role="listview">
  <?php foreach ($orders as $order) { ?>
 	<li><h3>
    <b><?php echo $text_order_id; ?></b> #<?php echo $order['order_id']; ?>
    <b><?php echo $text_status; ?></b> <?php echo $order['status']; ?>
    
    </h3><p>
    <b><?php echo $text_total; ?></b> <?php echo $order['total']; ?>, 
    <b><?php echo $text_date_added; ?></b> <?php echo $order['date_added']; ?><br/>
    <b><?php echo $text_products; ?></b> <?php echo $order['products']; ?>
    <b><?php echo $text_customer; ?></b> <?php echo $order['name']; ?>
    </p>
    </li>
    <br/>
  	&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $order['href']; ?>" rel="external"><img src="catalog/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $order['reorder']; ?>" rel="external"><img src="catalog/view/theme/default/image/reorder.png" alt="<?php echo $button_reorder; ?>" title="<?php echo $button_reorder; ?>" /></a>
    <br/>
   <?php } ?>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <br/><br/>
  <?php echo $text_empty; ?>
  <br/><br/>
  <?php } ?>
<a href="<?php echo $continue; ?>" class="button" data-theme="a" data-role="button" rel="external"><?php echo $button_continue; ?></a>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
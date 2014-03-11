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
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?> 
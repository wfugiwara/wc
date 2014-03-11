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
  <h2><?php echo $heading_title; ?></h2>
  <ul data-role="listview">
  <?php foreach ($downloads as $download) { ?>
  <li>
  <h3><b><?php echo $text_order; ?></b> <?php echo $download['order_id']; ?>
  <b><?php echo $text_size; ?></b> <?php echo $download['size']; ?>
  <b><?php echo $text_name; ?></b> <?php echo $download['name']; ?>
  </h3>
  <p>
  <b><?php echo $text_date_added; ?></b> <?php echo $download['date_added']; ?>
  <b><?php echo $text_remaining; ?></b> <?php echo $download['remaining']; ?>
  <?php if ($download['remaining'] > 0) { ?>
       <a href="<?php echo $download['href']; ?>" rel="external"><img src="catalog/view/theme/default/image/download.png" alt="<?php echo $button_download; ?>" title="<?php echo $button_download; ?>" /></a>
   <?php } ?>
  </p>
  <div class="pagination"><?php echo $pagination; ?></div>
  </li>
  <?php } ?>
  </ul>
<a href="<?php echo $continue; ?>" class="button" data-role="button" data-theme="a" rel="external"><?php echo $button_continue; ?></a>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
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
<h2><?php echo $heading_title; ?></h2>
  <?php if ($categories) { ?>
  <!--<p><b><?php echo $text_index; ?></b>
    <?php foreach ($categories as $category) { ?>
    <a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><b><?php echo $category['name']; ?></b></a>
    <?php } ?>
  </p>-->
  <ul data-role="listview">
  <?php foreach ($categories as $category) { ?>
  <li data-role="list-divider">
  	<?php echo $category['name']; ?>
    <!--<a id="<?php echo $category['name']; ?>"></a>-->
   </li>
     <?php if ($category['manufacturer']) { ?>
      <?php for ($i = 0; $i < count($category['manufacturer']);) { ?>
        <?php $j = $i + ceil(count($category['manufacturer']) / 4); ?>
        <?php for (; $i < $j; $i++) { ?>
        <?php if (isset($category['manufacturer'][$i])) { ?>
        <li><a href="<?php echo $category['manufacturer'][$i]['href']; ?>" rel="external"><?php echo $category['manufacturer'][$i]['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
       <?php } ?>
      <?php } ?>
  <?php } ?>
  </ul>
  <?php } else { ?>
<?php echo $text_empty; ?>
<a href="<?php echo $continue; ?>" class="button" data-role="button" rel="external"><?php echo $button_continue; ?></a>
<?php } ?>
<?php echo $content_bottom; ?>
</div></div>
<?php echo $footer; ?>
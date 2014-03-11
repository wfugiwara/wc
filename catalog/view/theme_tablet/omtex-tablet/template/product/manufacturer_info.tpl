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
  <h2 style="margin-top:5px; margin-bottom:5px;"><?php echo $heading_title; ?></h2>
  <?php if ($products) { ?>
     <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
     
      <div class="ui-grid-b">
	<?php $i=0; ?>
   <?php foreach ($products as $product) { ?>
   <div <?php if($i%3==0) { ?> class="ui-block-a" <?php } elseif($i%3==1) { ?> class="ui-block-b" <?php }elseif($i%3==2) { ?> class="ui-block-c"  <?php } $i++; ?> style="text-align:center;">
     
     <div class="grid-block">
      <a href="<?php echo $product['href']; ?>" rel="external">
      <?php if ($product['thumb']) { ?>
      <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" height="100px;" />
      <?php } ?>
      <h3><?php echo $product['name']; ?></h3>
       </a>
      <p><!--<?php echo $product['description']; ?><br/>-->
      <?php if ($product['price']) { ?>
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price'].'<br>'; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <br/>
      <img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
      <?php } ?>
      </p>
     
      </div>

 	</div>
    
    <?php } ?>

</div>
     <br/><br/>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
<?php echo $text_empty; ?>
<a href="<?php echo $continue; ?>" class="button" rel="external" data-role="button"><?php echo $button_continue; ?></a>
  <?php }?> 
<?php echo $content_bottom; ?>
</div></div>
<?php echo $footer; ?>
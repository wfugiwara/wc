<div data-role="content" style="margin-bottom:5px; margin-top:5px;">
    <?php if(isset($config_mobile_theme_product_view)) {
 		if($config_mobile_theme_product_view==0){
 ?>
 
 <ul data-role="listview" data-theme="a">
 <li data-role="list-divider"><?php echo $heading_title; ?></li>

     <?php foreach ($products as $product) { ?>
      <li><a href="<?php echo $product['href']; ?>" rel="external">
      <?php if ($product['thumb']) { ?>
      <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
      <?php } ?>
      <h3><?php echo $product['name']; ?></h3>
      <p><!--<?php echo $product['description']; ?><br/>-->
      <?php if ($product['price']) { ?>
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <br/>
      <img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
      <?php } ?>
      </p>
      </a>
      </li>
    <?php } ?>
   </ul>
      <br/><br/>
   <?php }else { ?>
   <ul data-role="listview" data-theme="c">
 <li data-role="list-divider"><?php echo $heading_title; ?></li>
 </ul>
  <div class="ui-grid-a grid-margin">
  <?php $i=0; ?>
   

  <?php foreach ($products as $product) { ?>
      <div class="<?php if($i%2==0) { echo "ui-block-a"; } else { echo "ui-block-b"; } ?>" style="text-align:center;">
      <?php $i++; ?>
      <?php if ($product['thumb']) { ?>
      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" width="100"/></a>
      <?php } ?>
      <br /><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
      <!--<p><?php echo $product['description']; ?><br/>-->
      <?php if ($product['price']) { ?>
        <br/>
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <br/>
      <img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
      <?php } ?>
      </p>
      </div>
      <?php } ?>
  </div>
  
  <?php }}?>
  <br/><br/>
</div>
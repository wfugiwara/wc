<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
<li data-role="list-divider"><?php echo $heading_title; ?></li> <li>
 <div class="ui-grid-b">
	<?php $i=0; ?>
       <?php foreach ($products as $product) { ?>
   <div <?php if($i%3==0) { ?> class="ui-block-a" <?php } elseif($i%3==1) { ?> class="ui-block-b" <?php }elseif($i%3==2) { ?> class="ui-block-c"  <?php } $i++; ?> style="text-align:center;">
     
     <div class="grid-block">
      <a href="<?php echo $product['href']; ?>" rel="external">
        <?php if ($product['thumb']) { ?>
        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
        <?php } ?>
        <h3><?php echo $product['name']; ?></h3>
        </a>
        <p>
        <?php if ($product['price']) { ?>
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span><br /> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        </p>
        
      </div>

 	</div>
    
    <?php } ?>
</div>
</li>
</ul>

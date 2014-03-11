<div data-role="content" style="margin-bottom:5px; margin-top:5px;">
<ul data-role="listview">
<li data-role="list-divider"><?php echo $heading_title; ?></li>
      <?php foreach ($products as $product) { ?>
      <li><a href="<?php echo $product['href']; ?>" rel="external">
        <?php if ($product['thumb']) { ?>
        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
        <?php } ?>
        <h3><?php echo $product['name']; ?></h3>
        <p>
        <?php if ($product['price']) { ?>
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?>
          <?php } ?>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        </p>
        </a>
        </li>
      <?php } ?>
</ul>
</div>
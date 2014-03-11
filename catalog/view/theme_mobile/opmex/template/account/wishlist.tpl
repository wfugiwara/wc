<?php echo $header; ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>  
  <?php if ($products) { ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="wishlist" data-ajax="false">
    <!--<?php echo $column_remove; ?></td>
        <?php echo $column_image; ?></td>
        <?php echo $column_name; ?></td>
        <?php echo $column_model; ?></td>
        <?php echo $column_stock; ?></td>
        <?php echo $column_price; ?></td>
        <?php echo $column_cart; ?></td>
        -->
          <ul data-role="listview" data-theme="a">
          <?php foreach ($products as $product) { ?>
          <li><a href="<?php echo $product['href']; ?>" rel="external">
          
           <?php if ($product['thumb']) { ?>
              <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
              <?php } ?>
            <h3><?php echo $product['name']; ?></h3>
            <p><?php echo $product['model']; ?>, 
            <?php echo $product['stock']; ?><br/>
            <?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <s><?php echo $product['price']; ?></s><b><?php echo $product['special']; ?></b>
                <?php } ?>
              </div>
              <?php } ?>
            </p>
            </a></li><br/>
            <table align="center"><tr>
            <td class="action"><img src="catalog/view/theme/default/image/cart-add.png" alt="<?php echo $button_cart; ?>" title="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" />&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<?php echo $product['remove']; ?>" rel="external"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a>
            </td>
           </tr></table> <br/>
          <?php } ?>
  </ul>
  </form>
 <a href="<?php echo $continue; ?>" class="button" data-role="button" rel="external"  data-theme="a"><?php echo $button_continue; ?></a>
  </div>
  <?php } else { ?>
  <br/><br/>
  <?php echo $text_empty; ?>
  <br/><br/>
  <a href="<?php echo $continue; ?>" class="button" data-role="button" rel="external"  data-theme="a"><?php echo $button_continue; ?></a>
  <?php } ?>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 

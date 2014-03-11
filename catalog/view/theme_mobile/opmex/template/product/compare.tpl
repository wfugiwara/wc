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
  
  <?php if ($products) { ?>
    <div data-role="collapsible-set" data-theme="c" data-content-theme="d">
		<h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
       
        <div data-role="collapsible" data-collapsed="true">
        <h3><?php echo $text_name; ?>, <?php echo $text_image; ?>, <?php echo $text_price; ?></h3>
        <ul data-role="listview">
        <?php foreach ($products as $product) { ?>
        <li>
        <a href="<?php echo $products[$product['product_id']]['href']; ?>" rel="external" >
           
        <?php if ($products[$product['product_id']]['thumb']) { ?>
          <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" />
          <?php } ?>
    
    	<h3><?php echo $products[$product['product_id']]['name']; ?></h3>
         <p><?php if ($products[$product['product_id']]['price']) { ?>
          <?php if (!$products[$product['product_id']]['special']) { ?>
          <?php echo $products[$product['product_id']]['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?></span> <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
          <?php } ?>
          <?php } ?>
        </p>
        </a>
</li>
<?php } ?>
</ul>
</div>
<!--<div data-role="collapsible" data-collapsed="true">
        <h3><?php echo $text_model; ?>, <?php echo $text_manufacturer; ?>, <?php echo $text_availability; ?></h3>
        <ul data-role="listview">	
		<?php foreach ($products as $product) { ?>
        <li>
        <h3><?php echo $products[$product['product_id']]['name']; ?></h3>
     	<p><?php echo $text_model; ?>: <?php echo $products[$product['product_id']]['name']; ?><br/>
        <?php echo $text_manufacturer; ?>: <?php echo $products[$product['product_id']]['manufacturer']; ?><br/>
        <?php echo $text_availability; ?>: <?php echo $products[$product['product_id']]['availability']; ?>
        </p>
        </li>
        <?php } ?>
</ul>
</div>-->

<!--<div data-role="collapsible" data-collapsed="true">
        <h3><?php echo $text_rating; ?>, <?php echo $text_weight; ?>, <?php echo $text_dimension; ?></h3>
        <ul data-role="listview">	
		<?php foreach ($products as $product) { ?>
        <li>
        <h3><?php echo $products[$product['product_id']]['name']; ?></h3>
     	<p>
        <?php echo $text_rating; ?>: <img src="catalog/view/theme/default/image/stars-<?php echo $products[$product['product_id']]['rating']; ?>.png" alt="<?php echo $products[$product['product_id']]['reviews']; ?>" /> <?php echo $products[$product['product_id']]['reviews']; ?><br/>
        <?php echo $text_weight; ?>: <?php echo $products[$product['product_id']]['weight']; ?><br/>
        <?php echo $text_dimension; ?>: <?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?>
          </p>
        </li>
        <?php } ?>
</ul>
</div>-->

<div data-role="collapsible" data-collapsed="true">
        <h3><?php echo $text_summary; ?></h3>
        <?php foreach ($products as $product) { ?>
        <h3><?php echo $products[$product['product_id']]['name']; ?></h3>
     	<p><?php echo $text_summary; ?>: <?php echo $products[$product['product_id']]['description']; ?>
        </p>
        <?php } ?>
</div>

<?php if($attribute_groups) { ?>
<div data-role="collapsible" data-collapsed="true">
        <?php foreach ($attribute_groups as $attribute_group) { ?>
    <h3><?php echo $attribute_group['name']; ?></h3>
    <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
        <h3><?php echo $attribute['name']; ?></h3>
        <?php foreach ($products as $product) { ?>
        <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
        <b><?php echo $products[$product['product_id']]['name']; ?></b>
        <p><?php echo $products[$product['product_id']]['attribute'][$key]; ?></p>
        <?php } else { ?>
        <?php } ?>
        <?php } ?>
    <?php } ?>
    <?php } ?>
   <?php } ?> 
</div>


<?php foreach ($products as $product) { ?>
      <b><?php echo $products[$product['product_id']]['name']; ?></b>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
          <a href="<?php echo $product['remove']; ?>" class="button" rel="external" data-role="button" data-inline="true"><?php echo $button_remove; ?></a>
         <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" data-theme="b" data-inline="true" />
         </form>
        <?php } ?>


</div>
 
<a href="<?php echo $continue; ?>" class="button" rel="external" data-role="button"  data-theme="a"><?php echo $button_continue; ?></a>
  <?php } else { ?>
<?php echo $text_empty; ?>
<a href="<?php echo $continue; ?>" class="button" rel="external" data-role="button"  data-theme="a"><?php echo $button_continue; ?></a>
  <?php } ?>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
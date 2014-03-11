<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php echo $content_top; ?>
<div data-role="content" data-theme="a">
   <?php if ($products) { ?>
    <!--<div class="sort" style="margin-bottom:15px;">
      <select onchange="location = this.value;" data-theme="a" >
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected">Sort By <?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>">Sory By <?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>-->
    <?php if(isset($config_mobile_theme_product_view)) {
 		if($config_mobile_theme_product_view==0){
 ?>
 
 <ul data-role="listview" data-theme="a">
     <?php foreach ($products as $product) { ?>
      <li><a href="<?php echo $product['href']; ?>" rel="external">
      <?php if ($product['thumb']) { ?>
      <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
      <?php } ?>
      <h3><?php echo $product['name']; ?></h3>
      <p><?php echo $product['description']; ?><br/>
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
  <div class="ui-grid-a" style="margin:-15px; ">
  <?php $i=0; ?>
  <?php foreach ($products as $product) { ?>
      <div class="<?php if($i%2==0) { echo "ui-block-a"; } else { echo "ui-block-b"; } ?>" style="text-align:center;">
      <?php $i++; ?>
      <?php if ($product['thumb']) { ?>
      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" width="100"/></a>
      <?php } ?>
      <br /><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
      <p><?php echo $product['description']; ?><br/>
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
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <?php echo $text_empty; ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button" rel="external" data-role="button"  data-theme="a"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php } ?>
</div>
<div data-role="content" data-theme="a">
<?php if ($categories) { ?>
<div class="content-secondary">
	<div data-role="collapsible" data-collapsed="true" data-theme="a" data-content-theme="d">
	<h3>Categories of <?php echo $heading_title; ?></h3>
	<ul data-role="listview" data-theme="a" data-dividertheme="d">
    <?php foreach ($categories as $category) { ?>
      <li><a href="<?php echo $category['href']; ?>" rel="external"><?php echo $category['name']; ?></a></li>
      <?php } ?> 
    </ul>
	</div>
</div>
<?php } ?>
</div>
<?php echo $content_bottom; ?>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.cookie('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
						
			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.cookie('display', 'grid');
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}
//--></script> 
<?php echo $footer; ?>
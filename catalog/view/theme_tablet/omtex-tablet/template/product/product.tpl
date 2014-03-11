<?php echo $header; ?>
<?php echo $content_top; ?>
<div data-role="content" style="text-align:center;">

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
    
<h2 style="margin:5px;"><?php echo $heading_title; ?></h2>
<div class="product-info">

<div class="ui-grid-a" style="text-align:left">
	<div class="ui-block-a">
        <?php if ($thumb || $images) { ?>
        <div class="left">
          <?php if ($thumb) { ?>
          <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox" data-ajax="false"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
          <?php } ?>
          <?php if ($images) { ?>
          <div class="image-additional">
            <?php foreach ($images as $image) { ?>
            <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox" data-ajax="false"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
            <?php } ?>
          </div>
          <?php } ?>
        </div>
        <?php } ?>

	</div>
    
    <div class="ui-block-b">

    <div class="description">
      <?php if ($manufacturer) { ?>
      <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>" rel="external"><?php echo $manufacturer; ?></a><br />
      <?php } ?>
      <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
      <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
      <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
    <?php if ($price) { ?>
    <div class="price"><?php echo $text_price; ?>
      <?php if (!$special) { ?>
      <?php echo $price; ?>
      <?php } else { ?>
      <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
      <?php } ?>
      <br />
      <?php if ($tax) { ?>
      <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
      <?php } ?>
      <?php if ($points) { ?>
      <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span> <br />
      <?php } ?>
      <?php if ($discounts) { ?>
      <br />
      <div class="discount">
        <?php foreach ($discounts as $discount) { ?>
        <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
    </div>
    <fieldset>
          <?php if ($options) { ?>
          <div class="options">
            <h2><?php echo $text_option; ?></h2>
            <br />
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <select name="option[<?php echo $option['product_option_id']; ?>]">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              <br />
              <?php } ?>
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              <br />
              <?php } ?>
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
         <style type="text/css">
			.option-image .ui-btn-inner {
			 white-space:normal;	
			}
			</style>
           <table class="option-image">
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <tr>
                  <td><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                  </td><td>
                  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
                  <table><tr><td><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" />
                  </td><td>
                  <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </td>
                    </tr>
                   </table>
                   </label>
                   </td> 
                </tr>
                <?php } ?>
              </table>
          </div>
        <br />
        <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
              <!--<a class="button" id="button-option-<?php echo $option['product_option_id']; ?>" rel="external"><span><?php echo $button_upload; ?></span></a>-->
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" data-role="datebox"
   data-options='{"mode": "calbox"}' />
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
            </div>
            <br />
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <b><?php echo $option['name']; ?>:</b><br />
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
            </div>
            <br />
            <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
          <div class="share" style="margin-left:10px; margin-top:10px;"><!-- AddThis Button BEGIN -->
            <div class="addthis_default_style"><a class="addthis_button_compact" ><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
            <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
            <!-- AddThis Button END --> 
            </div>
            <br/><br/>
         <table width="100%"><tr><td>Quantity</td><td>
          <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" style="width:50px;"/>
          </td><td>
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" data-theme="b" />
          </td></tr></table>
          <div data-role="controlgroup"> <a onclick="addToWishList('<?php echo $product_id; ?>');" data-role="button" data-theme="c" data-icon="add" rel="external">
            <?php echo $button_wishlist; ?>
            </a> <a onclick="addToCompare('<?php echo $product_id; ?>');" data-role="button" data-theme="c" data-icon="add" rel="external">
            <?php echo $button_compare; ?>
            </a> </div>
          <?php if ($minimum > 1) { ?>
          <div class="minimum"><?php echo $text_minimum; ?></div>
          <?php } ?>
        </fieldset>
        
    </div>
</div>
 
    <div data-role="collapsible" data-collapsed="true" data-theme="a" data-content-theme="d">
      <h3><?php echo $tab_description; ?></h3>
     <?php echo $description; ?>
    </div>
   <?php if ($attribute_groups) { ?>
    <div data-role="collapsible" data-collapsed="true" data-theme="a" data-content-theme="d">
      <h3><?php echo $tab_attribute; ?></h3>
        <table class="attribute">
          <?php foreach ($attribute_groups as $attribute_group) { ?>
          <thead>
            <tr>
              <td colspan="2"><?php echo $attribute_group['name']; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
            <tr>
              <td><?php echo $attribute['name']; ?></td>
              <td><?php echo $attribute['text']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
          <?php } ?>
        </table>
      </div>
   <?php } ?> 
    <?php if ($review_status) { ?>
      <div data-role="collapsible" data-collapsed="true" data-theme="a" data-content-theme="d">
        <h3><?php echo $tab_review; ?><!--<img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />--></h3>
        <div id="review"></div>
        <div data-role="fieldcontain">
          
          <h3><?php echo $text_write; ?></h3>
          <fieldset>
            <input type="text" name="name" value="" placeholder="<?php echo $entry_name; ?>" />
            <textarea  name="review" placeholder="<?php echo $entry_review; ?>">
            </textarea>
          </fieldset>
          <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
          <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
          <fieldset data-role="controlgroup">
            <input type="radio" name="rating" id="radio-choice-1" value="1" />
            <label for="radio-choice-1">1</label>
            <input type="radio" name="rating" id="radio-choice-2" value="2"  />
            <label for="radio-choice-2">2</label>
            <input type="radio" name="rating" id="radio-choice-3" value="3"  />
            <label for="radio-choice-3">3</label>
            <input type="radio" name="rating" id="radio-choice-4" value="4"  />
            <label for="radio-choice-4">4</label>
            <input type="radio" name="rating" id="radio-choice-5" value="5" checked="checked"  />
            <label for="radio-choice-5">5</label>
          </fieldset>
          &nbsp; <span><?php echo $entry_good; ?></span><br />
          <br />
          <fieldset>
            <input type="text" name="captcha" value="" placeholder="<?php echo $entry_captcha; ?>" />
            <br/><img src="index.php?route=product/product/captcha" alt="" id="captcha" />
			<a class="button" id="button-review" rel="external" data-role="button"><span><?php echo $button_continue; ?></span></a>
          </fieldset>
        </div>
      </div>
    <?php } ?>

 
<?php if ($products) { ?>
  <div data-role="collapsible" data-collapsed="true" data-theme="a" data-content-theme="d">
    <h3><?php echo $tab_related; ?> (<?php echo count($products); ?>)</h3>
    <ul data-role="listview">
    <?php foreach ($products as $product) { ?>
    <li><a href="<?php echo $product['href']; ?>" rel="external">
      <?php if ($product['thumb']) { ?>
      <div class="image"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></div>
      <?php } ?>
      <div class="name"><?php echo $product['name']; ?></div>
      <?php if ($product['price']) { ?>
      <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
     <!-- <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" rel="external"><span><?php echo $button_cart; ?></span></a>-->
      </a></li>
    <?php } ?>
    </ul>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>

    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
<?php echo $content_bottom; ?>
</div></div>
<script type="text/javascript"><!--
$('.fancybox').fancybox({cyclic: true});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {



					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}



				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
				$(".success a").attr("rel","external");	
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
$('#review').listview('refresh');

$('#button-review').bind('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});

//--></script> 

<?php echo $footer; ?>
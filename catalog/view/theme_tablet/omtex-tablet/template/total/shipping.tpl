<div data-role="collapsible" data-collapsed="true" id="shipping">
			<h3><?php echo $heading_title; ?></h3>
  				<p><?php echo $text_shipping; ?></p>
    			<span class="required">*</span> <?php echo $entry_country; ?>
        <select name="country_id" onchange="refresh_zone();$('select[name=\'zone_id\']').load('index.php?route=total/shipping/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');" data-native-menu="true">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($countries as $country) { ?>
            <?php if ($country['country_id'] == $country_id) { ?>
            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select><br />
        
        <div id="shipping_address_zone_id">
  		<span class="required">*</span> <?php echo $entry_zone; ?>
        <select name="zone_id" class="large-field" data-native-menu="true">
		   <option value=""><?php echo $text_select; ?></option>
	        <?php foreach ($zones as $zone) { ?>
	        <?php if ($zone['zone_id'] == $zone_id) { ?>
		        <option value="<?php echo $zone['zone_id']; ?>" selected="selected"><?php echo $zone['name']; ?></option>
	        <?php } else { ?>
		        <option value="<?php echo $zone['zone_id']; ?>"><?php echo $zone['name']; ?></option>
	        <?php } ?>
	        <?php } ?>
	      </select><br />    
		</div>
        
        <!--<span class="required">*</span> <?php echo $entry_zone; ?>
        <select name="zone_id" data-native-menu="true">
        </select><br />-->
        <br/> 
       <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="*<?php echo $entry_postcode; ?>" />
    
    <a id="button-quote" class="button" data-role="button" rel="external"><?php echo $button_quote; ?></a>
    <div id="quote" style="display: none;"></div>
    <input type="hidden" name="shipping_method" value="<?php echo $code; ?>" />
 </div>    
<script type="text/javascript"><!--
function refresh_zone(){
$('#shipping_address_zone_id span.ui-btn-text').html('<?php echo $text_select; ?>');
$('#shipping_address_zone_id select[name=\'zone_id\']').empty();
}
$('#button-quote').bind('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=total/shipping/quote',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-quote').attr('disabled', true);
			$('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-quote').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			$('.error').remove();

			if (json['redirect']) {
				location = json['redirect'];
			}
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#basket').before('<div class="warning">' + json['error']['warning'] + '</div>');
				}
				
				if (json['error']['country']) {
					$('#shipping select[name=\'country_id\'] + br').after('<div class="error">' + json['error']['country'] + '</div>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping select[name=\'zone_id\'] + br').after('<div class="error">' + json['error']['zone'] + '</div>');
				}
				
				if (json['error']['postcode']) {
					$('#shipping input[name=\'postcode\']').after('<div class="error">' + json['error']['postcode'] + '</div>');
				}					
			}
			
			if (json['shipping_methods']) {
				html  = '<br />';
				html += '<fieldset data-role="controlgroup">';
				for (i in json['shipping_methods']) {
												
					if (!json['shipping_methods'][i]['error']) {
						for (j in json['shipping_methods'][i]['quote']) {
							
							if (json['shipping_methods'][i]['quote'][j]['code'] == $('input[name=\'shipping_method\']').attr('value')) {
								html += '<input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" checked="checked" />';
							} else {
								html += '<input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" />';
							}
								
							html += '  <label for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['title'] + ' - ' + json['shipping_methods'][i]['quote'][j]['text'] + '</label>';
							
						}		
					} else {
						html += '  <div class="error">' + json['shipping_methods'][i]['error'] + '</div>';
					}
				}
				html += '</fieldset>';
				html += '<br /><a id="button-shipping" class="button" data-role="button" rel="external"><span><?php echo $button_shipping; ?></span></a>';				
		
				$('#quote').html(html).page();	
			
				$('#quote').slideDown('slow');
			}
		}
	});
});

$('#button-shipping').live('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=total/shipping/calculate',
		data: 'shipping_method=' + $('input[name=\'shipping_method\']:checked').attr('value'),
		dataType: 'json',		
		beforeSend: function() {
			$('.warning').remove();
			$('#button-shipping').attr('disabled', true);
			$('#button-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-shipping').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$('#shipping').before('<div class="warning">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
			}
			
			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('index.php?route=total/shipping/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
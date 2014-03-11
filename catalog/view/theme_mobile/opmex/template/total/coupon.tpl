<div data-role="collapsible" data-collapsed="true">
	<h3><?php echo $heading_title; ?></h3>
	<div id="coupon"><?php //echo $entry_coupon; ?>&nbsp;
 	<input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_coupon; ?>" />
    &nbsp;<a id="button-coupon" class="button" data-role="button" rel="external" data-theme="a"><?php echo $button_coupon; ?></a>
    </div>
</div>               
<script type="text/javascript"><!--
$('#button-coupon').bind('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=total/coupon/calculate',
		data: $('#coupon :input'),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-coupon').attr('disabled', true);
			$('#button-coupon').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-coupon').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$('#coupon').after('<div class="warning" style="margin-bottom:25px;">' + json['error'] + '&nbsp;&nbsp;<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
			}
			
			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script> 
<div data-role="collapsible" data-collapsed="true">
			<h3><?php echo $heading_title; ?></h3>
  				<div id="voucher"><?php //$entry_voucher; ?>&nbsp;
 				    <input type="text" name="voucher" value="<?php echo $voucher; ?>" placeholder="<?php echo $entry_voucher; ?>" />
    				&nbsp;<a id="button-voucher" class="button" data-role="button" rel="external"><?php echo $button_voucher; ?></a>
                </div>
</div>     
<script type="text/javascript"><!--
$('#button-voucher').bind('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=total/voucher/calculate',
		data: $('#voucher :input'),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-voucher').attr('disabled', true);
			$('#button-voucher').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-voucher').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$('#voucher').after('<div class="warning">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
			}
			
			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script> 
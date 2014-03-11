function copyAlert() { alert('Shipping Address Copied to Clipboard'); }

function showButton(shippingAddress) {
	document.write('<object width="220" height="25" style="display: inline-block; position: relative; float: left;">');
	document.write('<param name="movie" value="view/image/copy_button.swf">');
	document.write('<PARAM NAME=FlashVars VALUE="ctext=' + encodeURIComponent(shippingAddress) + '">');
	document.write('<param name="wmode" value="transparent">');
	document.write('<embed width="100%" height="100%" src="view/image/copy_button.swf" wmode="transparent" flashvars="ctext=' + encodeURIComponent(shippingAddress) +  '">');
	document.write('</embed>');
	document.write('</object>');
}

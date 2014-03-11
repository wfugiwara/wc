<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <?php if (!$logged) { ?>
  <div id="checkout">
  	<a id="login-show" style="color:#FF0000;"><?php echo $text_checkout_option; ?></a>
  	<div id="login"></div>
  </div>
  <?php } ?>
  <div class="slider-left">
    <?php if (!$logged) { ?>
    <div id="payment-address">
      <div class="onecheckout-heading"><span><?php echo $text_checkout_account; ?></span></div>
      <div class="onecheckout-content"></div>
    </div>
    <?php } else { ?>
    <div id="payment-address">
      <div class="onecheckout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
      <div class="onecheckout-content"></div>
    </div>
    <?php } ?>
    <?php if ($shipping_required) { ?>
    <div id="shipping-address">
      <div class="onecheckout-heading"><?php echo $text_checkout_shipping_address; ?></div>
      <div class="onecheckout-content"></div>
    </div>
	<?php } ?>
  </div>
  
  <div class="slider-mid">
    <?php if ($shipping_required) { ?>
    <div id="shipping-method">
      <div class="onecheckout-heading"><?php echo $text_checkout_shipping_method; ?></div>
      <div class="onecheckout-content"></div>
    </div>
    <?php } ?>
    <div id="payment-method">
      <div class="onecheckout-heading"><?php echo $text_checkout_payment_method; ?></div>
      <div class="onecheckout-content"></div>
    </div>
  </div>
  
  <div class="slider-right">
    <div id="confirm">
      <div class="onecheckout-heading"><?php echo $text_checkout_confirm; ?></div>
      <div class="onecheckout-content"></div>
    </div>
  </div>
  <div id="confirmorder" style="clear:both"></div>
  <?php echo $content_bottom; ?></div>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/onecheckout.css" media="screen" />
<style type="text/css">
<?php if ($this->config->get('onecheckout_style')==3 || !$this->config->get('onecheckout_style')) { ?>
.slider-left{width:32%;float:left;text-align:left;}
.slider-mid{width:28%;float:left;margin:0 3%;text-align:left;}
.slider-right{width:32%;float:left;text-align:left;}
<?php } elseif($this->config->get('onecheckout_style')==2) { ?>
.slider-left{width:50%;float:left;}
.slider-mid{width:46%;float:left;margin:0 0 0 3%;}
.slider-right{width:100%;float:left;}
<?php } elseif($this->config->get('onecheckout_style')==1) { ?>
.slider-left{width:100%;}
.slider-mid{width:100%;margin-left:0;}
.slider-right{width:100%;}
<?php } ?>
</style> 
<script type="text/javascript" src="catalog/view/javascript/jquery/onecolorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/onecolorbox/colorbox.css" media="screen" /> 
<script type="text/javascript"><!--
$(document).ready(function() {	
<?php if (!$logged) { ?> 
	$.ajax({
		url: 'index.php?route=onecheckout/login',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#checkout #login').html(json['output']);
				
			}
		}
	});	
	$.ajax({
		url: 'index.php?route=onecheckout/form',
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#payment-address .onecheckout-content').html(json['output']);		
				registerorguest();
			}
		}
	});	
	<?php if ($shipping_required) { ?>
	$.ajax({
		url: 'index.php?route=onecheckout/shipping',
		type: 'get',
		data: {countryid: '<?php echo $shipping_country_id; ?>',zoneid: '<?php echo $shipping_zone_id; ?>', isset:0 , city: '<?php echo $shipping_city; ?>', postcode: '<?php echo $shipping_postcode; ?>'},
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
											
			if (json['output']) {
				$('#shipping-method .onecheckout-content').html(json['output']);
				$('#shipping-method .onecheckout-content').slideDown('slow');	
								
					$.ajax({
						url: 'index.php?route=onecheckout/shipping&countryid=<?php echo $shipping_country_id; ?>&zoneid=<?php echo $shipping_zone_id; ?>&isset=0&city=<?php echo $shipping_city; ?>&postcode=<?php echo $shipping_postcode; ?>',
						type: 'post',
						data: $('#shipping-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}			
							paymentmethodload('<?php echo $payment_country_id; ?>', '<?php echo $payment_zone_id; ?>', 0 , '<?php echo $payment_city; ?>', '<?php echo $payment_postcode; ?>');
							
						}
					});	
	
			}
		}
	});	
	<?php } else { ?>
	paymentmethodload('<?php echo $payment_country_id; ?>', '<?php echo $payment_zone_id; ?>', 0 , '<?php echo $payment_city; ?>', '<?php echo $payment_postcode; ?>');
	<?php } ?>
<?php }else{ ?>
	$.ajax({
		url: 'index.php?route=onecheckout/address/payment',
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				if (json['alert']) {
					alert(json['alert']);
					json['output'] = '' ;
				}
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#payment-address .onecheckout-content').html(json['output']);
				<?php if ($shipping_required) { ?>
				shippingaddresslogin();
				<?php } else { ?>
				paymentmethodidload($('#payment-address select[name=\'address_id\']').val());
				<?php } ?>	
			}
		}
	});
<?php } ?>
});

//login down
$('#login-show').live('click', function() {
	$('#checkout #login').slideToggle('slow');
})

//login up
$('.close_la').live('click', function() {
	$('#checkout #login').slideUp('slow');
})

//register or guest 
$('#payment-address input[name=\'account\']').live('change', function() {
	registerorguest();
});

$('#payment-address input[name=\'shipping_address\']').live('change', function() {
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		$('#shipping-address').slideUp('slow');
		shippingmethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());	
		if($('#shipping-address .onecheckout-content .error'))
		  $('#shipping-address .onecheckout-content .error').remove();
	} else {
		$('#shipping-address').slideDown('slow');
		shippingmethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());	
	}
});

$('#shipping-method input[name=\'shipping_method\']').live('change', function() {
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		countryid = $('#payment-address select[name=\'country_id\']').val();
		zoneid = $('#payment-address select[name=\'zone_id\']').val();
		cityval =$('#payment-address input[name=\'city\']').val();
		postcodeval = $('#payment-address input[name=\'postcode\']').val();
	} else {
		countryid = $('#shipping-address select[name=\'country_id\']').val();
		zoneid = $('#shipping-address select[name=\'zone_id\']').val();
		cityval = $('#shipping-address input[name=\'city\']').val();
		postcodeval = $('#shipping-address input[name=\'postcode\']').val();
	}
	
	ajaxurl = 'index.php?route=onecheckout/shipping&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=1&city=' + cityval + '&postcode=' + postcodeval;
	
	if($('#shipping-address input[name=\'shipping_address\']:checked').val()=='existing'){
		ajaxurl = 'index.php?route=onecheckout/shipping&addressid=' + $('#shipping-address select[name=\'address_id\']').val();
	}
	
	$.ajax({
		url: ajaxurl,
		type: 'post',
		data: $('#shipping-method input[type=\'radio\']:checked'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#shipping-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
				}			
			} else {
				<?php if($this->config->get('onecheckout_refresh_payment')){ ?>
				refreshpayment()
				<?php } else { ?>
				confirmorder();
				<?php } ?>
			}
		}
	});	
					
});

$('#payment-method input[name=\'payment_method\']').live('change', function() {
	countryid = $('#payment-address select[name=\'country_id\']').val();
	zoneid = $('#payment-address select[name=\'zone_id\']').val();
	cityval = $('#payment-address input[name=\'city\']').val();
	postcodeval = $('#payment-address input[name=\'postcode\']').val();
	
	ajaxurl = 'index.php?route=onecheckout/payment&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=1&city=' + cityval + '&postcode=' + postcodeval;
	
	if($('#payment-address input[name=\'payment_address\']:checked').val()=='existing'){
		ajaxurl = 'index.php?route=onecheckout/payment&addressid=' + $('#payment-address select[name=\'address_id\']').val();
	}
	
	$.ajax({
		url: ajaxurl,
		type: 'post',
		data: $('#payment-method input[type=\'radio\']:checked'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
				}			
			} else {
				confirmorder();
			}
		}
	});	
					
});

function registerorguest(){

  if($('#reg-cpanle'))
    $('#reg-cpanle').remove();
	
  if($('#guest-cpanle'))
    $('#guest-cpanle').remove();
	
  if($('#payment-address input[name=\'account\']:checked').attr('value')){
	$.ajax({
		url: 'index.php?route=onecheckout/register',
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address .onecheckout-content').append('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#payment-address .onecheckout-content').append(json['output']);
				<?php if ($shipping_required) { ?>
				shippingaddressreg();
				<?php } ?>
			}
		}
	});	
  } else {
  	$.ajax({
		url: 'index.php?route=onecheckout/guest',
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address .onecheckout-content').append('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {
				$('#payment-address .onecheckout-content').append(json['output']);
				<?php if ($shipping_required) { ?>
				shippingaddress();
				<?php } ?>
			}
		}
	});	
  }
}

function shippingaddress(){
	var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
				
	if (shipping_address) {
		$('#shipping-address').slideUp('slow');
	} else {
		$('#shipping-address').slideDown('slow');
	}
											
	$.ajax({
		url: 'index.php?route=onecheckout/guest/shipping',
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}										
					
			if (json['output']) {
				$('#shipping-address .onecheckout-content').html(json['output']);											
			}
		}
	});				
}

function shippingaddresslogin(){
	$.ajax({
		url: 'index.php?route=onecheckout/address/shipping',
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}										
					
			if (json['output']) {											
				$('#shipping-address .onecheckout-content').html(json['output']);		
				$('#shipping-address').slideDown('slow');	
				
				$.ajax({
					url: 'index.php?route=onecheckout/shipping',
					type: 'get',
					data: {addressid: $('#shipping-address select[name=\'address_id\']').val()},
					dataType: 'json',
					beforeSend: function() {
						$('#shipping-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
					},		
					complete: function() {
						$('.wait').remove();
					},
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
											
						if (json['output']) {
							//$('#shipping-method .onecheckout-content').slideUp('slow');
							$('#shipping-method .onecheckout-content').html(json['output']);
							$('#shipping-method .onecheckout-content').slideDown('slow');	
							
							$.ajax({
								url: 'index.php?route=onecheckout/shipping&addressid=' + $('#shipping-address select[name=\'address_id\']').val(),
								type: 'post',
								data: $('#shipping-method input[type=\'radio\']:checked'),
								dataType: 'json',
								success: function(json) {
									if (json['redirect']) {
										location = json['redirect'];
									}
			
									paymentmethodidload($('#payment-address select[name=\'address_id\']').val());
								}
							});	
						}
					}
				});								
			}
		}
	});				
}

function shippingaddressreg(){
	var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
				
	if (shipping_address) {
		$('#shipping-address').slideUp('slow');
	} else {
		$('#shipping-address').slideDown('slow');
	}
											
	$.ajax({
		url: 'index.php?route=onecheckout/guest/shipping',
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}										
					
			if (json['output']) {
				$('#shipping-address .onecheckout-content').html(json['output'])
				$('#shipping-address .onecheckout-content').prepend('<input type="radio" name="shipping_address" value="new" checked="checked" style="display:none;" />');										
			}
		}
	});			
}

function shippingmethod(countryid, zoneid, isset, city, postcode) {
	$.ajax({
		url: 'index.php?route=onecheckout/shipping',
		type: 'get',
		data: {countryid: countryid,zoneid: zoneid, isset:isset, city:city, postcode:postcode},
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
											
			if (json['output']) {
				//$('#shipping-method .onecheckout-content').slideUp('slow');
				$('#shipping-method .onecheckout-content').html(json['output']);
				$('#shipping-method .onecheckout-content').slideDown('slow');	
								
					$.ajax({
						url: 'index.php?route=onecheckout/shipping&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=' + isset + '&city=' + city + '&postcode=' + postcode,
						type: 'post',
						data: $('#shipping-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (!json['error']) {
								confirmorder();
							}
						}
					});	
	
			}
		}
	});	
}

function paymentmethod(countryid, zoneid, isset, city, postcode) {
	$.ajax({
		url: 'index.php?route=onecheckout/payment',
		type: 'get',
		data: {countryid: countryid, zoneid: zoneid, isset:isset, city:city, postcode:postcode},
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				//$('#payment-method .onecheckout-content').slideUp('slow');
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
				  $.ajax({
						url: 'index.php?route=onecheckout/payment&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=' + isset + '&city=' + city + '&postcode=' + postcode,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (!json['error']) {
								confirmorder();
							}
						}
					});	
						
			}
		}
	});	
}

function paymentmethodload(countryid, zoneid, isset, city, postcode) {
	$.ajax({
		url: 'index.php?route=onecheckout/payment',
		type: 'get',
		data: {countryid: countryid, zoneid: zoneid, isset:isset, city:city, postcode:postcode},
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
				  $.ajax({
						url: 'index.php?route=onecheckout/payment&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=' + isset + '&city=' + city + '&postcode=' + postcode,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
							confirmorder();
						}
					});	
						
			}
		}
	});	
}

function shippingmethodid(addressid) {
	$.ajax({
		url: 'index.php?route=onecheckout/shipping',
		type: 'get',
		data: {addressid: addressid},
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
											
			if (json['output']) {
				//$('#shipping-method .onecheckout-content').slideUp('slow');
				$('#shipping-method .onecheckout-content').html(json['output']);
				$('#shipping-method .onecheckout-content').slideDown('slow');	
								
					$.ajax({
						url: 'index.php?route=onecheckout/shipping&addressid=' + addressid,
						type: 'post',
						data: $('#shipping-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (!json['error']) {
								confirmorder();
							}
						}
					});	
	
			}
		}
	});	
}

function paymentmethodid(addressid) {
	$.ajax({
		url: 'index.php?route=onecheckout/payment',
		type: 'get',
		data: {addressid: addressid},
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				//$('#payment-method .onecheckout-content').slideUp('slow');
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
					 $.ajax({
						url: 'index.php?route=onecheckout/payment&addressid=' + addressid,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (!json['error']) {
								confirmorder();
							}
						}
					});	
							
			}
		}
	});	
}

function paymentmethodidload(addressid) {
	$.ajax({
		url: 'index.php?route=onecheckout/payment',
		type: 'get',
		data: {addressid: addressid},
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				//$('#payment-method .onecheckout-content').slideUp('slow');
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
					 $.ajax({
						url: 'index.php?route=onecheckout/payment&addressid=' + addressid,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
							
							confirmorder();
							
						}
					});	
							
			}
		}
	});	
}

function confirmorder(){
	$.ajax({
		url: 'index.php?route=onecheckout/confirm',
		dataType: 'json',
		beforeSend: function() {
			$('#confirm .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
					
			if (json['output']) {
				if (json['total']) {
					$('#cart_total').html(json['total']);
					$('#cart-total').html(json['total']);
				}
				$('#confirm .onecheckout-content').hide();
				$('#confirm .onecheckout-content').html(json['output']);
				$('#confirm .onecheckout-content').slideDown('slow');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError);
		}
	});	
}

// Login
$('#button-login').live('click', function() {
	$.ajax({
		url: 'index.php?route=onecheckout/login',
		type: 'post',
		data: $('#checkout #login :input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-login').attr('disabled', true);
			$('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-login').attr('disabled', false);
			$('.wait').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			/**if (json['total']) {
				$('#cart_total').html(json['total']);
			}**/
			
			if (json['logged']) {
				$('#welcome').html(json['logged']);
			}
						
			if (json['error']) {
				$('#checkout #login .close_la').after('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				
				$('.warning').fadeIn('slow');
			} else {									
				<?php if (!$shipping_required) { ?>
				if (json['hasshipping']) {
					if($('#shipping-address'))
						$('#shipping-address').remove();
					if($('#shipping-method'))
						$('#shipping-method').remove();
					$('#payment-address').after('<div id="shipping-address"><div class="onecheckout-heading"><?php echo $text_checkout_shipping_address; ?></div><div class="onecheckout-content"></div></div>');
					$('#payment-method').before('<div id="shipping-method"><div class="onecheckout-heading"><?php echo $text_checkout_shipping_method; ?></div><div class="onecheckout-content"></div></div>');
				}
				<?php } ?>
				$.ajax({
					url: 'index.php?route=onecheckout/address/payment',
					dataType: 'json',
					beforeSend: function() {
						$('#payment-address .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
					},		
					complete: function() {
						$('.wait').remove();
					},
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}						
						
						if (json['output']) {
							$('#payment-address .onecheckout-content').html(json['output']);							
							$('#checkout').remove();							
							$('#payment-address .onecheckout-heading span').html('<?php echo $text_checkout_payment_address; ?>');							
							if(json['hasshipping']){
								shippingaddresslogin();
							} else {
								paymentmethodidload($('#payment-address select[name=\'address_id\']').val());
							}
					
						}
					}
				});	
			}
		}
	});	
});


function createorder(){
  if($('#payment-address input[name=\'account\']:checked').attr('value')){
	//register
	$.ajax({
		url: 'index.php?route=onecheckout/register',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'hidden\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning').remove();
			$('.error').remove();
						
			if (json['redirect']) {
				location = json['redirect'];
			}
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-address .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
				}
				
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<span id="error_email" class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['cpf']) {
					$('#payment-address input[name=\'cpf\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cpf'] + '</span>');
				}
				if (json['error']['cnpj']) {
					$('#payment-address input[name=\'cnpj\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cnpj'] + '</span>');
				}
				if (json['error']['data_nascimento']) {
					$('#payment-address input[name=\'data_nascimento\'] + br').after('<span id="error_data_nascimento" class="error">' + json['error']['data_nascimento'] + '</span>');
				}
				
				if (json['error']['numero']) {
					$('#payment-address input[name=\'numero\'] + br').after('<span id="error_numero" class="error">' + json['error']['numero'] + '</span>');
				}
				
				if (json['error']['razao_social']) {
					$('#payment-address input[name=\'razao_social\'] + br').after('<span id="error_razao_social" class="error">' + json['error']['razao_social'] + '</span>');
				}
				/*
				if (json['error']['placa1']) {
					$('#payment-address input[name=\'placa1\'] + br').after('<span id="error_placa1" class="error">' + json['error']['placa1'] + '</span>');
				}
				*/
				
				if (json['error']['sexo']) {
					$('#payment-address #sexo + br').after('<span id="error_sexo" class="error">' + json['error']['sexo'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span id="error_telephone" class="error">' + json['error']['telephone'] + '</span>');
				}		
				
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span id="error_company_id" class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span id="error_tax_id" class="error">' + json['error']['tax_id'] + '</span>');
				}
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['password']) {
					$('#payment-address input[name=\'password\'] + br').after('<span id="error_password" class="error">' + json['error']['password'] + '</span>');
				}	
				
				if (json['error']['confirm']) {
					$('#payment-address input[name=\'confirm\'] + br').after('<span id="error_confirm" class="error">' + json['error']['confirm'] + '</span>');
				}
				
				$('#button-confirmorder').attr('disabled', false);
				$('.wait').remove();																																	
			} else {				
				$.ajax({
					url: 'index.php?route=onecheckout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')){
								shippingaddressstr='<input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" style="display:none" />';
							} else {
								shippingaddressstr='<input type="checkbox" name="shipping_address" value="1" id="shipping" style="display:none" />';
							}
							
							$('#payment-address .onecheckout-content').html(json['output']);		
							$('#payment-address .onecheckout-content').after(shippingaddressstr);		
							$('#checkout').remove();						
							$('#payment-address .onecheckout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
							//shipping address
							<?php if ($shipping_required) { ?>
							if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')){								
								postshippingmethod();
							} else {					
								$.ajax({
									url: 'index.php?route=onecheckout/address/shipping',
									type: 'post',
									data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
									dataType: 'json',
									success: function(json) {
										$('.error').remove();
			
										if (json['redirect']) {
											location = json['redirect'];
										}
			
										if (json['error']) {
											if (json['error']['firstname']) {
												$('#shipping-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
											}
				
											if (json['error']['lastname']) {
												$('#shipping-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
											}	
				
											if (json['error']['email']) {
												$('#shipping-address input[name=\'email\'] + br').after('<span id="error_email" class="error">' + json['error']['email'] + '</span>');
											}
				
											if (json['error']['telephone']) {
												$('#shipping-address input[name=\'telephone\'] + br').after('<span id="error_telephone" class="error">' + json['error']['telephone'] + '</span>');
											}		
										
											if (json['error']['address_1']) {
												$('#shipping-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
											}	
				
											if (json['error']['city']) {
												$('#shipping-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
											}	
				
											if (json['error']['postcode']) {
												$('#shipping-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
											}	
				
											if (json['error']['country']) {
												$('#shipping-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
											}	
				
											if (json['error']['zone']) {
												$('#shipping-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
											}
											
											$('#button-confirmorder').attr('disabled', false);
											$('.wait').remove();
										} else {
											$.ajax({
												url: 'index.php?route=onecheckout/address/shipping',
												dataType: 'json',
												success: function(json) {
													if (json['redirect']) {
														location = json['redirect'];
													}
									
													if (json['output']) {
														$('#shipping-address .onecheckout-content').html(json['output']);
														postshippingmethod();
													}
												}
											});	
										}  
									}
								});		
							}
							<?php } else { ?>
							postpaymentmethod();
							<?php } ?>	
							
						}
					}
				});
			}	 
		}
	});		
  } else {
	//guest
	$.ajax({
		url: 'index.php?route=onecheckout/guest',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
		dataType: 'json',
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<span id="error_email" class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span id="error_telephone" class="error">' + json['error']['telephone'] + '</span>');
				}		
				
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span id="error_company_id" class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span id="error_tax_id" class="error">' + json['error']['tax_id'] + '</span>');
				}
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
				}
				
				$('#button-confirmorder').attr('disabled', false);
				$('.wait').remove();
			} else {
				//guest shipping address
				<?php if ($shipping_required) { ?>
				if($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
					postshippingmethod();					
				} else{			
					$.ajax({
						url: 'index.php?route=onecheckout/guest/shipping',
						type: 'post',
						data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
						dataType: 'json',				
						success: function(json) {
							$('.error').remove();
			
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (json['error']) {
								if (json['error']['firstname']) {
									$('#shipping-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
								}
				
								if (json['error']['lastname']) {
									$('#shipping-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
								}	
								
								if (json['error']['cpf']) {
									$('#shipping-address input[name=\'cpf\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cpf'] + '</span>');
								}
								if (json['error']['cnpj']) {
									$('#shipping-address input[name=\'cnpj\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cnpj'] + '</span>');
								}
								if (json['error']['razao_social']) {
									$('#shipping-address input[name=\'razao_social\'] + br').after('<span id="error_razao_social" class="error">' + json['error']['razao_social'] + '</span>');
								}
								
									
								if (json['error']['address_1']) {
									$('#shipping-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
								}	
				
								if (json['error']['city']) {
									$('#shipping-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
								}	
				
								if (json['error']['postcode']) {
									$('#shipping-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
								}	
				
								if (json['error']['country']) {
									$('#shipping-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
								}	
				
								if (json['error']['zone']) {
									$('#shipping-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
								}
								
								$('#button-confirmorder').attr('disabled', false);
								$('.wait').remove();
							} else {								
								postshippingmethod();
							}
						}
					});					
				}
				<?php } else { ?>
				postpaymentmethod();
				<?php } ?>
				
			}
		}
	});		
  }
}

function logcreateorder(){
	$.ajax({
		url: 'index.php?route=onecheckout/address/payment',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
		dataType: 'json',	
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-address .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
				}
				
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['cpf']) {
					$('#payment-address input[name=\'cpf\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cpf'] + '</span>');
				}
				if (json['error']['cnpj']) {
					$('#payment-address input[name=\'cnpj\'] + br').after('<span id="error_cpf" class="error">' + json['error']['cnpj'] + '</span>');
				}
				if (json['error']['razao_social']) {
					$('#payment-address input[name=\'razao_social\'] + br').after('<span id="error_razao_social" class="error">' + json['error']['razao_social'] + '</span>');
				}
				if (json['error']['numero']) {
					$('#payment-address input[name=\'numero\'] + br').after('<span id="error_numero" class="error">' + json['error']['numero'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span id="error_telephone" class="error">' + json['error']['telephone'] + '</span>');
				}		
				
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span id="error_company_id" class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span id="error_tax_id" class="error">' + json['error']['tax_id'] + '</span>');
				}
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
				}
				
				$('#button-confirmorder').attr('disabled', false);
				$('.wait').remove();
			} else {
				$.ajax({
					url: 'index.php?route=onecheckout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#payment-address .onecheckout-content').html(json['output']);
							<?php if ($shipping_required) { ?>
							$.ajax({
								url: 'index.php?route=onecheckout/address/shipping',
								type: 'post',
								data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
								dataType: 'json',
								success: function(json) {
									$('.error').remove();
			
									if (json['redirect']) {
										location = json['redirect'];
									}
			
									if (json['error']) {
										if (json['error']['warning']) {
											$('#shipping-address .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
											$('.warning').fadeIn('slow');
										}
										
										if (json['error']['firstname']) {
											$('#shipping-address input[name=\'firstname\'] + br').after('<span id="error_firstname" class="error">' + json['error']['firstname'] + '</span>');
										}
				
										if (json['error']['lastname']) {
											$('#shipping-address input[name=\'lastname\'] + br').after('<span id="error_lastname" class="error">' + json['error']['lastname'] + '</span>');
										}	
				
										if (json['error']['email']) {
											$('#shipping-address input[name=\'email\'] + br').after('<span id="error_email" class="error">' + json['error']['email'] + '</span>');
										}
				
										if (json['error']['telephone']) {
											$('#shipping-address input[name=\'telephone\'] + br').after('<span id="error_telephone" class="error">' + json['error']['telephone'] + '</span>');
										}		
										
										if (json['error']['address_1']) {
											$('#shipping-address input[name=\'address_1\'] + br').after('<span id="error_address_1" class="error">' + json['error']['address_1'] + '</span>');
										}	
				
										if (json['error']['city']) {
											$('#shipping-address input[name=\'city\'] + br').after('<span id="error_city" class="error">' + json['error']['city'] + '</span>');
										}	
				
										if (json['error']['postcode']) {
											$('#shipping-address input[name=\'postcode\'] + br').after('<span id="error_postcode" class="error">' + json['error']['postcode'] + '</span>');
										}	
				
										if (json['error']['country']) {
											$('#shipping-address select[name=\'country_id\'] + br').after('<span id="error_country_id" class="error">' + json['error']['country'] + '</span>');
										}	
				
										if (json['error']['zone']) {
											$('#shipping-address select[name=\'zone_id\'] + br').after('<span id="error_zone_id" class="error">' + json['error']['zone'] + '</span>');
										}
										
										$('#button-confirmorder').attr('disabled', false);
										$('.wait').remove();
									} else {						
										$.ajax({
											url: 'index.php?route=onecheckout/address/shipping',
											dataType: 'json',
											success: function(json) {
												if (json['redirect']) {
												location = json['redirect'];
												}
									
												if (json['output']) {
													$('#shipping-address .onecheckout-content').html(json['output']);
													postshippingmethod();
													
												}
											}
										});	
							
									}  
								}
							});
							<?php } else { ?>
							postpaymentmethod();
							<?php } ?>	
						}
					}
				});								
			}	  
		}
	});	
}

function postshippingmethod() {
	$.ajax({
		url: 'index.php?route=onecheckout/shipping',
		type: 'post',
		data: $('#shipping-method input[type=\'radio\']:checked'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#shipping-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
				}
				$('#button-confirmorder').attr('disabled', false);
				$('.wait').remove();
			} else {			
				postpaymentmethod();
			}
		}
	});	
}

function postpaymentmethod() {
	$.ajax({
		url: 'index.php?route=onecheckout/payment', 
		type: 'post',
		data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					
					$('.warning').fadeIn('slow');
				}
				$('#button-confirmorder').attr('disabled', false);
				$('.wait').remove();		
			} else {
				paymentbutton();
			}
		}
	});	
}

function paymentbutton() {
	$.ajax({
		url: 'index.php?route=onecheckout/confirm/createorder',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
		
			if (json['output']) {	
				$.ajax({
					url: 'index.php?route=onecheckout/address/getinfo',
					dataType: 'json',
					success: function(json) {
						if (json['paymentaddress']) {
							$('#payment-address .onecheckout-content').html(json['paymentaddress']);
						}
						
						if (json['shippingaddress']) {
							$('#shipping-address .onecheckout-content').html(json['shippingaddress']);
						}
						
						if (json['shippingmethod']) {
							$('#shipping-method .onecheckout-content').html(json['shippingmethod']);
						}
						
						if (json['paymentmethod']) {
							$('#payment-method .onecheckout-content').html(json['paymentmethod']);
						}
						
					}
				});	
				$('#checkout,#confirm .buttons,#confirm .cart-module').remove();
				$('.onecheckout-content input[type=\'text\'], .onecheckout-content input[type=\'password\'], .onecheckout-content input[type=\'checkbox\'], .onecheckout-content input[type=\'radio\'], .onecheckout-content select, .onecheckout-content  textarea').attr('disabled', true);
				//$('#confirm .onecheckout-content').append('<div id="confirmorder"></div>');
				$('#confirmorder').html(json['output']);				
				$('#confirmorder').slideDown('fast');
				$('#confirmorder div').css('display','block');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {			
			$('#button-confirmorder').attr('disabled', false);
			$('.wait').remove();
			alert(thrownError);
		}
	});					
}

function upcartmodule() {
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		countryid = $('#payment-address select[name=\'country_id\']').val();
		zoneid = $('#payment-address select[name=\'zone_id\']').val();
		cityval =$('#payment-address input[name=\'city\']').val();
		postcodeval = $('#payment-address input[name=\'postcode\']').val();
	} else {
		countryid = $('#shipping-address select[name=\'country_id\']').val();
		zoneid = $('#shipping-address select[name=\'zone_id\']').val();
		cityval = $('#shipping-address input[name=\'city\']').val();
		postcodeval = $('#shipping-address input[name=\'postcode\']').val();
	}
	
	ajaxurl = 'index.php?route=onecheckout/shipping&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=1&city=' + cityval + '&postcode=' + postcodeval;
	
	if($('#shipping-address input[name=\'shipping_address\']:checked').val()=='existing'){
		ajaxurl = 'index.php?route=onecheckout/shipping&addressid=' + $('#shipping-address select[name=\'address_id\']').val();
	}
	
	$.ajax({
		url: ajaxurl,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
											
			if (json['output']) {
				//$('#shipping-method .onecheckout-content').slideUp('slow');
				$('#shipping-method .onecheckout-content').html(json['output']);
				$('#shipping-method .onecheckout-content').slideDown('slow');	
								
					$.ajax({
						url: ajaxurl,
						type: 'post',
						data: $('#shipping-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {			
							$('.success, .warning').remove();
			
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (json['error']) {
								if (json['error']['warning']) {
									$('#shipping-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
									$('.warning').fadeIn('slow');
								}			
							}
								
	//**********************************************************************							
	countryid = $('#payment-address select[name=\'country_id\']').val();
	zoneid = $('#payment-address select[name=\'zone_id\']').val();
	cityval = $('#payment-address input[name=\'city\']').val();
	postcodeval = $('#payment-address input[name=\'postcode\']').val();
	
	ajaxurl = 'index.php?route=onecheckout/payment&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=1&city=' + cityval + '&postcode=' + postcodeval;
	
	if($('#payment-address input[name=\'payment_address\']:checked').val()=='existing'){
		ajaxurl = 'index.php?route=onecheckout/payment&addressid=' + $('#payment-address select[name=\'address_id\']').val();
	}
	
	$.ajax({
		url: ajaxurl,
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				//$('#payment-method .onecheckout-content').slideUp('slow');
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
				  $.ajax({
						url: ajaxurl,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							$('.success, .warning').remove();
			
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							if (json['error']) {
								if (json['error']['warning']) {
									$('#payment-method .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
									$('.warning').fadeIn('slow');
								}			
							} 
							confirmorder();
							
						}
					});	
						
			}
		}
	});	
	//**********************************************************************							
								
							
						}
					});	
	
			}
		}
	});	
}

$('#button-coupon').live('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=onecheckout/cartmodule/validateCoupon',
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
				$('#confirm .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error'] + '</div>');					
				$('.warning').fadeIn('slow');
			}
			
			if (json['redirect']) {
				upcartmodule();
			}
		}
	});
});

$('#button-reward').live('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=onecheckout/cartmodule/validateReward',
		data: $('#reward :input'),
		dataType: 'json',		
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-reward').attr('disabled', true);
			$('#button-reward').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-reward').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			if (json['error']) {
				$('#confirm .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error'] + '</div>');					
				$('.warning').fadeIn('slow');
			}
			
			if (json['redirect']) {
				upcartmodule();
			}
		}
	});
});

$('#button-voucher').live('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=onecheckout/cartmodule/validateVoucher',
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
				$('#confirm .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error'] + '</div>');					
				$('.warning').fadeIn('slow');
			}
			
			if (json['redirect']) {
				upcartmodule();
			}
		}
	});
});

$('#confirmorder #button-confirm').live('click', function() {
	$('#confirmorder #button-confirm').attr('disabled', true);
	$('#confirmorder #button-confirm').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
});

$('#button-confirmorder').live('click', function() {
if($('.onecheckout-content .error:first').html()) {
  $('.success, .warning').remove();
  $('#confirm .onecheckout-content').prepend('<div class="warning" style="display: none;">' + $('.onecheckout-content .error:first').html() + '</div>');					
  $('.warning').fadeIn('slow');	
} else {
	$.ajax({
		url: 'index.php?route=onecheckout/confirm/checklog', 
		type: 'post',
		data: $('#confirm input[type=\'checkbox\']:checked'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-confirmorder').attr('disabled', true);
			$('#button-confirmorder').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		success: function(json) {
			$('.success, .warning').remove();	
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#confirm .onecheckout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');					
					$('.warning').fadeIn('slow');
					$('#button-confirmorder').attr('disabled', false);
					$('.wait').remove();
				}
			} else {
				if (json['islogged']) {
					logcreateorder();
				} else {
					createorder();
				}
			}
		}
	});	
  }
});

function refreshpayment() {
	countryid = $('#payment-address select[name=\'country_id\']').val();
	zoneid = $('#payment-address select[name=\'zone_id\']').val();
	cityval = $('#payment-address input[name=\'city\']').val();
	postcodeval = $('#payment-address input[name=\'postcode\']').val();
	
	ajaxurl = 'index.php?route=onecheckout/payment&countryid=' + countryid + '&zoneid=' + zoneid + '&isset=1&city=' + cityval + '&postcode=' + postcodeval;
	
	if($('#payment-address input[name=\'payment_address\']:checked').val()=='existing'){
		ajaxurl = 'index.php?route=onecheckout/payment&addressid=' + $('#payment-address select[name=\'address_id\']').val();
	}
	
	$.ajax({
		url: ajaxurl,
		type: 'get',
		dataType: 'json',
		beforeSend: function() {
			$('#payment-method .onecheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
										
			if (json['output']) {
				//$('#payment-method .onecheckout-content').slideUp('slow');
				$('#payment-method .onecheckout-content').html(json['output']);	
				$('#payment-method .onecheckout-content').slideDown('slow');	
				
				  $.ajax({
						url: ajaxurl,
						type: 'post',
						data: $('#payment-method input[type=\'radio\']:checked'),
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
			
							confirmorder();
							
						}
					});	
						
			}
		}
	});	
}

function getzone(atype,zoneid){
	if ($('#'+atype+'-address select[name=\'country_id\']').val() == '') return;
	$.ajax({
		url: 'index.php?route=onecheckout/checkout/country&country_id=' + $('#'+atype+'-address select[name=\'country_id\']').val(),
		dataType: 'json',
		beforeSend: function() {
			$('#'+atype+'-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#'+atype+'-postcode-required').show();
			} else {
				$('#'+atype+'-postcode-required').hide();
			}
			html = '<option value=""><?php echo $text_select; ?></option>';			
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == zoneid) {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#'+atype+'-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}
//--></script> 
<?php echo $footer; ?>
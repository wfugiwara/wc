<?php if($coupon_status) { ?>
<div class="cart-module">
  <div class="cart-heading"><?php echo $coupon_heading_title; ?></div>
  <div class="cart-content" id="coupon"><?php echo $entry_coupon; ?>&nbsp;<br />
    <input type="text" name="coupon" value="<?php echo $coupon; ?>" />
    &nbsp;<a id="button-coupon" class="button"><span><?php echo $button_coupon; ?></span></a></div>
</div>
<?php } ?>
<?php if($reward_status) { ?>
<div class="cart-module">
  <div class="cart-heading"><?php echo $reward_heading_title; ?></div>
  <div class="cart-content" id="reward"><?php echo $entry_reward; ?>&nbsp;<br />
  <input type="text" name="reward" value="<?php echo $reward; ?>" />
  &nbsp;<a id="button-reward" class="button"><span><?php echo $button_reward; ?></span></a></div>
</div>
<?php } ?>
<?php if($voucher_status) { ?>
<div class="cart-module">
  <div class="cart-heading"><?php echo $voucher_heading_title; ?></div>
  <div class="cart-content" id="voucher"><?php echo $entry_voucher; ?>&nbsp;<br />
    <input type="text" name="voucher" value="<?php echo $voucher; ?>" />
    &nbsp;<a id="button-voucher" class="button"><span><?php echo $button_voucher; ?></span></a></div>
</div>
<?php } ?>
<style type="text/css">
.cart-module > div {
	display: block;
}
.cart-module .cart-heading {
	border: 1px solid #DBDEE1;
	padding: 8px 8px 8px 22px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	color: #555555;
	margin-bottom: 15px;
	cursor: pointer;
	background: #F8F8F8 url('catalog/view/theme/default/image/cart-right.png') 10px 50% no-repeat;
}
.cart-module .active {
	background: #F8F8F8 url('catalog/view/theme/default/image/cart-down.png') 7px 50% no-repeat;
}
.cart-module .cart-content {
	padding: 0px 0px 15px 0px;
	display: none;
	overflow: auto;
	font-family: Arial, Helvetica, sans-serif;
	font-size:12px;
}
</style>
<script type="text/javascript"><!--
$('.cart-module .cart-heading').bind('click', function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
	} else {
		$(this).addClass('active');
	}
		
	$(this).parent().find('.cart-content').slideToggle('slow');
});
//--></script>
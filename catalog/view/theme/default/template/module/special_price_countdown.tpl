<?php if ($show_special_price_countdown) { ?>

<style type="text/css">
  .counter_desc .cntSeparator {
	font-size: <?php echo $new_font_size;?>px;
	margin: 5px auto;
	height: <?php echo $digit_height;?>
	color: #000;
  }
  .counter_desc .desc { margin: 7px 3px; }
  .counter_desc .desc div {
	float: left;
	font-family: Arial;
	width: 70px;
	margin-right: 65px;
	font-size: 13px;
	font-weight: bold;
	color: #000;
  }
</style>

<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">

	<div class="counter_desc" id="counter_<?php echo $module; ?>" style="width:auto; display:block;"></div>
	
    </div>
  </div>
</div> 

<script type="text/javascript">
$(document).ready(function() {
  $('#counter_<?php echo $module; ?>').countdown({
	  image: '<?php echo $digit_image; ?>',
	  digitWidth: <?php echo $digit_width; ?>,
	  digitHeight: <?php echo $digit_height; ?>,
	  format: '<?php echo $countdown_format; ?>',
	  <?php if ($show_days) { ?>
	  startTime: '<?php echo ($days < 10)? "0" . $days : $days; ?>:<?php echo ($hours < 10)? "0" . $hours : $hours; ?>:<?php echo ($mins < 10)? "0" . $mins : $mins; ?>:<?php echo ($secs < 10)? "0" . $secs : $secs; ?>'
	  <?php } else { ?>
	  startTime: '<?php echo ($hours < 10)? "0" . $hours : $hours; ?>:<?php echo ($mins < 10)? "0" . $mins : $mins; ?>:<?php echo ($secs < 10)? "0" . $secs : $secs; ?>'
	  <?php }?>	
	});
});
 
</script>

<?php } ?>
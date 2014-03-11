<?php echo $header; ?>
<style type='text/css'>
.success, .warning{
	margin-top:10px;
}

<?php if (isset($order_feed_export) && $order_feed_export == 'all') echo ".filters {display:none;}";?>
</style>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div class="box">
  <div class="heading">
  <div class="left"></div>
  <div class="right"></div>
  <h1><img src="view/image/backup.png" /><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#backup').submit();addSave('<?php echo $text_success; ?>');" class="button"><span><?php echo $button_export; ?></span></a><a onclick="javascript:saveSettings();return false;" class="button"><span><?php echo $button_save; ?></span></a><a href="<?php echo $cancel; ?>" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $backup; ?>" method="post" enctype="multipart/form-data" id="backup">
		<table class="form">
			<tr>
				<td><?php echo $entry_export; ?></td>
				<td>
					<input id='order_feed_export_filtered' type='radio' name='order_feed_export' onchange='javascript:updateDisplay();' value='filtered' <?php if (isset($order_feed_export) && $order_feed_export == 'filtered' || !isset($order_feed_export)) echo 'checked="checked"';?>><label for='order_feed_export_filtered'><?php echo $option_filtered; ?></label></option>
					<input id='order_feed_export_all' type='radio' name='order_feed_export' onchange='javascript:updateDisplay();' value='all' <?php if (isset($order_feed_export) && $order_feed_export == 'all') echo 'checked="checked"';?>><label for='order_feed_export_all'><?php echo $option_all; ?></label></option>
				</td>
			</tr>
			<tr class="filters">
				<td><?php echo $entry_status; ?></td>
				<td>
					<select name="order_feed_status" id="">
						<option value=''><?php echo $entry_none; ?></option>
						<?php foreach ($order_statuses as $order_statuses) { ?>
						<?php if ($order_statuses['order_status_id'] == $order_status_id) { ?>
						<option value="<?php echo $order_statuses['order_status_id']; ?>" selected="selected"><?php echo $order_statuses['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $order_statuses['order_status_id']; ?>"><?php echo $order_statuses['name']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</td>
			</tr>
			<tr class="filters">
				<td><?php echo $entry_total_sum; ?></td>
				<td><?php echo $entry_from; ?> <?php echo $entry_currency; ?><input id="sum_from" type="text" name="order_feed_sum_from" value="<?php if (isset($order_feed_sum_from)) echo $order_feed_sum_from; ?>" size="14" /> <?php echo $entry_to; ?>  <?php echo $entry_currency; ?><input id="sum_to" type="text" name="order_feed_sum_to" value="<?php if (isset($order_feed_sum_to)) echo $order_feed_sum_to; ?>" size="14" /></td>
			</tr class="filters">
			<tr class="filters">
				<td><?php echo $entry_date; ?></td>
				<td><?php echo $entry_from; ?><input id="from" type="text" name="order_feed_date_from" value="<?php if (isset($order_feed_date_from)) echo $order_feed_date_from; ?>" size="14" /> <?php echo $entry_to; ?> <input id="to" type="text" name="order_feed_date_to" value="<?php if (isset($order_feed_date_to)) echo $order_feed_date_to; ?>" size="14" /></td>
			</tr>
			<tr class="filters">
				<td><?php echo $entry_order_numbers; ?></td>
				<td><?php echo $entry_from; ?><input id="sum_from" type="text" name="order_feed_order_from" value="<?php if (isset($order_feed_order_from)) echo $order_feed_order_from; ?>" size="14" /> <?php echo $entry_to; ?> <input id="order_to" type="text" name="order_feed_order_to" value="<?php if (isset($order_feed_order_to)) echo $order_feed_order_to; ?>" size="14" /></td>
			</tr>
		</table>
      <input type="hidden" name="order_feed_create" value="1" />
    </form>
  </div>
</div>
<script>
	$(function() {
		var dates = $( "#from, #to" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "from" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			},
			dateFormat: 'dd MM yy',
		});
	});

	function updateDisplay () {
		value = $('input:radio[name=order_feed_export]:checked').val();
		if(value == 'all') {
		  $('.filters').hide('slow', function() {
		  });
		} else {
		  $('.filters').show('slow', function() {
		  });
		}
	}

	function saveSettings() {
		var data = $('#backup').serialize();
		var url = 'index.php?route=feed/order_feed/saveModuleSettings&token=<?php echo $token ?>';
		$.ajax({
			type: "POST",
			url: url,
			data: data,
			success: function(result) {
				addSave(result);
			}
		});
	}

	function addSave(result) {
		$('.success').remove();
		$('.warning').hide();
		$('.breadcrumb').append('<div class="success">'+result+'</div>');
	}
</script>
<?php echo $footer; ?>
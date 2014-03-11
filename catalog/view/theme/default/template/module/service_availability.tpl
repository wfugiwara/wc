<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">
		<table class="form" id="service_availability">
		<tr>
			<td><?php echo $entry_country; ?></td>
			<td><select name="country_id">
				<option value=""><?php echo $text_select; ?></option>
				<?php foreach ($countries as $country) { ?>
				<?php if ($country['country_id'] == $country_id) { ?>
				<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
				<?php } ?>
				<?php } ?>
			</select></td>
		</tr>
    	<tr>
      		<td><?php echo $entry_zone; ?></td>
      		<td><select name="zone_id">
        		</select></td>
    	</tr>
		<tr>
			<td></td>
			<td><input type="button" value="<?php echo $text_check_availability; ?>" onclick="getServiceAvailability();" class="button" /></td>
		</tr>
		</table>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
$('#service_availability select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=module/service_availability/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#service_availability select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
					
			html = '';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#service_availability select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#service_availability select[name=\'country_id\']').trigger('change');

function getServiceAvailability(){

	var country_id = $('#service_availability select[name=\'country_id\']').val();
    var zone_id = $('#service_availability select[name=\'zone_id\']').val();
	
	$.ajax({
		url: 'index.php?route=module/service_availability/getserviceavailability&country_id=' + country_id + '&zone_id=' + zone_id,
		dataType: 'json',
		beforeSend: function() {
			$('#service_availability .button').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
				var buttonTR = $('#service_availability .button').parent().parent();				
				var html = "<tr id='service_message'><td></td><td>";				
				if(json.service_available == "true") {
					html += "<?php echo $text_service_available; ?></td></tr>";
				} else {
					html += "<?php echo $text_service_unavailable; ?></td></tr>";
				}
				$('#service_message').remove();
				$(buttonTR).after(html);	
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

	
}

//--></script>

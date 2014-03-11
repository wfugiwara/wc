<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div data-role="content">
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

<?php echo $column_left; ?>
<div id="column-center">
<?php echo $content_top; ?>
  <!--<h1><?php echo $heading_title; ?></h1>-->
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <h2><?php echo $text_your_details; ?></h2>
   
   <span class="required">*</span> <?php echo $entry_firstname; ?><br/>
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?><br />
           <span class="required">*</span> <?php echo $entry_lastname; ?><br/>
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?><br />
        
          <span class="required">*</span> <?php echo $entry_email; ?><br/>
          <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?><br />
        <span class="required">*</span> <?php echo $entry_telephone; ?><br/>
        <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?><br />
        <?php echo $entry_fax; ?><br/>
        <input type="text" name="fax" value="<?php echo $fax; ?>" />
    <br />
    <h2><?php echo $text_your_address; ?></h2>
    <?php echo $entry_company; ?><br/>
      <input type="text" name="company" value="<?php echo $company; ?>" /><br />
      <?php echo $entry_website; ?><br/>
      <input type="url" name="website" value="<?php echo $website; ?>" /><br />
      <span class="required">*</span> <?php echo $entry_address_1; ?><br/>
      <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
         <?php if ($error_address_1) { ?>
         <span class="error"><?php echo $error_address_1; ?></span>
         <?php } ?><br />
      <?php echo $entry_address_2; ?><br />
      <input type="text" name="address_2" value="<?php echo $address_2; ?>" /><br/>
      <span class="required">*</span> <?php echo $entry_city; ?><br/>
      <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?><br />
      <span id="postcode-required"  class="required">*</span> <?php echo $entry_postcode; ?><br/>
      <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?><br />
      <span class="required">*</span> <?php echo $entry_country; ?><br/>
      <select name="country_id" data-native-menu="true">
              <option value="false"><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?><br />
            
            <div id="affiliate_address_zone_id">
  		    <span class="required">*</span> <?php echo $entry_zone; ?><br/>
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
                              
        <!--<select name="zone_id"   data-native-menu="true">
        </select>-->
        
         <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
         <?php } ?><br />
     <a href="<?php echo $back; ?>" class="button" rel="external" data-inline="true" data-role="button"><?php echo $button_back; ?></a>
     <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-theme="a" data-inline="true" />
   </form>
<?php echo $content_bottom; ?>
</div>
</div>
<script type="text/javascript"><!--
/*function refresh_zone(){
$('#affiliate_address_zone_id span.ui-btn-text').html('<?php echo $text_select; ?>');
$('#affiliate_address_zone_id select[name=\'zone_id\']').empty();
}*/
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=affiliate/edit/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');

//--></script> 
<?php echo $footer; ?>
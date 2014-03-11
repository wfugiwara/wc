<?php echo $header; ?>
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

<?php echo $content_top; ?>
<div data-role="content">
  <!--<h2><?php echo $heading_title; ?></h2>-->
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <h2><?php echo $text_edit_address; ?></h2>
    <span class="required">*</span> <?php echo $entry_firstname; ?><br/>
    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <div class="error"><?php echo $error_firstname; ?></div>
            <?php } ?>
            <br />
    <span class="required">*</span> <?php echo $entry_lastname; ?><br/>
    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <div class="error"><?php echo $error_lastname; ?></div>
            <?php } ?>
             <br />
    <?php echo $entry_company; ?><br/>
    <input type="text" name="company" value="<?php echo $company; ?>" />
    		<br />
    <?php if ($company_id_display) { ?>
    <div>
          <?php echo $entry_company_id; ?><br />
          <input type="text" name="company_id" value="<?php echo $company_id; ?>" />
            <?php if ($error_company_id) { ?>
            <span class="error"><?php echo $error_company_id; ?></span>
            <?php } ?><br /></div>
      <?php } ?>
      
      <?php if ($tax_id_display) { ?>      
        <div>
          <?php echo $entry_tax_id; ?><br />
          <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
            <?php if ($error_tax_id) { ?>
            <span class="error"><?php echo $error_tax_id; ?></span>
            <?php } ?></div>
         <?php } ?>   
    
    <span class="required">*</span> <?php echo $entry_address_1; ?><br/>
    <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <div class="error"><?php echo $error_address_1; ?></div>
            <?php } ?>
             <br />
    <?php echo $entry_address_2; ?><br/>
    <input type="text" name="address_2" value="<?php echo $address_2; ?>" />
    		<br />
    <span class="required">*</span> <?php echo $entry_city; ?><br/>
    <input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <div class="error"><?php echo $error_city; ?></div>
            <?php } ?>
             <br />
    <span class="required" id="postcode-required" >*</span> <?php echo $entry_postcode; ?><br/>
    <input type="number" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <div class="error"><?php echo $error_postcode; ?></div>
            <?php } ?>
             <br />
    <span class="required">*</span> <?php echo $entry_country; ?><br/>
    <select name="country_id" data-native-menu="true">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <div class="error"><?php echo $error_country; ?></div>
            <?php } ?>
             <br />
        
        <div id="account_address_zone_id">
  		<span class="required">*</span> <?php echo $entry_zone; ?><br/>
        <select name="zone_id" class="large-field" data-native-menu="true">
		   <option value=""><?php echo $text_select; ?></option>
	      </select><br />    
		</div>
        
            <?php if ($error_zone) { ?>
            <div class="error"><?php echo $error_zone; ?></div>
            <?php } ?>
          <fieldset data-role="controlgroup" data-type="horizontal">
          <legend><?php echo $entry_default; ?></legend><br/>
          <?php if ($default) { ?>
            <input type="radio" name="default" value="1" checked="checked" id="choise_yes" />
            <label for="choise_yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="default" value="0" id="choise_no" />
            <label for="choise_no"><?php echo $text_no; ?></label>
            <?php } else { ?>
            <input type="radio" name="default" value="1" id="choise_yes" />
            <label for="choise_yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="default" value="0" checked="checked" id="choise_no" />
            <label for="choise_no"><?php echo $text_no; ?></label>
            <?php } ?>
            </fieldset>
<br/><br/><a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"><?php echo $button_back; ?></a>
<input type="submit" value="<?php echo $button_continue; ?>" class="button" data-inline="true" data-theme="a" />
</form>
</div>
<?php echo $content_bottom; ?>
<script type="text/javascript"><!--
function refresh_zone(){
$('#account_address_zone_id span.ui-btn-text').html('<?php echo $text_select; ?>');
$('#account_address_zone_id select[name=\'zone_id\']').empty();
}


$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=account/address/country&country_id=' + this.value,
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
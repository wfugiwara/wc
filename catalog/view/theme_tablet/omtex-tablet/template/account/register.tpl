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
  <?php echo $text_account_already; ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <div data-role="fieldcontain">
    <h2 style="margin:5px;"><?php echo $text_your_details; ?></h2>
    
    <?php echo $entry_firstname; ?><span class="required">*</span><br />
      <input type="text" name="firstname" <?php if ($firstname) { ?> value="<?php echo $firstname; ?>" <?php } ?> data-theme="c" />
            <?php if ($error_firstname) { ?>
            <div class="error"><?php echo $error_firstname; ?></div>
            <?php } ?><br />
            
            
            <?php echo $entry_lastname; ?><span class="required">*</span><br />     
      <input type="text" name="lastname" <?php if ($lastname) { ?> value="<?php echo $lastname; ?>" <?php } ?> />
            <?php if ($error_lastname) { ?>
            <div class="error"><?php echo $error_lastname; ?></div>
            <?php } ?><br />
            
            
            <?php echo $entry_email; ?><span class="required">*</span><br />
      <input type="email" name="email" <?php if ($email) { ?> value="<?php echo $email; ?>" <?php } ?> />
            <?php if ($error_email) { ?>
            <div class="error"><?php echo $error_email; ?></div>
            <?php } ?><br />
            
            
            <?php echo $entry_telephone; ?><span class="required">*</span><br />
      <input type="tel" name="telephone" <?php if ($telephone) { ?> value="<?php echo $telephone; ?>"  <?php } ?> />
            <?php if ($error_telephone) { ?>
            <div class="error"><?php echo $error_telephone; ?></div>
            <?php } ?><br />
           
            
           <?php echo $entry_fax; ?><br /> 
      <input type="tel" name="fax" <?php if ($fax) { ?> value="<?php echo $fax; ?>" <?php } ?> />
      
    <h2 style="margin:5px;"><?php echo $text_your_address; ?> </h2>
    
    <?php echo $entry_company; ?><br />
      <input type="text" name="company" <?php if ($company) { ?> value="<?php echo $company; ?>" <?php } ?> />
      
      <div style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
         <?php echo $entry_customer_group; ?><br />
          <?php foreach ($customer_groups as $customer_group) { ?>
            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />

            <?php } else { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />

            <?php } ?>
            <?php } ?>
        </div>
        
        <div id="company-id-display">
         <?php echo $entry_company_id; ?><span id="company-id-required" class="required">*</span><br />
          <input type="text" name="company_id" <?php if ($company_id) { ?> value="<?php echo $company_id; ?>" <?php } ?> />
            <?php if ($error_company_id) { ?>
            <div class="error"><?php echo $error_company_id; ?></div>
            <?php } ?>
        </div>
        
        <div id="tax-id-display">
         <span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?><br />
          <input type="text" name="tax_id" <?php if ($tax_id) { ?> value="<?php echo $tax_id; ?>" <?php } ?> />
            <?php if ($error_tax_id) { ?>
            <div class="error"><?php echo $error_tax_id; ?></div>
            <?php } ?>
        </div> 
           
       <?php echo $entry_address_1; ?><span class="required">*</span><br /> 
      <input type="text" name="address_1" <?php if ($address_1) { ?> value="<?php echo $address_1; ?>" <?php } ?> />
            <?php if ($error_address_1) { ?>
            <div class="error"><?php echo $error_address_1; ?></div>
            <?php } ?>
            <br />
            
        <?php echo $entry_address_2; ?><br />    
      <input type="text" name="address_2" <?php if ($address_2) { ?> value="<?php echo $address_2; ?>" <?php } ?>  />
      <br />
            
      <?php echo $entry_city; ?><span class="required">*</span><br />
      <input type="text" name="city" <?php if ($city) { ?> value="<?php echo $city; ?>" <?php } ?> />
            <?php if ($error_city) { ?>
            <div class="error"><?php echo $error_city; ?></div>
            <?php } ?><br />
            
            
      <?php echo $entry_postcode; ?><span id="postcode-required" class="required">*</span><br />
      <input type="text" name="postcode" <?php if ($postcode) { ?> value="<?php echo $postcode; ?>" <?php } ?> />
            <?php if ($error_postcode) { ?>
            <div class="error"><?php echo $error_postcode; ?></div>
            <?php } ?><br />
       
       <?php echo $entry_country; ?><span class="required">*</span>
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
          <span class="required">*</span> <?php echo $entry_zone; ?>
       <select name="zone_id" data-native-menu="true">
       <option value=""><?php echo $text_select; ?></option>
       </select>
            <?php if ($error_zone) { ?>
            <div class="error"><?php echo $error_zone; ?></div>
            <?php } ?>
    <h2 style="margin:5px;"><?php echo $text_your_password; ?></h2>
   	   <input type="password" name="password" <?php if ($password) { ?> value="<?php echo $password; ?>"  <?php } ?>placeholder="*<?php echo $entry_password; ?>"/>
            <?php if ($error_password) { ?>
            <div class="error"><?php echo $error_password; ?></div>
            <?php } ?>
       <input type="password" name="confirm" <?php if ($confirm) { ?> value="<?php echo $confirm; ?>" <?php } ?> placeholder="*<?php echo $entry_confirm; ?>"/>
            <?php if ($error_confirm) { ?>
            <div class="error"><?php echo $error_confirm; ?></div>
            <?php } ?>
    <h2 style="margin:5px;"><?php echo $text_newsletter; ?></h2>
  	      	<fieldset data-role="controlgroup" data-type="horizontal">
    		<legend><?php echo $entry_newsletter; ?></legend>
            <?php if ($newsletter) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" id="yes"/>
            <label for="yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="newsletter" value="0" id="no" />
            <label for="no"><?php echo $text_no; ?></label>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" id="yes"/>
            <label for="yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="newsletter" value="0" checked="checked" id="no"/>
            <label for="no"><?php echo $text_no; ?></label>
            <?php } ?>
            </fieldset>
    <?php if ($text_agree) { ?>
       <fieldset data-role="controlgroup">
	   <legend id="text_agree"><?php echo $text_agree; ?></legend>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" class="custom" id="agree"/>
        <label for="agree"><div id="text_i_agree"></div></label>
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" class="custom" id="agree"/>
        <label for="agree"><div id="text_i_agree"></div></label>
        <?php } ?>
        </fieldset>
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-theme="a" />
    <?php } else { ?>
    <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-theme="a" />
    <?php } ?>
  	</div>
  </form>
<?php echo $content_bottom; ?>
</div></div>
<script type="text/javascript"><!--
$('input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});


$('input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=account/register/country&country_id=' + this.value,
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
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 640,
	height: 480,
	autoDimensions: false
});
//--></script>  
<?php echo $footer; ?>

<script type="text/javascript">
<?php $config_account_id=$this->config->get('config_account_id'); ?>
$('#text_agree a').removeAttr('href');
$('#text_agree a').removeAttr('class');
$('#text_agree a').attr("href","#privacy_page");
$('#privacy_page_text').load('index.php?route=information/information/info&information_id=<?php echo $config_account_id; ?>');
</script>
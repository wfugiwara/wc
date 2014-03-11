<?php echo $header; ?>
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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a>
        <?php if ($customer_id) { ?>
        <a href="#tab-history"><?php echo $tab_history; ?></a><a href="#tab-transaction"><?php echo $tab_transaction; ?></a><a href="#tab-reward"><?php echo $tab_reward; ?></a>
        <?php } ?>
        <a href="#tab-ip"><?php echo $tab_ip; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <div id="vtabs" class="vtabs"><a href="#tab-customer"><?php echo $tab_general; ?></a>
            <?php $address_row = 1; ?>
            <?php foreach ($addresses as $address) { ?>
            <a href="#tab-address-<?php echo $address_row; ?>" id="address-<?php echo $address_row; ?>"><?php echo $tab_address . ' ' . $address_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#vtabs a:first').trigger('click'); $('#address-<?php echo $address_row; ?>').remove(); $('#tab-address-<?php echo $address_row; ?>').remove(); return false;" /></a>
            <?php $address_row++; ?>
            <?php } ?>
            <span id="address-add"><?php echo $button_add_address; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addAddress();" /></span></div>
          <div id="tab-customer" class="vtabs-content">
            <table class="form">
             <tr>
              <td><?php echo $entry_customer_group; ?></td>
                <td><select name="customer_group_id" id="customer_group_id">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
            </tr>
            <tr id="company-display">
              <td><span id="company-required" class="required">*</span> <?php echo $entry_company; ?></td>
              <td><input type="text" name="company" value="<?php echo $company; ?>" />
                <?php if ($error_company) { ?>
                <span class="error"><?php echo $error_company; ?></span>
                <?php } ?></td>
            </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
                <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                  <?php if ($error_firstname) { ?>
                  <span class="error"><?php echo $error_firstname; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
                <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                  <?php if ($error_lastname) { ?>
                  <span class="error"><?php echo $error_lastname; ?></span>
                  <?php } ?></td>
              </tr>
            <tr id="company-id-display">
              <td><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></td>
              <td><input type="text" name="company_id" value="<?php echo $company_id; ?>" id="cnpj"/>
                <?php if ($error_company_id) { ?>
                <span class="error"><?php echo $error_company_id; ?></span>
                <?php } ?></td>
            </tr>
            <tr id="tax-id-display">
              <td><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?></td>
              <td><input type="text" name="tax_id" value="<?php echo $tax_id; ?>" id="cpf"/>
                <?php if ($error_tax_id) { ?>
                <span class="error"><?php echo $error_tax_id; ?></span>
                <?php } ?></td>
            </tr>
            <tr id="ie-display">
              <td><span id="ie-required" class="required">*</span> <?php echo $entry_ie; ?></td>
              <td><input type="text" name="ie" value="<?php echo $ie; ?>" />
                <?php if ($error_ie) { ?>
                <span class="error"><?php echo $error_ie; ?></span>
                <?php } ?></td>
            <tr id="rg-display">
              <td><span id="rg-required" class="required">*</span> <?php echo $entry_rg; ?></td>
              <td><input type="text" name="rg" value="<?php echo $rg; ?>" />
                <?php if ($error_rg) { ?>
                <span class="error"><?php echo $error_rg; ?></span>
                <?php } ?></td>
            </tr>
           <tr id="sex-display"><?php echo $sex; ?>
           <td><span id="sex-required" class="required">*</span> <?php echo $entry_sex; ?></td>
           <td><select name="sex">
           <?php if ($sex == '') { ?>
                    <option value="" selected="selected"><?php echo $text_select; ?></option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino">Feminino</option>
                    <?php } ?>
           <?php if ($sex == 'Masculino') { ?>
                    <option value=""><?php echo $text_select; ?></option>
                    <option value="Masculino" selected="selected">Masculino</option>
                    <option value="Feminino">Feminino</option>
                    <?php } ?>
           <?php if ($sex == 'Feminino') { ?>
                    <option value=""><?php echo $text_select; ?></option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino" selected="selected">Feminino</option>
                    <?php } ?>
                  </select>
            <?php if ($error_sex) { ?>
            <span class="error"><?php echo $error_sex; ?></span>
            <?php } ?></td>
        </tr> 
        <tr id="birth-date-display">
          <td><span id="birth-date-required" class="required">*</span> <?php echo $entry_birth_date; ?></td>
          <td><input type="text" name="birth_date" value="<?php echo $birth_date; ?>" size="16" id="birth" />
            <?php if ($error_birth_date) { ?>
            <span class="error"><?php echo $error_birth_date; ?></span>
            <?php } ?></td>            
        </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_email; ?></td>
                <td><input type="text" name="email" value="<?php echo $email; ?>" />
                  <?php if ($error_email) { ?>
                  <span class="error"><?php echo $error_email; ?></span>
                  <?php  } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" id="tel"/>
                  <?php if ($error_telephone) { ?>
                  <span class="error"><?php echo $error_telephone; ?></span>
                  <?php  } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_fax; ?></td>
                <td><input type="text" name="fax" value="<?php echo $fax; ?>" id="cel"/></td>
              </tr>
              <tr>
                <td><?php echo $entry_password; ?></td>
                <td><input type="password" name="password" value="<?php echo $password; ?>"  />
                  <br />
                  <?php if ($error_password) { ?>
                  <span class="error"><?php echo $error_password; ?></span>
                  <?php  } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_confirm; ?></td>
                <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                  <?php if ($error_confirm) { ?>
                  <span class="error"><?php echo $error_confirm; ?></span>
                  <?php  } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_newsletter; ?></td>
                <td><select name="newsletter">
                    <?php if ($newsletter) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select name="status">
                    <?php if ($status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
            </table>
          </div>
          <?php $address_row = 1; ?>
          <?php foreach ($addresses as $address) { ?>
          <div id="tab-address-<?php echo $address_row; ?>" class="vtabs-content">
            <input type="hidden" name="address[<?php echo $address_row; ?>][address_id]" value="<?php echo $address['address_id']; ?>" />
            <table class="form">
              <tr>
                <td><?php echo $entry_company; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][company]" value="<?php echo $address['company']; ?>" /></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][firstname]" value="<?php echo $address['firstname']; ?>" />
                  <?php if (isset($error_address_firstname[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_firstname[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][lastname]" value="<?php echo $address['lastname']; ?>" />
                  <?php if (isset($error_address_lastname[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_lastname[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span id="postcode-required<?php echo $address_row; ?>" class="required">*</span> <?php echo $entry_postcode; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][postcode]" value="<?php echo $address['postcode']; ?>" id="postcode"/></td>
              </tr>                            
              <tr>
                <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][address_1]" value="<?php echo $address['address_1']; ?>" />
                  <?php if (isset($error_address_address_1[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_address_1[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_number; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][number]" value="<?php echo $address['number']; ?>" />
                  <?php if (isset($error_address_number[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_number[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_complement; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][complement]" value="<?php echo $address['complement']; ?>" /></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_address_2; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][address_2]" value="<?php echo $address['address_2']; ?>" />
                  <?php if (isset($error_address_address_2[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_address_2[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_city; ?></td>
                <td><input type="text" name="address[<?php echo $address_row; ?>][city]" value="<?php echo $address['city']; ?>" />
                  <?php if (isset($error_address_city[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_city[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_country; ?></td>
                <td><select name="address[<?php echo $address_row; ?>][country_id]" onchange="country(this, '<?php echo $address_row; ?>', '<?php echo $address['zone_id']; ?>');">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php foreach ($countries as $country) { ?>
                    <?php if ($country['country_id'] == $address['country_id']) { ?>
                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  <?php if (isset($error_address_country[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_country[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
                <td><select name="address[<?php echo $address_row; ?>][zone_id]">
                  </select>
                  <?php if (isset($error_address_zone[$address_row])) { ?>
                  <span class="error"><?php echo $error_address_zone[$address_row]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_default; ?></td>
                <td><?php if (($address['address_id'] == $address_id) || !$addresses) { ?>
                  <input type="radio" name="address[<?php echo $address_row; ?>][default]" value="<?php echo $address_row; ?>" checked="checked" /></td>
                <?php } else { ?>
                <input type="radio" name="address[<?php echo $address_row; ?>][default]" value="<?php echo $address_row; ?>" />
                  </td>
                <?php } ?>
              </tr>
            </table>
          </div>
          <?php $address_row++; ?>
          <?php } ?>
        </div>
        <?php if ($customer_id) { ?>
        <div id="tab-history">
          <div id="history"></div>
          <table class="form">
            <tr>
              <td><?php echo $entry_comment; ?></td>
              <td><textarea name="comment" cols="40" rows="8" style="width: 99%;"></textarea></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-history" class="button"><span><?php echo $button_add_history; ?></span></a></td>
            </tr>
          </table>
        </div>
        <div id="tab-transaction">
          <table class="form">
            <tr>
              <td><?php echo $entry_description; ?></td>
              <td><input type="text" name="description" value="" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_amount; ?></td>
              <td><input type="text" name="amount" value="" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-reward" class="button" onclick="addTransaction();"><span><?php echo $button_add_transaction; ?></span></a></td>
            </tr>
          </table>
          <div id="transaction"></div>
        </div>
        <div id="tab-reward">
          <table class="form">
            <tr>
              <td><?php echo $entry_description; ?></td>
              <td><input type="text" name="description" value="" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_points; ?></td>
              <td><input type="text" name="points" value="" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-reward" class="button" onclick="addRewardPoints();"><span><?php echo $button_add_reward; ?></span></a></td>
            </tr>
          </table>
          <div id="reward"></div>
        </div>
        <?php } ?>
        <div id="tab-ip">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $column_ip; ?></td>
                <td class="right"><?php echo $column_total; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($ips) { ?>
              <?php foreach ($ips as $ip) { ?>
              <tr>
                <td class="left"><a href="http://www.geoiptool.com/en/?IP=<?php echo $ip['ip']; ?>" target="_blank"><?php echo $ip['ip']; ?></a></td>
                <td class="right"><a href="<?php echo $ip['filter_ip']; ?>" target="_blank"><?php echo $ip['total']; ?></a></td>
                <td class="left"><?php echo $ip['date_added']; ?></td>
                <td class="right"><?php if ($ip['ban_ip']) { ?>
                  <b>[</b> <a id="<?php echo str_replace('.', '-', $ip['ip']); ?>" onclick="removeBanIP('<?php echo $ip['ip']; ?>');"><?php echo $text_remove_ban_ip; ?></a> <b>]</b>
                  <?php } else { ?>
                  <b>[</b> <a id="<?php echo str_replace('.', '-', $ip['ip']); ?>" onclick="addBanIP('<?php echo $ip['ip']; ?>');"><?php echo $text_add_ban_ip; ?></a> <b>]</b>
                  <?php } ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item['category'] != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item['category'] + '</li>');
				
				currentCategory = item['category'];
			}
			
			self._renderItem(ul, item);
		});
	}
});

$('select[id=\'customer_group_id\']').live('change', function() {
	$('input[name=\'customer_group_id\']').attr('value', this.value);
	
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['birth_date_display'] = '<?php echo $customer_group['birth_date_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['birth_date_required'] = '<?php echo $customer_group['birth_date_required']; ?>';
    customer_group[<?php echo $customer_group['customer_group_id']; ?>]['sex_display'] = '<?php echo $customer_group['sex_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['sex_required'] = '<?php echo $customer_group['sex_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_display'] = '<?php echo $customer_group['company_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_required'] = '<?php echo $customer_group['company_required']; ?>';
    customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['ie_display'] = '<?php echo $customer_group['ie_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['ie_required'] = '<?php echo $customer_group['ie_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['rg_display'] = '<?php echo $customer_group['rg_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['rg_required'] = '<?php echo $customer_group['rg_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['birth_date_display'] == '1') {
			$('#birth-date-display').show();
		} else {
			$('#birth-date-display').hide();
		}
		
		if (customer_group[this.value]['birth_date_required'] == '1') {
			$('#birth-date-required').show();
		} else {
			$('#birth-date-required').hide();
		}
        
		if (customer_group[this.value]['sex_display'] == '1') {
			$('#sex-display').show();
		} else {
			$('#sex-display').hide();
		}
		
		if (customer_group[this.value]['sex_required'] == '1') {
			$('#sex-required').show();
		} else {
			$('#sex-required').hide();
		}
		
        if (customer_group[this.value]['company_display'] == '1') {
			$('#company-display').show();
		} else {
			$('#company-display').hide();
		}
		
		if (customer_group[this.value]['company_required'] == '1') {
			$('#company-required').show();
		} else {
			$('#company-required').hide();
		}
		
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
        if (customer_group[this.value]['ie_display'] == '1') {
			$('#ie-display').show();
		} else {
			$('#ie-display').hide();
		}
		
		if (customer_group[this.value]['ie_required'] == '1') {
			$('#ie-required').show();
		} else {
			$('#ie-required').hide();
		}
		
		if (customer_group[this.value]['rg_display'] == '1') {
			$('#rg-display').show();
		} else {
			$('#rg-display').hide();
		}
		
		if (customer_group[this.value]['rg_required'] == '1') {
			$('#rg-required').show();
		} else {
			$('#rg-required').hide();
		}	
	}
});

$('select[id=\'customer_group_id\']').trigger('change');

//--></script> 
<script type="text/javascript"><!--
function country(element, index, zone_id) {
	$.ajax({
		url: 'index.php?route=sale/customer/country&token=<?php echo $token; ?>&country_id=' + element.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'address[' + index + '][country_id]\']').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required' + index).show();
			} else {
				$('#postcode-required' + index).hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == zone_id) {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'address[' + index + '][zone_id]\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

$('select[name$=\'[country_id]\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
var address_row = <?php echo $address_row; ?>;

function addAddress() {	
	html  = '<div id="tab-address-' + address_row + '" class="vtabs-content" style="display: none;">';
	html += '  <input type="hidden" name="address[' + address_row + '][address_id]" value="" />';
	html += '  <table class="form">';
    html += '    <tr>';
    html += '      <td><?php echo $entry_company; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][company]" value="" /></td>';
    html += '    </tr>';
	html += '    <tr>';
    html += '	   <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>';
    html += '	   <td><input type="text" name="address[' + address_row + '][firstname]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][lastname]" value="" /></td>';
    html += '    </tr>';
//    html += '    <tr class="company-id-display">';
//    html += '      <td><?php echo $entry_company_id; ?></td>';
//    html += '      <td><input type="text" name="address[' + address_row + '][company_id]" value="" /></td>';
//    html += '    </tr>';
//    html += '    <tr class="tax-id-display">';
//    html += '      <td><?php echo $entry_tax_id; ?></td>';
//    html += '      <td><input type="text" name="address[' + address_row + '][tax_id]" value="" /></td>';
//    html += '    </tr>';			
    html += '    <tr>';
    html += '      <td><span id="postcode-required' + address_row + '" class="required">*</span> <?php echo $entry_postcode; ?></td>';
    html += '      <td><input type="text" id="postcode" name="address[' + address_row + '][postcode]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][address_1]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_number; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][number]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><?php echo $entry_complement; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][complement]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_address_2; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][address_2]" value="" /></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_city; ?></td>';
    html += '      <td><input type="text" name="address[' + address_row + '][city]" value="" /></td>';
    html += '    </tr>';
	html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_country; ?></td>';
    html += '      <td><select name="address[' + address_row + '][country_id]" onchange="country(this, \'' + address_row + '\', \'0\');">';
    html += '         <option value=""><?php echo $text_select; ?></option>';
    <?php foreach ($countries as $country) { ?>
    html += '         <option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
    <?php } ?>
    html += '      </select></td>';
    html += '    </tr>';
    html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_zone; ?></td>';
    html += '      <td><select name="address[' + address_row + '][zone_id]"><option value="false"><?php echo $this->language->get('text_none'); ?></option></select></td>';
    html += '    </tr>';
	html += '    <tr>';
    html += '      <td><?php echo $entry_default; ?></td>';
    html += '      <td><input type="radio" name="address[' + address_row + '][default]" value="1" /></td>';
    html += '    </tr>';
    html += '  </table>';
    html += '</div>';
	
	$('#tab-general').append(html);
	
	$('select[name=\'address[' + address_row + '][country_id]\']').trigger('change');	
	
	$('#address-add').before('<a href="#tab-address-' + address_row + '" id="address-' + address_row + '"><?php echo $tab_address; ?> ' + address_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#vtabs a:first\').trigger(\'click\'); $(\'#address-' + address_row + '\').remove(); $(\'#tab-address-' + address_row + '\').remove(); return false;" /></a>');
		 
	$('.vtabs a').tabs();
	
	$('#address-' + address_row).trigger('click');
	
	address_row++;
}
//--></script>
<script type="text/javascript"><!--
$('#history .pagination a').live('click', function() {
	$('#history').load(this.href);
	
	return false;
});			

$('#history').load('index.php?route=sale/customer/history&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

$('#button-history').bind('click', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/history&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'comment=' + encodeURIComponent($('#tab-history textarea[name=\'comment\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-history').attr('disabled', true);
			$('#history').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-history').attr('disabled', false);
			$('.attention').remove();
      		$('#tab-history textarea[name=\'comment\']').val('');
		},
		success: function(html) {
			$('#history').html(html);
			
			$('#tab-history input[name=\'comment\']').val('');
		}
	});
});
//--></script>  
<script type="text/javascript"><!--
$('#transaction .pagination a').live('click', function() {
	$('#transaction').load(this.href);
	
	return false;
});			

$('#transaction').load('index.php?route=sale/customer/transaction&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

function addTransaction() {
	$.ajax({
		url: 'index.php?route=sale/customer/transaction&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-transaction input[name=\'description\']').val()) + '&amount=' + encodeURIComponent($('#tab-transaction input[name=\'amount\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-transaction').attr('disabled', true);
			$('#transaction').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-transaction').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#transaction').html(html);
			
			$('#tab-transaction input[name=\'amount\']').val('');
			$('#tab-transaction input[name=\'description\']').val('');
		}
	});
}
//--></script> 
<script type="text/javascript"><!--
$('#reward .pagination a').live('click', function() {
	$('#reward').load(this.href);
	
	return false;
});			

$('#reward').load('index.php?route=sale/customer/reward&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

function addRewardPoints() {
	$.ajax({
		url: 'index.php?route=sale/customer/reward&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-reward input[name=\'description\']').val()) + '&points=' + encodeURIComponent($('#tab-reward input[name=\'points\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-reward').attr('disabled', true);
			$('#reward').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-reward').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#reward').html(html);
								
			$('#tab-reward input[name=\'points\']').val('');
			$('#tab-reward input[name=\'description\']').val('');
		}
	});
}

function addBanIP(ip) {
	var id = ip.replace(/\./g, '-');
	
	$.ajax({
		url: 'index.php?route=sale/customer/addbanip&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent(ip),
		beforeSend: function() {
			$('.success, .warning').remove();
			
			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');		
		},
		complete: function() {
			
		},			
		success: function(json) {
			$('.attention').remove();
			
			if (json['error']) {
				 $('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
				
				$('.warning').fadeIn('slow');
			}
						
			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
				
				$('.success').fadeIn('slow');
				
				$('#' + id).replaceWith('<a id="' + id + '" onclick="removeBanIP(\'' + ip + '\');"><?php echo $text_remove_ban_ip; ?></a>');
			}
		}
	});	
}

function removeBanIP(ip) {
	var id = ip.replace(/\./g, '-');
	
	$.ajax({
		url: 'index.php?route=sale/customer/removebanip&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent(ip),
		beforeSend: function() {
			$('.success, .warning').remove();
			
			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');					
		},	
		success: function(json) {
			$('.attention').remove();
			
			if (json['error']) {
				 $('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
				
				$('.warning').fadeIn('slow');
			}
			
			if (json['success']) {
				 $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
				
				$('.success').fadeIn('slow');
				
				$('#' + id).replaceWith('<a id="' + id + '" onclick="addBanIP(\'' + ip + '\');"><?php echo $text_add_ban_ip; ?></a>');
			}
		}
	});	
};
//--></script> 
<script type="text/javascript"><!--
$('.htabs a').tabs();
$('.vtabs a').tabs();
//--></script>

<script type="text/javascript">
      jQuery(function($) {
      $("#postcode").mask("99999-999");
      $('[id^="address-"]').click(function() {
        $('[id^="postcode"]').unmask();
        $('[id^="postcode"]').mask("99999-999");
        });
      $("#birth").mask("99/99/9999");
      $("#cpf").mask("999.999.999-99");
      $("#cnpj").mask("99.999.999/9999-99");
      $("#tel").mask("(99)9999-9999");
      $("#cel").mask("(99)9999-9999?9");
   });
</script>

<?php echo $footer; ?>
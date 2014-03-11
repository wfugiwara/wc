<?php echo $header; ?>
<style type='text/css'>
.bottom_export {
	vertical-align:bottom;
	text-align:left;
}
.scroll_cell {
	width:400px;
}
.input_field {
	width:200px;
}

.scrollbox {
	margin-bottom: 5px;
	height:320px;
}
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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1><img src="view/image/backup.png" /><?php echo $heading_title; ?>&nbsp;(<a href="http://helpdesk.hostjars.com/entries/23220857-Customer-Import-Export-How-to-use" title='Documentation'><?php echo $text_documentation; ?></a>)</h1>
    <div class="buttons"><a onclick="$('#import').submit();" class="button"><span><?php echo $button_import; ?></span></a><a onclick="$('#export').submit();" class="button"><span><?php echo $button_export; ?></span></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="htabs"><a href="#tab-import"><?php echo $tab_import; ?></a><a href="#tab-export"><?php echo $tab_export; ?></a></div>
	 <div id="tab-import">
      <form action="<?php echo $import; ?>" method="post" enctype="multipart/form-data" id="import">
      <table class="form">
      	<!-- mapping fields to names -->
		<tr>
			<td colspan="2">
				<table>
					<tr><td class='input_field'><h2><?php echo $text_field_oc_title; ?></h2></td><td><h2><?php echo $text_field_csv_title; ?></h2></td>
					<tr><td class='input_field'><?php echo $text_field_firstname; ?></td><td><input type="text" name="customers_field_firstname" value="firstname"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_lastname; ?></td><td><input type="text" name="customers_field_lastname" value="lastname"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_email; ?></td><td><input type="text" name="customers_field_email" value="email"></td></tr>
					
					<tr><td class='input_field'>DDD: </td><td><input type="text" name="customers_field_ddd" value="ddd"></td></tr>
					
					<tr><td class='input_field'><?php echo $text_field_telephone; ?></td><td><input type="text" name="customers_field_telephone" value="telephone"></td></tr>
					
					<tr><td class='input_field'>DDD (Celular): </td><td><input type="text" name="customers_field_ddd2" value="ddd2"></td></tr>
					<tr><td class='input_field'>Celular: </td><td><input type="text" name="customers_field_telephone2" value="telephone2"></td></tr>
					
					 <tr><td class='input_field'><?php echo $text_field_fax; ?></td><td><input type="text" name="customers_field_fax" value="fax"></td></tr> 
					
					<tr><td class='input_field'>CPF: </td><td><input type="text" name="customers_field_cpf" value="cpf"></td></tr>
					<tr><td class='input_field'>CNPJ: </td><td><input type="text" name="customers_field_cnpj" value="cnpj"></td></tr>
					<tr><td class='input_field'>Razão Social: </td><td><input type="text" name="customers_field_razao_social" value="razao_social"></td></tr>
					<tr><td class='input_field'>Inscrição Estadual: </td><td><input type="text" name="customers_field_inscricao_estadual" value="inscricao_estadual"></td></tr>
					<tr><td class='input_field'>Data de Nascimento: </td><td><input type="text" name="customers_field_data_nascimento" value="data_nascimento"></td></tr>
					<tr><td class='input_field'>Sexo: </td><td><input type="text" name="customers_field_sexo" value="sexo"></td></tr>
					<?php /* 
					<tr><td class='input_field'>Renavam: </td><td><input type="text" name="customers_field_placa1" value="placa1"></td></tr>
					<tr><td class='input_field'>Renavam 2: </td><td><input type="text" name="customers_field_placa2" value="placa2"></td></tr>
					*/ 
					?>
					
					
					<tr><td class='input_field'><?php echo $text_field_password; ?><span class="help"><?php echo $text_password_help; ?></span></td><td><input type="text" name="customers_field_password" value="<?php echo $customers_field_password; ?>"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_newsletter; ?></td><td><input type="text" name="customers_field_newsletter" value="<?php echo $customers_field_newsletter; ?>"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_company; ?></td><td><input type="text" name="customers_field_company" value="company"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_address_1; ?></td><td><input type="text" name="customers_field_address_1" value="address_1"></td></tr>
					
					<tr><td class='input_field'>numero</td><td><input type="text" name="customers_field_numero" value="numero"></td></tr>
					
					<tr><td class='input_field'><?php echo $text_field_address_2; ?></td><td><input type="text" name="customers_field_address_2" value="address_2"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_postcode; ?></td><td><input type="text" name="customers_field_postcode" value="postcode"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_city; ?></td><td><input type="text" name="customers_field_city" value="city"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_country_id; ?></td><td><input type="text" name="customers_field_country_id" value="country_id"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_zone_id; ?></td><td><input type="text" name="customers_field_zone_id" value="zone_id"></td></tr>
					<tr><td class='input_field'><?php echo $text_field_status; ?></td><td><input type="text" name="customers_field_status" value="status"></td></tr>
				</table>
			</td>
		</tr>
		<!-- ignore where FIELD equals VALUE -->
		<tr>
			<td><?php echo $entry_ignore_fields; ?></td>
			<td>
				<input onfocus="$(this).val('');" type="text" name="customer_import_ignore_field" value="<?php if (isset($customer_import_ignore_field)) { echo $customer_import_ignore_field; } else { echo 'COLUMN'; }  ?>">
				&nbsp;<?php echo $entry_contains; ?>&nbsp;
				<input onfocus="$(this).val('');" type="text" name="customer_import_ignore_value" value="<?php if (isset($customer_import_ignore_value)) { echo $customer_import_ignore_value; } else { echo 'VALUE'; } ?>"></td>
		</tr>
      	<!-- delimiter -->
		<tr>
			<td><?php echo $entry_delimiter; ?></td>
			<td>
				<select name="customer_import_delimiter">
					<option value="," <?php if (isset($customer_import_delimiter) && $customer_import_delimiter == ',') { echo 'selected="true"'; } ?>>,</option>
					<option value="\t" <?php if (isset($customer_import_delimiter) && $customer_import_delimiter == '\t') { echo 'selected="true"'; } ?>><?php echo $entry_tab; ?></option>
					<option value="|" <?php if (isset($customer_import_delimiter) && $customer_import_delimiter == '|') { echo 'selected="true"'; } ?>>|</option>
					<option value=";" <?php if (isset($customer_import_delimiter) && $customer_import_delimiter == ';') { echo 'selected="true"'; } ?>>;</option>
					<option value="^" <?php if (isset($customer_import_delimiter) && $customer_import_delimiter == '^') { echo 'selected="true"'; } ?>>^</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="width:20px;"><?php echo $entry_import; ?></td>
          	<td><input type="file" name="import" /><a onclick="$('#import').submit();" class="button"><span><?php echo $button_import; ?></span></a></td>
		</tr>
      </table>
    </form>
    </div>
    <div id="tab-export">
    <form action="<?php echo $export; ?>" method="post" enctype="multipart/form-data" id="export">
      <table class="form">
        <tr>
          <td><?php echo $entry_export; ?></td>
          <td class='scroll_cell'><div class="scrollbox">
              <?php $class = 'odd'; ?>
              <?php foreach ($tables as $table) { ?>
              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
              <div class="<?php echo $class; ?>">
                <input type="checkbox" name="export[]" value="<?php echo $table; ?>" checked="checked" />
                <?php echo $table; ?>
               </div>
              <?php } ?>
            </div>
            <a onclick="$(this).parent().find(':checkbox').attr('checked', true);">Select All</a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);">Unselect All</a>
          </td>
        </tr>
        <tr>
		   	<td><?php echo $entry_single_address; ?><span class="help"><?php echo $entry_single_address_help; ?></span></td>
		   	<td colspan="2"><input type="checkbox" name="single_address" id="single_address" <?php if (isset($single_address)) echo 'checked="checked" '; ?>/></td>
    	    <td class="bottom_export">
          	<a onclick="$('#export').submit();" class="button"><span><?php echo $button_export; ?></span></a>
          </td>
        </tr>
      </table>
    </form>
    </div>
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
				dateFormat: 'yy-mm-dd';
			}
		});
	});
</script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<?php echo $footer; ?>
<div class="box" id="pp_shipping_estimator" style="display: none;">
    <div class="box-heading" ><?php echo $heading_title; ?></div>
    <div class="box-content" id="pp_shipping_estimator-content">
        <?php if ($auto_quote) { ?>
            <table id="autoquote" >
                <tr>
                    <td colspan="4" >
                        <?php
                        echo str_replace(
                                array('{country}', '{zone}'),
                                array($current_country, $current_zone),
                                $text_auto_quote
                        );
                        ?>
                    </td>
                </tr>
        <?php if ($auto_quote['lowest']['cost'] == 0) { ?>
                    <tr>
                        <td colspan="4" style="color:green;font-weight:bold;">
                            <?php
                            echo str_replace(
                                    '{shipping_method}', 
                                    $auto_quote['lowest']['title'],
                                    $text_auto_quote_cost_free
                            );
                            ?>
                        </td>
                    </tr>
        <?php } else { ?>
                    <tr>
                        <td colspan="4" style="color:green;">
                            <?php
                            echo str_replace(
                                    array('{shipping_cost}', '{shipping_method}'),
                                    array($auto_quote['lowest']['text'], $auto_quote['lowest']['title']),
                                    $text_auto_quote_cost_lowest
                            );
                            ?>
                        </td>
                    </tr>
        <?php } ?>
                <tr>
                    <td colspan="4" style="font-size: 11px;">
                        <a onclick="$('#autoquote').remove();$('#shipping').show();"><?php echo $text_wrong_region;?></a>
                        | <a onclick="$('#auto_quote-shipping_methods').show('slow');"><?php echo $text_other_methods;?></a></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="100%" cellpadding="3" id="auto_quote-shipping_methods" style="display:none;" >
    <?php foreach ($auto_quote['shipping_methods'] as $shipping_method) { ?>
                                <tr>
                                    <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
                                </tr>
                                    <?php if (!$shipping_method['error']) { ?>
                                        <?php foreach ($shipping_method['quote'] as $quote) { ?>
                                        <tr>
                                            <?php if ($auto_quote['lowest']['code'] == $quote['code']) { ?>
                                                <td width="1"><input type="radio" checked="checked" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" /></td>
                                            <?php } else { ?>
                                                <td width="1"><input type="radio"  name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" /></td>
                <?php } ?>
                                            <td><label style="font-size: 11px;" for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
                                            <td width="1"><label  for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                                        </tr>
            <?php } ?>	
        <?php } else { ?>
                                    <tr>
                                        <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
                                    </tr>
        <?php } ?>
    <?php } ?>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><a id="button-shipping" class="button"><span><?php echo $button_shipping; ?></span></a></td>
                </tr>
            </table>
            <table id="shipping" style="display:none;">
                <?php } else { ?>
                <table id="shipping">
                        <?php } ?>
                <tr>
                    <td colspan="4" style="font-size: 11px;">
                <?php echo $text_shipping; ?>
                    </td>
                </tr>
<?php if ($country_required) { ?>
                    <tr>
                        <td  style="font-size: 11px;"><span class="required">*</span> <?php echo $entry_country; ?></td>
                    </tr>
                    <tr>
                        <td>
                            <select style="font-size: 11px;"  name="country_id" onchange="$('select[name=\'zone_id\']').load('index.php?route=module/pp_shipping_estimator/zone&country_id=' + this.value + '&zone_id=<?php echo $pp_shipping_estimator_zone_id; ?>');">
                                <option value=""><?php echo $text_select; ?></option>
                                <?php foreach ($countries as $country) { ?>
                                    <?php if ($country['country_id'] == $pp_shipping_estimator_country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
    <?php } ?>
                            </select>
                        </td>
                    </tr> 
<?php } ?>
<?php if ($zone_required) { ?>
                    <tr>
                        <td  style="font-size: 11px;"><span class="required">*</span> <?php echo $entry_zone; ?></td>
                    </tr>
                    <tr>
                        <td><select style="font-size: 11px;"   name="zone_id" ></select></td>
                    </tr> 
<?php } ?>
<?php if ($postcode_required) { ?> 
                    <tr>
                        <td style="font-size: 11px;">
                            <span class="required">*</span> <?php echo $entry_postcode; ?>
                        </td>
                    </tr>
                    <tr>
                        <td><input style="font-size: 11px;"  type="text" name="postcode" value="<?php echo $pp_shipping_estimator_postcode; ?>" />    </td>
                    </tr>
<?php } ?>
                <tr>
                    <td><a id="button-quote"  class="button"><span><?php echo $button_quote; ?></span></a></td>
                </tr>

            </table>
            <div id="info_msg" style="width: 100%;display: none;padding-top: 3px;"></div>
            <div id="quote" style="display: none; "></div>
            <div id="info_msg2" style="width: 100%;display: none;padding-top: 3px;"></div>
    </div>
</div>
<script type="text/javascript">
<?php if (!$show_as_module) { ?>
                                            
        $(function(){

            $('#pp_shipping_estimator-content').appendTo($('input[name=\'quantity\']').parent().parent());

            $('#pp_shipping_estimator').remove();

        });
                                   
<?php } ?>
    $('select[name=\'zone_id\']').load('index.php?route=module/pp_shipping_estimator/zone&country_id=<?php echo $pp_shipping_estimator_country_id; ?>&zone_id=<?php echo $pp_shipping_estimator_zone_id; ?>');

    $('#button-quote').live('click', function() {
        $.ajax({
            type: 'POST',
            url: 'index.php?route=module/pp_shipping_estimator/quote', 
            data: $('input[type=\'text\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
            dataType: 'json',		
            beforeSend: function() {
                $('#button-quote').attr('disabled', true);
                $('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('#button-quote').attr('disabled', false);
                $('.wait').remove();
            },
            success: function(json) {
                    
                $('.error').remove();

                if (json['error']) {
			
                    $('#info_msg').html('<div style="color:red">' + json['text_error'] + '</div>');
							
                }else{

                    $('#info_msg').html('<div style="color:green">' + json['text_success'] + '</div>');
                }
                        
                $('#info_msg').show();
			
                if (json['shipping_methods']) {
                    
                    ppse_json_html  = '';
                    ppse_json_html += '<table width="100%" cellpadding="3" >';
				
                    for (i in json['shipping_methods']) {
                        
                        ppse_json_html += '<tr>';
                        ppse_json_html += '  <td colspan="3"><b>' + json['shipping_methods'][i]['title'] + '</b></td>';
                        ppse_json_html += '</tr>';
				
                        if (!json['shipping_methods'][i]['error']) {
                            
                            for (j in json['shipping_methods'][i]['quote']) {
                                
                                ppse_json_html += '<tr>';                      
                                ppse_json_html += '<td width="1"><input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" /></td>';
                                ppse_json_html += '  <td><label style="font-size: 11px;" for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['title'] + '</label></td>';
                                ppse_json_html += '  <td width="1"><label  for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['text'] + '</label></td>';
                                ppse_json_html += '</tr>';
                            }
                            
                        } else {
                        
                            ppse_json_html += '<tr>';
                            ppse_json_html += '  <td colspan="3"><div class="error">' + json['shipping_methods'][i]['error'] + '</div></td>';
                            ppse_json_html += '</tr>	';						
                        }
                    }
				
                    ppse_json_html += '</table>';
                    ppse_json_html += '<br /><a id="button-shipping" class="button"><span><?php echo $button_shipping; ?></span></a>';				
		
                    $('#quote').html(ppse_json_html);	
			
                    $('#quote').slideDown('slow');
                                
                }

            }
        });
    });
    
    $('#button-shipping').live('click', function() {

        $.ajax({
            type: 'POST',
            url: 'index.php?route=module/pp_shipping_estimator/calculate',
            data: $('input[type=\'text\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
            dataType: 'json',		
            beforeSend: function() {
                    
                $('#info_msg2').hide();
                $('#button-shipping').attr('disabled', true);
                $('#button-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                    
                $('#button-shipping').attr('disabled', false);
                $('.wait').remove();
          
            },	
            success: function(json) {
                if (json['error']) {
                        
                    $('#info_msg2').html('<div style="color:red">' + json['text_error'] +'</div>');
                            
                    $('#info_msg2').show();   
                }
                  
                if (json['redirect']) {
                    location = json['redirect'];
                }
            }

        });
    });
</script> 
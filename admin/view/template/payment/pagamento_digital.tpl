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
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    <table class="form">
	      <tr>
	        <td><span class="required">*</span> <?php echo $entry_token; ?></td>
	        <td><input type="text" name="pagamento_digital_token" value="<?php echo $pagamento_digital_token; ?>" size="50%" />
	          <?php if ($error_token) { ?>
	          <span class="error"><?php echo $error_token; ?></span>
	          <?php } ?></td>
	      </tr>
	      <tr>
	        <td><span class="required">*</span> <?php echo $entry_email; ?></td>
	        <td><input type="text" name="pagamento_digital_email" value="<?php echo $pagamento_digital_email; ?>" size="50%" />
	          <?php if ($error_email) { ?>
	          <span class="error"><?php echo $error_email; ?></span>
	          <?php } ?></td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_posfixo; ?></td>
	        <td><input type="text" name="pagamento_digital_posfixo" value="<?php echo $pagamento_digital_posfixo; ?>" /></td>
	      </tr>	      
	      <tr>
	        <td><?php echo $entry_dados_cliente; ?></td>
	        <td>
			  <select name="pagamento_digital_dados_cliente">
	            <?php if ($pagamento_digital_dados_cliente) { ?>
	            <option value="1" selected="selected"><?php echo $text_yes; ?></option>
	            <option value="0"><?php echo $text_no; ?></option>
	            <?php } else { ?>
	            <option value="1"><?php echo $text_yes; ?></option>
	            <option value="0" selected="selected"><?php echo $text_no; ?></option>
	            <?php } ?>
	          </select>
			</td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_update_status_alert; ?></td>
	        <td>
			  <select name="pagamento_digital_update_status_alert">
	            <?php if ($pagamento_digital_update_status_alert) { ?>
	            <option value="1" selected="selected"><?php echo $text_yes; ?></option>
	            <option value="0"><?php echo $text_no; ?></option>
	            <?php } else { ?>
	            <option value="1"><?php echo $text_yes; ?></option>
	            <option value="0" selected="selected"><?php echo $text_no; ?></option>
	            <?php } ?>
	          </select>
			</td>
	      </tr>		            
	      <tr>
	        <td><?php echo $entry_order_finalizando; ?></td>
	        <td><select name="pagamento_digital_order_finalizando" id="pagamento_digital_order_finalizando">
	          <?php foreach ($order_statuses as $order_status) { ?>
	          <?php if ($order_status['order_status_id'] == $pagamento_digital_order_finalizando) { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
	          <?php } else { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
	          <?php } ?>
	          <?php } ?>
	        </select>
	        </td>
	      </tr>      
	      
	      <tr>
	        <td><?php echo $entry_order_andamento; ?></td>
	        <td><select name="pagamento_digital_order_andamento" id="pagamento_digital_order_andamento">
	          <?php foreach ($order_statuses as $order_status) { ?>
	          <?php if ($order_status['order_status_id'] == $pagamento_digital_order_andamento) { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
	          <?php } else { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
	          <?php } ?>
	          <?php } ?>
	        </select>
	        </td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_order_cancelado; ?></td>
	        <td><select name="pagamento_digital_order_cancelado" id="pagamento_digital_order_cancelado">
	          <?php foreach ($order_statuses as $order_status) { ?>
	          <?php if ($order_status['order_status_id'] == $pagamento_digital_order_cancelado) { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
	          <?php } else { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
	          <?php } ?>
	          <?php } ?>
	        </select>
	        </td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_order_concluido; ?></td>
	        <td><select name="pagamento_digital_order_concluido" id="pagamento_digital_order_concluido">
	          <?php foreach ($order_statuses as $order_status) { ?>
	          <?php if ($order_status['order_status_id'] == $pagamento_digital_order_concluido) { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
	          <?php } else { ?>
	          <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
	          <?php } ?>
	          <?php } ?>
	        </select>
	         </td>
	      </tr>
	      
	      <tr>
	        <td><?php echo $entry_geo_zone; ?></td>
	        <td>
			  <select name="pagamento_digital_geo_zone_id">
	            <option value="0"><?php echo $text_all_zones; ?></option>
	            <?php foreach ($geo_zones as $geo_zone) { ?>
	            <?php if ($geo_zone['geo_zone_id'] == $pagamento_digital_geo_zone_id) { ?>
	            <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
	            <?php } else { ?>
	            <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
	           <?php } ?>
	            <?php } ?>
	          </select>
			</td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_status; ?></td>
	        <td>
			  <select name="pagamento_digital_status">
	            <?php if ($pagamento_digital_status) { ?>
	            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
	            <option value="0"><?php echo $text_disabled; ?></option>
	            <?php } else { ?>
	            <option value="1"><?php echo $text_enabled; ?></option>
	            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
	            <?php } ?>
	          </select>
			</td>
	      </tr>
	      <tr>
	        <td><?php echo $entry_sort_order; ?></td>
	        <td><input type="text" name="pagamento_digital_sort_order" value="<?php echo $pagamento_digital_sort_order; ?>" size="1" /></td>
	      </tr>
	    </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 
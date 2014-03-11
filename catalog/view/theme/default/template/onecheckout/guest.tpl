<div id="guest-cpanle" class="divclear">
<?php if ($shipping_required) { ?>
  <?php if ($shipping_address) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping"<?php if ($this->config->get('onecheckout_check_deliveryaddress')) { ?> checked="checked"<?php } ?> />
  <?php } else { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" />
  <?php } ?>
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <br />
<?php } else { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" style="display:none;" />
<?php } ?>
</div>
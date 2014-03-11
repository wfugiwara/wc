<div data-role="content" style="margin-bottom:5px; margin-top:5px;">
<div data-role="collapsible" data-theme="a">
				<h3><?php echo $text_store; ?></h3>
 <p>
    <select name="store" onchange="location = this.value">
      <?php foreach ($stores as $store) { ?>
      <?php if ($store['store_id'] == $store_id) { ?>
      <option value="<?php echo $store['url']; ?>" selected="selected"><?php echo $store['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $store['url']; ?>"><?php echo $store['name']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
</p>
 </div>
</div>

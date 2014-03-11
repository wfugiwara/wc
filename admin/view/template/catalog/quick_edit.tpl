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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/quickeditplus.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#quick_edit').submit();" class="button"><?php echo $button_update; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $quick_edit; ?>" method="post" id="quick_edit">
        <table class="form">
          <tr>
            <td><?php echo $entry_price_adjust; ?></td>
            <td><input type="text" name="price_adjust" value="<?php echo $price_adjust; ?>" size="4" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_price_type; ?></td>
            <td><select name="price_type">
              <?php foreach ($price_types_array as $price_type) { ?>
              <?php if( $price_type['id'] == $default_type_id) { ?>
              <option value="<?php echo $price_type['id']; ?>" selected="selected"><?php echo $price_type['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $price_type['id']; ?>"><?php echo $price_type['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_price_round; ?></td>
            <td><input type="text" name="price_round" value="<?php echo $price_round; ?>" size="4" /></td>
          </tr>

          <tr>
            <td><?php echo $entry_category; ?></td>
            <td><div class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($categories_array as $category) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php if( !$category['category_id'] ) { ?>
                  <input type="checkbox" name="all_categories" value="1" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" />
                  <?php } ?>
                  <?php echo $category['name']; ?>
                </div>
                <?php } ?>
              </div>
              <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
          </tr>

        </table>
      </form>

    </div>
	<tr>
					<td colspan="4">
					<img
									src="view/image/atention.png"
									alt="atetion" /><b> <?php echo $text_support; ?></b>
					</td>
				</tr>
	<tr>
  </div>
</div>
<?php echo $footer; ?>
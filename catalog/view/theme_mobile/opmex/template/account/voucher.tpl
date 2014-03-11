<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
</div>
<?php echo $content_top; ?>
<div data-role="content" style="text-align:center; margin-top:10px;">
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <p><?php echo $text_description; ?></p>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
<input type="text" name="to_name" value="<?php echo $to_name; ?>" placeholder="* <?php echo $entry_to_name; ?>" />
          <?php if ($error_to_name) { ?>
          <div class="error"><?php echo $error_to_name; ?></div>
          <?php } ?>

<input type="text" name="to_email" value="<?php echo $to_email; ?>" placeholder="* <?php echo $entry_to_email; ?>" />
          <?php if ($error_to_email) { ?>
          <div class="error"><?php echo $error_to_email; ?></div>
          <?php } ?>

<input type="text" name="from_name" value="<?php echo $from_name; ?>" placeholder="* <?php echo $entry_from_name; ?>" />
          <?php if ($error_from_name) { ?>
          <div class="error"><?php echo $error_from_name; ?></div>
          <?php } ?>

<input type="email" name="from_email" value="<?php echo $from_email; ?>" placeholder="* <?php echo $entry_from_email; ?>" />
          <?php if ($error_from_email) { ?>
          <div class="error"><?php echo $error_from_email; ?></div>
          <?php } ?>
          
<fieldset data-role="controlgroup">
    	<legend><span class="required">*</span><?php echo $entry_theme; ?></legend>          

<?php foreach ($voucher_themes as $voucher_theme) { ?>
          <?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id) { ?>
          <input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked"  data-theme="a"/>
          <label for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><?php echo $voucher_theme['name']; ?></label>
          <?php } else { ?>
          <input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"  data-theme="a"/>
          <label for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><?php echo $voucher_theme['name']; ?></label>
          <?php } ?>
          
          <?php } ?>
          <?php if ($error_theme) { ?>
          <div class="error"><?php echo $error_theme; ?></div>
          <?php } ?>
</fieldset>

<br/><?php echo $entry_message; ?><br/>
<textarea name="message"><?php echo $message; ?></textarea>
<br/><span class="required">*</span> <?php echo $entry_amount; ?><br/>
<input type="text" name="amount" value="<?php echo $amount; ?>" size="5" />
          <?php if ($error_amount) { ?>
          <div class="error"><?php echo $error_amount; ?></div>
          <?php } ?> 
<br/>        
   <?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" id="agree"  data-theme="a"/>
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" id="agree"  data-theme="a"/>
        <?php } ?>
        <label for="agree"><div id="text_i_agree"></div></label>       

        <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-theme="a" />
 </form>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
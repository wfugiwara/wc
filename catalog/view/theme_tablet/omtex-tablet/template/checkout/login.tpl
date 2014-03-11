<div id="checkout-login">
  <div class="ui-grid-a">
	<div class="ui-block-a">
    <div class="login-block">
    
        <h2><?php echo $text_new_customer; ?></h2>
        <fieldset data-role="controlgroup">
            <legend><?php echo $text_checkout; ?></legend>
            <?php if ($account == 'register') { ?>
            <input type="radio" name="account" value="register" id="register" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="register" id="register" />
            <?php } ?>
            <label for="register"><?php echo $text_register; ?></label>
         
          <?php if ($guest_checkout) { ?>
            <?php if ($account == 'guest') { ?>
            <input type="radio" name="account" value="guest" id="guest" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="guest" id="guest" />
            <?php } ?>
            <label for="guest"><?php echo $text_guest; ?></label>
          <?php } ?>
        </fieldset>  
          <p><?php echo $text_register_account; ?></p>
          <input type="button" value="<?php echo $button_continue; ?>" id="button-account" class="button" data-theme="a" />
          <br />
  	</div>
    </div>
    
    <div class="ui-block-b">
      <div class="login-block">
		<div id="login">
<h2><?php echo $text_returning_customer; ?></h2>
  <p><?php echo $text_i_am_returning_customer; ?></p>
  <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>"/>
  <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>"/>
  <br /><a href="<?php echo $forgotten; ?>" rel="external" ><?php echo $text_forgotten; ?></a><br/><br />
  <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="button" data-theme="b" /><br />
</div>
	</div>
	</div>
</div>    
</div>
<script type="text/javascript"><!--
$('#checkout-login').page();
//--></script> 

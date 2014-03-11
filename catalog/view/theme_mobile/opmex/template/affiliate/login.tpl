<?php echo $header; ?>
<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>  
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $content_top; ?>
<div data-role="content">
  <!--<h1><?php echo $heading_title; ?></h1>-->
  <h2 style="margin:5px;"><?php echo $text_new_affiliate; ?></h2>
  	  <?php echo $text_register_account; ?>
      <a href="<?php echo $register; ?>" class="button" rel="external" data-role="button" data-theme="a"><?php echo $button_continue; ?></a>
   <br/> 
  <h2 style="margin:5px;"><?php echo $text_returning_affiliate; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
          <input type="email" name="email" value="<?php echo $email; ?>" data-theme="a" placeholder="<?php echo $entry_email; ?>" />
          <input type="password" name="password" value="<?php echo $password; ?>" data-theme="a" placeholder="<?php echo $entry_password; ?>" />
          <br/><a href="<?php echo $forgotten; ?>" rel="external"><?php echo $text_forgotten; ?></a><br />
          <input type="submit" value="<?php echo $button_login; ?>" class="button" data-theme="a" />
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
       </form>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>

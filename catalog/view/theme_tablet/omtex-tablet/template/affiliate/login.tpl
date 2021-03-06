<?php echo $header; ?>
<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div data-role="content">
 <ul id="breadcrumbs-one">
    <?php 
    $total = count($breadcrumbs); 
    $i=0;
    foreach ($breadcrumbs as $breadcrumb) { 
        $i++;
        if($i==$total)
        {
    ?>
        <li><a class="current"><?php echo $breadcrumb['text']; ?></a></li>
    <?php 
        }else{
    ?>
      	<li><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a></li>
      <?php }
      } ?>
</ul>

<?php echo $column_left; ?>
<div id="column-center">
<?php echo $content_top; ?>
  
  <!--<h1><?php echo $heading_title; ?></h1>-->
  
    <div class="ui-grid-a">
	<div class="ui-block-a">
    <div class="login-block">
    
  <h2 style="margin:5px;"><?php echo $text_new_affiliate; ?></h2>
  	  <?php echo $text_register_account; ?>
      <a href="<?php echo $register; ?>" class="button" rel="external" data-role="button"><?php echo $button_continue; ?></a>
   <br/> 
  
  </div>
  
  </div>
    
    <div class="ui-block-b">
      <div class="login-block">
  
  <h2 style="margin:5px;"><?php echo $text_returning_affiliate; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
          <input type="email" name="email" value="<?php echo $email; ?>" data-theme="c" placeholder="<?php echo $entry_email; ?>" />
          <input type="password" name="password" value="<?php echo $password; ?>" data-theme="c" placeholder="<?php echo $entry_password; ?>" />
          <br/><a href="<?php echo $forgotten; ?>" rel="external"><?php echo $text_forgotten; ?></a><br /><br />
          <input type="submit" value="<?php echo $button_login; ?>" class="button" data-theme="b" />
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
       </form>
  </div>
  </div>
</div>       
       
<?php echo $content_bottom; ?>
</div></div>
<?php echo $footer; ?>

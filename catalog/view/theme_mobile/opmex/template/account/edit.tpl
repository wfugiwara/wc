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
<div data-role="content">
  <!--<h2><?php echo $heading_title; ?></h2>-->
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <h2 style="margin-top:0px;"><?php echo $text_your_details; ?></h2>
     	<span class="required">*</span> <?php echo $entry_firstname; ?><br/>
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <div class="error"><?php echo $error_firstname; ?></div>
            <?php } ?>
            <br />
        <span class="required">*</span> <?php echo $entry_lastname; ?><br/>
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <div class="error"><?php echo $error_lastname; ?></div>
            <?php } ?>
        <br />
        <span class="required">*</span> <?php echo $entry_email; ?><br/>
        <input type="email" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <div class="error"><?php echo $error_email; ?></div>
            <?php } ?>
        <br />
        <span class="required">*</span> <?php echo $entry_telephone; ?><br/>
        <input type="tel" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <div class="error"><?php echo $error_telephone; ?></div>
            <?php } ?>
        <br />    
        <?php echo $entry_fax; ?><br/>
        <input type="tel" name="fax" value="<?php echo $fax; ?>" />
    	<br />
	<a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"  data-theme="a"><?php echo $button_back; ?></a>
    <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-inline="true" data-theme="a" />
  </form>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
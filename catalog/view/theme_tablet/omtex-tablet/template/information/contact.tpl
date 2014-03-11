<?php echo $header; ?>
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
<!--<h3><?php echo $text_address; ?></h3>-->
  <div class="ui-grid-a">
	<div class="ui-block-a block-a-margin">
		<br />
		 <h2><?php echo $store; ?></h2>
        <b><?php echo $text_address; ?></b> <?php echo $address; ?>
        <?php if ($telephone) { ?>
        <br/><b><?php echo $text_telephone; ?></b> <?php echo $telephone; ?><br />
        <br />
        <?php } ?>
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
        <br/>
	
    </div>
    
    <div class="ui-block-b block-b-margin">

       
		<div data-role="collapsible" data-theme="a" data-content-theme="d" class="content" data-collapsed="false">
            <h3><?php echo $text_contact; ?></h3><p>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
         <input type="text" name="name" id="" data-theme="c" <?php if($name) { ?> value="<?php echo $name; ?>" <?php } else { ?> placeholder="<?php echo $entry_name; ?>" <?php } ?> />
            <?php if ($error_name) { ?>
                <div class="error"><?php echo $error_name; ?></div>
                <?php } ?>
        <input type="email" name="email" id="" data-theme="c" <?php if($email) { ?> value="<?php echo $email; ?>" <?php } else { ?> placeholder="<?php echo $entry_email; ?>" <?php } ?> />
            <?php if ($error_email) { ?>
                <div class="error"><?php echo $error_email; ?></div>
                <?php } ?>
        <textarea name="enquiry" data-theme="c" <?php if($enquiry) { ?>><?php echo $enquiry; ?><?php } else { ?> placeholder="<?php echo $entry_enquiry; ?>" ><?php } ?></textarea>
            <?php if ($error_enquiry) { ?>
                <div class="error"><?php echo $error_enquiry; ?></div>
                <?php } ?>
            
            <input type="text" name="captcha" <?php if($captcha) { ?> value="<?php echo $captcha; ?>" <?php } else { ?> placeholder="<?php echo $entry_captcha; ?>" <?php } ?> />
            <br/><br/><img src="index.php?route=information/contact/captcha" alt="" />
			<?php if ($error_captcha) { ?>
                 <div class="error"><?php echo $error_captcha; ?></div>
            <?php } ?>
            <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-theme="a" />
            </form>
            </p>
       </div>
	
    </div>
    
    
    
    

</div>
<?php echo $content_bottom; ?>
</div></div>
<?php echo $footer; ?>

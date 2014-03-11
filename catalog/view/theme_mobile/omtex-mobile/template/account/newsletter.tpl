<?php echo $header; ?>
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

<?php echo $content_top; ?>
<div data-role="content">
  <h2><?php echo $heading_title; ?></h2>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
   	<fieldset data-role="controlgroup" data-type="horizontal">
	<legend><?php echo $entry_newsletter; ?></legend>
           <?php if ($newsletter) { ?>
            <input type="radio" name="newsletter" value="1" id="choise_yes" checked="checked" />
            <label for="choise_yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="newsletter" value="0" id="choise_no"/>
            <label for="choise_no"><?php echo $text_no; ?></label>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" id="choise_yes"/>
            <label for="choise_yes"><?php echo $text_yes; ?></label>
            <input type="radio" name="newsletter" value="0" checked="checked" id="choise_no"/>
            <label for="choise_no"><?php echo $text_no; ?></label>
            <?php } ?>
     </fieldset>
    <a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"><?php echo $button_back; ?></a>
    <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-inline="true" data-theme="a" />
</form>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
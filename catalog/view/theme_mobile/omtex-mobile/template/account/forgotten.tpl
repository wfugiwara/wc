<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
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
    <p><?php echo $text_email; ?></p>
    <h2 style="margin:5px;"><?php echo $text_your_email; ?></h2>
    <input type="email" name="email" value="" placeholder="<?php echo $entry_email; ?>" />
    <br/><br/><a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"><?php echo $button_back; ?></a>
    <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-inline="true" data-theme="a" />
  </form>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
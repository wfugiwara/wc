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
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="password" data-ajax="false">
   <h2 style="margin:5px;"><?php echo $text_password; ?></h2>
      <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" />
            <?php if ($error_password) { ?>
            <div class="error"><?php echo $error_password; ?></div>
            <?php } ?>
      <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <div class="error"><?php echo $error_confirm; ?></div>
            <?php } ?>
            <br />
    <a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"><?php echo $button_back; ?></a>
    <input type="submit" value="<?php echo $button_continue; ?>" class="button" data-inline="true" data-theme="a" />
</form>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?> 
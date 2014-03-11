<?php echo $header; ?>
<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="external"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
</div>
<?php echo $content_top; ?>
<div data-role="content">
    <h2><?php echo $heading_title; ?></h2>
    <div class="content"><?php echo $text_error; ?></div>
    <a href="<?php echo $continue; ?>" data-role="button" rel="external"><?php echo $button_continue; ?></a>    
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>
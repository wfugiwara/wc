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
  <h2><?php echo $heading_title; ?></h2>
  <!--<h2><?php echo $text_address_book; ?></h2>-->
  <ul data-role="listview" style="margin-top:10px;"  data-theme="a">
  <?php foreach ($addresses as $result) { ?>
  <li>
  <p style="margin-top:5px;"><?php echo $result['address']; ?></p>
  </li>
       <a href="<?php echo $result['update']; ?>" class="button" data-role="button" data-inline="true" rel="external"  data-theme="a"><?php echo $button_edit; ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button" data-role="button" data-inline="true" rel="external"  data-theme="a"><?php echo $button_delete; ?></a>
  <?php } ?>
 </ul>
 <br/>
  <a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"  data-theme="a"><?php echo $button_back; ?></a>
  <a href="<?php echo $insert; ?>" class="button" data-role="button" data-inline="true" data-theme="a" rel="external"><?php echo $button_new_address; ?></a>
</div>  
<?php echo $content_bottom; ?>
<?php echo $footer; ?> 
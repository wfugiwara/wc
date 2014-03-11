<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/mail.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
      	<a onclick="$('#form').submit();"  class="button"><?php echo $button_update; ?></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      	<table class="list">
        	<tbody>
                <tr>
                    <td class="left" style="width:25%;"><?php echo $entry_email_providers; ?><span class="help"><?php echo $entry_help; ?></span></td>
                    <td class="left"><textarea name="email_providers" width="100%" style="width:100%;"><?php echo $email_providers; ?></textarea></td>
                </tr>
            </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
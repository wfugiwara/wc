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
  <h2 style="margin-top:0px;"><?php echo $heading_title; ?></h2>
  <?php echo $text_description; ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
    <h2><?php echo $text_order; ?></h2>
      *<?php echo $entry_firstname; ?>
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" /><br />
        <?php if ($error_firstname) { ?>
        <div class="error"><?php echo $error_firstname; ?></div>
        <?php } ?>
       *<?php echo $entry_lastname; ?>
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" /><br />
        <?php if ($error_lastname) { ?>
        <div class="error"><?php echo $error_lastname; ?></div>
        <?php } ?>
       *<?php echo $entry_email; ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="email" name="email" value="<?php echo $email; ?>" class="large-field" /><br />
        <?php if ($error_email) { ?>
        <div class="error"><?php echo $error_email; ?></div>
        <?php } ?>
       *<?php echo $entry_telephone; ?>
        <input type="tel" name="telephone" value="<?php echo $telephone; ?>" class="large-field" /><br />
        <?php if ($error_telephone) { ?>
        <div class="error"><?php echo $error_telephone; ?></div>
        <?php } ?>
       <div class="right"><span class="required">*</span> <?php echo $entry_order_id; ?>&nbsp;&nbsp;
     <input type="text" name="order_id" value="<?php echo $order_id; ?>" class="large-field" /><br />
        <?php if ($error_order_id) { ?>
        <div class="error"><?php echo $error_order_id; ?></div>
        <?php } ?>
        <?php echo $entry_date_ordered; ?>
     <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" class="large-field date" /><br />
    <br/><br/><h2><?php echo $text_product; ?></h2>
    <div id="return-product">
       <div class="content">
          <div class="return-product">
            <div class="return-name"><span class="required">*</span> <b><?php echo $entry_product; ?></b>
              <input type="text" name="product" value="<?php echo $product; ?>" />
            <br />
            <?php if ($error_product) { ?>
            <span class="error"><?php echo $error_product; ?></span>
            <?php } ?>
            </div>
            <div class="return-model"><span class="required">*</span> <b><?php echo $entry_model; ?></b>
          	 <input type="text" name="model" value="<?php echo $model; ?>" />
            <br />
            <?php if ($error_model) { ?>
            <span class="error"><?php echo $error_model; ?></span>
            <?php } ?>
            </div>
            <div class="return-quantity"><b><?php echo $entry_quantity; ?></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="text" name="quantity" value="<?php echo $quantity; ?>" />
            </div>
          </div>
          <div class="return-detail">
            <div class="return-reason">
            <fieldset data-role="controlgroup">
	   <legend id="text_agree"><span class="required">*</span> <b><?php echo $entry_reason; ?></b></legend><br />
               <?php foreach ($return_reasons as $return_reason) { ?>
              <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>
      			<input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" checked="checked"  data-theme="a"/>
                <label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label>
                <?php } else { ?>
                <input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"  data-theme="a"/>
                <label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label>
              <?php  } ?>
              <?php  } ?>
             </fieldset> 
             <?php if ($error_reason) { ?>
            <span class="error"><?php echo $error_reason; ?></span>
            <?php } ?>
            </div>
            <div class="return-opened">
            <fieldset data-role="controlgroup" data-type="horizontal">
	   <legend id="text_agree"><b><?php echo $entry_opened; ?></b></legend><br />
            <?php if ($opened) { ?>
            <input type="radio" name="opened" value="1" id="opened" checked="checked"  data-theme="a"/>
            <?php } else { ?>
            <input type="radio" name="opened" value="1" id="opened" />
            <?php } ?>
            <label for="opened"><?php echo $text_yes; ?></label>
            <?php if (!$opened) { ?>
            <input type="radio" name="opened" value="0" id="unopened" checked="checked" data-theme="a" />
            <?php } else { ?>
            <input type="radio" name="opened" value="0" id="unopened" />
            <?php } ?>
            <label for="unopened"><?php echo $text_no; ?></label>
           </fieldset>
           </div>
              <br />
              <br />
              <?php echo $entry_fault_detail; ?><br />
              
        <textarea name="comment" cols="50" rows="6"><?php echo $comment; ?></textarea>
      	</div>
        <input type="text" name="captcha" value="<?php echo $captcha; ?>" placeholder="<?php echo $entry_captcha; ?>" />
        <br/><img src="index.php?route=account/return/captcha" alt="" style="margin:5px; text-align:center" />

		<?php if ($error_captcha) { ?>
        <div class="error"><?php echo $error_captcha; ?></div>
        <?php } ?>
        </div>
     
    </div>
 
      <a href="<?php echo $back; ?>" class="button" data-role="button" data-inline="true" rel="external"  data-theme="a"><?php echo $button_back; ?></a>
  	  <input type="submit" value="<?php echo $button_continue; ?>" data-inline="true" data-theme="a" class="button" />
    </div>
  </form>
</div>  
  <?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<?php echo $footer; ?>
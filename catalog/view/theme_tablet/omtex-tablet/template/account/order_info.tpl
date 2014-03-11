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
    <ul data-role="listview" style="margin-bottom:15px;" data-divider-theme="d">
 <?php if ($invoice_no) { ?>
          <li data-role="list-divider">
          <b><?php echo $text_invoice_no; ?></b> : <?php echo $invoice_no; ?>
          </li>
          <?php } ?>
          <li data-role="list-divider">
          <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?>
          </li>
          <li data-role="list-divider">
          <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?>
          </li>
          <li data-role="list-divider">
          <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?>
          </li>
          <?php if ($shipping_method) { ?>
          <li data-role="list-divider"><b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
          <?php } ?>
          
          <li><h3><b><?php echo $text_payment_address; ?></b></h3>
          <p><?php echo $payment_address; ?></p>
          </li>
          
          <?php if ($shipping_address) { ?>
          <li><h3><b><?php echo $text_shipping_address; ?></b></h3>
          <p><?php echo $shipping_address; ?></p>
          </li>
          <?php } ?>
    </ul>
 
  <!--<ul data-role="listview" data-divider-theme="d"><li data-role="list-divider">
  <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" id="select_all" />
  <label for="select_all">Select All Products</label>
  </li>-->
  </ul>
        <ul data-role="listview" data-divider-theme="d">
        <?php foreach ($products as $product) { ?>
               
        <li><h3> <?php echo $product['name']; ?></h3> 
        <p>
            <?php foreach ($product['option'] as $option) { ?>
            <br />
            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br/>
            <?php } ?>
          
          <?php echo $product['model']; ?> <br/>
          <?php echo $column_quantity; ?>: <?php echo $product['quantity']; ?> - 
          <?php echo $column_price; ?> : <?php echo $product['price']; ?><br/>
          <?php echo $column_total; ?> : <?php echo $product['total']; ?>
       
        </p></li>
       <?php } ?>
      </ul>
    
      <ul data-role="listview" style="margin-bottom:15px;" data-divider-theme="d">
       <?php foreach ($totals as $total) { ?>
       <li data-role="list-divider" style="text-align:right; padding-top:1px; padding-bottom:2px;" ><h3><b><?php echo $total['title']; ?>:</b>
       <?php echo $total['text']; ?></h3></li>
        <?php } ?>
      </ul>
 
    
  <?php if ($comment) { ?>
  <?php echo $text_comment; ?> <?php echo $comment; ?>
  <?php } ?>
  <?php if ($histories) { ?>
  <h2><?php echo $text_history; ?></h2>
 	  <ul data-role="listview" style="margin-bottom:10px;">
      <?php foreach ($histories as $history) { ?>
      <li><p><br/><?php echo $column_date_added; ?>: <?php echo $history['date_added']; ?><br/>
      <?php echo $column_status; ?>: <?php echo $history['status']; ?><br/>
      <?php echo $column_comment; ?>: <?php echo $history['comment']; ?><br/>
      </p></li>
      <?php } ?>
      </ul>
  <?php } ?>
<a href="<?php echo $continue; ?>" class="button" data-role="button" rel="external"><?php echo $button_continue; ?></a>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?> 
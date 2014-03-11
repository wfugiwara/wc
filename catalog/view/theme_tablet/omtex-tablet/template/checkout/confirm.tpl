<?php if (!isset($redirect)) { ?>
<div id="checkout-confirm">
<div class="checkout-product">
        <!--<?php echo $column_name; ?>
        <?php echo $column_model; ?>
        <?php echo $column_quantity; ?>
        <?php echo $column_price; ?>
        <?php echo $column_total; ?>-->
<ul data-role="listview" data-divider-theme="d" style="margin-top:25px;"> 
      <?php foreach ($products as $product) { ?>
      <li><h3><a href="<?php echo $product['href']; ?>" rel="external"><?php echo $product['name']; ?></a> </h3>
         <p><?php foreach ($product['option'] as $option) { ?>
          <br />
          &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?>
        <?php echo $product['model']; ?>
        <?php echo $column_quantity; ?> : <?php echo $product['quantity']; ?><br />
        <?php echo $column_price; ?>:<?php echo $product['price']; ?>
        <?php echo $column_total; ?>:<?php echo $product['total']; ?>
        </p>
      </li>
      <?php } ?>
</ul>
<ul data-role="listview" data-divider-theme="d" style="margin-top:25px;">      
      <?php foreach ($vouchers as $voucher) { ?>
      <li data-role="list-divider" style="text-align:right;"><?php echo $voucher['description']; ?> 1 <?php echo $voucher['amount']; ?> <?php echo $voucher['amount']; ?></li>
      <?php } ?>
</ul>
<ul data-role="listview" data-divider-theme="d" style="margin-top:25px;">     
      <?php foreach ($totals as $total) { ?>
      <li data-role="list-divider" style="text-align:right;"><b><?php echo $total['title']; ?>:</b> <?php echo $total['text']; ?></li>
       <?php } ?>
</ul>
</div>
<div class="payment" style="margin:25px;"><?php echo $payment; ?></div>
</div>
<script type="text/javascript"><!--
$('#checkout-confirm').page();
//--></script>  
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script> 
<?php } ?>  
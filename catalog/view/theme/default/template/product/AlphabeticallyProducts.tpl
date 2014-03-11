<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
	<div>
      <h1><?php echo $heading_title; ?></h1>
	  <div>
    <?php if ($products) { $i = 0; ?>
    <table class="list1" style="border: none;">
      <tr>
      <?php foreach ($products as $product) { ?>            
         <td valign="top" style="text-align:left; padding: 20px 10px; border: none;">
            <div class="product-list">
                <a href="<?php echo $href.'index.php?route=product/product&product_id='.$product['id']; ?>">
            <table>                
                <tr>
                    <td>
                        <div class="image"><img src="<?php echo $product['image']; ?>" alt="Image not found" /></div>
                    </td>
                </tr>               
            </table>            
                </a>
            </div>         
	 <p style="width:100px;"><?php echo $product['name']; ?></p>
	 </td>
      <?php $i++; ($i%5==0)?($print = "</tr><tr>"):($print = ""); echo $print;} ?>
      </tr>
    </table>
    <div class="pagination"><?php echo $pagination; ?></div>
    <?php } else {?>
    <h3>No Products found!</h3>
    <?php  } ?>
	</div>
	</div>
<?php echo $content_bottom; ?></div>
<?php echo $footer; ?> 
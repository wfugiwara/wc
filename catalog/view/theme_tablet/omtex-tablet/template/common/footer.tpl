  <?php if ($informations) { ?>
<ul data-role="listview" id="more_info">
<li data-role="list-divider"><?php echo $text_information; ?></li>
 <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>" rel="external"><?php echo $information['title']; ?></a></li>
      <?php } ?>
     </ul>
     <?php } ?>
<ul data-role="listview" id="more_customer_service">
<li data-role="list-divider"><?php echo $text_nav_support; ?></li>
 	  <li><a href="<?php echo $contact; ?>" rel="external" ><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $return; ?>" rel="external" ><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>" rel="external" ><?php echo $text_sitemap; ?></a></li>
   </ul>  
<ul data-role="listview" id="more_extras">
<li data-role="list-divider"><?php echo $text_extra; ?></li>
 	  <li><a href="<?php echo $manufacturer; ?>" rel="external" ><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $voucher; ?>" rel="external" ><?php echo $text_voucher; ?></a></li>
      <li><a href="<?php echo $affiliate; ?>" rel="external" ><?php echo $text_affiliate; ?></a></li>
      <li><a href="<?php echo $special; ?>" rel="external" ><?php echo $text_special; ?></a></li>
	  <?php echo $language; ?>
  	  <?php echo $currency; ?>
   </ul>  
<ul data-role="listview" id="more_account">
<li data-role="list-divider"><?php echo $text_account; ?></li>
 <li><a href="<?php echo $account; ?>" rel="external" ><?php echo $text_account; ?></a></li>
 <?php if (isset($logged)) { ?>
 <li><a href="index.php?route=account/logout" rel="external" ><?php echo $text_logout; ?></a></li>
 <?php } ?>
      <li><a href="<?php echo $order; ?>" rel="external" ><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>" rel="external" ><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>" rel="external" ><?php echo $text_newsletter; ?></a></li>
   </ul>          
<div data-role="footer" data-theme="a">

<div data-role="navbar">
			<ul>
				<li><a id="click_info" data-icon="info"><?php echo $text_nav_info; ?></a></li>
                <li><a id="click_customer_service" data-icon="gear"><?php echo $text_nav_support; ?></a></li>
				<li><a id="click_extras" data-icon="plus"><?php echo $text_extra; ?></a></li>
				<li><a id="click_account" data-icon="grid"><?php echo $text_account; ?></a></li>
		    </ul>
</div>
<div id="powered"><?php 
    	 $powered=explode('<br>',$powered); 
    	 if($powered[0]!="") { ?>
         <div id="device_mode" data-role="navbar">
            <ul>
                <li><?php echo $powered[0];?></li>
                <li><a href="#" data-role="button" data-corners="false" data-inline="true" data-theme="b"><?php echo $text_tablet; ?></a></li>
            </ul>
    	</div>
        <?php
        	}	
            echo $powered[1].' '.$powered[2];
        ?>
    </div>
</div>
<div id="back-top">
        <div class="top_icon_right" data-role="controlgroup">
            <a href="#top" data-role="button" data-icon="arrow-u" data-iconpos="notext" data-theme="a"></a>
        </div>
</div>
</div>
<div data-role="page" id="agree_page"> 
  <div data-role="content"> 
	<div id="agree_page_text"></div>
  	<p><a href="#page" data-role="button">back</a></p>
  </div>
</div>
<div data-role="page" id="privacy_page"> 
  <div data-role="content"> 
	<div id="privacy_page_text"></div>
  	<p><a href="#page" data-role="button">back</a></p>
  </div>
</div>
</body></html>
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
  <h2><?php echo $heading_title; ?></h2>
  <ul data-role="listview">
        <li data-role="list-divider"><?php echo $text_information; ?></li>
        <?php foreach ($informations as $information) { ?>
            <li><a href="<?php echo $information['href']; ?>" rel="external"><?php echo $information['title']; ?></a></li>
            <?php } ?>
            <li><a href="<?php echo $contact; ?>" rel="external"><?php echo $text_contact; ?></a></li>
        <li><a href="<?php echo $special; ?>" rel="external"><?php echo $text_special; ?></a></li>
        <li data-role="list-divider"><?php echo $text_edit; ?></li>
        <li><a href="<?php echo $account; ?>" rel="external"><?php echo $text_account; ?></a>
        <li><a href="<?php echo $edit; ?>" rel="external"><?php echo $text_edit; ?></a></li>
        <li><a href="<?php echo $password; ?>" rel="external"><?php echo $text_password; ?></a></li>
        <li><a href="<?php echo $address; ?>" rel="external"><?php echo $text_address; ?></a></li>
        <li><a href="<?php echo $history; ?>" rel="external"><?php echo $text_history; ?></a></li>
        <li><a href="<?php echo $download; ?>" rel="external"><?php echo $text_download; ?></a></li>
        <li data-role="list-divider"><?php echo $text_checkout; ?></li> 
        <li><a href="<?php echo $cart; ?>" rel="external"><?php echo $text_cart; ?></a></li>
        <li><a href="<?php echo $checkout; ?>" rel="external"><?php echo $text_checkout; ?></a></li>
        <li><a href="<?php echo $search; ?>" rel="external"><?php echo $text_search; ?></a></li>
        <li data-role="list-divider"><?php echo $text_nav_categories; ?></li>
        <?php foreach ($categories as $category_1) { ?>
        <li><a href="<?php echo $category_1['href']; ?>" rel="external"><?php echo $category_1['name']; ?></a>
          <?php if ($category_1['children']) { ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <li><a href="<?php echo $category_2['href']; ?>" rel="external"><?php echo $category_2['name']; ?></a>
              <?php if ($category_2['children']) { ?>
                <?php foreach ($category_2['children'] as $category_3) { ?>
                <li><a href="<?php echo $category_3['href']; ?>" rel="external"><?php echo $category_3['name']; ?></a></li>
                <?php } ?>
             <?php } ?>
           <?php } ?>
         <?php } ?>
        </li>
        <?php } ?>
        
       </ul>
<?php echo $content_bottom; ?>
</div></div>
<?php echo $footer; ?>
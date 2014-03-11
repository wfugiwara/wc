<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
						<li data-role="list-divider"><?php echo $heading_title; ?></li>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>" rel="external"><?php echo $information['title']; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $contact; ?>" rel="external"><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>" rel="external"><?php echo $text_sitemap; ?></a></li>
    </ul>

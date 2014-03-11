<div data-role="content">
	<div data-role="collapsible" data-collapsed="true" data-inline="true" data-theme="a" data-content-theme="d">
		<h3><?php echo $heading_title; ?></h3>
			<ul data-role="listview" data-theme="c" data-dividertheme="b">
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>" rel="external"><?php echo $information['title']; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $contact; ?>" rel="external"><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>" rel="external"><?php echo $text_sitemap; ?></a></li>
    </ul>
  </div>
</div>

<div data-role="content">
	<div data-role="collapsible" data-collapsed="true" data-inline="true" data-theme="a" data-content-theme="b">
		<h3><?php echo $heading_title; ?></h3>
			<?php foreach ($categories as $category) { ?>
                 <?php if ($category['children']) { ?>
                  <div data-role="collapsible" data-theme="a" data-collapsed="true" data-content-theme="d">
                  <h3><?php echo $category['name']; ?></h3>
                     <ul data-role="listview" data-theme="a">
                    <li><a href="<?php echo $category['href']; ?>" rel="external"><?php echo $category['name']; ?></a></li>
                    <?php foreach ($category['children'] as $child) { ?>
                    <li>
                      <?php if ($child['category_id'] == $child_id) { ?>
                      <a href="<?php echo $child['href']; ?>" class="active" rel="external"> - <?php echo $child['name']; ?></a>
                      <?php } else { ?>
                      <a href="<?php echo $child['href']; ?>" rel="external"> - <?php echo $child['name']; ?></a>
                      <?php } ?>
                    </li>
                    <?php } ?>
                  </ul>
                  </div>
                  <?php } else { ?>
                 <ul data-role="listview" style="margin-top:5px; margin-bottom:5px;" data-theme="a">
                  <?php if ($category['category_id'] == $category_id) { ?>
                  <li><a href="<?php echo $category['href']; ?>" class="active" rel="external"><?php echo $category['name']; ?></a></li>
                  <?php } else { ?>
                  <li><a href="<?php echo $category['href']; ?>" rel="external"><?php echo $category['name']; ?></a></li>
                  <?php } ?>
                 </ul>
                 <?php } ?>
                </li>
                <?php } ?>
			
		</div>
</div>

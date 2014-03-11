<?php if ($reviews) { ?>
<ul data-role="listview" style="margin:20px;">
<?php foreach ($reviews as $review) { ?>
<li data-role="list-divider"><b><?php echo $review['author']; ?></b> | <?php echo $review['date_added']; ?></li>
<li>
<h3><img src="catalog/view/theme/default/image/stars-<?php echo $review['rating'] . '.png'; ?>" alt="<?php echo $review['reviews']; ?>" /></h3>
<p><?php echo $review['text']; ?></p>  
</li>
<?php } ?>
</ul>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div class="content"><?php echo $text_no_reviews; ?></div>
<?php } ?>

<div class="carousel">
  <ul class="slides" style="text-align:center; display:block;">
    <?php foreach ($banners as $banner) { ?>
    <li>
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>" rel="external"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
    <?php } ?>
    </li>
    <?php } ?>
    </ul>
</div>
<script type="text/javascript"><!--
$(window).load(function() {
			$('.carousel').flexslider({
			 animation: "slide",
			 controlsContainer: ".flexslider-container"
			});
		});
--></script>


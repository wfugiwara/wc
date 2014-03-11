<div class="carousel">
  <ul class="slides" style="text-align:center; display:block;" data-theme="a">
    <?php foreach ($banners as $banner) { ?>
    <li>
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>" rel="external"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" width="<?php echo $width; ?>" height="<?php echo $height; ?>" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" width="<?php echo $width; ?>" height="<?php echo $height; ?>" />
    <?php } ?>
    <!--<p class="flex-caption" style="margin:0px;"><?php echo $banner['title']; ?></p>-->
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


<style>
@media screen and (orientation:portrait) {
   /* Portrait styles here */
.banner img{
max-width: 320px !important;	
}


}
/* Landscape */
@media screen and (orientation:landscape) {
   /* Landscape styles here */
}
</style>

<div class="banner">
  <ul class="slides" style="text-align:center; display:block;" data-theme="a">
  <!--<div id="slideshow<?php echo $module; ?>" class="nivoSlider" style="width: <?php echo $width; ?>px; height: <?php echo $height; ?>px;">-->
    <?php foreach ($banners as $banner) { ?>
    <li>
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>" rel="external"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"  />
    <?php } ?>
    <!--<p class="flex-caption" style="margin:0px;"><?php echo $banner['title']; ?></p>-->
    </li>
    <?php } ?>
    </ul>
</div>
<script type="text/javascript"><!--
$(window).load(function() {
			$('.banner').flexslider({
			 animation: "slide",
			 controlsContainer: ".flexslider-container1"
			});
		});
--></script>

<div id="carousel<?php echo $module; ?>" style="margin:15px 0;">

  <ul class="jcarousel-skin-opencart">

    <?php foreach ($banners as $banner) { ?>

    <li style="width:433px!important;"><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></li>

    <?php } ?>

  </ul>

</div>

<script type="text/javascript"><!--

$('#carousel<?php echo $module; ?> ul').jcarousel({

	vertical: false,

	visible: <?php echo $limit; ?>,

	scroll: <?php echo $scroll; ?>

});

//--></script>
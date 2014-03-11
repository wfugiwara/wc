<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php if(isset($icon_tablet)){ ?>
<link rel="apple-touch-icon-precomposed" href="<?php echo $icon_tablet; ?>"/>
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" href="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/jquery-mobile/jquery.mobile-1.2.0.min.css" />
<script src="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/jquery-mobile/jquery.js" type="text/javascript"></script>
<script src="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/jquery-mobile/jquery.mobile-1.2.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<!--[if IE]>
<script type="text/javascript" src="catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4-iefix.js"></script>
<![endif]--> 
<link rel="stylesheet" href="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/flexslider/flexslider.css" type="text/css" media="screen" />
<script src="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/flexslider/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/jquery/common.js"></script>
<script src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/app.js" type="text/javascript"></script>
<link rel="stylesheet" href="catalog/view/theme_tablet/<?php echo $this->config->get('config_template_tablet'); ?>/stylesheet/stylesheet.css" type="text/css" media="screen"> 

<link rel="stylesheet" type="text/css" href="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jqm-datebox.min.css" /> 
<script type="text/javascript" src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jqm-datebox.core.min.js"></script>
<script type="text/javascript" src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jqm-datebox.mode.calbox.min.js"></script>

<?php echo $google_analytics; ?>
<script type="text/javascript"><!--
$(document).ready(function() {
     $("a").attr("rel","external");
	 $("#text_i_agree").html('<?php echo $text_i_agree; ?>');
	 $("#search_form").hide();
	 $("#more_info").hide();
	 $("#more_customer_service").hide();
	 $("#more_extras").hide();
	 $("#more_account").hide();
	 $("#more_categories").hide(); 
	 $('#click_search').click(function() {
          $('#search_form').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 $('#click_categories').click(function() {
          $('#more_categories').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 $('#click_info').click(function() {
          $('#more_info').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 $('#click_customer_service').click(function() {
          $('#more_customer_service').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 $('#click_extras').click(function() {
          $('#more_extras').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 $('#click_account').click(function() {
          $('#more_account').animate({
               height: 'toggle'
               }, 200
          );
     });
	 
	 // hide #back-top first
	$("#back-top").hide();
	
	// fade in #back-top
	$(function () {
		$(window).scroll(function () {
			if ($(this).scrollTop() > 100) {
				$('#back-top').fadeIn();
			} else {
				$('#back-top').fadeOut();
			}
		});

		// scroll body to 0px on click
		$('#back-top a').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});
	});
	 
});
//--></script> 
</head>
<body id="top">
<div data-role="page" id="page" data-theme="c">
<div data-role="header" data-theme="a" data-backbtn="false" style="border-bottom:none;">
     <table width="100%"><tr>
        <td width="20%">
        <a href="<?php echo $home; ?>" rel="external">
       <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" height="30" style="margin-left:10px;"/>
        </a>
        </td>
        <td width="60%">
        <div data-role="controlgroup" data-type="horizontal" style="float:right; margin-top:20px;">
		    <a href="<?php echo $home; ?>" data-role="button" data-icon="home" data-theme="b" rel="external"><?php echo $text_home; ?></a>
			<a href="<?php echo $account; ?>" data-role="button" data-icon="grid" data-theme="b" rel="external"><?php echo $text_account; ?></a>
			<a href="<?php echo $shopping_cart; ?>" data-role="button" data-icon="gear" data-theme="b" rel="external"><?php echo $text_nav_cart; ?></a>
			<a href="index.php?route=information/contact" data-role="button" data-icon="forward" data-theme="b" rel="external"><?php echo $text_nav_contact; ?></a>
        </div> 
        </td>
        <td width="20%">
        <form action="index.php?route=product/search"  method="get" enctype="multipart/form-data" id="search" data-ajax="false" style="margin-right:5px; margin-left:5px; width:175px; border-bottom:none;">
		<input type="hidden" name="route" value="product/search"/>
		<input type="search" name="search" id="searc-basic" value="" data-theme="c" placeholder="<?php echo $text_search; ?>" data-inline="true" />
		</form>
    	</td>
        </tr>
       <tr><td colspan="3">
       <div data-role="controlgroup" data-type="horizontal" data-inset="true">
		    <?php if ($categories) { ?>
    			<?php foreach ($categories as $category) { ?>
                   <a href="<?php echo $category['href']; ?>" rel="external" data-role="button" data-theme="c"><?php echo $category['name']; ?></a>
                <?php } ?>
		   <?php } ?>
</div>       
       </td></tr>
		
      </table>
</div>
        
      <div id="notification"></div>

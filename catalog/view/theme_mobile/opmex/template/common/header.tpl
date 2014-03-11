<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
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
<?php if(isset($icon_mobile)){ ?>
<link rel="apple-touch-icon-precomposed" href="<?php echo $icon_mobile; ?>"/>
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" href="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jquery.mobile-1.0a3.min.css" />

<?php if($this->config->get('config_mobile_theme_style')) { 
		 if($this->config->get('config_mobile_theme_style')=='Customize') {
         	include_once("catalog/view/theme_mobile/".$this->config->get('config_template_mobile')."/stylesheet/style_custom.php"); 
		 }
      }
?>

<script src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jquery-1.5.min.js" type="text/javascript"></script>
<script src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/jquery-mobile/jquery.mobile-1.0a3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<!--[if IE]>
<script type="text/javascript" src="catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4-iefix.js"></script>
<![endif]--> 
<link rel="stylesheet" href="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/flexslider/flexslider.css" type="text/css" media="screen" />
<script src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/flexslider/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/jquery/common.js"></script>
<link rel="stylesheet" href="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/stylesheet/stylesheet.css" type="text/css" media="screen"> 
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
	 
});
//--></script> 

<script type="text/javascript" src="catalog/view/javascript/jquery.maskedinput-1.3.min.js"></script>
			<script>
				 $(document).ready(function() {
				 
				 
				  $("input[name='data_nascimento'] ").mask("99/99/9999");
				  $("input[name='ddd'] ").mask("(99)");
				  //$("input[name='telephone'] ").mask("9999-9999");
				  $("input[name='ddd2'] ").mask("(99)");
				  $("input[name='postcode'] ").mask("99999-999");
				 //$("input[name='placa1'] ").mask("aaa-9999");
				 // $("input[name='placa2'] ").mask("aaa-9999");
				  $("#cpf").mask("999.999.999-99");
				  $("#cnpj").mask("99.999.999/9999-99");
				  
				 
				/* formulário de criação de conta */
					if ($("#fisica").is(':checked')) {
						$('.pessoa_fisica').show();
						$('.pessoa_juridica').hide();
						$("#placa2").hide();						
					}
					if ($("#juridica").is(':checked')) {
						$('.pessoa_fisica').hide();
						$('.pessoa_juridica').show(); 
						$("#placa2").show();						
					}
					$('#juridica').change( function() {
						$("#cnpj").val("");
						$('.pessoa_fisica').show();
						$('.pessoa_juridica').hide();
						$("#placa2").hide();
												
					});
					$('#fisica').change( function() {
						$("#cpf").val("");
						$('.pessoa_fisica').hide();
						$('.pessoa_juridica').show();  
						$("#placa2").show();
					}); 
				});    
			</script> 

</head>
<body>
<div data-role="page" id="page">
	<div data-role="header" data-theme="c" data-backbtn="false">
		<div style="height:65px;">
        <div class="header_logo" style="float:left; margin-top:0px; margin-left:5px;">
        <a href="<?php echo $home; ?>" rel="external">
       <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" height="55"/>
        </a>
        </div>
        <div style="float:right; margin-top:5px;" >
        <a href="<?php echo $home; ?>" rel="external"><img src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/image/home-icon.png" style="margin-right:5px;" height="25"/></a>
        <a href="tel:<?php echo $telephone; ?>" rel="external"><img src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/image/phone-icon.png" style="margin-right:5px;" height="25"/></a>
        <a href="<?php echo $shopping_cart; ?>" rel="external" style="text-decoration:none;"><img src="catalog/view/theme_mobile/<?php echo $this->config->get('config_template_mobile'); ?>/image/cart-icon.png" style="margin-right:5px;" height="25"/></a>
        </div>
        </div>
        
        <div data-role="navbar" data-position="inline">
        <ul>
        <li><a data-theme="c" id="click_categories"><?php echo $text_nav_categories; ?></a></li>
        <li><a href="<?php echo $account; ?>" rel="external" data-theme="c"><?php echo $text_account; ?></a></li>
        <li><a data-theme="c" id="click_search" ><?php echo $text_search; ?></a></li>
        <li><a href="index.php?route=information/contact" rel="external" data-theme="c"><?php echo $text_nav_contact; ?></a></li>
        </ul>
        </div>
       
       <div data-role="fieldcontain" class="ui-hide-label ui-body-g" id="search_form">
<form action="index.php" method="get" enctype="multipart/form-data" id="search_form" data-ajax="false">
<input type="hidden" name="route" value="product/search"/>
<input type="search" name="search" id="searc-basic" value="" placeholder="<?php echo $text_search; ?>"/>
</form>
		</div> 
</div>

<div id="notification" data-rel="dialog"></div>

<?php if ($categories) { ?>
       <div data-role="content" id="more_categories">
       <div data-role="collapsible" data-theme="a" data-content-theme="a" >
		<h3><?php echo $text_nav_categories; ?></h3>
				<?php foreach ($categories as $category) { ?>
                   <?php if ($category['children']) { ?>
                     <div data-role="collapsible" data-theme="a" data-collapsed="true" data-content-theme="d">
                     <h3><?php echo $category['name']; ?></h3>
                     <ul data-role="listview" data-theme="a">
                     <li><a href="<?php echo $category['href']; ?>" rel="external"><?php echo $category['name']; ?></a></li>
                     <?php for ($i = 0; $i < count($category['children']);) { ?>
                      <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                      <?php for (; $i < $j; $i++) { ?>
                      <?php if (isset($category['children'][$i])) { ?>
                      <li><a href="<?php echo $category['children'][$i]['href']; ?>" rel="external"> - <?php echo $category['children'][$i]['name']; ?></a></li>
                      <?php } ?>
                      <?php } ?>
                   <?php } ?>
                   </ul>
                 	</div>
                 <?php } else { ?>
                 <ul data-role="listview" style="margin-top:5px; margin-bottom:5px;" data-theme="a">
                 <li><a href="<?php echo $category['href']; ?>" rel="external"><?php echo $category['name']; ?></a></li>
                 </ul>
                 <?php } ?>
               <!-- </ul>-->
                <?php } ?>
                <ul data-role="listview" style="margin-top:5px; margin-bottom:5px;" data-theme="a">
                	<li><a href="como-funciona" rel="external">Como funciona</a></li>
                </ul>
			</div>
		</div>  
       <?php } ?>

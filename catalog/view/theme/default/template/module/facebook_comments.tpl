<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?> (<fb:comments-count href="<?php echo $current_url; ?>"></fb:comments-count>)</div>
  <div class="box-content">
    <div class="box-product" id="facebook_comments_<?php echo $module; ?>">
		<div class="fb-comments" data-href="<?php echo $current_url; ?>" data-num-posts="<?php echo $posts; ?>" data-width="<?php echo $width; ?>" data-colorscheme="<?php echo $color_scheme; ?>"></div>
    </div>
  </div>
</div>

<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '<?php echo $app_id; ?>', // App ID
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
   }(document));   
</script>
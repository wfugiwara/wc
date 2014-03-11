<!-- 
 * @package Zopim Live Chat
 * @version 0.2.2
 -->
 
<!-- Start of Zopim Live Chat Script -->
<script type="text/javascript"> 
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=
z.s=d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o
){z.set._.push(o)};$.setAttribute('charset','utf-8');$.async=!0;z.set.
_=[];$.src=('https:'==d.location.protocol?'https://ssl':'http://cdn')+
'.zopim.com/?<?php echo $code; ?>';$.type='text/java'+s;z.
t=+new Date;z._=[];e.parentNode.insertBefore($,e)})(document,'script')
</script>
<!-- End of Zopim Live Chat Script -->

<script type="text/javascript"> 
$zopim( function() {
	$zopim.livechat.setLanguage('<?php echo $language; ?>');
	$zopim.livechat.setName('<?php echo $username; ?>');
    	$zopim.livechat.setEmail('<?php echo $useremail; ?>');
	$zopim.livechat.button.setPosition('<?php echo $position; ?>');
	$zopim.livechat.window.setTheme('<?php echo $theme; ?>');
	$zopim.livechat.window.setColor('<?php echo $color; ?>');
	$zopim.livechat.bubble.setTitle('<?php echo addslashes($bubbleTitle); ?>');
	$zopim.livechat.bubble.setText('<?php echo addslashes($bubbleText); ?>');
	<?php if($bubbleEnable=="show") { ?>
	$zopim.livechat.bubble.show(true);
	<?php } ?>
	<?php if($bubbleEnable=="hide") { ?>
	$zopim.livechat.bubble.hide(true);
	<?php } ?>
	$zopim.livechat.setGreetings({
		  'online' : ['<?php echo addslashes($OnlineShort); ?>', '<?php echo addslashes($OnlineLong); ?>'],
		  'offline': ['<?php echo addslashes($OfflineShort); ?>', '<?php echo addslashes($OfflineLong); ?>'],
		  'away'   : ['<?php echo addslashes($AwayShort); ?>', '<?php echo addslashes($AwayLong); ?>']  
	  });
	<?php if($hideonoffline){ ?>
	$zopim.livechat.button.setHideWhenOffline(true);
	<?php } ?>
})
</script>

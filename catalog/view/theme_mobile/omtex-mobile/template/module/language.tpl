<?php if (count($languages) > 1) { ?>
<li>
<form id="language_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" data-ajax="false">
  <div id="language"><?php echo $text_language; ?>&nbsp;&nbsp;
    <select onchange="language_form_submit(this.value);" >
   <?php foreach ($languages as $language) { ?>
        <option value="<?php echo $language['code'];?>" <?php if($language_code == $language['code']){ ?> selected="selected" <?php } ?>> <!--<img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />--> <?php echo $language['name']; ?></option>
    <?php } ?>  
    </select>
    <input type="hidden" name="language_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </div>
</form>
</li>
<?php } ?>
<script type="text/javascript">
function language_form_submit(language){
	$('input[name=\'language_code\']').attr('value', language);
	document.forms["language_form"].submit();
}
</script>
<div class='close_la'></div>
<table>
  <tr>
  	<td width="30%"><b><?php echo $entry_email; ?></b>&nbsp;<input type="text" name="email" value="" /><br /></td>
	<td width="30%"><b><?php echo $entry_password; ?></b>&nbsp;<input type="password" name="password" value="" /><br /></td>
	<td width="15%" align="center"><a id="button-login" class="button"><span><?php echo $button_login; ?></span></a><br /></td>
	<td width="25%"><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></td>
  </tr>
</table>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-login').click();
	}
});
//--></script>   
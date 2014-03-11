<?php  echo $header;  ?>
 <div id="content">
	  <div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	  </div>
	  <?php if ($error_warning) { ?>
	  <div class="warning"><?php echo $error_warning; ?></div>
	  <?php } ?>
		<div class="box">
		   
		   <div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
		  
			<div class="heading">
			  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
				<div class="buttons">
				  <a onclick="$('#form').submit();" class="button"><?php echo $this->language->get("button_save"); ?></a>
				</div>  
			</div>
			
			<div class="content"><form action="<?php echo $action;?>" method="post" id="form">
				<div class="box-columns">
				
					<div id="panel-general">
						
						<div class="content-setting">
								<h4><?php echo $this->language->get('text_general_setting');?></h4>
								<table class="form">
									
									<tr>
										<td><?php echo $this->language->get('entry_large_image_demension');?></td>
										<td>
											<input name="pavblog[general_lwidth]" value="<?php echo $general_setting['general_lwidth'];?>" size="3"/> 
											x 
											<input size="3" name="pavblog[general_lheight]" value="<?php echo $general_setting['general_lheight'];?>" />
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_small_image_demension');?></td>
										<td>
											<input name="pavblog[general_swidth]" value="<?php echo $general_setting['general_swidth'];?>" size="3"/>
											x 
											<input size="3" name="pavblog[general_sheight]" value="<?php echo $general_setting['general_sheight'];?>" />
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_xsmall_image_demension');?></td>
										<td>
											<input name="pavblog[general_xwidth]" value="<?php echo $general_setting['general_xwidth'];?>" size="3"/> 
											x 
											<input size="3" name="pavblog[general_xheight]" value="<?php echo $general_setting['general_xheight'];?>" />
										</td>
									</tr>
								</table>
								<h4><?php echo $this->language->get('text_category_setting');?></h4>
								<table class="form">
									<tr>
										<td><?php echo $this->language->get('entry_children_columns');?></td>
										<td>
											<input name="pavblog[children_columns]" value="<?php echo $general_setting['children_columns'];?>" size="10"/>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_category_image_demension');?></td>
										<td>
											<input name="pavblog[general_cwidth]" value="<?php echo $general_setting['general_cwidth'];?>" size="3"/> 
											x 
											<input size="3" name="pavblog[general_cheight]" value="<?php echo $general_setting['general_cheight'];?>" />
										</td>
									</tr> 
									<tr>
										<td><?php echo $this->language->get('entry_limit_leading_blogs');?></td>
										<td>
											<input name="pavblog[cat_limit_leading_blog]" value="<?php echo $general_setting['cat_limit_leading_blog'];?>" size="10"/>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_limit_secondary_blogs');?></td>
										<td>
											<input name="pavblog[cat_limit_secondary_blog]" value="<?php echo $general_setting['cat_limit_secondary_blog'];?>" size="10"/>
										</td>
									</tr>
									
									
									<tr>
										<td><?php echo $this->language->get('entry_leading_image_types');?></td>
										<td>
											<select name="pavblog[cat_leading_image_type]">
											<?php foreach( $image_types as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_leading_image_type']){?>selected="selected"<?php } ?> ><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_secondary_image_types');?></td>
										<td>
											<select name="pavblog[cat_secondary_image_type]">
											<?php foreach( $image_types as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_secondary_image_type']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_columns_leading_blogs');?></td>
										<td>
											<input name="pavblog[cat_columns_leading_blog]" value="<?php echo $general_setting['cat_columns_leading_blogs'];?>" size="10"/>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_columns_secondary_blogs');?></td>
										<td>
											<input name="pavblog[cat_columns_secondary_blogs]" value="<?php echo $general_setting['cat_columns_secondary_blogs'];?>" size="10"/>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_title');?></td>
										<td>
											<select name="pavblog[cat_show_title]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_title']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_description');?></td>
										<td>
											<select name="pavblog[cat_show_description]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_description']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_readmore');?></td>
										<td>
											<select name="pavblog[cat_show_readmore]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_readmore']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_image');?></td>
										<td>
											<select name="pavblog[cat_show_image]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_image']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
				
									<tr>
										<td><?php echo $this->language->get('entry_show_author');?></td>
										<td>
											<select name="pavblog[cat_show_author]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_author']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_category');?></td>
										<td>
											<select name="pavblog[cat_show_category]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_category']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_created');?></td>
										<td>
											<select name="pavblog[cat_show_created]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_created']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_hits');?></td>
										<td>
											<select name="pavblog[cat_show_hits]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_hits']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_comment_counter');?></td>
										<td>
											<select name="pavblog[cat_show_comment_counter]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['cat_show_comment_counter']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									
								</table>
								<h4><?php echo $this->language->get('text_blog_setting');?></h4>
								
								
								<table class="form">
									
								
								
									<tr>
										<td><?php echo $this->language->get('entry_blog_image_types');?></td>
										<td>
											<select name="pavblog[blog_image_type]">
											<?php foreach( $image_types as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_image_type']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_title');?></td>
										<td>
											<select name="pavblog[blog_show_title]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_title']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									
									<tr>
										<td><?php echo $this->language->get('entry_show_image');?></td>
										<td>
											<select name="pavblog[blog_show_image]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_image']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>

									<tr>
										<td><?php echo $this->language->get('entry_show_author');?></td>
										<td>
											<select name="pavblog[blog_show_author]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_author']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_category');?></td>
										<td>
											<select name="pavblog[blog_show_category]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_category']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_created');?></td>
										<td>
											<select name="pavblog[blog_show_created]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_created']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_comment_counter');?></td>
										<td>
											<select name="pavblog[blog_show_comment_counter]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_comment_counter']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_show_hits');?></td>
										<td>
											<select name="pavblog[blog_show_hits]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_hits']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									
									<tr>
										<td><?php echo $this->language->get('entry_show_comment_form');?></td>
										<td>
											<select name="pavblog[blog_show_comment_form]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['blog_show_comment_form']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_comment_engine');?></td>
										<td>
											<select name="pavblog[comment_engine]">
												<?php foreach( $comment_engine as $key => $engine ){?>
													<option value="<?php echo $key;?>" <?php if($key==$general_setting['comment_engine']){?>selected="selected"<?php } ?>><?php echo $engine;?></option>
												<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_diquis_account');?></td>
										<td><input name="pavblog[diquis_account]" value="<?php echo $general_setting['diquis_account'];?>" size="30"/>
										<br>
											<a href="https://disqus.com/admin/signup/" target="_blank"><?php echo $this->language->get('text_signup_diquis');?> </a>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_facebook_appid');?></td>
										<td><input name="pavblog[facebook_appid]" value="<?php echo $general_setting['facebook_appid'];?>" size="30"/></td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_comment_limit');?></td>
										<td><input name="pavblog[comment_limit]" value="<?php echo $general_setting['comment_limit'];?>" size="30"/></td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_facebook_width');?></td>
										<td><input name="pavblog[facebook_width]" value="<?php echo $general_setting['facebook_width'];?>" size="30"/></td>
									</tr>
									
									<tr>
										<td><?php echo $this->language->get('entry_auto_publish_comment');?></td>
										<td>
											<select name="pavblog[auto_publish_comment]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['auto_publish_comment']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_enable_recaptcha');?></td>
										<td>
											<select name="pavblog[enable_recaptcha]">
											<?php foreach( $yesno as $k => $v ) { ?>
												<option value="<?php echo $k;?>" <?php if($k==$general_setting['enable_recaptcha']){?>selected="selected"<?php } ?>><?php echo $v;?></option>	
											<?php } ?>
											</select>
											<a href="http://www.google.com/recaptcha" target="_blank"><?php echo $this->language->get('text_register_recaptcha');?></a>
										</td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_recaptcha_public_key');?></td>
										<td><input name="pavblog[recaptcha_public_key]" value="<?php echo $general_setting['recaptcha_public_key'];?>" size="60"/></td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_recaptcha_private_key');?></td>
										<td><input name="pavblog[recaptcha_private_key]" value="<?php echo $general_setting['recaptcha_private_key'];?>" size="60"/></td>
									</tr>
									
								</table>
						</div>
					</div>
					
				</div>
				
				
			</div>
		</div>	
		
		
 </div>
  
 <script type="text/javascript">
	$(".pavhtabs a").tabs();
	$(".pavmodshtabs a").tabs();
	function __submit( val ){
		$("#action_mode").val( val );
		$("#form").submit();
	}
	
 </script>
 
<?php echo $footer; ?>
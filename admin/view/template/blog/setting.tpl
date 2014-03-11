<?php echo $header; ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/blog/colorpicker.css" />
<script type="text/javascript" src="view/javascript/blog/colorpicker.js"></script>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	
	<div class="container">
		<div id="et-header">
			<span class="em-header"><img src="view/image/blog/blog_manager.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></span>
			
			<ul>
				<li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
				<li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
				<li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
				<li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
				<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
					<li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
				<?php } ?>
				<?php if (isset($haspermission_editSetting)) { ?>
					<li><a href="<?php echo $menu_setting_href; ?>" class="active"><?php echo $text_menu_setting; ?></a></li>
				<?php } ?>
				<!--<li><a href="<?php echo $menu_about_href; ?>" class="active"><?php echo $text_menu_about; ?></a></li>-->
			</ul>
		</div>
		
		<?php if ($error_warning) { ?>
			<div class="warning">
				<?php echo $error_warning; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		<?php if ($success) { ?>
			<div class="success">
				<?php echo $success; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		
		<div id="et-content">
			<?php if (isset($haspermission_editSetting)) { ?>
				<div class="floatRight"><a onclick="$('#blogSetting').submit();" class="button"><?php echo $button_save; ?></a> </div>
				
				<div id="tabs" class="htabs">
					<a href="#tabBlog"><?php echo $text_tab_blog; ?></a>
					<a href="#tabCategory"><?php echo $text_tab_category; ?>  <?php if(isset($error_tabCategory)) { echo $error_tabCategory; } ?></a>
					<a href="#tabArticle"><?php echo $text_tab_article; ?> <?php if(isset($error_tabArticle)) { echo $error_tabArticle; } ?></a>
					<a href="#tabComment"><?php echo $text_tab_comment; ?> <?php if(isset($error_tabComment)) { echo $error_tabComment; } ?></a>
					<a href="#tabSearch"><?php echo $text_tab_search; ?> <?php if(isset($error_tabSearch)) { echo $error_tabSearch; } ?></a>
					<a href="#tabAdmin"><?php echo $text_tab_admin; ?> <?php if(isset($error_tabAdmin)) { echo $error_tabAdmin; } ?></a>
				</div>
				
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="blogSetting">
					<div id="tabBlog">
						<h3><?php echo $text_section_general; ?></h3>
						<?php if (count($languages) > '1') { ?>
                     <div id="languages" class="htabs">
                        <?php foreach ($languages as $language) { ?>
                           <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                        <?php } ?>
                     </div>
                  <?php } ?>
                  <?php foreach ($languages as $language) { ?>
                     <div id="language<?php echo $language['language_id']; ?>">
                        <table class="form blogSetting">
                           <tr>
                              <td><?php echo $entry_blog_name; ?></td>
                              <td class="input_350" colspan="2"><input type="text" name="blogHomeDescription[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($blogHomeDescriptionValues[$language['language_id']]) ? $blogHomeDescriptionValues[$language['language_id']]['name'] : $blogNameValue; ?>" /></td>
                           </tr>
                           <tr>
                              <td><?php echo $entry_blog_meta; ?></td>
                              <td>
											<p><?php echo $entry_blog_keyword; ?></p>
											<textarea name="blogHomeDescription[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($blogHomeDescriptionValues[$language['language_id']]) ? $blogHomeDescriptionValues[$language['language_id']]['meta_keyword'] : $blogKeywordValue; ?></textarea>
											<?php echo $entry_blog_keyword_help; ?>
										</td>
                              <td>
											<p><?php echo $entry_blog_description; ?></p>
											<textarea name="blogHomeDescription[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($blogHomeDescriptionValues[$language['language_id']]) ? $blogHomeDescriptionValues[$language['language_id']]['meta_description'] : $blogDescriptionValue; ?></textarea>
											<?php echo $entry_blog_description_help; ?>
										</td>
                           </tr>
                           <tr>
                              <td><?php echo $entry_blog_home_description; ?><br />
                              <?php echo $entry_blog_home_description_help; ?></td>
                              <td colspan="2"><textarea name="blogHomeDescription[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($blogHomeDescriptionValues[$language['language_id']]) ? $blogHomeDescriptionValues[$language['language_id']]['description'] : ''; ?></textarea></td>
                           </tr>
                        </table>
                     </div>
						<?php } ?>
						
						<h3><?php echo $text_section_setting; ?></h3>
						<table class="form blogSetting">
							<tr>
                        <td><?php echo $entry_art_order; ?></td>
                        <td class="select_175">
                           <select name="artOrder">								
                              <option value="sortAsc" <?php if ($artOrderValue == 'sortAsc') { echo 'selected="selected"'; } ?>><?php echo $entry_order_asc; ?></option>
                              <option value="sortDesc" <?php if ($artOrderValue == 'sortDesc') { echo 'selected="selected"'; } ?>><?php echo $entry_order_desc; ?></option>
                              <option value="dateAsc" <?php if ($artOrderValue == 'dateAsc') { echo 'selected="selected"'; } ?>><?php echo $entry_date_asc; ?></option>
                              <option value="dateDesc" <?php if ($artOrderValue == 'dateDesc' || $artOrderValue == '') { echo 'selected="selected"'; } ?>><?php echo $entry_date_desc; ?></option>
                           </select>
                        <?php echo $entry_art_order_help; ?>
                        </td>
							</tr>
							<tr>
								<td><?php echo $entry_blog_exclude; ?></td>
								<td>
									<?php echo $entry_blog_exclude_help; ?>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($categories as $category) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($category['category_id'], $blogExcludeValues)) { ?>
												<input type="checkbox" name="blogExclude[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
												<?php echo $category['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="blogExclude[]" value="<?php echo $category['category_id']; ?>" />
												<?php echo $category['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
						</table>
						
						<h3><?php echo $text_section_layout; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_blog_col; ?></td>
								<td class="select_175">
									<select name="blogCol">
										<option value="" <?php if(!isset($blogColValue) || $blogColValue == ''){ echo 'selected="selected"'; } ?>><?php echo $text_blogcol1; ?></option>
										<option value="blogCol2 imageBlock equalHeight" <?php if (strpos($blogColValue, 'blogCol2') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol2; ?></option>
										<option value="blogCol3 imageBlock equalHeight" <?php if (strpos($blogColValue, 'blogCol3') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol3; ?></option>
										<option value="blogCol4 imageBlock equalHeight" <?php if (strpos($blogColValue, 'blogCol4') !== false) { echo 'selected="selected"'; } ?>><?php echo $text_blogcol4; ?></option>
									</select>
									<?php echo $entry_blog_col_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_blog_suffix; ?></td>
								<td><input type="text" name="blogSuffix" value="<?php echo $blogSuffixValue; ?>" /><?php echo $entry_blog_suffix_help; ?></td>
							</tr>
						</table>
					</div>
					
					<div id="tabCategory">
						<h3><?php echo $text_section_setting; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><span class="required">*</span> <?php echo $entry_show_category; ?></td>
								<td class="input_35">
									<input type="text" name="articleCat" value="<?php echo $articleCatValue; ?>" />
									<?php if ($error_articleCat) { ?><span class="error"><?php echo $error_articleCat; ?></span><?php } ?>
									<?php echo $entry_show_category_help; ?>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_description; ?></td>
								<td class="input_35">
									<input type="text" name="articleDesc" value="<?php echo $articleDescValue; ?>" />
									<?php if ($error_articleDesc) { ?><span class="error"><?php echo $error_articleDesc; ?></span><?php } ?>
									<?php echo $entry_description_help; ?>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_image_featured; ?></td>
								<td class="input_35"><input type="text" name="articleFeatWidth" value="<?php echo $articleFeatWidthValue; ?>" />
									x
									<input type="text" name="articleFeatHeight" value="<?php echo $articleFeatHeightValue; ?>" />
									<?php if ($error_articleFeature) { ?><span class="error"><?php echo $error_articleFeature; ?></span><?php } ?>
									<?php echo $entry_image_featured_help; ?>
								</td>
							</tr>
						</table>
						
						<h3><?php echo $text_section_virdir; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_virtual_directory; ?></td>
								<td class="select_90">
									<select name="virDir">
										<?php if (isset($virDirValue) && $virDirValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_virtual_directory_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_virdir_name; ?></td>
								<td class="input_80"><input type="text" name="virDirName" value="<?php echo (isset($virDirNameValue) && $virDirNameValue) ? $virDirNameValue : 'blog'; ?>" /><?php echo $entry_virdir_name_help; ?></td>
							</tr>							
							<tr>
								<td><?php echo $entry_virdir_exclude; ?></td>
								<td>
									<?php echo $entry_virdir_exclude_help; ?>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($categories as $category) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($category['category_id'], $virDirExcludeValues)) { ?>
												<input type="checkbox" name="virDirExclude[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
												<?php echo $category['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="virDirExclude[]" value="<?php echo $category['category_id']; ?>" />
												<?php echo $category['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
						</table>
					</div>
					
					<div id="tabArticle">
						<h3><?php echo $text_section_setting; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_seosuffix; ?></td>
								<td class="input_100"><input type="text" name="seoSuffix" value="<?php echo $seoSuffixValue; ?>" /><?php echo $entry_seosuffix_help; ?></td>
							</tr>
							<tr>
								<td><?php echo $entry_article_info; ?></td>
								<td class="select_90">
									<?php echo $entry_article_info_help; ?>
									<ul class="list-plain">
										<li><input type="checkbox" name="artInfoName" <?php if(isset($artInfoNameValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_author; ?><label></li>
										<li><input type="checkbox" name="artInfoCategory" <?php if(isset($artInfoCategoryValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_category; ?><label></li>
										<li class="clear"><input type="checkbox" name="artInfoDate" <?php if(isset($artInfoDateValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_date; ?><label></li>
										<li><input type="checkbox" name="artInfoComment" <?php if(isset($artInfoCommentValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_comment; ?><label></li>
										<li class="clear"><input type="checkbox" name="artInfoUpdate" <?php if(isset($artInfoUpdateValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_update; ?><label></li>
									</ul>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_product_article; ?></td>
								<td class="select_90">
									<select name="relProductArticle">
										<option value="1" <?php echo ($relProductArticleValue) ? 'selected="selected"' : ''; ?>><?php echo $text_enabled; ?></option>
										<option value="0" <?php echo (!$relProductArticleValue) ? 'selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
									</select>
									<?php echo $entry_product_article_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_product_related; ?></td>
								<td class="select_90">
									<select name="relProductRelated">
										<option value="1" <?php echo ($relProductRelatedValue) ? 'selected="selected"' : ''; ?>><?php echo $text_enabled; ?></option>
										<option value="0" <?php echo (!$relProductRelatedValue) ? 'selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
									</select>
									<?php echo $entry_product_related_help; ?>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_product_related_row; ?></td>
								<td class="input_35">
									<input type="text" name="relProduct" value="<?php echo $relProductValue; ?>" />
									<?php if ($error_relProduct) { ?><span class="error"><?php echo $error_relProduct; ?></span><?php } ?>
									<?php echo $entry_product_perrow_help; ?>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_product_image; ?></td>
								<td class="input_35">
									<input type="text" name="relProductWidth" value="<?php echo $relProductWidthValue; ?>" /> x 
									<input type="text" name="relProductHeight" value="<?php echo $relProductHeightValue; ?>" />
									<?php if ($error_relProductWH) { ?><span class="error"><?php echo $error_relProductWH; ?></span><?php } ?>
									<?php echo $entry_product_image_help; ?>
								</td>
							</tr>
						</table>
						
						<h3><?php echo $text_section_socmed; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_socmed; ?></td>
								<td class="select_90">
									<select name="socMedia">
										<option value="1" <?php echo ($socMediaValue) ? 'selected="selected"' : ''; ?>><?php echo $text_enabled; ?></option>
										<option value="0" <?php echo (!$socMediaValue) ? 'selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
									</select>
									<?php echo $entry_socmed_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_addthis; ?></td>
								<td><input type="text" name="pubID" value="<?php echo $pubIDValue; ?>" /><?php echo $entry_addthis_help; ?></td>
							</tr>
							<tr>
								<td><?php echo $entry_socmedcode; ?></td>
								<td>
									<textarea name="socMedCode" cols="40" rows="10"><?php echo $socMedCodeValue; ?></textarea><?php echo $entry_socmedcode_help; ?>
								</td>
							</tr>
						</table>
					</div>
					
					<div id="tabComment">
						<h3><?php echo $text_section_setting; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_comment_status; ?></td>
								<td class="select_90">
									<select name="commentStatus">
										<?php if ($commentStatusValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_comment_status_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_perarticle; ?></td>
								<td class="input_35"><input type="text" name="commentLimit" value="<?php echo $commentLimitValue; ?>" /><?php echo $entry_comment_perarticle_help; ?></td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_avatar; ?></td>
								<td class="input_35"><input type="text" name="commentAvatar" value="<?php echo $commentAvatarValue; ?>" /><?php echo $entry_comment_avatar_help; ?></td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_comment_characters; ?></td>
								<td class="input_35">
									<input type="text" name="commentMin" value="<?php echo $commentMinValue; ?>" /> - 
									<input type="text" name="commentMax" value="<?php echo $commentMaxValue; ?>" />
									<?php if ($error_commentMinMax) { ?><span class="error"><?php echo $error_commentMinMax; ?></span><?php } ?>
									<?php echo $entry_comment_characters_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_order; ?></td>
								<td class="select_175">
									<select name="commentOrder">
										<option value="ASC" <?php if ($commentOrderValue == 'ASC') { echo 'selected="selected"'; } ?>><?php echo $entry_date_asc; ?></option>
										<option value="DESC" <?php if ($commentOrderValue == 'DESC' || $commentOrderValue == '') { echo 'selected="selected"'; } ?>><?php echo $entry_date_desc; ?></option>
									</select>
									<?php echo $entry_comment_order_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_email_notify; ?></td>
								<td><input type="text" name="emailNotify" value="<?php echo $emailNotifyValue; ?>" /><?php echo $entry_email_notify_help; ?></td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_captcha; ?></td>
								<td class="select_175">
									<select name="commentCaptha">
										<option value="disabled" <?php if($commentCapthaValue == 'disabled'){ echo 'selected="selected"'; } ?>><?php echo $text_disabled; ?></option>
										<option value="guest" <?php if($commentCapthaValue == 'guest'){ echo 'selected="selected"'; } ?>><?php echo $text_gueast_only; ?></option>
										<option value="visitor" <?php if($commentCapthaValue == 'visitor'){ echo 'selected="selected"'; } ?>><?php echo $text_all_visitor; ?></option>
										<option value="nondefault" <?php if($commentCapthaValue == 'nondefault'){ echo 'selected="selected"'; } ?>><?php echo $text_non_default; ?></option>
									</select>
									<?php echo $entry_comment_captcha_help; ?>
								</td>
							</tr>
						</table>
						
						<h3><?php echo $text_section_accperm; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_guest_comment; ?></td>
								<td class="select_90">
									<select name="guestComment">
										<option value="1" <?php if (!isset($guestCommentValue) || $guestCommentValue == 1) { ?>selected="selected"<?php } ?>><?php echo $text_allow; ?></option>
										<option value="2" <?php if ($guestCommentValue == 2) { ?>selected="selected"<?php } ?>><?php echo $text_disallow; ?></option>
									</select>
									<?php echo $entry_guest_comment_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_disabled_cat; ?></td>
								<td>
									<?php echo $entry_comment_disabled_cat_help; ?>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($categories as $category) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($category['category_id'], $commentDisableCatValues)) { ?>
												<input type="checkbox" name="commentDisableCat[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
												<?php echo $category['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="commentDisableCat[]" value="<?php echo $category['category_id']; ?>" />
												<?php echo $category['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_auto_approve; ?></td>
								<td class="select_90">
									<select name="commentDefApprove">
										<?php if ($commentDefApproveValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_comment_auto_approve_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_comment_approve_group; ?></td>
								<td>
									<?php echo $entry_comment_approve_group_help; ?>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($customer_groups as $cusgroup) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($cusgroup['customer_group_id'], $commentApproveGroupValues)) { ?>
												<input type="checkbox" name="commentApproveGroup[]" value="<?php echo $cusgroup['customer_group_id']; ?>" checked="checked" />
												<?php echo $cusgroup['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="commentApproveGroup[]" value="<?php echo $cusgroup['customer_group_id']; ?>" />
												<?php echo $cusgroup['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
						</table>
                  <h3><?php echo $text_section_badge_admin; ?></h3>
                  <table class="form blogSetting">
                     <tr>								
                        <td><?php echo $entry_comment_admin_badge; ?></td>                        
								<td>
									<?php echo $entry_comment_admin_badge_help; ?>
                           <span class="help"><b><i>(<?php foreach ($user_groups as $admGroup1) { ?><?php echo sprintf($admGroup1['name']); ?>. <?php } ?>)</i></b></span>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($user_groups as $admGroup) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($admGroup['user_group_id'], $commentAdminBadgeGroupValues)) { ?>
												<input type="checkbox" name="commentAdminBadgeGroup[]" value="<?php echo $admGroup['user_group_id']; ?>" checked="checked" />
												<?php echo $admGroup['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="commentAdminBadgeGroup[]" value="<?php echo $admGroup['user_group_id']; ?>" />
												<?php echo $admGroup['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
                  </table>
                  <?php if (count($user_groups) > '1') { ?>
                     <div id="adminColor" class="htabs" style="margin-left:15px;">
                        <?php foreach ($user_groups as $admGroup) { ?>
                           <a href="#adminColor<?php echo $admGroup['user_group_id']; ?>"><?php echo $admGroup['name']; ?></a>
                        <?php } ?>
                     </div>
                     <?php } ?>
                     <?php foreach ($user_groups as $admGroup) { ?>
                     <div id="adminColor<?php echo $admGroup['user_group_id']; ?>">
                        <table class="form blogSetting">
                           <tr>
                              <td><?php echo $entry_badge_admin; ?></td>
                              <td><input id="adminColorPicker<?php echo $admGroup['user_group_id']; ?>" type="text" name="adminBlogColors[<?php echo $admGroup['user_group_id']; ?>][adminBadgeColor]" size="100" value="<?php echo isset($adminBlogColorsValues[$admGroup['user_group_id']]) ? $adminBlogColorsValues[$admGroup['user_group_id']]['adminBadgeColor'] : 'ff0000'; ?>" /><?php echo $entry_badge_admin_help; ?></td>
                           </tr>
                        </table>
                     </div>
                  <?php } ?>
                  <h3><?php echo $text_section_badge_customer; ?></h3>
                  <table class="form blogSetting">
                     <tr>
								<td><?php echo $entry_comment_customer_badge; ?></td>
								<td>
									<?php echo $entry_comment_customer_badge_help; ?>
                           <span class="help"><b><i>(<?php foreach ($customer_groups as $cusgroup1) { ?><?php echo sprintf($cusgroup1['name']); ?>. <?php } ?>)</i></b></span>
									<div class="scrollbox">
										<?php $class = 'odd'; ?>
										<?php foreach ($customer_groups as $cusgroup) { ?>
											<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
											<div class="<?php echo $class; ?>">
											<?php if (in_array($cusgroup['customer_group_id'], $commentBadgeGroupValues)) { ?>
												<input type="checkbox" name="commentBadgeGroup[]" value="<?php echo $cusgroup['customer_group_id']; ?>" checked="checked" />
												<?php echo $cusgroup['name']; ?>
											<?php } else { ?>
												<input type="checkbox" name="commentBadgeGroup[]" value="<?php echo $cusgroup['customer_group_id']; ?>" />
												<?php echo $cusgroup['name']; ?>
											<?php } ?>
											</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
								</td>
							</tr>
                  </table>                  
                  <?php if (count($customer_groups) > '1') { ?>
                     <div id="badge" class="htabs" style="margin-left:15px;">
                        <?php foreach ($customer_groups as $cusgroup) { ?>
                           <a href="#badge<?php echo $cusgroup['customer_group_id']; ?>"><?php echo $cusgroup['name']; ?></a>
                        <?php } ?>
                     </div>
                     <?php } ?>
                     <?php foreach ($customer_groups as $cusgroup) { ?>
                     <div id="badge<?php echo $cusgroup['customer_group_id']; ?>">
                        <table class="form blogSetting">
                           <tr>
                              <td><?php echo $entry_badge_customer; ?></td>
                              <td><input id="colorPicker<?php echo $cusgroup['customer_group_id']; ?>" type="text" name="commentBadgeColor[<?php echo $cusgroup['customer_group_id']; ?>][color]" size="100" value="<?php echo isset($commentBadgeColorValues[$cusgroup['customer_group_id']]) ? $commentBadgeColorValues[$cusgroup['customer_group_id']]['color'] : '0555C6'; ?>" /><?php echo $entry_badge_customer_help; ?></td>
                           </tr>
                        </table>
                     </div>
                  <?php } ?>
					</div>
					
					<div id="tabSearch">
						<h3><?php echo $text_section_setsearch; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_search_status; ?></td>
								<td class="select_90">
									<select name="searchStatus">
										<?php if (isset($searchStatusValue) && $searchStatusValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_search_status_help; ?>
								</td>
							</tr>
                     <tr>
								<td><?php echo $entry_article_info; ?></td>
								<td class="select_90">
									<?php echo $entry_search_article_info_help; ?>
									<ul class="list-plain">
										<li><input type="checkbox" name="srchInfoName" <?php if(isset($srchInfoNameValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_author; ?><label></li>
										<li><input type="checkbox" name="srchInfoDate" <?php if(isset($srchInfoNameValue)){ echo 'checked="checked"'; } ?>><label><?php echo $entry_artinfo_date; ?><label></li>
									</ul>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_search_limit; ?></td>
								<td class="input_35">
									<input type="text" name="searchLimit" value="<?php echo $searchLimitValue; ?>" />
									<?php if ($error_searchLimit) { ?><span class="error"><?php echo $error_searchLimit; ?></span><?php } ?>
									<?php echo $entry_search_limit_help; ?>
								</td>
							</tr>
							<tr>
								<td><span class="required">*</span> <?php echo $entry_search_gridrow; ?></td>
								<td class="input_35">
									<input type="text" name="searchGrid" value="<?php echo $searchGridValue; ?>" />
									<?php if ($error_searchGrid) { ?><span class="error"><?php echo $error_searchGrid; ?></span><?php } ?>
									<?php echo $entry_search_gridrow_help; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_search_display; ?></td>
								<td class="select_125">
									<select name="searchDisplay">
										<option value="plain" <?php if($searchDisplayValue == 'plain'){ echo 'selected="selected"'; } ?>><?php echo $text_plain_list; ?></option>
										<option value="compact" <?php if($searchDisplayValue == 'compact'){ echo 'selected="selected"'; } ?>><?php echo $text_compact_list; ?></option>
										<option value="grid" <?php if($searchDisplayValue == 'grid'){ echo 'selected="selected"'; } ?>><?php echo $text_grid; ?></option>
									</select>
									<?php echo $entry_search_display_help; ?>
								</td>
							</tr>
						</table>
						
						<h3><?php echo $text_section_setfeed; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><?php echo $entry_blog_feed; ?></td>
								<td class="select_90">
									<select name="blogFeed">
										<?php if ($blogFeedValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_blog_feed_help; ?>
                           <span class="help">
                              <a onClick="window.open('<?php echo $store; ?>index.php?route=feed/blog');" class="top"><?php echo $text_default; ?> <?php echo $text_blog_feed; ?></a><br>
                              <?php foreach ($stores as $store1) { ?>
                                 <a onClick="window.open('<?php echo $store1['href']; ?>index.php?route=feed/blog');"><?php echo $store1['name']; ?> <?php echo $text_blog_feed; ?></a><br>
                              <?php } ?>
                           </span>
								</td>
							</tr>
                     <tr>
                        <td><?php echo $entry_blog_feed_limit; ?></td>
								<td class="input_35">
                           <input type="text" name="feedLimit" value="<?php echo $feedLimitValue; ?>" />
									<?php echo $entry_blog_feed_limit_help; ?>
								</td>
							</tr>
							<tr>
								<td style="vertical-align:top"><?php echo $entry_blog_sitemap; ?></td>
								<td class="select_90">
									<select name="blogSitemap">
										<?php if ($blogSitemapValue) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
									<?php echo $entry_blog_sitemap_help; ?>
                           <span class="help">
                              <a onClick="window.open('<?php echo $store; ?>index.php?route=feed/blog_sitemap');" class="top"><?php echo $text_default; ?> <?php echo $text_blog_sitemap; ?></a><br>
                              <?php foreach ($stores as $stored) { ?>
                                 <a onClick="window.open('<?php echo $stored['href']; ?>index.php?route=feed/blog_sitemap');"><?php echo $stored['name']; ?> <?php echo $text_blog_sitemap; ?></a><br>
                              <?php } ?>
                           </span>									
								</td>
							</tr>
                     <tr>
                        <td style="vertical-align:top"><?php echo $entry_blog_sitemap_limit; ?></td>
                        <td class="input_35">
                           <input type="text" name="sitemapLimit" value="<?php echo $sitemapLimitValue; ?>" />
									<?php echo $entry_blog_sitemap_limit_help; ?>
									<?php echo $entry_blog_htaccess_help; ?>
								</td>
							</tr>
						</table>
					</div>
					
					<div id="tabAdmin">
						<h3><?php echo $text_section_setting; ?></h3>
						<table class="form blogSetting">
							<tr>
								<td><span class="required">*</span> <?php echo $entry_show_admin; ?></td>
								<td class="input_35">
									<input type="text" name="articleAdmin" value="<?php echo $articleAdminValue; ?>" />
									<?php if ($error_articleAdmin) { ?><span class="error"><?php echo $error_articleAdmin; ?></span><?php } ?>
									<?php echo $entry_show_admin_help; ?>
								</td>
							</tr>
						</table>
					</div>
					
				</form>
			<?php } else { ?>
				<div class="attention">
					<?php echo $error_nopermission; ?>
				</div>
			<?php } ?>
		</div>
		
		<div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
	</div>
</div>
<script type="text/javascript"><!--
<?php foreach ($customer_groups as $cusgroup) { ?>
$(document).ready(function() {
	$('#colorPicker<?php echo $cusgroup['customer_group_id']; ?>').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
});
<?php } ?>
<?php foreach ($user_groups as $admGroup) { ?>
$(document).ready(function() {
	$('#adminColorPicker<?php echo $admGroup['user_group_id']; ?>').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
});
<?php } ?>
//--></script>
<script type="text/javascript" src="<?php echo HTTP_SERVER; ?>view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script>
<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs();
$('#badge a').tabs();
$('#adminColor a').tabs();
//--></script> 
<?php echo $footer; ?>
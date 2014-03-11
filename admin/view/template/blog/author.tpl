<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	
	<div class="container">
		<div id="et-header">
			<span class="em-header"><img src="view/image/blog/blog_manager.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></span>
			
			
			<?php if ($adminAvailable) { ?>
				<ul>
					<li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
					<li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
					<li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
					<li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
					<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
						<li><a href="<?php echo $menu_author_href; ?>" class="active"><?php echo $text_menu_author; ?></a></li>
					<?php } ?>
					<?php if (isset($haspermission_editSetting)) { ?>
						<li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
					<?php } ?>
					<!--<li><a href="<?php echo $menu_about_href; ?>" class="active"><?php echo $text_menu_about; ?></a></li>-->
				</ul>
			<?php } ?>
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
		<?php if ($attention) { ?>
			<div class="attention">				
				<?php echo $attention; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		
		<div id="et-content">
		<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission) || !$adminAvailable) { ?>
			
			<div id="tabs" class="htabs">
				<a href="#tabAuthors"><?php echo $text_tab_author; ?> <?php if(isset($error_tabAuthors)) { echo $error_tabAuthors; } ?></a>
				<a href="#tabPermission"><?php echo $text_tab_permission; ?></a>
			</div>

			<div id="tabAuthors">
				<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || !$adminAvailable) { ?>
				<table class="blogAuthor">
					<tr>
						<?php if (isset($haspermission_removeAuthor)) { ?>
						<td class="authorList">
							<?php if ($error_delAdmin) { ?><span class="error"><?php echo $error_delAdmin; ?></span><?php } ?>
							<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="delAuthor">
								<table class="blogList">
									<thead>
										<tr>
											<td class="checkbox center"><input type="checkbox" onclick="$('input[name*=\'delAuthor\']').attr('checked', this.checked);"/></td>
											<td class="author center"><?php echo $text_author_name; ?></td>
											<td class="group center"><?php echo $text_author_group; ?></td>
											<td class="center"><?php echo $text_author_user; ?></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<?php $class = 'odd';?>
											<?php foreach ($authors as $author) { ?>
												<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
												<tr class="<?php echo $class; ?>">
													<td class="checkbox center"><input type="checkbox" name="delAuthor[]" value="<?php echo $author['author_id']; ?>" /></td>
													<td><?php echo $author['name']; ?></td>
													<td class="center"><?php echo $this->language->get('text_perm_' . strtolower($author['groupname'])); ?></td>
													<td><?php echo $author['fullname']; ?></td>
												</tr>
											<?php } ?>
										</tr>
									</tbody>
								</table>
								<div class="buttons right">
									<a onclick="$('#delAuthor').submit();" class="button"><?php echo $button_delete; ?></a>
								</div>
							</form>
						</td>
						<?php } ?>
						<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor)  || !$adminAvailable) { ?>
						<td class="authorAdd">
							<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="addAuthor">
							
							<?php if (isset($haspermission_addAuthor)  || !$adminAvailable) { ?>
							<table class="blogList">
								<thead>
									<tr>
										<td colspan="2"><?php echo $text_author_add; ?></td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><?php echo $text_user; ?></td>
										<td class="select_175">
											<?php if ($users) { ?>
												<select name="user_id">
													<?php foreach ($users as $user) { ?>
														<option value="<?php echo $user['user_id']; ?>"><?php echo $user['fullname']; ?></option>
													<?php } ?>
												</select>
											<?php } else { ?> <a href="<?php echo $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL'); ?>" target="_blank"><?php echo $text_user_required; ?></a> <?php } ?>
											<?php if ($error_selectUser) { ?><span class="error"><?php echo $error_selectUser; ?></span><?php } ?>
										</td>
									</tr>
									<tr>
										<td><?php echo $text_author_name2; ?></td>
										<td class="input_165">
											<input type="text" name="addAuthor" value="<?php echo $addAuthorValue; ?>"/>
											<?php if ($error_addAuthor) { ?><span class="error"><?php echo $error_addAuthor; ?></span><?php } ?>
										</td>
									</tr>
									<tr>
										<td><?php echo $text_author_group2; ?></td>
										<td class="select_90">
											<select name="author_group_id">
												<?php foreach ($authorGroups as $authorGroup) { ?>
													<?php if (!$adminAvailable && $authorGroup['name'] == 'Admin') { ?>
														<option value="<?php echo $authorGroup['author_group_id']; ?>" selected="selected"><?php echo $this->language->get('text_perm_' . strtolower($authorGroup['name'])); ?></option>
													<?php } ?>
													<?php if ($adminAvailable) { ?>
														<option value="<?php echo $authorGroup['author_group_id']; ?>"><?php echo $this->language->get('text_perm_' . strtolower($authorGroup['name'])); ?></option>
													<?php } ?>
												<?php } ?>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							<div class="buttons right">
								<a onclick="$('#addAuthor').submit();" class="button"><?php echo $button_submit; ?></a>
							</div>
							<?php } ?>
							
							<?php if (isset($haspermission_editAuthor)) { ?>
							<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="renAuthor">
							<table class="blogList">
								<thead>
									<tr>
										<td colspan="2"><?php echo $text_author_rename; ?></td>
									</tr>
								</thead>
								<tbody>
									<tr class="select_175">
										<td><?php echo $text_author_name2; ?></td>
										<td>
											<select name="author_id">
												<?php foreach ($authors as $author) { ?>
													<option value="<?php echo $author['author_id']; ?>"><?php echo $author['name']; ?></option>
												<?php } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td><?php echo $text_author_rename2; ?></td>
										<td class="input_165">
											<input type="text" name="renAuthor" value="<?php echo $renAuthorValue; ?>"/>
											<?php if ($error_renAuthor) { ?><span class="error"><?php echo $error_renAuthor; ?></span><?php } ?>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							<div class="buttons right">
								<a onclick="$('#renAuthor').submit();" class="button"><?php echo $button_submit; ?></a>
							</div>
							<?php } ?>
						</td>
						<?php } ?>
					</tr>
				</table>
				<?php } else { ?>
					<div class="attention">
						<?php echo $error_nopermission; ?>
					</div>
				<?php } ?>
			</div>
			<div id="tabPermission">
			<?php if (isset($haspermission_editPermission)) { ?>
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="permBlog">
					<table class="form groupPerm">
						<thead>
							<tr>
								<td><?php echo $text_perm_author; ?></td>
								<td><?php echo $text_perm_editor; ?></td>
								<td><?php echo $text_perm_admin; ?></td>
							</tr>
						</thead>
						<tbody>
						<tr>
							<td>
								<?php foreach ($permGroups as $permGroup) { 
									if ($permGroup['name'] == 'Author') { ?>
										
										<b><input type="checkbox" onclick="$('input.permAutorArticle').attr('checked', this.checked);" /> <?php echo $text_perm_article; ?></b>
											<div>
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('addArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addArticle" /> <?php echo $text_article_create; ?> <br />
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('copyArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyArticle" /> <?php echo $text_article_copy; ?> <br />
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('editOwnArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOwnArticle" /> <?php echo $text_article_editown; ?> <br />
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('editOtherArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOtherArticle" /> <?php echo $text_article_editother; ?> <br />
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('changeAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="changeAuthor" /> <?php echo $text_article_editauthor; ?> <br />
												<input class="permAutorArticle" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeArticle" /> <?php echo $text_article_remove; ?> <br />
											</div>
										<b><input type="checkbox" onclick="$('input.permAutorCategory').attr('checked', this.checked);" /> <?php echo $text_perm_category; ?></b>
											<div>
												<input class="permAutorCategory" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('addCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addCategory" /> <?php echo $text_category_create; ?><br />
												<input class="permAutorCategory" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('copyCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyCategory" /> <?php echo $text_category_copy; ?><br />
												<input class="permAutorCategory" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('editCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editCategory" /> <?php echo $text_category_edit; ?><br />
												<input class="permAutorCategory" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeCategory" /> <?php echo $text_category_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permAutorComment').attr('checked', this.checked);" /> <?php echo $text_perm_comment; ?></b>
											<div>
												<input class="permAutorComment" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('editComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editComment" /> <?php echo $text_comment_edit; ?><br />
												<input class="permAutorComment" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('replyComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="replyComment" /> <?php echo $text_comment_reply; ?><br />
												<input class="permAutorComment" type="checkbox" name="permAuthor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeComment" /> <?php echo $text_comment_remove; ?><br />
											</div>
									<?php }
								} ?>
							</td>
							<td>
								<?php foreach ($permGroups as $permGroup) { 
									if ($permGroup['name'] == 'Editor') { ?>
										<b><input type="checkbox" onclick="$('input.permEditorArticle').attr('checked', this.checked);" /> <?php echo $text_perm_article; ?></b>
											<div>
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('addArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addArticle" /> <?php echo $text_article_create; ?> <br />
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('copyArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyArticle" /> <?php echo $text_article_copy; ?> <br />
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editOwnArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOwnArticle" /> <?php echo $text_article_editown; ?> <br />
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editOtherArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOtherArticle" /> <?php echo $text_article_editother; ?> <br />
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('changeAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="changeAuthor" /> <?php echo $text_article_editauthor; ?><br />
												<input class="permEditorArticle" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeArticle" /> <?php echo $text_article_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permEditorCategory').attr('checked', this.checked);" /> <?php echo $text_perm_category; ?></b>
											<div>
												<input class="permEditorCategory" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('addCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addCategory" /> <?php echo $text_category_create; ?><br />
												<input class="permEditorCategory" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('copyCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyCategory" /> <?php echo $text_category_copy; ?><br />
												<input class="permEditorCategory" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editCategory" /> <?php echo $text_category_edit; ?><br />
												<input class="permEditorCategory" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeCategory" /> <?php echo $text_category_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permEditorComment').attr('checked', this.checked);" /> <?php echo $text_perm_comment; ?></b>
											<div>
												<input class="permEditorComment" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editComment" /> <?php echo $text_comment_edit; ?><br />
												<input class="permEditorComment" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('replyComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="replyComment" /> <?php echo $text_comment_reply; ?><br />
												<input class="permEditorComment" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeComment" /> <?php echo $text_comment_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permEditorAuthor').attr('checked', this.checked);" /> <?php echo $text_perm_author; ?></b>
											<div>
												<input class="permEditorAuthor" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('addAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addAuthor" /> <?php echo $text_autor_add; ?><br />
												<input class="permEditorAuthor" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editAuthor" /> <?php echo $text_autor_edit; ?><br />
												<input class="permEditorAuthor" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('removeAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeAuthor" /> <?php echo $text_autor_remove; ?><br />
												<input class="permEditorAuthor" type="checkbox" name="permEditor[]" <?php if (unserialize($permGroup['permission']) && in_array('editPermission', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editPermission" /> <?php echo $text_autor_permission; ?><br />
											</div>
									<?php }
								} ?>
							</td>
							<td>
								<?php foreach ($permGroups as $permGroup) { 
									if ($permGroup['name'] == 'Admin') { ?>
										<b><input type="checkbox" onclick="$('input.permAdminArticle').attr('checked', this.checked);" /> <?php echo $text_perm_article; ?></b>
											<div>
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('addArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addArticle" /> <?php echo $text_article_create; ?> <br />
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('copyArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyArticle" /> <?php echo $text_article_copy; ?> <br />
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('editOwnArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOwnArticle" /> <?php echo $text_article_editown; ?> <br />
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('editOtherArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editOtherArticle" /> <?php echo $text_article_editother; ?> <br />
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('changeAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="changeAuthor" /> <?php echo $text_article_editauthor; ?><br />
												<input class="permAdminArticle" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('removeArticle', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeArticle" /> <?php echo $text_article_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permAdminCategory').attr('checked', this.checked);" /> <?php echo $text_perm_category; ?></b>
											<div>
												<input class="permAdminCategory" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('addCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addCategory" /> <?php echo $text_category_create; ?><br />
												<input class="permAdminCategory" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('copyCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="copyCategory" /> <?php echo $text_category_copy; ?><br />
												<input class="permAdminCategory" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('editCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editCategory" /> <?php echo $text_category_edit; ?><br />
												<input class="permAdminCategory" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('removeCategory', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeCategory" /> <?php echo $text_category_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permAdminComment').attr('checked', this.checked);" /> <?php echo $text_perm_comment; ?></b>
											<div>
												<input class="permAdminComment" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('editComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editComment" /> <?php echo $text_comment_edit; ?><br />
												<input class="permAdminComment" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('replyComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="replyComment" /> <?php echo $text_comment_reply; ?><br />
												<input class="permAdminComment" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('removeComment', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeComment" /> <?php echo $text_comment_remove; ?><br />
											</div>
										<b><input type="checkbox" onclick="$('input.permAdminAuthor').attr('checked', this.checked);" /> <?php echo $text_perm_author; ?></b>
											<div>
												<input class="permAdminAuthor" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('addAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="addAuthor" /> <?php echo $text_autor_add; ?><br />
												<input class="permAdminAuthor" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('editAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="editAuthor" /> <?php echo $text_autor_edit; ?><br />
												<input class="permAdminAuthor" type="checkbox" name="permAdmin[]" <?php if (unserialize($permGroup['permission']) && in_array('removeAuthor', unserialize($permGroup['permission']))) { echo 'checked="checked"'; } ?> value="removeAuthor" /> <?php echo $text_autor_remove; ?><br />
												<input type="checkbox" name="permAdmin[]" checked="checked" disabled="disabled" value="editPermission" /> <?php echo $text_autor_permission; ?><br />
												<input type="hidden" name="permAdmin[]" value="editPermission">
											</div>
										<b><?php echo $text_perm_setting; ?></b>
											<div>
												<input type="checkbox" name="permAdmin[]" checked="checked" disabled="disabled" value="editSetting" /> <?php echo $text_setting_permission; ?><br />
												<input type="hidden" name="permAdmin[]" value="editSetting">
											</div>
									<?php }
								} ?>
							</td>
						</tr>
						</tbody>
					</table>
					<input type="hidden" name="permBlog" value="">
				</form>
				<div class="buttons right">
					<a onclick="$('#permBlog').submit();" class="button"><?php echo $button_save; ?></a>
				</div>
			<?php } else { ?>
				<div class="attention">
					<?php echo $error_nopermission; ?>
				</div>
			<?php } ?>
			</div>
		<?php } else { ?>
			<div class="attention">
				<?php echo $error_nopermission; ?>
			</div>
		<?php } ?>
		</div>
		
		<div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
	</div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<?php echo $footer; ?>
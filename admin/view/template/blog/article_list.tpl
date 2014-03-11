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
			
			<ul>
				<li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
				<li><a href="<?php echo $menu_article_href; ?>" class="active"><?php echo $text_menu_article; ?></a></li>
				<li><a href="<?php echo $menu_category_href; ?>"><?php echo $text_menu_category; ?></a></li>
				<li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
				<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
					<li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
				<?php } ?>
				<?php if (isset($haspermission_editSetting)) { ?>
					<li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
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
		<?php if ($attention) { ?>
			<div class="attention">				
				<?php echo $attention; ?>
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
			<div class="heading">
				<h2><?php echo $heading_list; ?></h2>
				<div class="buttons">
					<?php if (isset($haspermission_addArticle)) { ?>
						<a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a>
					<?php } ?>
					<?php if (isset($haspermission_copyArticle)) { ?>
						<a onclick="$('#form-delete').attr('action', '<?php echo $copy; ?>'); $('#form-delete').submit();" class="button"><?php echo $button_copy; ?></a>
					<?php } ?>
					<?php if (isset($haspermission_removeArticle)) { ?>
						<a onclick="$('#form-delete').submit();" class="button"><?php echo $button_delete; ?></a>
					<?php } ?>
				</div>				
			</div>
			
			<div class="articleFilter">
				<h3><?php echo $text_filter; ?></h3>
				
				<table class="filter">						
               <tr>
                  <td class="title"><?php echo $text_date_start; ?></td>
                     <td class="input_100">
                        <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" />
                     </td>
                  <td class="title"><?php echo $text_date_end; ?></td>
                     <td class="input_100">
                        <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" />
                     </td>
                  </tr>
               <tr>							
						<td class="title"><?php echo $text_category; ?></td>
						<td class="select_175">
							<select name="filter_category">
								<option value="all"><?php echo $text_all; ?></option>
								<?php foreach ($categories as $category) { ?>
								<?php if ($category['category_id']==$filter_category) { ?>
									<option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
								<?php } else { ?>
									<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option> 
								<?php } ?>
								<?php } ?>
							</select>
						</td>
						<td class="title"><?php echo $text_author; ?></td>
						<td class="select_175">
							<select name="filter_author">
								<option value="all"><?php echo $text_all; ?></option>
								<?php foreach ($authors as $author) { ?>
									<?php if ($author['author_id']==$filter_author) { ?>
										<option value="<?php echo $author['author_id']; ?>" selected="selected"><?php echo $author['name']; ?></option>
									<?php } else { ?>
										<option value="<?php echo $author['author_id']; ?>"><?php echo $author['name']; ?></option> 
									<?php } ?>
								<?php } ?>
							</select>
						</td>
					</tr>
					<tr>
						<td class="title"><?php echo $text_status; ?></td>
						<td class="select_90">								
							<select name="filter_status">
								<option value="all"><?php echo $text_all; ?></option>
								<?php if ($filter_status) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
								<?php } ?>
								<?php if (!is_null($filter_status) && !$filter_status) { ?>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="0"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>								
						</td>
                  <td class="title"><?php echo $text_store; ?></td>
                  <td class="select_90" colspan="3">                  
                     <select name="filter_store">
                        <option value="all"><?php echo $text_all; ?></option>                        
                        <?php if ($filter_store === '0') { ?>
                           <option value="0" selected="selected"><?php echo $text_default; ?></option>
                        <?php } else { ?>
                           <option value="0"><?php echo $text_default; ?></option>
                        <?php } ?>
                        <?php foreach ($stores as $store) { ?>
                           <?php if ($store['store_id']==$filter_store) { ?>
                              <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
                           <?php } else {?>
                              <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                           <?php } ?>
                        <?php } ?>
                     </select>
                  </td>
					</tr>
				</table>
				<div class="buttons right">
					<a onclick="filter();" class="button"><?php echo $text_apply_filter; ?></a>
				</div>
			</div>			
			<span id="filterOptions">[ <a href="<?php echo $action; ?>"><?php echo $text_reset; ?></a> -  <span><?php echo $text_show_filter; ?></span> ]</span>
			
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-delete">
				<table class="blogList">
					<thead>
						<tr>
							<?php if (isset($haspermission_removeArticle) || isset($haspermission_copyArticle)) { ?>
								<td width="1" class="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<?php } ?>
							<?php if ($sort == 'ad.title') { ?>
								<td class="center <?php echo strtolower($order); ?>"><a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a></td>
							<?php } else { ?>
								<td class="center"><a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a></td>
							<?php } ?>
							<td class="center" style="width:225px;"><?php echo $column_seo; ?></td>
							<?php if ($sort == 'a.created') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:100px;"><a href="<?php echo $sort_created; ?>"><?php echo $column_created; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:100px;"><a href="<?php echo $sort_created; ?>"><?php echo $column_created; ?></a></td>
							<?php } ?>
							<td class="center">
								<?php if ($sort == 'a2c.category_id') { ?>
									<a href="<?php echo $sort_category; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_category; ?></a>
								<?php } else { ?>
									<a href="<?php echo $sort_category; ?>"><?php echo $column_category; ?></a>
								<?php } ?>
							</td>
							<td class="center">
								<?php if ($sort == 'a.author_id') { ?>
									<a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
								<?php } else { ?>
									<a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
								<?php } ?>
							</td>
                     <td class="center">
                        <?php if ($sort == 'a2s.store_id') { ?>
									<a href="<?php echo $sort_store; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_store; ?></a>
								<?php } else { ?>
									<a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a>
								<?php } ?>
                     </td>
							<td class="center" style="width:105px;"><?php echo $column_status; ?></td>
							<td class="center <?php echo ($sort == 'a.sort_order') ? strtolower($order) : ''; ?>" style="width:65px;"><a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a></td>
							<?php if (isset($haspermission_editOwnArticle) || isset($haspermission_editOtherArticle)) { ?>
								<td class="center" style="width:60px;"><?php echo $column_action; ?></td>
							<?php } ?>
						</tr>
					</thead>
					<tbody>					
						<?php if ($articles) { ?>
							<?php $class = 'odd'; $i = 0; ?>
							<?php foreach ($articles as $article) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); $i = $i + 1; ?>
								<?php $disabled = ($article['status']) ? '' : ' disabled'; ?>
								<tr id="article-row<?php echo $article['article_id']; ?>" class="<?php echo $class . $disabled; ?>">
									<?php if (isset($haspermission_removeArticle) || isset($haspermission_copyArticle)) { ?>
										<td class="center">
											<input type="checkbox" name="selected[]" value="<?php echo $article['article_id']; ?>" <?php echo ($article['selected']) ? 'checked="checked"' : ''; ?> />
										</td>
									<?php } ?>
									<td class="left"><?php echo $article['title']; ?></td>
									<td class="left"><?php echo $article['keyword']; ?></td>									 
									<td class="center"><?php echo $article['created']; ?></td>
									<td class="left">
										<?php foreach ($categories as $category) { ?>
											<?php if (in_array($category['category_id'], $article['category'])) { ?>
												<?php echo $category['name'];?><br>
											<?php } ?>
										<?php } ?>				
									</td>
									<td class="left">
										<?php foreach ($authors as $author) { ?>
											<?php if ($author['author_id'] == $article['author']) { echo $author['name']; } ?>
										<?php } ?>
									</td>
                           <td class="left">
                              <?php foreach ($stores as $store1) { ?>
                                 <?php if (in_array(0, $article['store'])) { ?>
                                    <?php echo $text_default; ?>
                                 <?php } elseif (in_array($store1['store_id'], $article['store'])) { ?>
												<?php echo $store1['name'];?><br>
											<?php } ?>
                              <?php } ?>
                           </td>
									<td class="center">
										<?php if (isset($haspermission_editOwnArticle) && $article['ownArticle'] || isset($haspermission_editOtherArticle) && $article['otherArticle']) { ?>
											<select onchange="editStatus(<?php echo $article['article_id']; ?>)" id="artStatus-<?php echo $article['article_id']; ?>" name="status_<?php echo $article['article_id']; ?>">
												<option value="1" <?php echo ($article['status']) ? 'selected="selected"' : ''; ?> ><?php echo $text_enabled; ?></option>
												<option value="0" <?php echo (!$article['status']) ? 'selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
											</select>
										<?php } else { ?>
											<?php echo ($article['status']) ? $text_enabled : $text_disabled; ?>
										<?php } ?>
									</td>
									<td class="center input_35_center">
										<?php if (isset($haspermission_editOwnArticle) && $article['ownArticle'] || isset($haspermission_editOtherArticle) && $article['otherArticle']) { ?>
											<input onchange="editOrder(<?php echo $article['article_id']; ?>)" id="artOrder-<?php echo $article['article_id']; ?>" type="text" name="sort_order_<?php echo $article['article_id']; ?>" value="<?php echo $article['sort_order']; ?>" tabindex="<?php echo $i; ?>" />
										<?php } else { ?>
											<?php echo $article['sort_order']; ?>
										<?php } ?>
									</td>
									<?php if (isset($haspermission_editOwnArticle) || isset($haspermission_editOtherArticle)) { ?>
										<td class="center">
											<?php if (isset($haspermission_editOwnArticle) && $article['ownArticle'] || isset($haspermission_editOtherArticle) && $article['otherArticle']) { ?>
												<?php foreach ($article['action'] as $action) { ?>
													<a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a>
												<?php } ?>
											<?php } ?>
										</td>
									<?php } ?>
								</tr>
							<?php } ?>
						<?php } else { ?>
							<tr>
								<?php if (isset($haspermission_removeArticle) && (isset($haspermission_editOwnArticle) || isset($haspermission_editOtherArticle))) { ?>
									<td class="center" colspan="9"><?php echo $text_no_results; ?></td>
								<?php } elseif (isset($haspermission_removeArticle) || (isset($haspermission_editOwnArticle) || isset($haspermission_editOtherArticle))) { ?>
									<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
								<?php } else { ?>
									<td class="center" colspan="5"><?php echo $text_no_results; ?></td>
								<?php } ?>
							</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
		
		<div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
	</div>
</div>
<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#filterOptions span').toggle(function(){
		$('.articleFilter').slideToggle();
		$(this).text('<?php echo $text_hide_filter; ?>');
	}, function() {
		$('.articleFilter').slideToggle('fast');
		$(this).text('<?php echo $text_show_filter; ?>');
	});
});

$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});

function filter() {
	url = 'index.php?route=blog/article&token=<?php echo $token; ?>';
		
	var filter_category = $('select[name=\'filter_category\']').attr('value');
	if (filter_category != 'all') {
		url += '&filter_category=' + encodeURIComponent(filter_category);
	}
	
	var filter_author = $('select[name=\'filter_author\']').attr('value');
	if (filter_author != 'all') {
		url += '&filter_author=' + encodeURIComponent(filter_author);
	}	
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	if (filter_status != 'all') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}
   var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
   
   var filter_store = $('select[name=\'filter_store\']').attr('value');
	if (filter_store != 'all') {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}

	location = url;
}

function editStatus(article_id) {
	$.ajax({
		url: 'index.php?route=blog/article/editStatus&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: 'status=' + encodeURIComponent($('select[name="status_' + article_id + '"]').val()) + '&article_id=' + article_id,
		beforeSend: function() {
			$('.success-status' + article_id).remove();
			$('.success, .warning, .error, .attention').remove();
			$('#artStatus-' + article_id).after('<img src="view/image/blog/load.gif" class="loading-status' + article_id + '" />');
		},
		complete: function() {
			$('.loading-status' + article_id).remove();
		},				
		success: function(json) {					
			if (json['success']) {
				$('#artStatus-' + article_id).after('<img src="view/image/blog/check.png" class="success-status' + article_id + '" />');
				
				if (json['status'] == 'disabled') {
					$('#article-row' + article_id).addClass('disabled');
				} else {
					$('#article-row' + article_id).removeClass('disabled');
				}
				
				setTimeout(function(){
					$('.success-status' + article_id).fadeOut(400).delay(350).remove();
				},2500);
			}
		}
	});
}

function editOrder(article_id) {
	$.ajax({
		url: 'index.php?route=blog/article/editOrder&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: 'sort_order=' + encodeURIComponent($('input[name="sort_order_' + article_id + '"]').val()) + '&article_id=' + article_id,
		beforeSend: function() {
			$('.success-order' + article_id).remove();
			$('.attention-order' + article_id).remove();
			$('.success, .warning, .error, .attention').remove();
			$('#artOrder-' + article_id).after('<img src="view/image/blog/load.gif" class="loading-order' + article_id + '" />');
		},
		complete: function() {
			$('.loading-order' + article_id).remove();
		},				
		success: function(json) {					
			if (json['success']) {
				$('#artOrder-' + article_id).after('<img src="view/image/blog/check.png" class="success-order' + article_id + '" />');
				setTimeout(function(){
					$('.success-order' + article_id).fadeOut(400).delay(350).remove();
				},2500);
			}
			if (json['error']) {
				$('#artOrder-' + article_id).after('<img src="view/image/blog/attention.png" class="attention-order' + article_id + '" />');
			}
		}
	});
}
//--></script>

<div class="hidden">
	<img src="view/image/blog/load.gif" />
	<img src="view/image/blog/check.png" />
	<img src="view/image/blog/attention.png" />
</div>
<?php echo $footer; ?>
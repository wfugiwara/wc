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
			<div class="heading">
			  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			
			</div>
			
			<div class="content">
				<div class="box-columns">
					
					<div class="column2">
						
						<div class="tool-icons clearfix" style="width:100%">
							<h4><?php echo $this->language->get('text_quickicons');?></h4>
							<ul>
								<li><a href="<?php echo $manage_category_link;?>"><span class="icon-category icon"></span><span><?php echo $this->language->get('Categories')?></span></a></li>
								<li><a href="<?php echo $add_category_link;?>"><span class="icon-addcategory icon"></span><span><?php echo $this->language->get('Add Category')?></span></a></li>
								<li><a href="<?php echo $manage_blog_link;?>"><span class="icon-blogs icon"></span><span><?php echo $this->language->get('Blogs')?></span></a></li>
								<li><a href="<?php echo $add_blog_link;?>"><span class="icon-blog icon"></span><span><?php echo $this->language->get('Add Blog')?></span></a></li>
								<li><a href="<?php echo $manage_comment_link;?>"><span class="icon-comment icon"></span><span><?php echo $this->language->get('Comment')?></span></a></li>
								<li><a href="<?php echo $modules_setting_link;?>"><span class="icon-modules icon"></span><span><?php echo $this->language->get('Modules Setting')?></span></a></li>
								
							</ul>
						</div>
						<div class="clearfix pav-toolbar" style="width:100%">
							<h4><?php echo $this->language->get('text_modules_setting');?></h4>
							<ul>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavbloglatest','token='.$token);?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_latest');?></span></a>
								</li>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavblogcomment','token='.$token);?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_comment');?></span></a>
								</li>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavblogcategory','token='.$token);?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_category');?></span></a>
								</li>
							</ul>
							<h4><?php echo $this->language->get('text_modules_urls');?></h4>
							<ol>	
								<li>Font Page: <b><?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs";?></b></li>
								<li>Category Page:<b> <?php echo HTTPS_CATALOG."index.php?route=pavblog/category&id=";?></b>CATEGORY_ID</li>
								<li>Item Page: <b><?php echo HTTPS_CATALOG."index.php?route=pavblog/blog/id=";?></b>BLOG_ID</li>
								
								<li>Filter By Tag:<b> <?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs&tag";?></b>TAG_NAME</li>

								
							</ol>
						</div>
					</div>
					
					<div class="column2">
						
						<div  class="htabs">
							<a href="#panel-lastest"><?php echo $this->language->get('Latest Blog');?></a>
							<a href="#panel-mostread"><?php echo $this->language->get('Most Read');?></a>
							<a href="#panel-comments"><?php echo $this->language->get('Latest Comment');?></a>	
						</div>
						<div id="panel-lastest">
							<ul>
							<?php foreach( $newest as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ul>
						</div>
						<div id="panel-mostread">
							<ul>
							<?php foreach( $mostread as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ul>
						</div>
						<div id="panel-comments">
							<ul>
								<?php foreach( $comments as $comment ) { ?>
								<li><a href="<?php echo $this->url->link("module/pavblog/comment","id=".$comment['comment_id']."&token=".$token);?>"><?php echo substr($comment['comment'],0,100);?></a></li>
								<?php } ?>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>	
		
		
 </div>
 
 <script type="text/javascript">
	$('.htabs a').tabs();
 </script>
<?php echo $footer; ?>
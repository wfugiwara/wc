<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
   <?php echo $content_top; ?>   
   <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
   </div>
   <div id="blogArticle" itemscope itemtype="http://schema.org/Article">
      <div class="articleHeader">
         <h1 itemprop="headline"><?php echo $title; ?></h1>
         <?php if ($art_infoName || $art_infoCategory || $art_infoDate || $art_infoComment) { ?>
            <span>
               <?php echo $art_infoName . $art_infoCategory . $art_infoDate; ?>
               <?php if ($art_infoName || $art_infoCategory || $art_infoDate) { ?>. <?php }?>
                <?php if ($art_infoComment) { ?><?php echo $comments; ?>.<?php }?>
            </span>
         <?php }?>
         <a href="<?php echo $link; ?>" itemprop="url" style="display:none" title=""></a>
      </div>      
      <div class="articleContent" itemprop="articleBody">
         <?php echo $description; ?>
      </div>      
      <?php if ($tags || $art_infoUpdate) { ?>
         <div class="tags-update">
            <?php if ($tags) { ?>
               <span class="tags"><b><?php echo $text_tags; ?></b>   <?php echo $tags; ?></span>
            <?php } ?>
            <?php if ($art_infoUpdate) { ?>
               <span class="updateInfo"><?php echo $text_update ?> <span itemprop="dateModified"><?php echo $modified; ?></span></span>
            <?php } ?>
         </div>
      <?php } ?>      
      <?php if ($socMedia || $artRelateds || $prodRelateds) { ?>
         <div class="articleBottom">
            <?php if ($socMedia && !$socMedCode) { ?>
               <div class="addthis_toolbox addthis_default_style">
                  <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
                  <a class="addthis_button_tweet"></a>
                  <a class="addthis_button_google_plusone" g:plusone:size="medium"></a>
                  <a href="<?php echo $this->url->link('feed/blog'); ?>" target="_blank"><img src="catalog/view/theme/default/image/livemarks.png" alt="" width="20" height="20" border="0" /></a>
               </div>
            <?php } else { ?>
               <?php echo $socMedCode; ?>
            <?php } ?>
            <?php if ($artRelateds) { ?>
               <div id="articleRelated">
                  <h4><?php echo $text_related; ?></h4>
                  <?php if (count($artRelateds) <= 5) { ?>
                     <ul>
                     <?php foreach ($artRelateds as $artRelated) { ?>
                        <li><a href="<?php echo $this->url->link('blog/article', 'article_id=' . $artRelated['article_id']); ?>"><?php echo $artRelated['title']; ?></a></li>
                     <?php } ?>
                     </ul>
                  <?php } else { ?>
                     <?php for ($i = 0; $i < count($artRelateds);) { ?>
                        <ul>
                        <?php $j = $i + ceil(count($artRelateds) / 2); ?>
                        <?php for (; $i < $j; $i++) { ?>
                           <?php if (isset($artRelateds[$i])) { ?>
                              <li><a href="<?php echo $this->url->link('blog/article', 'article_id=' . $artRelateds[$i]['article_id']); ?>"><?php echo $artRelateds[$i]['title']; ?></a></li>
                           <?php } ?>
                        <?php } ?>
                        </ul>
                     <?php } ?>
                  <?php } ?>
               </div>
            <?php } ?>
            <?php if ($prodRelateds && $relProductRelated) { ?>
               <div id="productRelated">
                  <h4><?php echo $text_related_product; ?></h4>
                  <div class="box-product">
                  <?php foreach ($prodRelateds as $prodRelated) { ?>
                  <?php if ($prodRelated['status']==1) { ?>
                     <div class="relProduct" style="width:<?php echo (100/$prodPerRow)-0.5 . '%';?>">
                        <?php if ($prodRelated['thumb']) { ?>
                           <div class="image"><a href="<?php echo $prodRelated['href']; ?>"><img src="<?php echo $prodRelated['thumb']; ?>" alt="<?php echo $prodRelated['name']; ?>" /></a></div>
                        <?php } ?>
                        <div class="name"><a href="<?php echo $prodRelated['href']; ?>"><?php echo $prodRelated['name']; ?></a></div>
                        <?php if ($prodRelated['price']) { ?>
                           <div class="price">
                              <?php if (!$prodRelated['special']) { ?>
                                 <?php echo $prodRelated['price']; ?>
                              <?php } else { ?>
                                 <span class="price-old"><?php echo $prodRelated['price']; ?></span> <span class="price-new"><?php echo $prodRelated['special']; ?></span>
                              <?php } ?>
                           </div>
                        <?php } ?>
                        <?php if ($prodRelated['rating']) { ?>
                           <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $prodRelated['rating']; ?>.png" alt="<?php echo $prodRelated['reviews']; ?>" /></div>
                        <?php } ?>
                        <div class="cart"><a onclick="addToCart('<?php echo $prodRelated['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
                     </div>
                  <?php } ?>
                  <?php } ?>
                  </div>
               </div>
            <?php } ?>
         </div>
      <?php } ?>      
      <?php echo $content_bottom; ?>      
      <a name="articleComments"></a>
      <?php if ($commentStatus) { ?>
         <div id="articleComments">
            <h4><?php echo $heading_comment; ?> <span><?php echo $replies; ?></span></h4>
            <div id="comments"></div>            
            <div id="commentRespond">
					<?php if ($guestCommentDisallow) { ?><div class="attention"><?php echo $text_login_comment; ?></div><?php } ?>
					<?php if (!$guestCommentDisallow) { ?>
						<h4 id="commentTitle"><?php echo $text_postComment; ?></h4>
						<h4 id="replyTitle"><?php echo $text_postReply; ?></h4>
						<a id="cancelCommentReply" href="#commentRespond" style="display:none;"><?php echo $text_cancel_reply; ?></a>
						<div id="commentInput">
							<table>
								<tr>
									<td><span class="required">*</span> <b><?php echo $entry_name; ?></b></td>
									<td>
									<?php if ($customerID) { ?>
										<input type="text" name="commentName" value="<?php echo $customerName; ?>" class="inputName" tabindex="1" disabled="disabled" />
									<?php } else { ?>
										<input type="text" name="commentName" value="" class="inputName" tabindex="1" />
									<?php } ?>										
									</td>
								</tr>
								<tr>
									<td><span class="required">*</span> <b><?php echo $entry_email; ?></b><span class="note"><?php echo $text_note_publish; ?></span></td>
									<td>
									<?php if ($customerID) { ?>
										<input type="text" name="commentMail" value="<?php echo $customerMail; ?>" class="inputMail" tabindex="2" disabled="disabled" />
									<?php } else { ?>
										<input type="text" name="commentMail" value="" class="inputMail" tabindex="2"  />
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td>&nbsp;&nbsp;&nbsp;<b><?php echo $entry_site; ?></b><span class="note"><?php echo $text_note_website; ?></span></td>
									<td><input type="text" name="commentSite" value="" tabindex="3" /></td>
								</tr>
								<tr>
									<td><span class="required">*</span> <b><?php echo $entry_comment; ?></b></td>
									<td>
										<textarea name="commentContent" cols="50" rows="8" class="inputContent" tabindex="4" ></textarea>
									</td>
								</tr>
								<?php if ($commentCaptha) { ?>
									<tr>
										<td colspan="2" class="captcha">
											<div class="inputCaptcha">
												<span class="captchaInput">
													<b><?php echo $entry_captcha; ?></b><br />
													<input type="text" name="commentCaptcha" value="" tabindex="5" />
												</span>
												<span class="captchaImage">
													<img id="captcha"  src="index.php?route=blog/article/captcha" alt="" />
												</span>
											</div>											
										</td>
									</tr>
								<?php } ?>
							</table>
							<input type="hidden" name="comment_parent_id" id="parent_id" value="0" />
							<div class="right">
								<a id="submitComment" class="button"><span><?php echo $button_submit; ?></span></a>
							</div>
						</div>
					<?php } ?>
            </div>
         </div>
      <?php } ?>
   </div>
<?php if ($socMedia) { ?>
   <script type="text/javascript">var addthis_config = {"data_track_clickback":true,"ui_click": true};</script>
   <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js<?php if($pubID) { echo '#pubid=' . $pubID; } ?>"></script>
<?php } ?>
<?php if ($commentStatus) { ?>
<script type="text/javascript"><!--
   $('#comments').load('index.php?route=blog/article/comment&article_id=<?php echo $article_id; ?>');
   $('#comments .pagination a').live('click', function() {
      $('#articleComments').slideUp(1000).after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /><?php echo $text_wait; ?></div>');
      $('#comments').load(this.href);
      setTimeout(function(){
         $('.attention').remove();
         $('#articleComments').slideDown(2000)
      },2500);
      return false;
   });	
	<?php if (!$guestCommentDisallow) { ?>
		$('#submitComment').bind('click', function() {
			$.ajax({
				type: 'POST',
				url: 'index.php?route=blog/article/write&article_id=<?php echo $article_id; ?>',
				dataType: 'json',
				data: 'name=' + encodeURIComponent($('input[name=\'commentName\']').val()) + '&email=' + encodeURIComponent($('input[name=\'commentMail\']').val()) + '&website=' + encodeURIComponent($('input[name=\'commentSite\']').val()) + '&content=' + encodeURIComponent($('textarea[name=\'commentContent\']').val()) + '&captcha=' + encodeURIComponent($('input[name=\'commentCaptcha\']').val()) + '&customer_id=' + encodeURIComponent($('input[name=\'customer_id\']').val()) + '&parent_id=' + encodeURIComponent($('input[name=\'comment_parent_id\']').val()),
				beforeSend: function() {
					$('.success, .warning, .error').remove();
					$('#submitComment').attr('disabled', true);
					$('#commentInput').before('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /><?php echo $text_wait; ?></div>');
				},
				complete: function() {
					$('#submitComment').attr('disabled', false);
					$('.attention').remove();
				},
				success: function(json) {
					if (json['error']) {					 
						$('#commentInput').before('<div class="warning">' + json['error']['common'] + '</div>');						
						if (json['error']['name']) {
							$('.inputName').after('<span class="error">' + json['error']['name'] + '</span>');
						}
						if (json['error']['email']) {
							$('.inputMail').after('<span class="error">' + json['error']['email'] + '</span>');
						}
						if (json['error']['content']) {
							$('.inputContent').after('<span class="error">' + json['error']['content'] + '</span>');
						}
						if (json['error']['captcha']) {
							$('.inputCaptcha').after('<span class="error">' + json['error']['captcha'] + '</span>');
								d = new Date();
						$("#captcha").attr("src", "index.php?route=blog/article/captcha/?"+d.getTime());
					
						}
					}					
					if (json['success']) {
						<?php if (!$customerID) { ?>
							$('input[name=\'commentName\']').val('');
							$('input[name=\'commentMail\']').val('');
						<?php } ?>
						$('input[name=\'commentSite\']').val('');
						$('textarea[name=\'commentContent\']').val('');
						$('input[name=\'commentCaptcha\']').val('');					
						$('#commentInput').before('<div class="success">' + json['success'] + '</div>');
						setTimeout(function(){
							$('.success').fadeOut(300).delay(450).remove();
							<?php if ($autoApprove) { ?>
								$('#cancelCommentReply').trigger('click');
								$('#comments').delay(1000).load('index.php?route=blog/article/comment&article_id=<?php echo $article_id; ?>');
							<?php } ?>
						},2500);
					d = new Date();
						$("#captcha").attr("src", "index.php?route=blog/article/captcha/?"+d.getTime());					
					}
				}
			});
		});		
		addComment={
			moveForm:
			function(d,f,i){
				document.getElementById(i).style.display="block";
				var m=this,
				a,
				h=m.I(d),
				b=m.I(i),
				l=m.I("cancelCommentReply"),
				j=m.I("parent_id");				
				if(!h||!b||!l||!j){
					return
				}
				m.respondId=i;
				if(!m.I("tempCommentRespond")){
					a=document.createElement("div");
					a.id="tempCommentRespond";
					a.style.display="none";
					b.parentNode.insertBefore(a,b)
				}
				h.parentNode.insertBefore(b,h.nextSibling);
				j.value=f;
				l.style.display="";
				l.onclick=function(){
					var n=addComment,e=n.I("tempCommentRespond"),o=n.I(n.respondId);
					document.getElementById(i).style.display="";
					if(!e||!o){
						return
					}
					n.I("parent_id").value="0";
					e.parentNode.insertBefore(o,e);
					e.parentNode.removeChild(e);
					this.style.display="none";
					this.onclick=null;
					return false
				};
				try{
					m.I("comment").focus()
				}
				catch(g){}
				return false
			}
			,I:function(a){
				return document.getElementById(a)
			}
		};
	<?php } ?>	
   //--></script>
<?php } ?>
</div>
<?php echo $footer; ?> 
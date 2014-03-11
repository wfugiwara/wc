<div class="box blogModule <?php echo $classSuffix; ?>">
   <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
   <div class="box-content">
      <ul class="recentComments">
      <?php foreach ($comments as $comment) { ?>
         <li>
            <a href="<?php echo $comment['link']; ?>#articleComments" title="<?php echo $comment['name']; ?>" class="avatar"><?php echo $comment['avatar']; ?></a>
            <?php echo $comment['author']; ?> <i><?php echo $text_comment_on; ?></i>
            <a href="<?php echo $comment['link']; ?>#articleComments" title="<?php echo $comment['article']; ?>" class="title"><?php echo $comment['article']; ?></a>
         </li>
      <?php } ?>
      </ul>
   </div>
   <div class="box-footer"><span></span></div>
</div>
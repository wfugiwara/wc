<style>
    ul.dropmenu{
	position: relative;
	margin: 0px;
	padding: 1px 0px 0px 0px;
	display:block;
	font-family:Verdana,Arial,Helvetica,sans-serif;
	font-size: 12px;
}
.dropmenu li{
	position: relative;
	list-style: none;
	margin: 0px;
	boder:1px so
	display: block;
	cursor: point;
        padding-bottom: 1px;
}
.dropmenu li a{
	padding: 10px 30px 9px 15px;
	display: block;
	cursor: point;
	color: <?php echo $config['text_main'];?>;
	text-decoration: none;
	background-color: <?php echo $config['color_Main'];?>;
	font-weight: bold;
	-moz-border-radius-bottomleft: 5px;
	-moz-border-radius-bottomright: 5px;
	-moz-border-radius-topleft: 5px;
	-moz-border-radius-topright: 5px;
}
.dropmenu li a:hover{
	background-color: <?php echo $config['color_sub'];?>;
	color: <?php echo $config['Text_sub'];?>;
}
.dropmenu li span{
	display: block;
	float: right;
	height: 10px;
	width: 10px;
	background:transparent url(./catalog/view/javascript/jquery/dropmenu/plus.png) repeat-x scroll 0 0;
	position: absolute;
	top: 13px;
	right: 10px;
}
.dropmenu li:hover ul, .dropmenu li:hover div{
	display: block;
}
.dropmenu ul, .dropmenu div{
	position: absolute;
	display: none;
	width: 162px;
	left: 155px;
	top: 0px;
	margin: 0px;
	padding: 0px;
        box-shadow: 3px 3px 3px <?php echo $config['color_sub'];?>;
}
.dropmenu li div ul{
	border: none;
	background: none;
	position: relative;
	display: block;
	left: 0px;
}
.dropmenu ul li{
	border: 0;
	float: none;
}

.dropmenu div ul{
	position: relative;
	display: block;
}
.dropmenu li div{
	background-color: #cccccc;
	padding: 5px;
	display: none;
	position: absolute;
}
</style>
<script type="text/javascript" src="catalog/view/javascript/jquery/dropmenu/dropmenu.js"></script>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div style="padding:2px;" class="box-content">
    <div class="">
      <ul id="nav-one" class="dropmenu">
        <?php foreach ($categories as $category) { ?>
        <li>
          <?php if ($category['category_id'] == $category_id) { ?>
          <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
          <?php } else { ?>
          <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
          <?php } ?>
          <?php if ($category['children']) { ?>
          <ul>
            <?php foreach ($category['children'] as $child) { ?>
            <li>
              <?php if ($child['category_id'] == $child_id) { ?>
              <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
              <?php } else { ?>
              <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
      </ul>
    </div>
  </div>
</div>
<script>
$(document).ready(function(){
	$("#nav-one").dropmenu({openAnimation: "size",
							closeAnimation: "size"});
});
</script>
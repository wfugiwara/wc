<?php
  $i = 65;
  $break = "";
?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">    
	  <div class="box-alphabeticallyproducts">      		  
		  <div valign="top">		    
		    <?php $i = 65; ?>
		    <table>
		      <tr>
			<td>			  
			    <a href="<?php echo $href; ?>"><?php echo '&nbsp;&nbsp;'.chr(35).'&nbsp;&nbsp;'; ?></a>
			</td>
		    <?php while($i<91){ ?>
			<td>
			  <a href="<?php echo $href.chr($i); ?>"><?php echo '&nbsp;&nbsp;'.chr($i).'&nbsp;&nbsp;'; ?></a>
			</td>
		    <?php
		      $i++;
		      ($i%5==4)?$break = "</tr><tr>":$break="";
		      echo $break;
		      }
		    ?>
		      </tr>
		    </table>
		  </div>		  		  
		  <div>&nbsp;</div>      
	  </div>    
  </div>
</div>

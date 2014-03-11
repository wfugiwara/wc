<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
  	<div style="text-align:center;">
  	<a href="http://www.correios.com.br"><img src="http://www.correios.com.br/_imag/0_logo10.gif" border="0" alt="Correios" /></a>
    
    <form method="get" action="http://websro.correios.com.br/sro_bin/txect01$.QueryList?" name="rastreamento" id="rastreamento" target="_blank" >
	  <div style="text-align: left;"><?php echo $text_tip; ?></div>
	  <textarea name="P_COD_UNI" rows="2" style="width: 96%;"></textarea>
	  <small><?php echo $text_tip2; ?></small>
	  <input type="hidden" name="P_LINGUA" value="001" />
	  <input type="hidden" name="P_TIPO" value="001" />
	  
      <div style="margin-top: 5px;">
      <a class="button" onclick="$('#rastreamento').submit();" title="<?php echo $text_button; ?>"><span><?php echo $text_button; ?></span></a>
      </div>	  
    </form> 
    </div>
  </div>
</div>

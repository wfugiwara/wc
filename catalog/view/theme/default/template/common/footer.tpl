<div id="footer">
  <?php if ($informations) { ?>
  <div class="column">
    <h3><?php echo $text_information; ?></h3>
    <ul>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <?php } ?>
  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="<?php echo $contact; ?>">Fale Conosco</a></li>
      <li><a href="agende-um-servico">Agende um Serviço</a></li>
      <li><a href="trabalhe-na-wecare-auto">Trabalhe na WeCare Auto</a></li>
      <li><a href="seja-um-revendedor-wecare-auto">Seja um revendedor WeCare Auto</a></li>
    </ul>
  </div>
  <div class="column">
    <h3>Nossos Pacotes</h3>
    <ul>
      <li><a href="index.php?route=information/tellafriend">Indique para um Amigo</a></li>
      <li><a href="para-voce">Para Você</a></li>
      <li><a href="para-sua-empresa">Para sua Empresa</a></li>
      <li><a href="meu-pacote-ideal">Descubra qual o pacote ideal para você</a></li>
    </ul>
  </div>
  <div class="column">
    <h3><?php echo $text_account; ?></h3>
    <ul>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
    </ul>
  </div>
</div>
<div class="infoRodape">
	<img src="image/tipos-cartao.gif" />
    <!--- Secure Site Seal - DO NOT EDIT --->
<span id="ss_img_wrapper_115-55_image_en"><a href="https://www.alphassl.com/ssl-certificates/wildcard-ssl.html" target="_blank" title="SSL Certificates"><img alt="Wildcard SSL Certificates" border=0 id="ss_img" src="//seal.alphassl.com/SiteSeal/images/alpha_noscript_115-55_en.gif" title="SSL Certificate"></a></span><script type="text/javascript" src="//seal.alphassl.com/SiteSeal/alpha_image_115-55_en.js"></script>
<!--- Secure Site Seal - DO NOT EDIT --->
</div>

<!--<div id="powered"><?php echo $powered; ?></div>-->

</div>
</body></html>
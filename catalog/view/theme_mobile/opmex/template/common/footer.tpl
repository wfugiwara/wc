  <?php if ($informations) { ?>
<ul data-role="listview" id="more_info" data-theme="a">
<li data-role="list-divider">Informação</li>
 <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>" rel="external"><?php echo $information['title']; ?></a></li>
     <?php } ?>
     </ul>
     <?php } ?>
<ul data-role="listview" id="more_customer_service" data-theme="a">
<li data-role="list-divider">Atendimento</li>
 	  <li><a href="<?php echo $contact; ?>" rel="external">Fale Conosco</a></li>
      <li><a href="agende-um-servico" rel="external">Agende um Serviço</a></li>
      <li><a href="trabalhe-na-wecare-auto" rel="external">Trabalhe na WeCare Auto</a></li>
      <li><a href="seja-um-revendedor-wecare-auto" rel="external">Seja um revendedor</a></li>
      
      <!--<li><a href="<?php echo $contact; ?>" rel="external" ><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $return; ?>" rel="external" ><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>" rel="external" ><?php echo $text_sitemap; ?></a></li>-->
   </ul>  
<ul data-role="listview" id="more_extras" data-theme="a">
<li data-role="list-divider">Nossos Pacotes</li>
 	  <!--<li><a href="index.php?route=information/tellafriend" rel="external">Indique para um Amigo</a></li>-->
      <li><a href="para-voce" rel="external">Para Você</a></li>
      <li><a href="para-sua-empresa" rel="external">Para sua Empresa</a></li>
      <!--<li><a href="meu-pacote-ideal" rel="external">Descubra qual o pacote ideal para você</a></li>-->
      <!--<li><a href="<?php echo $manufacturer; ?>" rel="external" ><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $voucher; ?>" rel="external" ><?php echo $text_voucher; ?></a></li>
      <li><a href="<?php echo $affiliate; ?>" rel="external" ><?php echo $text_affiliate; ?></a></li>
      <li><a href="<?php echo $special; ?>" rel="external" ><?php echo $text_special; ?></a></li>-->
	  <?php echo $language; ?>
  	  <?php echo $currency; ?>
   </ul>  
<ul data-role="listview" id="more_account" data-theme="a">
<li data-role="list-divider">Cadastro</li>
 <li><a href="<?php echo $account; ?>" rel="external" ><?php echo $text_account; ?></a></li>
 <?php if (isset($logged)) { ?>
 <li><a href="index.php?route=account/logout" rel="external" ><?php echo $text_logout; ?></a></li>
 <?php } ?>
      <li><a href="<?php echo $order; ?>" rel="external" ><?php echo $text_order; ?></a></li>
      <!--<li><a href="<?php echo $wishlist; ?>" rel="external" ><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>" rel="external" ><?php echo $text_newsletter; ?></a></li>-->
   </ul>          
<div data-role="footer" data-theme="c">

<div data-role="navbar">
			<ul>
				<li><a id="click_info" data-icon="info">Informação</a></li>
                <li><a id="click_customer_service" data-icon="gear">Atendimento</a></li>
				<li><a id="click_extras" data-icon="plus">Nossos Pacotes</a></li>
				<li><a id="click_account" data-icon="grid">Cadastro</a></li>
				
                <!--<li><a href="<?php echo $contact; ?>" data-icon="contact" rel="external">Contact</a></li>-->
            </ul>
                     
		</div>
        <div id="powered" style="text-align:center"><?php echo $powered; ?></div>
</div>
</div>

<div data-role="page" id="agree_page"> 
  <div data-role="content"> 
	<div id="agree_page_text"></div>
  	<p><a href="#page" data-role="button" data-theme="a">back</a></p>
  </div>
</div>
<div data-role="page" id="privacy_page"> 
  <div data-role="content"> 
	<div id="privacy_page_text"></div>
  	<p><a href="#page" data-role="button" data-theme="a">back</a></p>
  </div>
</div>
</body></html>
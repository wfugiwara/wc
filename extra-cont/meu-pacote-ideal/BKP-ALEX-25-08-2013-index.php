<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Agende um Serviço - WeCare Auto</title>

<!--[CSS PADRAO]-->
<link href="css/reset.css" rel="stylesheet" type="text/css" media="screen">
<link href="css/formulario.css" rel="stylesheet" type="text/css" media="screen">

<script type="text/javascript" src="jquery-1.2.3.pack.js"></script>
<script type="text/javascript" src="jquery.idTabs.min.js"></script>

</head>

<body>

<div id="usual1" class="usual"> 
    <ul> 
        <li><a href="#tab1" class="selected">Pessoa Física</a></li> 
        <li><a href="#tab2">Pessoa Jurídica</a></li> 
	</ul> 
    
    <!-- pessoa física -->
    <div id="tab1">
        <p><span class="nPerg">01</span> - Possui mais de um veículo na residência?</p><br />
        <p><input name="pergunta01" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta01" type="radio" value="nao" /> Não</p>
        <hr />
        <p><span class="nPerg">02</span> - É médico?</p><br />
        <p><input name="pergunta02" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta02" type="radio" value="nao" /> Não</p>
        <hr />
        <p><span class="nPerg">03</span> - Viaja mais de 3 vezes ao mês a trabalho?</p><br />
        <p><input name="pergunta03" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta03" type="radio" value="nao" /> Não</p>
        <hr />
        <p><span class="nPerg">04</span> - Qual a sua idade?</p><br />
        <p><input name="pergunta04" type="radio" value="menos-30" /> menos de 30 &nbsp;&nbsp;&nbsp;<input name="pergunta04" type="radio" value="30-ou-mais" /> 30 ou mais</p>
        <hr />
        <p><span class="nPerg">05</span> - Pretende trocar seu carro no próximo ano?</p><br />
        <p><input name="pergunta05" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta05" type="radio" value="nao" /> Não</p>
        <hr />
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="220"><strong>Conheça nossa sugestão de pacote ideal para você:</strong></td>
            <td><a href="#stop" class="verResultado">Ver resultado</a></td>
          </tr>
        </table>
    </div><!-- fim pessoa física-->
    
    <!-- pessoa jurídica -->
    <div id="tab2">
    	<p><span class="nPerg">01</span> - A principal funcão da contratação do serviço será para:</p><br />
        <p><input name="pergunta01" type="checkbox" value="somente-garantir" /> <strong>A)</strong> Somente garantir uma gestão de frotas mais eficiente e menos custosa<br /><input name="pergunta01" type="checkbox" value="alem-disso" /> <strong>B)</strong> Além disso, oferecer um serviço diferenciado aos altos executivos da empresa</p>
        <hr />
        <p><span class="nPerg">02</span> - Possui um motoristas fixos disponíveis para cuidar da frota instalada, levar e buscar os carros para manutenção, inspeção veicular, revisões e etc?</p><br />
        <p><input name="pergunta02" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta02" type="radio" value="nao" /> Não</p>
        <hr />
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="220"><strong>Conheça nossa sugestão de pacote ideal para você:</strong></td>
            <td><a href="#stop" class="verResultado">Ver resultado</a></td>
          </tr>
        </table>
    </div> <!-- fim pessoa jurídica -->
</div> 
 
<script type="text/javascript"> 
  $("#usual1 ul").idTabs(); 
</script>


</body>
</html>
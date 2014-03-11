<?
ob_start();

	IF( $_POST['tipo'] == 'pessoa_fisica' ){

		$LinkPessoaFisica01 = "http://www.wecareauto.com.br/para-voce/wecare-familia";
		$LinkPessoaFisica02 = "http://www.wecareauto.com.br/para-voce/wecare-medico";
		$LinkPessoaFisica03 = "http://www.wecareauto.com.br/para-voce/wecare-executivo";
		$LinkPessoaFisica04 = "http://www.wecareauto.com.br/para-voce/wecare-plus";
		$LinkPessoaFisica05 = "http://www.wecareauto.com.br/para-voce/wecare-day-by-day";
		$LinkPessoaFisica06 = "http://www.wecareauto.com.br/para-voce/wecare-plus";
		$LinkPessoaFisica07 = "http://www.wecareauto.com.br/para-voce/wecare-plus";

		// 01
		if( ( $_POST['pergunta01'] == 'sim' ) AND ( $_POST['pergunta02'] == 'sim' OR $_POST['pergunta02']  == 'nao' ) AND ( $_POST['pergunta03'] == 'sim' OR $_POST['pergunta03'] == 'nao' ) AND ( $_POST['pergunta04'] == 'menos-30' OR $_POST['pergunta04'] == '30-ou-mais' ) AND ( $_POST['pergunta05'] == 'sim' OR $_POST['pergunta05']   == 'nao' ) ){
			
			header('Location: ' . $LinkPessoaFisica01 );
		
		}
		
		// 02
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'sim' ) AND ( $_POST['pergunta03'] == 'sim' OR $_POST['pergunta03'] == 'nao' )  AND ( $_POST['pergunta04'] == 'menos-30' OR $_POST['pergunta04'] == '30-ou-mais' ) AND ( $_POST['pergunta05'] == 'sim' OR $_POST['pergunta05']   == 'nao' ) ){

			header('Location: ' . $LinkPessoaFisica02 );
			
		}	
		
		// 03
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'nao' ) AND ( $_POST['pergunta03'] == 'sim' ) AND ( $_POST['pergunta04'] == 'menos-30' OR $_POST['pergunta04'] == '30-ou-mais' ) AND (  $_POST['pergunta05'] == 'sim' OR $_POST['pergunta05'] == 'nao' ) ){

			header('Location: ' . $LinkPessoaFisica03 );
			
		}	

		// 04
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'nao' ) AND ( $_POST['pergunta03'] == 'nao' ) AND ( $_POST['pergunta04'] == 'menos-30' ) AND ( $_POST['pergunta05'] == 'sim' ) ){

			header('Location: ' . $LinkPessoaFisica04 );
			
		}

		// 05
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'nao' ) AND ( $_POST['pergunta03'] == 'nao' ) AND ( $_POST['pergunta04'] == 'menos-30' ) AND ( $_POST['pergunta05'] == 'nao' ) ){

			header('Location: ' . $LinkPessoaFisica05 );
			
		}	
		
		// 06
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'nao' ) AND ( $_POST['pergunta03'] == 'nao' ) AND ( $_POST['pergunta04'] == '30-ou-mais' ) AND ( $_POST['pergunta05'] == 'sim' ) ){

			header('Location: ' . $LinkPessoaFisica06 );
			
		}
		
		// 07
		if( ( $_POST['pergunta01'] == 'nao' ) AND ( $_POST['pergunta02'] == 'nao' ) AND ( $_POST['pergunta03'] == 'nao' ) AND ( $_POST['pergunta04'] == '30-ou-mais' ) AND ( $_POST['pergunta05'] == 'nao' ) ){

			header('Location: ' . $LinkPessoaFisica07 );
			
		}		

	}elseif( $_POST['tipo'] == 'pessoa_juridica' ) {
	
	
		$LinkPessoaJuridica01 = "http://www.wecareauto.com.br/para-sua-empresa/wecare-private";
		$LinkPessoaJuridica02 = "http://www.wecareauto.com.br/para-sua-empresa/wecare-comfort";
		$LinkPessoaJuridica03 = "http://www.wecareauto.com.br/para-sua-empresa/wecare-fit";
		
		if( ( $_POST['pergunta07'] == 'alem-disso' ) AND ( $_POST['pergunta06'] == 'sim' OR $_POST['pergunta06'] == 'nao' ) ){
			
			header('Location: ' . $LinkPessoaJuridica01 );
		
		}

		if( ( $_POST['pergunta07'] == 'somente-garantir' ) AND ( $_POST['pergunta06'] == 'sim' ) ){
			
			header('Location: ' . $LinkPessoaJuridica02 );
		
		}

		if( ( $_POST['pergunta07'] == 'somente-garantir' ) AND ( $_POST['pergunta06'] == 'nao' ) ){
			
			header('Location: ' . $LinkPessoaJuridica03 );
		
		}		
	
	}

?>
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
<script>
	function ValidaCamposPessoaFisica()
	{
	
		LiberaFormulario = 0;
	
		if( ( document.getElementById('pergunta01[S]').checked == false ) && ( document.getElementById('pergunta01[N]').checked == false ) ){
		   
			alert('Pergunta "01  - Possui mais de um veículo na residência?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}
		
		if( ( document.getElementById('pergunta02[S]').checked == false ) && ( document.getElementById('pergunta02[N]').checked == false ) ){
		   
			alert('Pergunta "02 - É médico?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}
		
		if( ( document.getElementById('pergunta03[S]').checked == false ) && ( document.getElementById('pergunta03[N]').checked == false ) ){
		   
			alert('Pergunta "03 - Viaja mais de 3 vezes ao mês a trabalho?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}

		if( ( document.getElementById('pergunta04[S]').checked == false ) && ( document.getElementById('pergunta04[N]').checked == false ) ){
		   
			alert('Pergunta "04 - Qual a sua idade?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}

		if( ( document.getElementById('pergunta05[S]').checked == false ) && ( document.getElementById('pergunta05[N]').checked == false ) ){
		   
			alert('Pergunta "05 - Pretende trocar seu carro no próximo ano?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}
		
		if ( LiberaFormulario == 0 ) {
		
			document.getElementById("pessoa_fisica").submit();
			
		}
		
	}
	
	function ValidaCamposPessoaJuridica()
	{
	
		LiberaFormulario = 0;	
		
		if( ( document.getElementById('pergunta07[S]').checked == false ) && ( document.getElementById('pergunta07[N]').checked == false ) ){
		   
			alert('Pergunta "01 - A principal funcão da contratação do serviço será para:" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}

		if( ( document.getElementById('pergunta06[S]').checked == false ) && ( document.getElementById('pergunta06[N]').checked == false ) ){
		   
			alert('Pergunta "02 - Possui um motoristas fixos disponíveis para cuidar da frota instalada, levar e buscar os carros para manutenção, inspeção veicular, revisões e etc?" é obrigatória!!!');
			LiberaFormulario = 1;
			return false;
		   
		}
		
		if ( LiberaFormulario == 0 ) {
		
			document.getElementById("pessoa_juridica").submit();
			
		}		
		
	}	
</script>
</head>

<body>

<div id="usual1" class="usual"> 
    <ul> 
        <li><a href="#tab1" class="selected">Pessoa Física</a></li> 
        <li><a href="#tab2">Pessoa Jurídica</a></li> 
	</ul> 
    
    <!-- pessoa física -->
    <div id="tab1">
		<form name="pessoa_fisica" id="pessoa_fisica" action="" method="post" target="_parent">
			<p><span class="nPerg">01</span> - Possui mais de um veículo na residência?</p><br />
			<p><input name="pergunta01" id="pergunta01[S]" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta01"  id="pergunta01[N]" type="radio" value="nao" /> Não</p>
			<hr />
			<p><span class="nPerg">02</span> - É médico?</p><br />
			<p><input name="pergunta02" id="pergunta02[S]" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta02" id="pergunta02[N]" type="radio" value="nao" /> Não</p>
			<hr />
			<p><span class="nPerg">03</span> - Viaja mais de 3 vezes ao mês a trabalho?</p><br />
			<p><input name="pergunta03" id="pergunta03[S]" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta03" id="pergunta03[N]" type="radio" value="nao" /> Não</p>
			<hr />
			<p><span class="nPerg">04</span> - Qual a sua idade?</p><br />
			<p><input name="pergunta04" id="pergunta04[S]" type="radio" value="menos-30" /> menos de 30 &nbsp;&nbsp;&nbsp;<input name="pergunta04" id="pergunta04[N]" type="radio" value="30-ou-mais" /> 30 ou mais</p>
			<hr />
			<p><span class="nPerg">05</span> - Pretende trocar seu carro no próximo ano?</p><br />
			<p><input name="pergunta05" id="pergunta05[S]" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta05" id="pergunta05[N]" type="radio" value="nao" /> Não</p>
			<hr />
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="220"><strong>Conheça nossa sugestão de pacote ideal para você:</strong></td>
				<td><a href="#stop" Onclick="return ValidaCamposPessoaFisica();" class="verResultado">Ver resultado</a></td>
			  </tr>
			</table>
			<input type="hidden" name="tipo" id="tipo" value="pessoa_fisica">
		</form>
    </div><!-- fim pessoa física-->
    
    <!-- pessoa jurídica -->
    <div id="tab2">
		<form name="pessoa_juridica" id="pessoa_juridica" action="" method="post" target="_parent">
			<p><span class="nPerg">01</span> - A principal funcão da contratação do serviço será para:</p><br />
			<p><input name="pergunta07" id="pergunta07[S]" type="radio" value="somente-garantir" /> <strong>A)</strong> Somente garantir uma gestão de frotas mais eficiente e com menor custo.<br /><input name="pergunta07"  id="pergunta07[N]" type="radio" value="alem-disso" /> <strong>B)</strong> Além disso, oferecer um serviço diferenciado aos principais executivos da empresa</p>
			<hr />
			<p><span class="nPerg">02</span> - Pretende renovar veículos da sua frota no próximo ano?</p><br />
			<p><input name="pergunta06" id="pergunta06[S]" type="radio" value="sim" /> Sim &nbsp;&nbsp;&nbsp;<input name="pergunta06" id="pergunta06[N]" type="radio" value="nao" /> Não</p>
			<hr />
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="220"><strong>Conheça nossa sugestão de pacote ideal para você:</strong></td>
				<td><a href="#stop" Onclick="return ValidaCamposPessoaJuridica();" class="verResultado">Ver resultado</a></td>
			  </tr>
			</table>
			<input type="hidden" name="tipo" id="tipo" value="pessoa_juridica">
		</form>
    </div> <!-- fim pessoa jurídica -->
</div> 
 
<script type="text/javascript"> 
  $("#usual1 ul").idTabs(); 
</script>


</body>
</html>
<?php
include("dados.php");
//acões de loja
$erro = 'nao';
if(isset($_POST['acao']) && isset($_POST['email']) && isset($_POST['senha']) && !empty($_POST['email']) && !empty($_POST['senha'])){
$email_user = $_POST['email'];
$query = $db->query("SELECT * FROM `".DB_PREFIX."user` WHERE `email` = '".$email_user."' AND user_group_id = 1 LIMIT 1");
$res = $query->row;
if($res && sizeof($res)>=1){
$senha_user = $db->escape(sha1($res['salt'] . sha1($res['salt'] . sha1($_POST['senha']))));
if($senha_user==$res['password'] && $res['email']==$email_user){
$erro = 'nao';
$_SESSION['braspagapi_email'] = $email_user;
$_SESSION['braspagapi_id'] = $res['user_id'];
@header("Location: pedidos.php");
}else{
$erro = 'sim';
}
}else{
$erro = 'sim';
}
}
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="js/bootstrap.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body>

    <div class="container">

      <form class="form-signin" method="post" action="index.php">
<?php if($erro=='sim'){?>
<div class="alert">
  <button type="button" class="close" data-dismiss="alert">X</button>
  <strong>Ops!</strong> Acesso negado ou invalido!
</div>
<?php } ?>
	  <input type="hidden" value="login" name="acao">
        <h2 class="form-signin-heading">Braspag - API</h2>
        <input type="text" name="email" class="input-block-level" placeholder="E-mail" required>
        <input type="password" name="senha" class="input-block-level" placeholder="Senha" required>
		
        <button class="btn btn-large btn-primary" type="submit">Login</button>
      </form>

    </div> <!-- /container -->

  </body>
</html>

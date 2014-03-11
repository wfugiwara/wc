<?php
/*
echo "teste deploy";
$numero = "000034343";
echo $numero;
*/
date_default_timezone_set('America/Araguaina');
/*ini_set("include_path", ".:/vservers/user/htdocs/wecare/PHPMailer/");*/
$root = $_SERVER['DOCUMENT_ROOT'];
ini_set('include_path', $root."/PHPMailer/");

require_once("class.phpmailer.php");
$mailer = new PHPMailer();
$mailer->IsSMTP();
$mailer->Host = 'smtp.office365.com'; //'mail.example.com';
$mailer->SMTPAuth = true;
$mailer->Username = 'admin@wecareauto.com.br'; //'root@example.com';
$mailer->Password = 'wecare@2013';
$mailer->SMTPSecure = 'tls';
$mailer->FromName = 'Ricardo Teixeira <ricardo.teixeira01@gmail.com>';
$mailer->From = 'admin@wecareauto.com.br';
$mailer->AddCustomHeader('Reply-to:ricardo.teixeira01@gmail.com');
$mailer->AddAddress('ricardo@netsoftbi.com','Ricardo');
$mailer->AddAddress('faleconosco@wecareauto.com.br','fale conosco');
$mailer->Subject = 'Teste email - fale conosco';
$mailer->Body = 'Cintia, acho que acertei, quando voce der o reply ele vai para o email do cliente.';

if(!$mailer->Send())
{
echo "Message was not sent";
echo "Mailer Error: " . $mailer->ErrorInfo;
exit;
}

?>
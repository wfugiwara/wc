<?php
include("dados.php");
include("../app/braspag/loja5.php");
$email_lay = EmailPagoBraspag(1001);
EnviarEmailBrasPag($config,'suportedaloja@gmail.com','teste',$email_lay);
?>
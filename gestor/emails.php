<?php
function EnviarEmailBrasPag($config,$para,$titulo,$mensagem){
$mail = new Mail();
$mail->protocol = $config->get('config_mail_protocol');
$mail->parameter = $config->get('config_mail_parameter');
$mail->hostname = $config->get('config_smtp_host');
$mail->username = $config->get('config_smtp_username');
$mail->password = $config->get('config_smtp_password');
$mail->port = $config->get('config_smtp_port');
$mail->timeout = $config->get('config_smtp_timeout');				
$mail->setTo($para);
$mail->setFrom($config->get('config_email'));
$mail->setSender($config->get('config_name'));
$mail->setSubject(html_entity_decode($titulo, ENT_QUOTES, 'UTF-8'));
$mail->setHtml($mensagem);
$mail->send();
}
function EmailPagoBraspag($pedido){
global $lista_de_status_braspag;
$dados_pedido = ItensPedidoBrasPag($pedido);
$pedido_loja = TotalPedidoBrasPag($pedido);
$pedido_b = DetalhesPedidoBrasPag($pedido);
$html = "Ola, <b>".$pedido_loja['firstname']." ".$pedido_loja['lastname']."</b><br>";
$html .= "Sua assinatura <b>#".$pedido."</b> recebeu uma nova atualiza&ccedil;&atilde;o de status para <b>".$lista_de_status_braspag[$pedido_b['statusPedido']]."</b><br><br>";
$html .= "<b>Historico de Fatura(s):</b><br>";
$html .= "<table border='1' width='700'>";
$html .= "<tr><td width='100'><b>Fatura#</b></td><td width='150'><b>Data a pagar/pago</b></td><td><b>Status</b></td><td width='100'><b>Pago</b></td></tr>";
foreach($dados_pedido AS $item){
$html .= "<tr><td>".$item['numPag']."</td><td>".$item['dataDebito']."</td><td>".$lista_de_status_braspag[$item['statusPagamento']]."</td><td>".$item['pago']."</td></tr>";
}
$html .= "</table>";
$html .= "<br>Dica: Mantenha sempre suas mensalidades e pagamentos em dia para manter seu servi&ccedil;o corretamente.<br>";
$html .= "Para duvidas ou informa&ccedil;&otilde;es entre em contato.<br>";
return $html;
}
?>
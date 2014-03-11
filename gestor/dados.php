<?php
@session_start();
// Configuration
require_once('../config.php');
// Startup
require_once(DIR_SYSTEM . 'startup.php');
// Application Classes
require_once(DIR_SYSTEM . 'library/customer.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/tax.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');
require_once(DIR_SYSTEM . 'library/cart.php');
require_once(DIR_SYSTEM . 'library/mail.php');
// Registry
$registry = new Registry();
// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);
// Config
global $config;
$config = new Config();
$registry->set('config', $config);
// Database 
global $db;
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);
// Settings
$query = $db->query("SELECT * FROM `".DB_PREFIX."setting`");
foreach ($query->rows as $setting) {
	$config->set($setting['key'], $setting['value']);
}
foreach ($query->row as $key => $value) {
	$config->set('config_' . $key, $value);
}
//meios
$meios_braspag = array(0=>'Amex',1=>'Visa',2=>'Amex',3=>'RedeCard',28=>'Visa',30=>'Mastercard',31=>'Diners',34=>'Visa',41=>'Hipercard',71=>'Visa',120=>'Mastercard',33=>'Boleto Itau',35=>'Boleto Unibanco',36=>'Boleto Bradesco',37=>'Boleto Itau',40=>'Boleto BB',6=>'Debito Bradesco',7=>'Debito BB',9=>'Debito CEF',17=>'Debito HSBC',18=>'Debito Itau',32=>'Debito Bradesco',38=>'Debito Itau');
global $lista_de_status_braspag;
$lista_de_status_braspag = array(0=>'Pagamento confirmado',1=>'Pagamento Autorizado',2=>'Negado, vai tentar novamente',3=>'Negado, nao agendar retentativa',4=>'Negado, nao tentar novamente',5=>'Negado, nao tentar novamente, pedido desabilitado',6=>'Aguardando resposta',7=>'Desqualificado',8=>'Erro interno');
$cores_braspag = array(0=>'success',1=>'info',2=>'warning',3=>'important',4=>'important',5=>'important',6=>'inverse',7=>'important',8=>'important');
//function
function QualPeriodicidadeBraspag($per){
if($per==1){
return 'Mensal (12x)';
}elseif($per==6){
return 'Semestral (2x)';
}else{
return 'Anual (1x)';
}
}
//chama os layouts de email
include('emails.php');
?>
<?php
// Configuration
require_once('../../config.php');
// Startup
require_once(DIR_SYSTEM . 'startup.php');
// Application Classes
require_once(DIR_SYSTEM . 'library/customer.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/tax.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');
require_once(DIR_SYSTEM . 'library/cart.php');
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
?>
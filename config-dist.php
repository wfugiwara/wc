<?php

$dir = getcwd();
$path = '';

// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['SERVER_NAME'] . '/' . $path);

// HTTPS
define('HTTPS_SERVER', 'http://' . $_SERVER['SERVER_NAME'] . '/' . $path);

// DIR
define('DIR_APPLICATION', $dir . '/catalog/');
define('DIR_SYSTEM', $dir . '/system/');
define('DIR_DATABASE', $dir . '/system/database/');
define('DIR_LANGUAGE', $dir . '/catalog/language/');
define('DIR_TEMPLATE', $dir . '/catalog/view/theme/');
define('DIR_CONFIG', $dir . '/system/config/');
define('DIR_IMAGE', $dir . '/image/');
define('DIR_CACHE', $dir . '/system/cache/');
define('DIR_DOWNLOAD', $dir . '/download/');
define('DIR_LOGS', $dir . '/system/logs/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'DB_USER');
define('DB_PASSWORD', 'DB_PASS');
define('DB_DATABASE', 'DB_NAME');
define('DB_PREFIX', '');
?>

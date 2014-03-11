<?php

chdir(__DIR__ . '/../');
$dir = getcwd();
$path = '';

// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['SERVER_NAME'] . '/' . $path . 'admin/');
define('HTTP_CATALOG', 'http://' . $_SERVER['SERVER_NAME'] . '/' . $path);

// HTTPS
define('HTTPS_SERVER', 'http://' . $_SERVER['SERVER_NAME'] . '/admin/');
define('HTTPS_CATALOG', 'http://' . $_SERVER['SERVER_NAME'] . '/');

// DIR
define('DIR_APPLICATION', $dir . '/admin/');
define('DIR_SYSTEM', $dir . '/system/');
define('DIR_DATABASE', $dir . '/system/database/');
define('DIR_LANGUAGE', $dir . '/admin/language/');
define('DIR_TEMPLATE', $dir . '/admin/view/template/');
define('DIR_CONFIG', $dir . '/system/config/');
define('DIR_IMAGE', $dir . '/image/');
define('DIR_CACHE', $dir . '/system/cache/');
define('DIR_DOWNLOAD', $dir . '/download/');
define('DIR_LOGS', $dir . '/system/logs/');
define('DIR_CATALOG', $dir . '/catalog/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'DB_USER');
define('DB_PASSWORD', 'DB_PASS');
define('DB_DATABASE', 'DB_NAME');
define('DB_PREFIX', '');
?>


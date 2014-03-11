<?php
include("dados.php");
unset($_SESSION['braspagapi_email']);
unset($_SESSION['braspagapi_id']);
@header("Location: index.php");
?>
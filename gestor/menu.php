
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="pedidos.php">BRASPAG</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="pedidos.php">Pedidos</a></li>
			  <li class="active"><a href="logs.php">Logs API</a></li>
              <li class="active"><a href="javascript:void(0);">Ola, <?php echo $_SESSION['braspagapi_email'];?></a></li>
			  <li class="active"><a href="javascript:void(0);">&Uacute;ltima consulta Braspag: <?php echo @$dados_cron['data_hora'];?></a></li>
            </ul>
            <form class="navbar-form pull-right">
              <a href="sair.php" class="btn">SAIR</a>
            </form>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
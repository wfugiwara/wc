<?php 
class ControllerAccountMeusVouchers extends Controller { 
	private $error = array();

	public function index() {
		$this->language->load('account/voucher');
		$this->load->model('account/order');
		
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}
		
		$this->data['cupons'] = $this->getCupons($this->customer->getId());

		$this->document->setTitle("Meus Vouchers");

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => "Meus Vouchers",
			'href'      => $this->url->link('account/meus_vouchers', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
				
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_description'] = $this->language->get('text_description');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
			
		$this->data['action'] = $this->url->link('account/voucher', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/meus_voucher.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/meus_voucher.tpl';
		} else {
			$this->template = 'default/template/account/meus_voucher.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);
				
		$this->response->setOutput($this->render());		
  	}
	
	public function imprimir(){
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/gera_voucher', '', 'SSL');
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}
		$cup = $this->getCupon((int)$_GET['cupom']);
		$nome = $this->customer->getFirstName()." ".$this->customer->getLastName();
		$logo = $this->config->get('voucherparceiros_logo');
	?>
	
	<!DOCTYPE html>
<html>
  <head>
    <title>Imprimir Voucher</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
	<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
	<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
  </head>
  <body>
<div class="container" style="border:1px #CCC solid;">
<table width="100%">
<thead>
<tr class="well well-small">
<td>&nbsp;&nbsp;VOUCHER</td>
<td></td>
<td class="pull-right"><b>#<?php echo $cup['idCupon'];?>&nbsp;&nbsp;</b></td>
</tr>
<tr>
<td width="150" align="center">
<br>
<img src="image/<?php echo $logo;?>" width="90">
<br>
<img src="image/<?php echo $cup['imagemPar'];?>" width="90">
<br>
</td>
<td width="400">
<b>Cliente:</b><br><?php echo $nome;?><br><br>
<b>Parceiro:</b><br>
- <?php echo $cup['nomePar'];?><br>
- <?php echo $cup['det'];?><br>
</td>
<td width="150" align="center"><h2><?php echo $cup['valCupon'];?>%</h2><b>desconto</b></td>
</tr>
</thead>
</table>
<br>
</div>
<br>
<center><button onclick="self.print()" class="btn btn-primary" type="button">Imprimir</button></center>

  </body>
</html>

<?php
	
	}
	
  
	public function getCupons($cliente) {
      	$query = $this->db->query("SELECT * FROM   `voucher_cupons` AS a,`voucher_parceiros` AS b,`voucher_locais` AS c WHERE a.idPar=b.idPar AND a.idCli = '".$cliente."' AND a.idEnd=c.idL ORDER BY a.idCupon DESC");
		return $query->rows;
	}
	
	public function getCupon($id) {
      	$query = $this->db->query("SELECT * FROM   `voucher_cupons` AS a,`voucher_parceiros` AS b,`voucher_locais` AS c WHERE a.idPar=b.idPar AND c.idL=a.idEnd AND a.idCupon = '".$id."'");
		return $query->row;
	}
	
	protected function validate() {
    	return true;				
	}
}
?>
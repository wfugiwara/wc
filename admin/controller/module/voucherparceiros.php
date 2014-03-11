<?php
class ControllerModuleVoucherParceiros extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/voucherparceiros');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');
		$this->load->model('sale/voucherparceiros');
				
		//salva as configuracoes
		if (($this->request->server['REQUEST_METHOD'] == 'POST' || isset($_GET['acao'])) && $this->validate()) {
			//categorias
			if(isset($_POST['acao']) && $_POST['acao']=='editar' && $_POST['tipo']=='categoria'){
			$this->model_sale_voucherparceiros->editarCategoria($_POST['categoria'],(int)$_POST['sub'],(int)$_POST['cat_id']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=categorias&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_POST['acao']) && $_POST['acao']=='add' && $_POST['tipo']=='categoria'){
			$this->model_sale_voucherparceiros->addCategoria($_POST['categoria'],(int)$_POST['sub']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=categorias&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_GET['acao']) && $_GET['acao']=='remover' && isset($_GET['id_remover']) && $_GET['tab']=='categorias'){
			$this->model_sale_voucherparceiros->removerCategoria($_GET['id_remover']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=categorias&token=' . $this->session->data['token'], 'SSL'));
			}
			//parceiros
			if(isset($_POST['acao']) && $_POST['acao']=='editar' && $_POST['tipo']=='parceiro'){
			$this->model_sale_voucherparceiros->editarParceiro($_POST['parceiro'],$_POST['config_logo'],(int)$_POST['categoria'],'',$_POST['valor'],(int)$_POST['par_id']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=parceiros&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_POST['acao']) && $_POST['acao']=='add' && $_POST['tipo']=='parceiro'){
			$this->model_sale_voucherparceiros->addParceiro($_POST['parceiro'],$_POST['config_logo'],(int)$_POST['categoria'],'',$_POST['valor']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=parceiros&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_GET['acao']) && $_GET['acao']=='remover' && isset($_GET['id_remover']) && $_GET['tab']=='parceiros'){
			$this->model_sale_voucherparceiros->removerParceiro($_GET['id_remover']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=parceiros&token=' . $this->session->data['token'], 'SSL'));
			}
			
			//produto
			if(isset($_POST['acao']) && $_POST['acao']=='add' && $_POST['tipo']=='produto'){
			$this->model_sale_voucherparceiros->addProduto($_POST['produto']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=prod&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_GET['acao']) && $_GET['acao']=='remover' && isset($_GET['id_remover']) && $_GET['tab']=='prod'){
			$this->model_sale_voucherparceiros->removerprod($_GET['id_remover']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=prod&token=' . $this->session->data['token'], 'SSL'));
			}
			
			//parceiros
			if(isset($_POST['acao']) && $_POST['acao']=='editar' && $_POST['tipo']=='ends'){
			$this->model_sale_voucherparceiros->editarends($_POST['end_id'],$_POST['parceiro'],$_POST['end']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=ends&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_POST['acao']) && $_POST['acao']=='add' && $_POST['tipo']=='ends'){
			$this->model_sale_voucherparceiros->addends($_POST['parceiro'],$_POST['end']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=ends&token=' . $this->session->data['token'], 'SSL'));
			}
			if(isset($_GET['acao']) && $_GET['acao']=='remover' && isset($_GET['id_remover']) && $_GET['tab']=='ends'){
			$this->model_sale_voucherparceiros->removerends($_GET['id_remover']);
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=ends&token=' . $this->session->data['token'], 'SSL'));
			}
			
			$this->model_setting_setting->editSetting('voucherparceiros', $this->request->post);		
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['image'])) {
			$this->data['error_image'] = $this->error['image'];
		} else {
			$this->data['error_image'] = array();
		}
				
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/voucherparceiros', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/voucherparceiros', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];
		
		//produtos
		$this->load->model('catalog/product');
		$this->data['produtos'] = $this->model_catalog_product->getProducts();
		$this->data['produtosv'] = $this->model_catalog_product->produtosvalidos();
		
		//categorias
		$categorias = $this->model_sale_voucherparceiros->Categorias();
		$this->data['categorias'] = array();
		foreach ($categorias as $key=>$vals) {
			$cat_info = $this->model_sale_voucherparceiros->getCategoria($vals['paiCat']);
			if(isset($cat_info['nomeCat'])){
			$sub = $cat_info['nomeCat'];
			}else{
			$sub = "";
			}
			$this->data['categorias'][] = array(
					'id' => $vals['idCat'],
					'nome'       => $vals['nomeCat'],
					'sub'       => $sub,
					'idsub'       => $vals['paiCat']
			);
		}
		//parceiros
		$parceiros = $this->model_sale_voucherparceiros->Parceiros();
		$this->data['parceiros'] = array();
		foreach ($parceiros as $key=>$vals) {
			$cat_info = $this->model_sale_voucherparceiros->getCategoria($vals['catPar']);
			if(isset($cat_info['nomeCat'])){
			$sub = $cat_info['nomeCat'];
			}else{
			$sub = "";
			}
			$this->data['parceiros'][] = array(
					'id' => $vals['idPar'],
					'nome'       => $vals['nomePar'],
					'imagem'       => $vals['imagemPar'],
					'end'       => $vals['enderecoPar'],
					'categoria'       => $sub,
					'categoriaid'       => $vals['catPar'],
					'valor'       => $vals['valVoucher']
			);
		}
		
		//parceiros
		$parceiross = $this->model_sale_voucherparceiros->Enderecos();
		$this->data['ends'] = array();
		foreach ($parceiross as $key=>$vals) {
			$cat_info = $this->model_sale_voucherparceiros->GetParceiro($vals['idPar']);
			$this->data['ends'][] = array(
					'id_par' => $cat_info['idPar'],
					'nome_par'       => $cat_info['nomePar'],
					'end'       => $vals['det'],
					'id'       => $vals['idL']
			);
		}
		//cupons
		$cc = $this->model_sale_voucherparceiros->Cupons();
		$this->data['cupons'] = $cc;

		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		if (isset($this->request->post['voucherparceiros_status'])) {
			$this->data['voucherparceiros_status'] = $this->request->post['voucherparceiros_status'];
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=status&token=' . $this->session->data['token'], 'SSL'));
		} else {
			$this->data['voucherparceiros_status'] = $this->config->get('voucherparceiros_status');
		}	
		
		if (isset($this->request->post['voucherparceiros_logo'])) {
			$this->data['voucherparceiros_logo'] = $this->request->post['voucherparceiros_logo'];
			$this->redirect($this->url->link('module/voucherparceiros', 'tab=status&token=' . $this->session->data['token'], 'SSL'));
		} else {
			$this->data['voucherparceiros_logo'] = $this->config->get('voucherparceiros_logo');
		}
				
			
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/voucherparceiros.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		return true;
	}
}
?>
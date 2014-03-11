<?php
class ControllerPaymentPagamentoDigital extends Controller {
 	protected function index() {
			
		$this->language->load('payment/pagamento_digital');
		
	    $this->data['button_confirm'] = $this->language->get('button_confirm_pd');
	    $this->data['action'] = 'https://www.pagamentodigital.com.br/checkout/pay/';
	    $this->data['text_information'] =  $this->language->get('text_information');
	    $this->data['text_wait'] = $this->language->get('text_wait');
		
    	$this->load->model('checkout/order');
	    $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);			
	    
	    // valor do frete será 0 pois o módulo enviará de forma diferente este valor para o Pagamento Digital
	   	$this->data['shipping_total'] = 0;
	    
	    $this->data['products'] = array();
	    	
	    foreach ($this->cart->getProducts() as $product) {
	    	$option_data = array();
	    
	    	foreach ($product['option'] as $option) {
	    		$option_data[] = array(
	    			'name'  => $option['name'],
	    			'value' => $option['option_value']
	    		);
	    	}
	    
	    	$this->data['products'][] = array(
	    		'product_id'=> $product['product_id'],
    			'name'     	=> $product['name'],
    			'model'    	=> $product['model'],
				// uso do 'convert' ao invés do 'format' preserva o número de dígitos após a vírgula que evita o problema de arredondamento no Bcash
	    		'value'     => $this->currency->convert($product['price'], $this->config->get('config_currency'), $order_info['currency_code']),
    			'quantity' 	=> $product['quantity'],
    			'option'   	=> $option_data
	    	);
	    }
		
	    // obtendo frete, descontos e taxas
	    $this->data['discount_total'] = 0;
		 
		$total = $this->currency->format($order_info['total'] - $this->cart->getSubTotal(), $order_info['currency_code'], false, false);

		if ($total > 0) {
	    	$this->data['products'][] = Array(
				'product_id' 	=> 'extra_amount',
				'name' 			=> $this->language->get('text_extra_amount'),
				'model'    		=> '',
				'value' 		=> $total,
				'quantity' 		=> 1,
				'option'   		=> array()
			);
		} 
		else if($total < 0) {
			$this->data['discount_total'] = $total * (-1);
		} 		
	    
	    $this->data['email_loja'] = $this->config->get('pagamento_digital_email');
	    
	    if($this->config->get('pagamento_digital_posfixo') != ""){
	    	$this->data['id_pedido'] = $this->session->data['order_id']."_".$this->config->get('pagamento_digital_posfixo');
	    }
	    else{
	    	$this->data['id_pedido'] = $this->session->data['order_id'];
	    }
	    
	    $this->data['url_retorno'] = $this->url->link('payment/pagamento_digital/callback');
		
	    // obtendo os dados pessoais
	    $this->data['enviar_dados_cliente'] = false;
		
	    if($this->config->get('pagamento_digital_dados_cliente')) {
		    
	    	$this->data['enviar_dados_cliente'] = true;
			
			$this->load->model('localisation/zone');
		    
		   	if ($this->cart->hasShipping()) {
	
				$zone = $this->model_localisation_zone->getZone($order_info['shipping_zone_id']);
				
			    $this->data['nome'] = html_entity_decode($order_info['shipping_firstname'].' '.$order_info['shipping_lastname'], ENT_QUOTES, 'UTF-8');
			    $this->data['endereco'] = html_entity_decode($order_info['shipping_address_1'], ENT_QUOTES, 'UTF-8');
				$this->data['bairro'] = html_entity_decode($order_info['shipping_address_2'], ENT_QUOTES, 'UTF-8');
			    $this->data['cidade'] = html_entity_decode($order_info['shipping_city'], ENT_QUOTES, 'UTF-8');
			    $this->data['cep'] = preg_replace ("/[^0-9]/", '', $order_info['shipping_postcode']);
		    	$this->data['email'] = html_entity_decode($order_info['email'], ENT_QUOTES, 'UTF-8');
		    	$this->data['telephone'] = html_entity_decode($order_info['telephone'], ENT_QUOTES, 'UTF-8');
				
		    	if (isset($zone['code'])) {
		    		$this->data['estado'] = html_entity_decode($zone['code'], ENT_QUOTES, 'UTF-8');
		    	}
			}
			else{
				$zone = $this->model_localisation_zone->getZone($order_info['payment_zone_id']);
				
			    $this->data['nome'] = html_entity_decode($order_info['payment_firstname'].' '.$order_info['payment_lastname'], ENT_QUOTES, 'UTF-8');
			    $this->data['endereco'] = html_entity_decode($order_info['payment_address_1'], ENT_QUOTES, 'UTF-8');
				$this->data['bairro'] = html_entity_decode($order_info['payment_address_2'], ENT_QUOTES, 'UTF-8');
			    $this->data['cidade'] = html_entity_decode($order_info['payment_city'], ENT_QUOTES, 'UTF-8');
			    $this->data['cep'] = preg_replace ("/[^0-9]/", '', $order_info['payment_postcode']);
		    	$this->data['email'] = html_entity_decode($order_info['email'], ENT_QUOTES, 'UTF-8');
		    	$this->data['telephone'] = html_entity_decode($order_info['telephone'], ENT_QUOTES, 'UTF-8');
				
		    	if (isset($zone['code'])) {
		    		$this->data['estado'] = html_entity_decode($zone['code'], ENT_QUOTES, 'UTF-8');
		    	}
			}			
	    }
	    
	    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/pagamento_digital.tpl')) {
	    	$this->template = $this->config->get('config_template') . '/template/payment/pagamento_digital.tpl';
	    }
	    else{
	      	$this->template = 'default/template/payment/pagamento_digital.tpl';
	    }	
			
	    $this->render();
	  }
		
	public function confirm() {
	    
		$this->load->model('checkout/order');
		
    	$this->model_checkout_order->confirm($this->session->data['order_id'], $this->config->get('pagamento_digital_order_finalizando'));
    	/*
    	$this->cart->clear();
    		
    	unset($this->session->data['shipping_method']);
    	unset($this->session->data['shipping_methods']);
    	unset($this->session->data['payment_method']);
    	unset($this->session->data['payment_methods']);
    	unset($this->session->data['guest']);
    	unset($this->session->data['comment']);
    	unset($this->session->data['order_id']);
    	unset($this->session->data['coupon']);
    	unset($this->session->data['voucher']);
    	unset($this->session->data['vouchers']);
		*/
	}
			
	public function callback() {
		
	    // retorno
	    $id_transacao = $_POST['id_transacao'];
	    $valor_original = $_POST['valor_original'];
	    $valor_loja = $_POST['valor_loja'];
	    $status = $_POST['status'];
	    $cod_status = $_POST['cod_status'];
	    $data_credito = $_POST['data_credito'];
	    
	    $id_pedido = explode('_', $_POST['id_pedido']);
		
		$this->load->model('checkout/order');
		$order = $this->model_checkout_order->getOrder($id_pedido[0]);		
		
	    $token = $this->config->get('pagamento_digital_token');
	    
	    $tipo_pagamento = utf8_encode($_POST['tipo_pagamento']);
	    $parcelas		= $_POST['parcelas'];
	    
	    $comment = "Tipo de pagamento escolhido: ".$tipo_pagamento." - Número de parcelas: ".$parcelas;
	    
	    $update_status_alert = false;
	    if($this->config->get('pagamento_digital_update_status_alert')){
	    	$update_status_alert = true;
	    }
	    
	    $post = "transacao=$id_transacao" .
	    	"&status=$status" .
	    	"&cod_status=$cod_status" .
	    	"&valor_original=" . $this->currency->format($order['total'], $order['currency_code'], false, false) . // verifica se o valor da compra é igual ao recebido pelo Pagamento Digital
	    	"&valor_loja=$valor_loja" .
	    	"&token=$token";
	    
	    $url = "https://www.pagamentodigital.com.br/checkout/verify/";
		  
	    ob_start();
	    $ch = curl_init();
	    curl_setopt ($ch, CURLOPT_URL, $url);
	    curl_setopt ($ch, CURLOPT_POST, 1);
	    curl_setopt ($ch, CURLOPT_POSTFIELDS, $post);
	    curl_exec ($ch);
	    $resposta = ob_get_contents();
	    ob_end_clean();
		  
	    if(trim($resposta) == "VERIFICADO"){
	      
			if ($order['order_status_id'] == '0' && date('d/m/Y') != $data_credito) {
				$this->model_checkout_order->confirm($id_pedido[0], $this->config->get('pagamento_digital_order_andamento'), $comment);
			}		  
		  
			switch($cod_status){
	
				case 0:
					if($order['order_status_id'] != $this->config->get('pagamento_digital_order_andamento')){
						$this->model_checkout_order->update($id_pedido[0], $this->config->get('pagamento_digital_order_andamento'), $comment, $update_status_alert);
					}
					break;
								
				case 1:
					if($order['order_status_id'] != $this->config->get('pagamento_digital_order_concluido')){
						// evita que o status seja alterado novamente se hoje for a data em que a loja receberá o crédito.
						if(date('d/m/Y') != $data_credito) {
							$this->model_checkout_order->update($id_pedido[0], $this->config->get('pagamento_digital_order_concluido'), '', $update_status_alert);
						}
					}
					break;
				
				case 2:
					if($order['order_status_id'] != $this->config->get('pagamento_digital_order_cancelado')){
						$this->model_checkout_order->update($id_pedido[0], $this->config->get('pagamento_digital_order_cancelado'), '', $update_status_alert);
					}
					break;
			}
	    }
		// O Pagamento Digital não confirmou a autenticidade dos dados, ou seja, os valores da loja e os que foram recebidos pelo Pagamento Digital se divergem.
		/*
		else{
			if($order['order_status_id'] != $this->config->get('pagamento_digital_order_cancelado')){
				$comment = "Compra cancelada por problemas de autenticidade dos dados enviados ao Pagamento Digital. Valor original da compra: " . round($order['total'], 2) . ". Valor recebido pelo Pagamento Digital: " . $valor_original;
				$this->model_checkout_order->update($id_pedido[0], $this->config->get('pagamento_digital_order_cancelado'), $comment, $update_status_alert);
			}
		}
		*/
	    $this->redirect($this->url->link('checkout/success'));
	}
}
?>

<?php
// Heading
$_['heading_title']       		= 'Bcash';

// Text
$_['text_payment']        		= 'Pagamento';
$_['text_success']        		= 'Módulo Bcash atualizado com sucesso!';
$_['text_pagamento_digital'] 	= '<a onclick="window.open(\'http://www.bcash.com.br/\');"><img src="view/image/payment/pagamento_digital.png" alt="Bcash" title="Bcash" style="border: 1px solid #EEEEEE;" /></a>';
$_['text_order_nao_efetivado'] 	= 'O pagamento no site do Bcash não foi concluído.';

// Entry
$_['entry_token']         		= 'Chave de acesso:<br /><span class="help">Chave de acesso ou token que identifica a loja</span>';
$_['entry_email']         		= 'Email:<br /><span class="help">Email da loja cadastrado no Bcash</span>';
$_['entry_posfixo']         	= 'Pós-fixo para o número do pedido:<br /><span class="help">Útil para quando tiver várias lojas na mesma conta no Bcash, evitando conflito de pedidos com o mesmo número na mesma conta. Ex. para pedido de nro. 15 e pós-fixo "loja01" aparecerá no Bcash como "15_loja01" </span>';
$_['entry_order_finalizando'] 	= 'Status aguardando retorno:<br /><span class="help">Status quando a loja aguarda o primeiro retorno da confirmação da transação pelo Bcash</span>';
$_['entry_order_andamento'] 	= 'Status em andamento:<br /><span class="help">O Bcash recebeu a transação, está analisando ou aguardando o pagamento</span>';
$_['entry_order_concluido'] 	= 'Status concluído:<br /><span class="help">A transação já passou por todo o processo e foi finalizada, ou foi confirmado o pagamento</span>';
$_['entry_order_cancelado'] 	= 'Status cancelado:<br /><span class="help">Por qualquer motivo a transação foi cancelada, pagamento foi negado, estornado, ocorreu um chargeback</span>';
$_['entry_geo_zone']      		= 'Região geográfica:';
$_['entry_status']        		= 'Situação:';
$_['entry_sort_order']    		= 'Ordenação:';
$_['entry_dados_cliente']    	= 'Enviar dados do cliente:<br /><span class="help">Envia os dados do cliente (nome, endereço, email, etc) para o Bcash.</span>';
$_['entry_update_status_alert'] = 'Alertar sobre mudança no status da transação:<br /><span class="help">Envia email para o cliente avisando-o sobre mudança no status do pedido.</span>';

// Error
$_['error_permission']    		= 'Atenção: Você não possui permissão para modificar o pagamento Bcash!';
$_['error_loja']          		= 'Digite o Código da Loja';
$_['error_token']         		= 'Digite a Chave acesso';
$_['error_email']         		= 'Digite o e-mail cadastrado no Bcash';
?>
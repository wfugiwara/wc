<?php
class ModelTotalAVista extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if ($this->cart->hasShipping() && $this->config->get('avista_status')) {
			$methods_aplicaveis = explode(",", $this->config->get('avista_methods'));
			
			if(isset($this->session->data['payment_method']['code']))
  			$paymethod = $this->session->data['payment_method']['code'];
			
			if(isset($paymethod)) {
			  if(in_array($paymethod, $methods_aplicaveis)) {
			    $this->load->language('total/avista');
			    $percent = $this->config->get('avista_total') / 100;
			    $percent = $total * $percent;
			    $total_data[] = array( 
					'code'		 => 'avista',
            		'title'      => 'Desconto de ' . $this->config->get('avista_total'). '%',
            		'text'       => '<span class="discont">- ' . $this->currency->format($percent) . '</span>',
            		'value'      => $percent*-1,
				    'sort_order' => $this->config->get('avista_sort_order')
			    );
			    $total -= $percent;
			  }
		  }
		}
	}
}
?>

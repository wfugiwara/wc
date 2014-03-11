<?php

class ControllerModulePpShippingEstimator extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('module/pp_shipping_estimator');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('pp_shipping_estimator', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['token'] = $this->session->data['token'];

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['title_basic'] = $this->language->get('title_basic');

        $this->data['title_advanced'] = $this->language->get('title_advanced');

        $this->data['text_note'] = $this->language->get('text_note');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');

        $this->data['text_none'] = $this->language->get('text_none');

        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_position'] = $this->language->get('entry_position');
        $this->data['entry_show_mode'] = $this->language->get('entry_show_mode');

        $this->data['text_show_module'] = $this->language->get('text_show_module');
        $this->data['text_show_product'] = $this->language->get('text_show_product');

        $this->data['entry_default_country'] = $this->language->get('entry_default_country');
        $this->data['entry_default_zone'] = $this->language->get('entry_default_zone');
        $this->data['entry_default_postcode'] = $this->language->get('entry_default_postcode');
        
        $this->data['entry_auto_quote'] = $this->language->get('entry_auto_quote');
        
                
        $this->data['entry_show_country_field'] = $this->language->get('entry_show_country_field');
        $this->data['entry_show_zone_field'] = $this->language->get('entry_show_zone_field');
        $this->data['entry_show_postcode_field'] = $this->language->get('entry_show_postcode_field');

        if (isset($this->request->post['pp_shipping_estimator'])) {
            $this->data['modules'] = $this->request->post['pp_shipping_estimator'];
        } elseif ($this->config->get('pp_shipping_estimator')) {
            $this->data['modules'] = $this->config->get('pp_shipping_estimator');
        }


        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_add_account'] = $this->language->get('button_add_account');
        $this->data['button_remove'] = $this->language->get('button_remove');

        $this->data['text_content_top'] = $this->language->get('text_content_top');
        $this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
        $this->data['text_column_left'] = $this->language->get('text_column_left');
        $this->data['text_column_right'] = $this->language->get('text_column_right');

        $this->data['text_tip_layout'] = $this->language->get('text_tip_layout');



        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['tab_general'] = $this->language->get('tab_general');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

   	if (substr(VERSION, 0, 5) == '1.5.0') {

	    $this->data['version'] = '1.5.0';

	    if (isset($this->request->post['pp_shipping_estimator_module'])) {
		$modules = explode(',', $this->request->post['pp_shipping_estimator_module']);
		$this->data['pp_shipping_estimator_module'] = $this->request->post['pp_shipping_estimator_module'];
	    } elseif ($this->config->get('pp_shipping_estimator_module') != '') {
		$modules = explode(',', $this->config->get('pp_shipping_estimator_module'));
		$this->data['pp_shipping_estimator_module'] = $this->config->get('pp_shipping_estimator_module');
	    } else {
		$modules = array();
		$this->data['pp_shipping_estimator_module'] = null;
	    }


	    foreach ($modules as $module) {
		if (isset($this->request->post['pp_shipping_estimator_' . $module . '_layout_id'])) {
		    $this->data['pp_shipping_estimator_' . $module . '_layout_id'] = $this->request->post['pp_shipping_estimator_' . $module . '_layout_id'];
		} else {
		    $this->data['pp_shipping_estimator_' . $module . '_layout_id'] = $this->config->get('pp_shipping_estimator_' . $module . '_layout_id');
		}

		if (isset($this->request->post['pp_shipping_estimator_' . $module . '_position'])) {
		    $this->data['pp_shipping_estimator_' . $module . '_position'] = $this->request->post['pp_shipping_estimator_' . $module . '_position'];
		} else {
		    $this->data['pp_shipping_estimator_' . $module . '_position'] = $this->config->get('pp_shipping_estimator_' . $module . '_position');
		}

		if (isset($this->request->post['pp_shipping_estimator_' . $module . '_status'])) {
		    $this->data['pp_shipping_estimator_' . $module . '_status'] = $this->request->post['pp_shipping_estimator_' . $module . '_status'];
		} else {
		    $this->data['pp_shipping_estimator_' . $module . '_status'] = $this->config->get('pp_shipping_estimator_' . $module . '_status');
		}

		if (isset($this->request->post['pp_shipping_estimator_' . $module . '_sort_order'])) {
		    $this->data['pp_shipping_estimator_' . $module . '_sort_order'] = $this->request->post['pp_shipping_estimator_' . $module . '_sort_order'];
		} else {
		    $this->data['pp_shipping_estimator_' . $module . '_sort_order'] = $this->config->get('pp_shipping_estimator_' . $module . '_sort_order');
		}
	    }

	    $this->data['modules'] = $modules;
	} else {

	    $this->data['version'] = '1.5.1';

	    $this->data['modules'] = array();

	    if (isset($this->request->post['pp_shipping_estimator_module'])) {

		$this->data['modules'] = $this->request->post['pp_shipping_estimator_module'];
	    } elseif ($this->config->get('pp_shipping_estimator_module')) {
		$this->data['modules'] = $this->config->get('pp_shipping_estimator_module');
	    }
	}


        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/pp_shipping_estimator', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/pp_shipping_estimator', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


        if (isset($this->request->post['pp_shipping_estimator_status'])) {
            $this->data['pp_shipping_estimator_status'] = $this->request->post['pp_shipping_estimator_status'];
        } else {
            $this->data['pp_shipping_estimator_status'] = $this->config->get('pp_shipping_estimator_status');
        }

        if (isset($this->request->post['pp_shipping_estimator_country_id'])) {
            $this->data['pp_shipping_estimator_country_id'] = $this->request->post['pp_shipping_estimator_country_id'];
        } elseif (!is_null($this->config->get('pp_shipping_estimator_country_id'))) {
            $this->data['pp_shipping_estimator_country_id'] = $this->config->get('pp_shipping_estimator_country_id');
        } else {

            $this->data['pp_shipping_estimator_country_id'] = $this->config->get('config_country_id');
        }

        if (isset($this->request->post['pp_shipping_estimator_postcode'])) {

            $this->data['pp_shipping_estimator_postcode'] = $this->request->post['pp_shipping_estimator_postcode'];
        } else {

            $this->data['pp_shipping_estimator_postcode'] = $this->config->get('pp_shipping_estimator_postcode');
        }



        if (isset($this->request->post['pp_shipping_estimator_show_mode'])) {
            $this->data['pp_shipping_estimator_show_mode'] = $this->request->post['pp_shipping_estimator_show_mode'];
        } else {
            $this->data['pp_shipping_estimator_show_mode'] = $this->config->get('pp_shipping_estimator_show_mode');
        }

        if (isset($this->request->post['pp_shipping_estimator_auto_quote'])) {
            $this->data['pp_shipping_estimator_auto_quote'] = $this->request->post['pp_shipping_estimator_auto_quote'];
        } else {
            $this->data['pp_shipping_estimator_auto_quote'] = $this->config->get('pp_shipping_estimator_auto_quote');
        }

        if (isset($this->request->post['pp_shipping_estimator_zone_id'])) {
            $this->data['pp_shipping_estimator_zone_id'] = $this->request->post['pp_shipping_estimator_zone_id'];
        } elseif (!is_null($this->config->get('pp_shipping_estimator_zone_id'))) {

            $this->data['pp_shipping_estimator_zone_id'] = $this->config->get('pp_shipping_estimator_zone_id');
        } else {

            $this->data['pp_shipping_estimator_zone_id'] = $this->config->get('config_zone_id');
        }

        $this->data['zones'] = $this->zone($this->data['pp_shipping_estimator_country_id'], $this->data['pp_shipping_estimator_zone_id'], false);

        if (isset($this->request->post['pp_shipping_estimator_show_country_field'])) {
            $this->data['pp_shipping_estimator_show_country_field'] = $this->request->post['pp_shipping_estimator_show_country_field'];
        } elseif (!is_null($this->config->get('pp_shipping_estimator_show_country_field'))) {
            $this->data['pp_shipping_estimator_show_country_field'] = $this->config->get('pp_shipping_estimator_show_country_field');
        } else {

            $this->data['pp_shipping_estimator_show_country_field'] = 1;
        }

        if (isset($this->request->post['pp_shipping_estimator_show_zone_field'])) {
            $this->data['pp_shipping_estimator_show_zone_field'] = $this->request->post['pp_shipping_estimator_show_zone_field'];
        } elseif (!is_null($this->config->get('pp_shipping_estimator_show_zone_field'))) {
            $this->data['pp_shipping_estimator_show_zone_field'] = $this->config->get('pp_shipping_estimator_show_zone_field');
        } else {

            $this->data['pp_shipping_estimator_show_zone_field'] = 1;
        }
        if (isset($this->request->post['pp_shipping_estimator_show_postcode_field'])) {
            $this->data['pp_shipping_estimator_show_postcode_field'] = $this->request->post['pp_shipping_estimator_show_postcode_field'];
        } elseif (!is_null($this->config->get('pp_shipping_estimator_show_postcode_field'))) {
            $this->data['pp_shipping_estimator_show_postcode_field'] = $this->config->get('pp_shipping_estimator_show_postcode_field');
        } else {

            $this->data['pp_shipping_estimator_show_postcode_field'] = 1;
        }

        $this->load->model('design/layout');

        $this->data['layouts'] = $this->model_design_layout->getLayouts();

        $this->load->model('localisation/country');

        $this->data['countries'] = $this->model_localisation_country->getCountries();



        $this->template = 'module/pp_shipping_estimator.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    public function zone($country_id = '', $zone_id = '', $response = true) {


        $output = '<option value="">' . $this->language->get('text_none') . '</option>';

        $this->load->model('localisation/zone');

        $results = array();

        if ($country_id != '') {

            $results = $this->model_localisation_zone->getZonesByCountryId($country_id);
        } elseif (isset($this->request->get['country_id'])) {

            $results = $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']);
        }
        foreach ($results as $result) {
            $output .= '<option value="' . $result['zone_id'] . '"';

            if ($zone_id == $result['zone_id']) {
                $output .= ' selected="selected"';
            }
            if (isset($this->request->get['zone_id']) && ($this->request->get['zone_id'] == $result['zone_id'])) {
                $output .= ' selected="selected"';
            }
            $output .= '>' . $result['name'] . '</option>';
        }


        if (!$results) {
            $output .= '<option value="0">' . $this->language->get('text_none') . '</option>';
        }

        if ($response) {
            $this->response->setOutput($output);
        } else {

            return $output;
        }
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/pp_shipping_estimator')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>
<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/


class Controllersimonoopsimonsaveandstay extends Controller {
    public function index() {
        $allowedRoutes = Array(
                  "module/account"
                , "module/affiliate"
                , "module/banner"
                , "module/bestseller"
                , "module/carousel"
                , "module/category"
                , "module/featured"
                , "module/google_talk"
                , "module/information"
                , "module/latest"
                , "module/slideshow"
                , "module/special"
                , "module/store"
                , "module/welcome"

                , "catalog/product/update"
                , "catalog/category/update"
                , "catalog/attribute/update"
                , "catalog/attribute_group/update"
                , "catalog/option/update"
                , "catalog/manufacturer/update"
                , "catalog/download/update"
                , "catalog/review/update"
                , "catalog/information/update"

                , "shipping/citylink"
                , "shipping/flat"
                , "shipping/free"
                , "shipping/item"
                , "shipping/parcelforce_48"
                , "shipping/pickup"
                , "shipping/royal_mail"
                , "shipping/ups"
                , "shipping/usps"
                , "shipping/weight"

                , "payment/alertpay"
                , "payment/authorizenet_aim"
                , "payment/bank_transfer"
                , "payment/cheque"
                , "payment/cod"
                , "payment/free_checkout"
                , "payment/liqpay"
                , "payment/moneybookers"
                , "payment/nochex"
                , "payment/paymate"
                , "payment/paypoint"
                , "payment/perpetual_payments"
                , "payment/pp_pro"
                , "payment/pp_pro_uk"
                , "payment/pp_standard"
                , "payment/sagepay"
                , "payment/sagepay_direct"
                , "payment/sagepay_us"
                , "payment/twocheckout"
                , "payment/web_payment_software"
                , "payment/worldpay"

                , "total/coupon"
                , "total/credit"
                , "total/handling"
                , "total/low_order_fee"
                , "total/reward"
                , "total/shipping"
                , "total/sub_total"
                , "total/tax"
                , "total/total"
                , "total/voucher"
                , "feed/google_base"
                , "feed/google_sitemap"

                , "sale/coupon/update"
                , "sale/voucher_theme/update"
                , "sale/voucher/update"

                , "setting/setting"
            
                , "design/layout/update"

                , "user/user_permission/update"
                , "user/user/update"

                , "localisation/language/update"
                , "localisation/currency/update"
                , "localisation/stock_status/update"
                , "localisation/order_status/update"
                , "localisation/return_reason/update"
                , "localisation/return_action/update"
                , "localisation/return_status/update"
                , "localisation/country/update"
                , "localisation/zone/update"
                , "localisation/geo_zone/update"
                //, "localisation/tax_rate/update" // NOT SUPPORTED
                , "localisation/length_class/update"
                , "localisation/weight_class/update"

                #added on v1.1.1
                , "design/banner/update"
                , "module/tg_benetton_banner"
                , "module/tg_benetton_cp"
                , "module/tg_benetton_footer"
                , "module/tg_benetton_paymentimages"
                , "module/tg_benetton_slideshow"
                , "module/category_accordion_menu"
                , "module/maintenance"
        );
        if(in_array($this->request->get['route'], $allowedRoutes)) {
            $this->document->addStyle('view/stylesheet/simonsaveandstay.css');
            $this->document->addScript('view/javascript/simonoop/simonsaveandstay.js');
        }
    }
}

?>
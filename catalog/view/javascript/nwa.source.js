var nwa_view =  null;
var nwa_list_html =  null;
var nwa_product_html =  null;
 
$.fn.nwaList = function(options)
{
 
    return this.each(function()
    {
        var id = null;

        var myregexp = /addToCart\('([0-9]*?)'\)/m;
        var match = myregexp.exec($(this).attr('onclick').toString());

        if (match != null) {
            id =  parseInt(match[1]);
        } 
       
        if ($.inArray(id,options.out_stock_list) != -1){
 
            $(this).before('<span style="color:red;font-weight:bold">'+options.title+'</span><br/>');

            if (options.gray_style){
 
                if ($(this).is('input')){
                    
                    $(this).val(options.text); 
                    
                    $(this).css('background',"url('image/nwa_button.png') repeat-x scroll left top transparent");
                    $(this).css('background-color','#BEBDBD');
         
                }else{

                    $(this).html('<span>'+options.text+'</span>');
                    
                    $(this).css('background',"url('image/nwa_button-left.png') top left no-repeat");
                    $(this).find('span').css('background',"url('image/nwa_button-right.png') top right no-repeat");
                }
                
            }else{
                
                if ($(this).is('input')){
                    
                    $(this).val(options.text); 
        
                }else{

                    $(this).html('<span>'+options.text+'</span>');
                }
            }
 
            var events = '';
              
              
            $(this).attr('onclick','');
            
            if(options.show_mode == 1 || options.show_mode == 2){
                
                if(options.show_mode == 1 ){
                
                    events = 'mouseenter click';

                }else {

                    events = 'click';
                }
                      
                $(this).bind(events,function(e){
            
                    $('#nwa_list_product_id').val(id);

                    $('#nwa_list_msg').hide();
                    
                    var top_pos = e.pageY + 15;

                    $('#nwa_list').css('top', top_pos +'px');
                    
                    var left_pos =  ((e.pageX + $('#nwa_list').width()) > ($(window).width() + 15)) ? ($(window).width() - ($('#nwa_list').width() + 15)) : e.pageX -30;
                    
                    $('#nwa_list').css('left',(left_pos + 'px'));

                    $('#nwa_list_container').show('slow');

                    $('#nwa_list_email').focus();
                        
                    e.stopPropagation();
                        
                });
 
 
            }else if (options.show_mode == 3){
 
                $(this).click(function(e){

                    location = 'index.php?route=product/product&product_id='+id;

                });
                 
            }else if (options.show_mode == 4){
                
                $('#nwa_list_product_id').val(id); 
 
                if (!nwa_list_html){
                   
                    nwa_list_html = $('#nwa_list_container').html();
                   
                    $('#nwa_list_container').remove();
                }
                
                $(this).click(function(e){
   
                    $.colorbox({
                        overlayClose: true,
                        opacity: 0.5,
                        width: '230px',
                        height: '310px',
                        href: false,
                        html:  nwa_list_html
                    });  
                    
                    $('#nwa_list_product_id').val(id);
                    
                  //   $('body').colorbox.resize();  
                     
                    setTimeout(function(){
                        $('#nwa_list_email').focus();
                    },300);
                    
                });
                
            }
 
        };
    });

}
 
$(function(){
    
    if (typeof($.colorbox) != 'function'){

        $.getScript('catalog/view/javascript/jquery/nwa_colorbox/jquery.colorbox-min.js');  
    
       $('head').append('<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/nwa_colorbox/colorbox.css" media="screen" />');
       
    }
    
    if (typeof($.cookie) != 'undefined'){

        nwa_view = $.cookie('display');

        $('.display').live('hover',function(){

            setTimeout(function(){

                if (nwa_view !=  $.cookie('display')){

                    location.reload();

                }

            },200);

        });

    }
 
    $('#nwa_list_register,#nwa_list_register span').live('click',function(e){
 
        $.ajax({
            type: 'POST',
            url: 'index.php?route=module/notify_when_arrives/register',
            data: 'notify_phone='+$('#nwa_list_phone').val()+'&notify_custom='+$('#nwa_list_custom').val()+'&notify_name='+$('#nwa_list_name').val()+'&notify_email='+$('#nwa_list_email').val()+'&notify_product_id='+$('#nwa_list_product_id').val(),
            dataType: 'json',		
            beforeSend: function() {

                $('#nwa_list_msg').hide();
                $('#nwa_list_register').attr('disabled', true); 
                $('#nwa_list_register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');

            },
            complete: function() {

                $('#nwa_list_register').attr('disabled', false);
                $('.wait').remove();

            },	
            success: function(json) {

                if (json['sucess']) {

                    $('#nwa_list_msg').html('<div style="color:green">' + json['msg'] +'</div>');

                }else{

                    $('#nwa_list_msg').html('<div style="color:red">' + json['msg'] +'</div>');
                }

                $('#nwa_list_msg').show(); 

              // $('body').colorbox.resize();  
            }


        });

    });

 
    $('#nwa_product_register').live('click', function() {   
        

        
        $.ajax({
            type: 'POST',
            url: 'index.php?route=module/notify_when_arrives/register',
            data: 'notify_phone='+$('#nwa_phone').val()+'&notify_custom='+$('#nwa_custom').val()+'&notify_name='+$('#nwa_name').val()+'&notify_email='+$('#nwa_email').val()+'&notify_product_id='+$('#nwa_product_id').val()+'&notify_option_id='+$('#nwa_option_id').val()+'&notify_option_value_id='+$('#nwa_option_value_id').val(),
            dataType: 'json',		
            beforeSend: function() {
       
                $('#nwa_product_register').attr('disabled', true); 
                
                $('#nwa_msg').hide();

                $('#nwa_product_register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');

            },
            complete: function() {

                $('#nwa_product_register').attr('disabled', false);
                $('.wait').remove();

            },	
            success: function(json) {

                if (json['sucess']) {

                    $('#nwa_msg').html('<div style="color:green">' + json['msg'] +'</div>');

                }else{

                    $('#nwa_msg').html('<div style="color:red">' + json['msg'] +'</div>');
                }

                $('#nwa_msg').show(); 
             //  $('body').colorbox.resize(); 
            }

        });
    });
    

    $('#nwa_list_close,#nwa_list_close span,#nwa_product_close,#nwa_product_close span').live('click',function(){
 
        if ($('#colorbox').is(':hidden')){
      
            $('#nwa_list_container').hide('slow');
                
        }else {

            $.colorbox.close();
                
        }
            
    });
    
    $('body').live('click',function(){
 
        $('#nwa_list_container').hide('slow');
   
    });
    $('#nwa_list *').live('click',function(e){
 
        e.stopPropagation();
            
    });
    
    $('#nwa_email').live('keyup',function(event) {

        if ( event.which == 13 ) {
            
            $('#nwa_product_register').trigger('click');
           
        }

    });
    $('#nwa_list_email').live('keyup',function(event) {

        if ( event.which == 13 ) {
            
            $('#nwa_list_register').trigger('click');
           
        }

    }); 
 
});
 	
$.fn.nwaOption = function(b,c,d,e){

    $('#nwa_product').hide();
	 
    if (typeof(nwa_options[b]) != 'undefined' && typeof(nwa_options[b][c]) != 'undefined') {

        $('#nwa_option_id').val(b);
        $('#nwa_option_value_id').val(nwa_options[b][c]);

        if(nwa_title == ''){

            nwa_title = $('#nwa_title').text();

        }

        $('#nwa_title').text(d+' : '+e+' '+ nwa_title);

        if ($(this).is('input')){

            $(this).attr('checked',false);

        }else{

            $(this).val("");

        }
        
        $('#nwa_product_container').html($('#nwa_product'));
        
        $('#nwa_product_close').remove();
         
        $('#nwa_product').prependTo($(this).parent().parent()).show('slow');

        $('#nwa_email').focus();
 
    }
};

$.fn.nwaProduct = function(options){
 
    var  add_to_cart = options.button_cart;   
 
    if ($.inArray(options.show_mode,Array(0,1,2)) != -1){
        
        $('#nwa_product_container').html($('#nwa_product'));
        
        $('#nwa_product_close').remove();
   
    } 
 
    if (options.show_mode == 0){

        $(add_to_cart).parent().parent().html($('#nwa_product'));

    }else if(options.show_mode  == 2){

        $(add_to_cart).parent().before($('#nwa_product'));

    }else if(options.show_mode == 3){
        
        if (options.gray_style){
 
            if ($(add_to_cart).is('input')){
                    
                $(add_to_cart).val(options.text); 
                    
                $(add_to_cart).css('background',"url('image/nwa_button.png') repeat-x scroll left top transparent");
                $(add_to_cart).css('background-color','#BEBDBD');
         
            }else{

                $(add_to_cart).html('<span>'+options.text+'</span>');
                    
                $(add_to_cart).css('background',"url('image/nwa_button-left.png') top left no-repeat");
                $(add_to_cart).find('span').css('background',"url('image/nwa_button-right.png') top right no-repeat");
            }
                
        }else{
                
            if ($(add_to_cart).is('input')){
                    
                $(add_to_cart).val(options.text); 
        
            }else{

                $(add_to_cart).html('<span>'+options.text+'</span>');
            }
        }

        if (!nwa_product_html){

            nwa_product_html = $('#nwa_product_container').html();

            $('#nwa_product_container').remove();
        }
        
        $(add_to_cart).parent().html($(add_to_cart));
        
        $(add_to_cart).before('<span style="color:red;font-weight:bold">'+options.title+'</span>');
                         
        $(add_to_cart).unbind();

        $(add_to_cart).click(function(e){

            $.colorbox({
                overlayClose: true,
                opacity: 0.5,
                width: '230px',
                height: '310px',
                href: false,
                html:  nwa_product_html
            });  


             //   $('body').colorbox.resize();

            $('#nwa_product_email').focus();

        });

    } else{

        $(add_to_cart).parent().html($('#nwa_product'));
    }

    $('head').append('<style type="text/css">#shipping{display:none;}</style>');
    
}
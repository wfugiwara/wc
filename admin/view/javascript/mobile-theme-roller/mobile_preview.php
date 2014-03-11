<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" type="text/css" href="css/structure.css" />
  <script type="text/javascript" src="js/jquery.js" ></script> 
  <script type="text/javascript" src="js/jquery-mobile.js" ></script>
  
  <style type="text/css">
	.ui-page{
		/*padding: 30px;*/
		}
	
	.preview{
		width: 325px;
		float: left;
		border: none;
		margin: 4px 10px 4px 10px;
	}
	
	.wrapper{
		padding: 30px;
		background: #fff;
		min-height: 500px;
	}
    
	.add-swatch{
		border: 1px dashed; 
		height: 227px; 
		width: 278px; 
		background: #eee; 
		overflow: hidden;
		cursor: pointer;
	}
	
	#add-swatch h5{
		text-align: center; 
		margin-top: 70px;
	}
    
	#add-swatch h5 a{
		font-family: Helvetica, Arial, sans serif;
		text-decoration: none; 
		color: #000;
	}
	
	#highlight{
		display: none; 
		z-index: 20
	}
	
	.ui-page{
		background: #fff;
	}

	.preview .ui-bar-a{
		border-right-width: 0;
		border-left-width: 0;
	}

	.preview fieldset [data-role=list-divider]{
		border-right-width: 1px;
		border-left-width: 1px;
	}
	
	.ui-slider{
		width: 62% !important;
	}
	
	.ui-select{
		width: 100% !important;
	}
	
	.input{
		width: 90% !important;
	}
	
	[for=radio-choice-1]>span{
		-moz-border-radius: 				   0 !important;
		-webkit-border-radius: 				   0 !important;
		border-radius: 						   0 !important;
	}
	
	.preview .ui-content{
		overflow-y: hidden !important;
	}
	
	.preview .ui-header{
		border-right-width: 0 !important;
		border-left-width: 0 !important;
	}
  </style>
  
  <style type="text/css" id="styleblock">
    <!-- custom overrides go here -->
  </style>
</head>
<body>
<div class="preview ui-shadow swatch">
	<div class="ui-header ui-bar-c" data-swatch="c" data-form="ui-bar-c" data-role="header" role="banner">
		<div style="height:35px;">
            <div style="float:left; margin-top:5px; margin-left:5px;" class="header_logo">
                <a rel="external" class="ui-link">
               <img height="25" alt="Your Store" title="Your Store" src="images/opmex/logo-mobile.png">
                </a>
            </div>
        	<div style="float:right; margin-top:5px;" data-form="ui-bar-c">
                <a rel="external" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/home-icon.png"></a>
                <a rel="external" href="tel:9876543210" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/phone-icon.png"></a>
                <a style="text-decoration:none;" rel="external" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/cart-icon.png"></a>
       		</div>
        </div>
        <div data-position="inline" data-role="navbar" class="ui-navbar ui-navbar-noicons" role="navigation">
            <ul class="ui-grid-c" data-theme="c">
                <li class="ui-block-a"><a data-theme="c" data-form="ui-btn-up-c">Categories</a></li>
                <li class="ui-block-b"><a data-theme="c" data-form="ui-btn-up-c">Account</a></li>
                <li class="ui-block-c"><a data-theme="c" data-form="ui-btn-up-c">Search</a></li>
                <li class="ui-block-d"><a data-theme="c" data-form="ui-btn-up-c">Contact</a></li>
            </ul>
        </div>
        <div class="ui-hide-label ui-field-contain ui-body-d" data-role="fieldcontain" style="display: block;">
            <form data-ajax="false" id="search_form" enctype="multipart/form-data" method="get" action="">
                <input type="hidden" value="product/search" name="route">
                <input type="true" data-type="search" placeholder="Search" value="" id="searc-basic" name="filter_name">
            </form>
		</div>
	</div>
	
	<div data-role="content" class="ui-content">
		<ul data-role="listview" class="ui-listview" role="listbox" data-dividertheme="a"  data-theme="a">
			<li data-swatch="c" class="ui-li ui-li-divider ui-btn ui-bar-c" data-role="list-divider" role="" data-form="ui-bar-c">Featured</li>
            <li class="ui-li-has-thumb ui-btn ui-btn-icon-right ui-li ui-btn-up-a" role="option" tabindex="-1">
            <a class="ui-link-inherit" data-form="ui-btn-up-a" data-theme="a">
                <img alt="iMac" src="images/opmex/imac.jpg" class="ui-li-thumb" style="margin-top:18px;">
                <h3 class="ui-li-heading">iMac</h3>
        <p class="ui-li-desc">
                            $119.50                                  </p>
        </a>
       </li>
            <li class="ui-li-has-thumb ui-btn ui-btn-icon-right ui-li ui-btn-up-a" role="option" tabindex="-1">
            <a class="ui-link-inherit" data-form="ui-btn-up-a" data-theme="a">
                <img alt="iPhone" src="images/opmex/iphone.jpg" class="ui-li-thumb" style="margin-top:18px;">
                <h3 class="ui-li-heading">iPhone</h3>
        <p class="ui-li-desc">
                            $120.68                                  </p>
        </a>
       </li>
    </ul>
	</div>

	<div class="ui-content" data-role="content">
		<ul data-role="listview" class="ui-listview" role="listbox" data-dividertheme="a" data-theme="a">
            <li data-swatch="c" class="ui-li ui-li-divider ui-btn ui-bar-c" data-role="list-divider" role="" data-form="ui-bar-c">Support</li>
			<li role="option" tabindex="-1" class="ui-btn ui-btn-icon-right ui-li ui-btn-up-a" ><a href="" class="ui-link-inherit" data-form="ui-btn-up-a" data-theme="a">Contact Us</a></li>
      		<li role="option" tabindex="-1" class="ui-btn ui-btn-icon-right ui-li ui-btn-up-a"><a href="" class="ui-link-inherit" data-form="ui-btn-up-a" data-theme="a">Site Map</a></li>
   		</ul>
	</div>



    <div class="ui-bar-c ui-footer" data-swatch="c" data-form="ui-bar-c" data-role="footer" role="contentinfo">
        <div data-role="navbar" class="ui-navbar" role="navigation">
                <ul class="ui-grid-c">
                    <li class="ui-block-a"><a data-icon="info" data-form="ui-btn-up-c">Info</a></li>
                    <li class="ui-block-b"><a data-icon="gear" data-form="ui-btn-up-c">Support</a></li>
                    <li class="ui-block-c"><a data-icon="plus" data-form="ui-btn-up-c">Extras</a></li>
                    <li class="ui-block-d"><a data-icon="grid" data-form="ui-btn-up-c">Account</a></li>
                </ul>
        </div>
    </div>
</div>

<div class="preview ui-shadow swatch">
	<div class="ui-header ui-bar-c" data-swatch="c" data-form="ui-bar-c" data-role="header" role="banner">
		<div style="height:35px;">
            <div style="float:left; margin-top:5px; margin-left:5px;" class="header_logo">
                <a rel="external" class="ui-link">
               <img height="25" alt="Your Store" title="Your Store" src="images/opmex/logo-mobile.png">
                </a>
            </div>
        	<div style="float:right; margin-top:5px;" data-form="ui-bar-a">
                <a rel="external" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/home-icon.png"></a>
                <a rel="external" href="tel:9876543210" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/phone-icon.png"></a>
                <a style="text-decoration:none;" rel="external" class="ui-link"><img height="25" style="margin-right:5px;" src="images/opmex/cart-icon.png"></a>
       		</div>
        </div>
        <div data-position="inline" data-role="navbar" class="ui-navbar ui-navbar-noicons" role="navigation">
            <ul class="ui-grid-c">
                <li class="ui-block-a"><a data-theme="c" data-form="ui-btn-up-c">Categories</a></li>
                <li class="ui-block-b"><a data-theme="c" data-form="ui-btn-up-c">Account</a></li>
                <li class="ui-block-c"><a data-theme="c" data-form="ui-btn-up-c">Search</a></li>
                <li class="ui-block-d"><a data-theme="c" data-form="ui-btn-up-c">Contact</a></li>
            </ul>
        </div>
         
    </div>
 
 	<div class="ui-content ui-body-a" data-theme="a" data-form="ui-body-a" data-role="content" role="main">
       <p style="margin: 18px 0;">
       Content Body - Sample & <a class="ui-link" data-form="ui-body-a" href="#" data-theme="a">links</a>.
       </p> 
            <table>
            <tr>
            <td><input type="text" placeholder="Quantity" class="input" data-form="ui-body-a" /></td>
            <td><button data-icon="plus" data-theme="b" data-form="ui-btn-up-b" data-inline="true">Add To Cart</button></td>
          </tr>
          </table>
        <div data-role="fieldcontain">
            <select name="select-choice-1" id="select-choice-1" data-native-menu="false" data-theme="a" data-form="ui-btn-up-a">
            <option value="1">Sort By Default</option>
            <option value="2">Name (A - Z)</option>
            <option value="3">Name (Z - A)</option>
            <option value="4">Price (Low > High)</option>
            <option value="5">Price (High > Low)</option>
            <option value="6">Rating (Highest)</option>
            <option value="7">Rating (Lowest)</option>
          </select>
          </div>
        <div data-role="fieldcontain">
            <fieldset data-role="controlgroup">
            <input type="radio" name="radio-choice-a" id="radio-choice-1-a" value="choice-1" checked="checked" />
            <label for="radio-choice-1-a" data-form="ui-btn-up-a">Register Account</label>
            <input type="radio" name="radio-choice-a" id="radio-choice-2-a" value="choice-2"  />
            <label for="radio-choice-2-a" data-form="ui-btn-up-a">Guest Checkout</label>
          </fieldset>
        </div>
        <div data-role="fieldcontain">
            <fieldset data-role="controlgroup" data-type="horizontal">
            <input type="radio" name="radio-view-a" id="radio-view-a-a" value="list" checked="checked"/>
            <label for="radio-view-a-a" data-form="ui-btn-up-a">List</label>
            <input type="radio" name="radio-view-a" id="radio-view-b-a" value="grid"  />
            <label for="radio-view-b-a" data-form="ui-btn-up-a">Grid</label>
          </fieldset>
          </div>
  	</div>
    
	<div class="ui-bar-c ui-footer" data-swatch="c" data-form="ui-bar-c" data-role="footer" role="contentinfo">
        <div data-role="navbar" class="ui-navbar" role="navigation">
                <ul class="ui-grid-c">
                    <li class="ui-block-a"><a data-icon="info" data-theme="c" data-form="ui-btn-up-c">Info</a></li>
                    <li class="ui-block-b"><a data-icon="gear" data-theme="c" data-form="ui-btn-up-c">Support</a></li>
                    <li class="ui-block-c"><a data-icon="plus" data-theme="c" data-form="ui-btn-up-c">Extras</a></li>
                    <li class="ui-block-d"><a data-icon="grid" data-theme="c" data-form="ui-btn-up-c">Account</a></li>
                </ul>
        </div>
    </div>
</div>

<!--<div id="highlight"> </div>-->

</body>
</html>
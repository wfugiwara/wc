//jQuery(function($) { 
//	$("table.list tr:even").addClass("even");
// 	$("table.list tr:odd").addClass("odd");
//});




jQuery(function($) { 
   //$("table.list tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
   $("table.list tr:nth-child(even)").addClass("even");
 });
 
 //jQuery(function($) { 
 //  $("table.list tr").mouseover(function(){$(this).addClass("over").css({backgroundColor: "#BCD4EC"});}).mouseout(function(){$(this).removeClass("over");});
//   $("table.list tr:nth-child(even)").addClass("even").css({backgroundColor: "#ECF6FC"});
// });



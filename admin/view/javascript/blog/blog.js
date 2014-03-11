$('.success img, .attention img, .warning img').live('click', function() {
   $(this).parent().fadeOut('slow', function() {
      $(this).remove();
   });
});

$('#tabs a').tabs();
$(document).ready (function() {
  
  $('.rounded').corner();
  $('#globalnav').corner({
  			  tl: false,
  			  tr: false,
  			  bl: { radius: 10 },
  			  br: { radius: 10 },
  			  autoPad: true,
  			  antiAlias: true
  });
  $('.content_header').corner({
  			  tl: { radius: 10 },
  			  tr: { radius: 10 },
  			  bl: false,
  			  br: false,
  			  autoPad: true,
  			  antiAlias: true
  });
  
  $('textarea.expanding').autogrow();
  
	$('span.pullquote').each(function() {
		text = $(this).text();
		text=text.replace( /\((.*)\)/gi, " " );
		if ($(this).is(".right")) 
			$(this).parent().before('<blockquote class="pullquote right"><p>&quot;'+ text +'&quot;</p></blockquote>');
		else
			$(this).parent().before('<blockquote class="pullquote"><p>&quot;'+ text +'&quot;</p></blockquote>');
	});
	
	$("#company_new #company_name").autocomplete('/companies/suggestions', {
  		matchContains: true
  });
  
  $("#company_new #company_name").result(function(event, q, formatted) {
      $("#company_new #company_logo").empty();
      $("#company_new #company_stock_symbol").val('');
      $("#company_new #company_description").val('').autogrow();;
      $("#company_new #company_website_url").val('');
      $("#company_new #company_google_cid").val('');
  		if (q) {
        $.getJSON("/companies/lookup.js?q="+escape(q),
        function(data){
          $("#company_new #company_stock_symbol").val(data.company.stock_symbol);
          $("#company_new #company_description").val(data.company.description).autogrow();
          $("#company_new #company_website_url").val(data.company.website_url);
          $("#company_new #company_google_cid").val(data.company.google_cid);
          $("<img/>").attr("src", "/companies/lookup_logo?stock_symbol="+data.company.stock_symbol).appendTo("#company_new #company_logo");
        });
  		}
  	});  
    
    $('.star-rating').rating({ 
      callback: function(value, link){ 
          $(this).parent().children('.rating_value').val(value); 
        }
    });

    
    
	  
});
(function(){

	//Create Namespace
	if(!window.CM) {window['CM'] = {}}	

	//Helper function to check if an element (i.e. div) exists. Argument is element id
	var exists = function(element) {
		if (!document.getElementById(element)) {
			return false;
		}
		else {
			return true;
		}
	}
	window['CM']['exists'] = exists;

	//Shows or hides div when element is clicked, depending on action parameter (can be show or hide)
	var deleteCompanyConfirm = function() {		
		$('.delete-company').click(function(){
			var deleteBttn = this;
			var companyId = document.getElementById("companyId").innerHTML;
			$.prompt('Do you really want to delete this company?',{ 
				buttons: { Delete: true, Cancel: false }, 
				submit: function(v,m){
					if(v){
						$.ajax({
			                // url: deleteBttn.href.replace('/companies/destroy/'+companyId,'/'),
							url: '/companies/destroy/'+companyId,
			                // type: 'POST',
			                // 	dataType: 'script',
			                // data: { '_method': 'destroy' },
			                success: function() {
								window.location.reload();
			                    // the item has been deleted
			                    // might want to remove it from the interface
			                    // or redirect or reload by setting window.location
								// url: '/admin'
			                }
			            });
					}

				}
			});
		});		
	}
	window['CM']['deleteCompanyConfirm'] = deleteCompanyConfirm;
	
	var logIn = function(){
		$('#login-link').click(function(e){
				e.preventDefault();
				var contact = "asdfasdfasdfs";
				// load the contact form using ajax
				$.get("/login", function(data){
					// create a modal dialog with the data
					$(data).modal({
						close: false,
						position: ["15%",],
						overlayId: 'contact-overlay',
						containerId: 'contact-container',
						onOpen: contact.open,
						onShow: contact.show,
						onClose: contact.close
					});
				});
	
			
		});
	}
	window['CM']['logIn'] = logIn;
	
	var formValidation = function(id){
		var formId = document.getElementById(id);
		$('#registerForm').validate();
	}
	window['CM']['formValidation'] = formValidation;	

})();
		

//All functions that need to be executed after page load go here

$(document).ready (function() {
		
	if(CM.exists('signup')){
		CM.formValidation('registerForm');
	}
	
	// CM.logIn();
	
	//If page is "Adminster Company", execute the following function
	if (CM.exists('administer-companies')) {
		CM.deleteCompanyConfirm();
	}

  // $('.rounded').corner();
  // $('#globalnav').corner({
  //   			  tl: false,
  //   			  tr: false,
  //   			  bl: { radius: 10 },
  //   			  br: { radius: 10 },
  //   			  autoPad: true,
  //   			  antiAlias: true
  //   });
  // 
  //   $('#search_q').click(function(evt){
  //     var obj = $(this);
  //     if(obj.attr('initialized') != 'true'){
  //       obj.val('');
  //       obj.attr('initialized', 'true');
  //     }
  // 
  //   });
  // 
  //     $('.rounded').corner();
  //     
  //   // $('#globalnav').corner({
  //   //           tl: false,
  //   //           tr: false,
  //   //           bl: { radius: 10 },
  //   //           br: { radius: 10 },
  //   //           autoPad: true,
  //   //           antiAlias: true
  //   //    });
  //      
  //   $('.content_header').corner({
  //          tl: { radius: 10 },
  //          tr: { radius: 10 },
  //          bl: false,
  //          br: false,
  //          autoPad: true,
  //          antiAlias: true
  //   });
  //   
  //   $('.content_box').corner({
  //          tl: { radius: 10 },
  //          tr: { radius: 10 },
  //          bl: false,
  //          br: false,
  //          autoPad: true,
  //          antiAlias: true
  //   });
  //   
  //     $('textarea.expanding').autogrow();
  //       
  //     $('span.pullquote').each(function() {
  //      text = $(this).text();
  //      text=text.replace( /\((.*)\)/gi, " " );
  //      if ($(this).is(".right")) 
  //        $(this).parent().before('<blockquote class="pullquote right"><p>&quot;'+ text +'&quot;</p></blockquote>');
  //      else
  //        $(this).parent().before('<blockquote class="pullquote"><p>&quot;'+ text +'&quot;</p></blockquote>');
  //     });
  //     
  //   $("#company_new #company_name").autocomplete('/companies/suggestions', {
  //        matchContains: true
  //     });
  //     
  //     $("#company_new #company_name").result(function(event, q, formatted) {
  //         $("#company_new #company_logo").empty();
  //         $("#company_new #company_stock_symbol").val('');
  //         $("#company_new #company_description").val('').autogrow();;
  //         $("#company_new #company_website_url").val('');
  //         $("#company_new #company_google_cid").val('');
  //        if (q) {
  //           $.getJSON("/companies/lookup.js?q="+escape(q),
  //           function(data){
  //             $("#company_new #company_stock_symbol").val(data.company.stock_symbol);
  //             $("#company_new #company_description").val(data.company.description).autogrow();
  //             $("#company_new #company_website_url").val(data.company.website_url);
  //             $("#company_new #company_google_cid").val(data.company.google_cid);
  //             $("<img/>").attr("src", "/companies/lookup_logo?stock_symbol="+data.company.stock_symbol).appendTo("#company_new #company_logo");
  //           });
  //        }
  //      });  
  //       
  //       $('.star-rating').rating({ 
  //         callback: function(value, link){ 
  //             $(this).parent().children('.rating_value').val(value); 
  //           }
  //       });
  //       
  //       $('.tablink').click(function () {
  //         clicked_tab = $(this);
  //         if (clicked_tab.attr('tab') == "follow_link") {
  //           return true
  //         } else {
  //           $(".tablink").each(function (i) {
  //             if ($(this).hasClass("on")) {
  //               $(this).removeClass("on");
  //               $(this).next().removeClass("tabimg_right_on").addClass("tabimg_right_off");
  //               $(this).prev().removeClass("tabimg_left_on").addClass("tabimg_left_off");
  //               $('#' + $(this).attr('tab')).fadeOut(function() {
  //                  $('#' + clicked_tab.attr('tab')).fadeIn();
  //                });
  //             };
  //           });
  //           clicked_tab.addClass("on");
  //           clicked_tab.next().addClass("tabimg_right_on");
  //           clicked_tab.prev().addClass("tabimg_left_on");
  //           return false;
  //         }
  //       });
  //   
  //       $("#slider").slider({ 
  //                   min: 0, 
  //                   max: 10,
  //                   stepping: 1, 
  //                   startValue: 5,
  //                   slide: function(e,ui) {
  //                      $("#slider-value").html(ui.value);
  //                      switch (Math.round(parseInt(ui.value)/2)) {
  //                       case 5:
  //                         var color = "#2a9641";
  //                         break;
  //                       case 4:
  //                         var color = "#a6d96a";
  //                         break;
  //                       case 3:
  //                         var color = "#d6b57e";
  //                         break;
  //                       case 2:
  //                         var color = "#f46d43";
  //                         break;
  //                       case 1:
  //                         var color = "#d25754";
  //                         break;
  //                      }
  //                      $("#slider-value").css('color',color);
  //                   }
  //       });
  // 
  // 	
});
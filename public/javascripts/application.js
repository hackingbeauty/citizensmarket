(function(){

	//Create Namespace
	if(!window.CM) {window['CM'] = {}}	

	//Helper function to check if an element (i.e. div) exists. Argument is element id
	var exists = function(element) {
		if (!document.getElementById(element)) {
			return false;
		} else {
			return true;
		}
	}
	window['CM']['exists'] = exists;
	
	//Confirmation when deleting a company
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
			            });//end ajax
					}//end if
				}//end submit
			});//end prompt
		});//end click		
	}//end function
	window['CM']['deleteCompanyConfirm'] = deleteCompanyConfirm;
	
	//Forgot Password modal 
	var forgotPassword = function(){
		$('#forgot-password-link').click(function(e){
				e.preventDefault();
				var imageLarge = "<p>blah blah</p>"
				$.prompt(imageLarge,{ 
					// buttons: { Delete: true, Close: false }, 
				});
				// ajax call
				// $.get("/forgot", function(data){
				// 	// create a modal dialog with the data
				// 	$(data).modal({
				// 		close: false,
				// 		position: ["15%",],
				// 		overlayId: 'contact-overlay',
				// 		containerId: 'contact-container',
				// 		onOpen: contact.open,
				// 		onShow: contact.show,
				// 		onClose: contact.close
				// 	});
				// });// end get
		});// end click
	}//end function
	window['CM']['forgotPassword'] = forgotPassword;
	
	//In-line validation for Registration form
	var registrationFormValidation = function(){
		$('#register-form').validate({
			rules: {
				'user[firstname]': {
	                required: true,
					minlength: 1,
	            },
				'user[lastname]': {
	                required: true,
					minlength: 1,
	            },
				'user[email]': {
	                required: true,
	                email: true
	            },
	            'user[password]': {
	                required: true,
	                minlength: 6,
	            },
	            'user[password_confirmation]': {
	                required: true,
	                equalTo: "#user_password"
	            },
	            'user[agree_to_terms]': "required"
	        },
	        messages: {
		        'user[firstname]': {
					required: "Please enter your first name"
				},
				'user[lastname]': {
					required: "Please enter your last name"
				},
		        'user[email]': {
					required: "Please enter your email address",
					email: "Please enter a valid email address"
				},
	            'user[password]': {
	                required: "Please provide a password",
	                minLength: "Your password must be at least 5 characters long"
	            },
	            'user[password_confirmation]': {
	                required: "Confirm your password",
	                equalTo: "Please enter the same password as above"
	            },
	            'user[agree_to_terms]': "Please accept our policy"
	        }
		});
	}
	window['CM']['registrationFormValidation'] = registrationFormValidation;
	
	//Clear search-box default text when user clicks inside
	var searchBoxClearText = function(){
		$('#search_q').click(function(){
			this.value = "";
		});
	}
	window['CM']['searchBoxClearText'] = searchBoxClearText;
	
	//Function to embed Flash media
	var embedFlash = function(media,div,width,height){
		var flashvars = {};
		var params = {wmode:"transparent"};
		var attributes = {};
		swfobject.embedSWF("/swf/path-to-swf", div, height, width, "9.0.0","flash/expessInstall.swf", flashvars, params, attributes);
	}
	window['CM']['embedFlash'] = embedFlash;
		
})();
		

//All functions that need to be executed after page load go here

$(document).ready (function() {
		
	if(CM.exists('search_q')){
		CM.searchBoxClearText();
	}
	
	if(CM.exists('register')){
		CM.registrationFormValidation();
	}

	if (CM.exists('administer-companies')) {
		CM.deleteCompanyConfirm();
	}
	
	// if (CM.exists('login')) {
	// 	CM.forgotPassword();
	// }
		
});
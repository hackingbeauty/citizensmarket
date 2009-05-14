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
	
	//Login modal 
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
				});// end get
		});// end click
	}//end function
	window['CM']['logIn'] = logIn;
	
	//In-line validation for Registration form
	var formValidation = function(){
		$('#register-form').validate({
			rules: {
	            password: {
	                required: true,
	                minlength: 5,
	            },
	            confirm_password: {
	                required: true,
	                equalTo: "#password"
	            },
	            email: {
	                required: true,
	                email: true
	            },
	            agree_to_terms: "required"
	        },
	        messages: {
	            password: {
	                required: "Please provide a password",
	                minLength: "Your password must be at least 5 characters long"
	            },
	            confirm_password: {
	                required: "Confirm your password",
	                equalTo: "Please enter the same password as above"
	            },
	            email: {
					required: "Please enter your email address",
					email: "Please enter a valid email address"
				},
	            agree_to_terms: "Please accept our policy"
	        }
		});
	}
	window['CM']['formValidation'] = formValidation;
	
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
		CM.formValidation();
	}

	if (CM.exists('administer-companies')) {
		CM.deleteCompanyConfirm();
	}
	
});
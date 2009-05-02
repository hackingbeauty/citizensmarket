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
	var formValidation = function(id){
		var formId = document.getElementById(id);
		$('#registerForm').validate();
	}
	window['CM']['formValidation'] = formValidation;	

})();
		

//All functions that need to be executed after page load go here

$(document).ready (function() {
	
	//If page is "Registration", execute the following function	
	if(CM.exists('signup')){
		CM.formValidation('registerForm');
	}

	//If page is "Adminster Company", execute the following function
	if (CM.exists('administer-companies')) {
		CM.deleteCompanyConfirm();
	}

});
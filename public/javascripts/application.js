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
	
	var videoClick = function(){
		$('#video').click(function(){
			$(this).css('background','none');
			$(":nth-child(1)").css('visibility','visible');
		});
	}
	window['CM']['videoClick'] = videoClick;
	
	//Sign In Modal
	var logIn = function() {
		$('#login-bttn').click(function(){
			$('#flash-errors').html("");
		});
		$('#login-form').jqm({
			modal: true, 
			trigger: '#login-bttn'
		});

	var paintStars = function(){
		$('.fixed_star_rating').stars({inputType: "select", disabled: true, split: 2});
		$('.editable_star_rating').stars({inputType: "select", split: 2});
	}
	window['CM']['paintStars'] = paintStars;
	
	//Sign In Button Drop Down Menu
	var signInDropDown = function() {
		$('#login-form').jqm({modal: true, trigger: '#login-bttn'});

		return false;		
	}//end function
	window['CM']['logIn'] = logIn;
	
	var logInSubmit = function(){
		var options = { 
			target:    '#login-body',   // target element(s) to be updated with server response 
			type:      'post',        // 'get' or 'post', override for form's 'method' attribute 
			dataType:  'json',       // 'xml', 'script', or 'json' (expected server response type)
			success:   logInSuccess,  // post-submit callback 
			error: 				logInError
			// beforeSubmit:  showRequest,  // pre-submit callback 
			// other available options: 
			//url:       url         // override for form's 'action' attribute
			//clearForm: true        // clear all form fields after successful submit 
			//resetForm: true        // reset the form after successful submit 
			// $.ajax options can be used here too, for example: 
			//timeout:   3000 
		}
		$('#sign-in-form').submit(function() {
		  $(this).ajaxSubmit(options);
		  return false;
		})
	}
	window['CM']['logInSubmit'] = logInSubmit;
	
	var logInSuccess = function(responseText, statusText){
		alert('success yessss ' +  responseText + ' ' + statusText);
	}
	//No need to make this method public
	
	var logInError = function(responseText, statusText){
		alert('error ' + responseText + ' ' + statusText);
	}
	//No need to make this method public
		
	var toolTip = function(){
		$('.tooltip').tooltip({
			delay: 0,
			showURL: false,
			bodyHandler: function() {
				// return $("<img/>").attr("src", this.src);'
				var toolTipBlurb = $(this).next().html();
				// alert(html);
				if(toolTipBlurb != ''){
					return $("<span class='rounded'>"+toolTipBlurb+"</span>");
				}
			}
		});
	}
	window['CM']['toolTip'] = toolTip;
	
	//Inline validation for Registration form
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
         'user[terms_of_use]': {
					required: true
				}
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
   		'user[terms_of_use]': {
					required: "Please accept our policy" 
				}
	    }
		});
	}
	window['CM']['registrationFormValidation'] = registrationFormValidation;
	
	// var registerSubmit = function(){
	// 	var options = { 
	// 		target:    '#register-body',   // target element(s) to be updated with server response 
	// 		type:      'post',        // 'get' or 'post', override for form's 'method' attribute 
	// 		dataType:  'script',       // 'xml', 'script', or 'json' (expected server response type)
	// 		// success:   registerSuccess  // post-submit callback 
	// 		// error: 				registerError
	// 	};
	// 	$('#register-form').submit(function() {
	// 	  $(this).ajaxSubmit(options)
	// 	  return false;
	// 	})
	// }
	// window['CM']['registerSubmit'] = registerSubmit;
		
	//Clear search-box default text when user clicks inside
	var searchBoxClearText = function(){
		$('#search_q').val("Search Citizens Market");
		$('#search_q').css('color','#b4b2b2');
		$('#search_q').click(function(){
			this.value = "";
			$(this).css('color','black');
		});
		$('#search_q').blur(function(){
			$(this).val("Search Citizens Market");
			$(this).css('color','#b4b2b2');
		});
	}
	window['CM']['searchBoxClearText'] = searchBoxClearText;
	
	//Search Click
	var searchClick = function(){
		$('#search_submit').click(function(){

			return false;
		});
	}
	window['CM']['searchClick'] = searchClick;
	
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

	CM.searchClick();
	
	// Too many places where stars might appear to use if(exists...)
	CM.paintStars();
	
	if(CM.exists('homepage')){
		CM.videoClick();
	}
	
	if(CM.exists('companies')){
		CM.toolTip();
	}
	
	if(CM.exists('login-bttn')) {
		CM.logIn();
		CM.logInSubmit();
	}
		
	if(CM.exists('register')){
		CM.registrationFormValidation();
	}

	if (CM.exists('administer-companies')) {
		CM.deleteCompanyConfirm();
	}
		
});
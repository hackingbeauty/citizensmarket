// cm_chained_selects.js
// By Luke Griffiths
//
// copyright Citizens Market 2008

jQuery.fn.chained_select = function(target, data){
		$(this).change( function(){				
			///////////
			var current_value = $(this).val();
			string = "({aaa:'a', bbb:'B'})";
			data = eval(data);//get json array
			$(target).html("");//clear old options
			
			$(target).get(0).add(new Option('', '                                                             '), null);
			sub_data = data[current_value];
			for ( key in sub_data){	
				$(target).get(0).add(new Option(sub_data[key],[key]), null);
            }
			
		})
}
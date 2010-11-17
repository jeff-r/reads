$(function() {
  if (!window.console) {      
    window.console = {};
    window.console.log = function(){};
  }

	$('.mark_as_read_button').click(jr.onMarkAsRead);
	$('a').attr('target', "_blank");
});

var jr = {};

jr.onMarkAsRead = function(event) {
	event.preventDefault();

	// window.aaa = event;
	// window.aab = event.currentTarget.form.parentNode.action;
	// window.aab = event.currentTarget.form.parentNode;
	var id = $(this).attr('data-itemid');
	console.log('id: ' + id);
	var url = "/feed_items/" + id + ".xml"
	var div = $(this).parents(".item")[0];


	$.ajax({
		type: 'POST',
		url: url,
		data: "_method=put&read_item_id=" + id,
		success: function() {
			console.log('Success');
			$(div).fadeOut(1000);
		},
		complete: function() {
			console.log('complete');
		},
		error: function(msg) {
			console.log('error: ' + msg);
			window.aaa = msg;
			$(div).hide('blind');
		}
		
	});





	// $(this).fadeOut('slow', function() {
	// 	$.ajax({
	// 		type: 'POST',
	// 		url: url,
	// 		data: "_method=put"
	// 	});
	// 	console.log('Made ajax call');
	// });
	console.log('target: ' + event.currentTarget.baseURI);
}

jr.showAllMembers = function(obj) {
	console.log('showAllMembers');
	var key;
	for (key in obj) {
		if (obj.hasOwnProperty(key))
			console.log('obj[' + key + ']: ' + obj[key]);
	}
}
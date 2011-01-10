$(function() {
  if (!window.console) {      
    window.console = {};
    window.console.log = function(){};
  }

	$('.mark_as_read_button').click(jr.onMarkAsRead);
	$("a[href^=http://]").attr('target', "_blank");
	jr.setup_nav_draggables();
});

var jr = {};

jr.setup_nav_draggables = function() {
	$('.sortable').sortable({ 
				placeholder: 'ui-state-highlight',
				forcePlaceholderSize: true,
				forceHolderSize: true
				});
};


jr.onMarkAsRead = function(event) {
	event.preventDefault();

	var id = $(this).attr('data-itemid');
	console.log('id: ' + id);

  // rails knows where the root_url of the app is, but we don't 
  // So populate the value with rails, and read it here, in javascript
  var root_url = $('#feed_header').attr('data-basepath');
	var url = root_url + "feed_items/" + id + ".xml"
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
}

jr.showAllMembers = function(obj) {
	console.log('showAllMembers');
	var key;
	for (key in obj) {
		if (obj.hasOwnProperty(key))
			console.log('obj[' + key + ']: ' + obj[key]);
	}
}

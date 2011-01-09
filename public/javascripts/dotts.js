$(function() {
  if (!window.console) {      
    window.console = {};
    window.console.log = function(){};
  }

  $('.traillinks').sortable({ connectWith: '.traillinks', update:jr.ondrop_link });
  $('.traillist').sortable({ connectWith: '.traillist', update:jr.ondrop_trail_list });
  // $('.column').sortable( { connectWith: ".column #pagelist", update: jr.ondrop_trail } );
  $('.column').sortable( { connectWith: ".column", update: jr.ondrop_trail } );
  
  $('.datetimefield').datetimepicker( { 
      dateFormat: 'yy-mm-dd',
      timeFormat: 'hh:mm' 
      });
  // format '2010-12-02 07:53'

  $('.deletelink').click(jr.ondeleteclick);
  $('.trailtitlecommand').click(jr.onTitleCommandClick);
	$("a[href^=http://]").attr('target', "_blank");
  
  $('.close-on-success').click(function(event) {
    event.preventDefault();
    // we just need to add the key/value pair for the DELETE method
    // as the second argument to the JQuery $.post() call
    console.log($(this).parent().parent().attr('action'));
  });

});

jr.onTitleCommandClick = function(event, ui) {
  event.preventDefault();
  console.log(this.href);
  $.ajax({
      url: this.href,
      dataType: 'html',
      type: 'POST'
      });

  $('.traillinks').removeClass('currenttrail');
  var traildiv = $(this).parent().parent();
  $('.traillinks', traildiv).addClass('currenttrail');

}

jr.ondrop_trail_list = function(event, ui) {
  console.log ("*** ondrop_trail_list")
  var els = $('div', $(event.target));
  var pagediv = els.parent().parent();
  var pagetitle = $('div.pagetitle', pagediv);
  var page_id = pagetitle.attr('data-pageid');

  console.log ("page_id: " + page_id);
  var n;
  var indexes = [];
  for (n=0; n<els.length; n++) {
    var el = $(els[n]);
    var a = el.attr('data-id');
    indexes[n] = a;
    console.log('a = ' + a);
  }
  
  // rails knows where the root_url of the app is, but we don't 
  // So populate the value with rails, and read it here, in javascript
  var root_url = $('#all_trails_div').attr('data-basepath');
  var url = root_url + 'trails/sort_trails_list/';
  console.log(url);
  $.ajax({
      url: root_url + 'trails/sort_trails_list/',
      data: {page_id: page_id, indexes: indexes},
      dataType: 'html',
      type: 'POST'
      });
}

jr.ondrop_link = function(event, ui) {
  var els = $('div', $(event.target));
  var traildiv = els.parent().parent();
  var trailtitle = $('div.trailtitle', traildiv);
  var trail_id = trailtitle.attr('data-trailid');
  var n;
  var indexes = [];
  for (n=0; n<els.length; n++) {
    var el = $(els[n]);
    var a = el.attr('data-id');
    indexes[n] = a;
  }

  // rails knows where the root_url of the app is, but we don't 
  // So populate the value with rails, and read it here, in javascript
  var root_url = $('#all_trails_div').attr('data-basepath');
  $.ajax({
      url: root_url + '/links/sortorder/',
      data: {trail_id: trail_id, indexes: indexes},
      dataType: 'html',
      type: 'POST'
      });
}

jr.ondrop_trail = function(event, ui) {
  var column_index = $(event.target).attr('data-column');

  var els = $('div.trailtitle', $(event.target));
  var n;
  var indexes = [];
  for (n=0; n<els.length; n++) {
    var el = $(els[n]);
    var a = el.attr('data-trailid');
    indexes[n] = a;
  }

  // rails knows where the root_url of the app is, but we don't 
  // So populate the value with rails, and read it here, in javascript
  var root_url = $('#all_trails_div').attr('data-basepath');
  $.ajax({
      url: root_url + 'trails/sortorder/',
      data: {column_index: column_index, indexes: indexes},
      dataType: 'html',
      type: 'POST'
      });
}

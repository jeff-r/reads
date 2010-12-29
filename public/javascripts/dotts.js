$(function() {
  if (!window.console) {      
    window.console = {};
    window.console.log = function(){};
  }

  // $('.traildiv').sortable();

  //$('.traillinks').sortable( { update: function(event, ui) {console.log("in receive")} });

  //$('.column').sortable();
  //$('.traildiv').sortable({ connectWith: '.traildiv' });
  
  $('.traillinks').sortable({ update:jr.ondrop });
  
  $('.column').sortable( { connectWith: ".column", update: jr.ondrop_trail } );
  
  $('.datetimefield').datetimepicker( { 
      dateFormat: 'yy-mm-dd',
      timeFormat: 'hh:mm' 
      });
  // format '2010-12-02 07:53'
  $('.deletelink').click(jr.ondeleteclick);
  $('.titlecommand').click(jr.onTitleCommandClick);
	$("a[href^=http://]").attr('target', "_blank");
  

  $('.close-on-success').click(function(event) {
    event.preventDefault();
    // we just need to add the key/value pair for the DELETE method
    // as the second argument to the JQuery $.post() call
    //$.post(this.href, { _method: 'delete' }, null, "script");
    console.log($(this).parent().parent().attr('action'));
  });
});

// var jr = {};
jr.hostname = "http://localhost:3000";
// jr.hostname = "http://jeffroush.dyndns.org/trails";

jr.onTitleCommandClick = function(event, ui) {
  event.preventDefault();
  console.log(this.href);
  $.ajax({
      url: this.href,
      dataType: 'html',
      type: 'POST'
      });

  $('.traillinks').removeClass('currenttrail');
  //var traildiv = this.parent;
  var traildiv = $(this).parent().parent();
  // console.log(traildiv)
  $('.traillinks', traildiv).addClass('currenttrail');
  // $('.traillinks').addClass('currenttrail');

}

jr.ondrop = function(event, ui) {
  var els = $('div', $(event.target));
  var n;
  var indexes = [];
  for (n=0; n<els.length; n++) {
    var el = $(els[n]);
    var a = el.attr('data-id');
    indexes[n] = a;
  }

  // and now indexes is an array of the indexes of the links
  for (n=0; n<indexes.length; n++) {
    console.log("indexes[" + n + "] = " + indexes[n]);
  }

  $.ajax({
      url: jr.hostname + '/links/',
      data: {indexes: indexes},
      dataType: 'html',
      type: 'POST'
      });
}
jr.ondrop_trail = function(event, ui) {
  var column_index = $(event.target).attr('data-column');
  console.log("column: " + column_index);
  var els = $('div.trailtitle', $(event.target));
  var els = $('div.trailtitle', $(event.target));
  var n;
  var indexes = [];
  for (n=0; n<els.length; n++) {
    var el = $(els[n]);
    var a = el.attr('data-trailid');
    console.log ("*** " + a);
    indexes[n] = a;
  }

  // and now indexes is an array of the indexes of the links
  for (n=0; n<indexes.length; n++) {
    console.log("indexes[" + n + "] = " + indexes[n]);
  }

  $.ajax({
      url: jr.hostname + '/trails/sortorder/',
      data: {column_index: column_index, indexes: indexes},
      dataType: 'html',
      type: 'POST'
      });
}

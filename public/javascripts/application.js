$(function() {

  var $tabs = $("#tabs").tabs();

  var $tab_items = $("ul:first li",$tabs).droppable({
    accept: ".sortable li",
    hoverClass: "ui-state-hover",
    drop: function(ev, ui) {
      var $item = $(this);
      var $list = $($item.find('a').attr('href')).find('.sortable');

      ui.draggable.hide('slow', function() {
        $tabs.tabs('select', $tab_items.index($item));
        $(this).appendTo($list).show('slow');
      
        // Make an update to the controller to update the entry in the list-task table
        // to reflect that this task is now in a new list
        id =  $(this).parent().attr("id").split("_")[1];
        task_id = $(this).attr("id").split("_")[1];

        $list_to_sort = $(this).parent();

        $.post('/lists/' + id + '/add', {task_id: task_id}, function(){
          
          $.post('/lists/' + id + '/sort', $list_to_sort.sortable('serialize'));
          });
        
        });
    }
  });
  
		
  $(".sortable").disableSelection();
  
  $(".sortable").sortable({
    placeholder: 'ui-state-highlight',
    cursorAt: { cursor: "move", top: 5, left: 445},
    update : function() {
      id =  $(this).attr("id").split("_")[1];
      $.post('/lists/'+ id + '/sort',
        $(this).sortable('serialize'));
    },
    start: function() {
      $("#pin-icon").addClass("hide");
    },
    stop: function() {
      $("#pin-icon").removeClass("hide");
    }
  });

  $("#new-task-form").submit(function(){

    $.post("/tasks/",
            $(this).serialize(), 
            function(task, status){
              $(".master").append(task);},
            "html"); 
    
    return false;
  });

});


$(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
  .find(".portlet-header")
    .addClass("ui-widget-header ui-corner-all")
    .prepend('<span class="ui-icon ui-icon-plusthick"></span>')
    .end()
  .find(".portlet-content");

$(".portlet-header .ui-icon").click(function() {
  $(this).toggleClass("ui-icon-minusthick").toggleClass("ui-icon-plusthick");
  $(this).parents(".portlet:first").find(".portlet-content").toggle();
});

/* set global variable for boxy window */
var contactBoxy = null;
/* what to do when click on contact us link */
$('#contact_us').click(function(){
    var boxy_content;
    boxy_content += "<div style=\"width:300px; height:300px\"><form id=\"feedback\">";
    boxy_content += "<p>Task name:<br /><input type=\"text\" name=\"subject\" id=\"subject\" size=\"41\" /></p><p>Number of pomodoros:<br /><input type=\"text\" name=\"your_email\" size=\"41\" /></p><p>description:<br /><textarea name=\"comment\" id=\"comment\" cols=\"35\" rows=\"5\"></textarea></p><br /><input type=\"submit\" name=\"submit\" value=\"add >>\" />";
    boxy_content += "</form></div>";
    contactBoxy = new Boxy(boxy_content, {
        title: "Add new task",
        draggable: false,
        modal: true,
        behaviours: function(c) {
            c.find('#feedback').submit(function() {
                Boxy.get(this).setContent("<div style=\"width: 300px; height: 300px\">Sending...</div>");
                // submit form by ajax using post and send 3 values: subject, your_email, comment
                $.post("feedback.php", { subject: c.find("input[name='subject']").val(), your_email: c.find("input[name='your_email']").val(), comment: c.find("#comment").val()},
                function(data){
                    /*set boxy content to data from ajax call back*/
                    contactBoxy.setContent("<div style=\"width: 300px; height: 300px\">"+data+"</div>");
                });
                return false;
            });
        }
    });
    return false;
});




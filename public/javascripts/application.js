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

//------------------------------
                //  Retro Countdown
                //------------------------------
                
                $('#countdown-retro').epiclock({mode: $.epiclock.modes.loop, offset: {minutes: 25}, format: 'i:s', renderer: 'retro-countdown'}).bind('timer', function ()
                {
                   $li =  $($(".current").children()[0]);
                   $li.find("#tomato_bg-icon:first").attr("id","tomato-icon"); 
                });
                
                //------------------------------
                //
                //  Define the controls
                //
                //------------------------------
                
                $('#pause').click(function ()
                {
                    $.epiclock.pause();
                });
                
                $('#resume').click(function ()
                {
                    $.epiclock.resume();
                });
                
                $('#restart').click(function ()
                {
                    $.epiclock.restart();
                });
    
      $.epiclock.pause();

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
    $('#new-task').click(function(){
        var boxy_content;
        boxy_content += "<div style=\"width:300px; height:300px\"><form id=\"feedback\">";
        boxy_content += "<form accept-charset=\"UTF-8\" action=\"/tasks\" id=\"new-task-form\" method=\"post\"><div style=\"margin:0;padding:0;display:inline\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" /><input name=\"authenticity_token\" type=\"hidden\" value=\"nKQTIvO7cUBCZcJQkRNJ39O1QNNi3wIHc7nEve5m3cc=\" /></div><input id=\"task_name\" name=\"task[name]\" size=\"30\" type=\"text\" value=\"task name\" /><select id=\"task_estimate\" name=\"task[estimate]\"><option value=\"\">estimated pomodoros</option><option value=\"1\">1</option><option value=\"2\">2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option></select><input id=\"task_tag_list\" name=\"task[tag_list]\" size=\"30\" type=\"text\" value=\"tags\" /><input id=\"task_submit\" name=\"commit\" type=\"submit\" value=\"Add Task\" />";
        boxy_content += "</form></div>";
        contactBoxy = new Boxy(boxy_content, {
            title: "Add new task",
            draggable: false,
            modal: true,
            behaviours: function(c) {
                c.find('#feedback').submit(function() {
                    $.post("/tasks/",
                      $(this).serialize(), 
                      function(task, status){
                        $(".master").append(task);},
                      "html"); 
                              return false;
                          });
            }
        });
        return false;
    });
/* set global variable for boxy window */
    var contactBoxy = null;
    /* what to do when click on contact us link */
    $('#about').click(function(){
        var boxy_content;
        boxy_content += "<div style=\"width:300px; height:300px\">This app is based on the Pomodoro Technique and was build in a 48 hour web application development competition (<a href=\"http://railsrumble.com/\">Rails Rumble</a> 2010) by <a href=\"http://twitter.com/thedelchop\">@thedelchop</a> and <a href=\"http://twitter.com/aaronball09\">@aaronball09</a>.";
        boxy_content += "</div>";
        contactBoxy = new Boxy(boxy_content, {
            title: "About",
            draggable: false,
            modal: true
        });
        return false;
    });
	
	    $('#info').click(function(){
        var boxy_content;
        boxy_content += "<div style=\"width:300px; height:300px\"> The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down periods of work into 25-minute intervals called 'pomodoros' (from the Italian word for 'tomato') separated by breaks.<br><br> - <a href=\"http://en.wikipedia.org/wiki/Pomodoro_Technique\">wikipedia</a>";
        boxy_content += "</div>";
        contactBoxy = new Boxy(boxy_content, {
            title: "Pomodoro Technique",
            draggable: false,
            modal: true
        });
        return false;
    });
});






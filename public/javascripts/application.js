$(function() {

  contentArranger.init();

  $('#tabs-wrapper').tabs({
    panelTemplate: "<ul class=\"task-list\"></ul>"
    // ajaxOptions:{
    //   dataFilter: function(data,type){
    //     
    //     tasks = $.parseJSON(data); 
    //    
    //     var output = '';

    //     $.each(tasks, function(index, task){
    //       // Build an ul of tasks
    //       var source =  "<li id=\"task_{{id}}\">" + 
    //                       "<span id=\"pin-icon\"></span>" + 
    //                       "<div class=\"fields-wrapper\">" + 
    //                         "<div class=\"inputs\">{{name}}{{#tomatoes}}{{/tomatoes}}</div>" +
    //                       "</div>" + 
    //                       "<form method=\"delete\" action=\"/tasks/{{id}}\" class=\"delete\">" +
    //                          "<input name=\"_method\" type=\"hidden\" value=\"delete\" />" + 
    //                          "<input type=\"submit\" value=\"\" class=\"delete_button\" />" + 
    //                          "<input name=\"authenticity_token\" type=\"hidden\" value=" + window._token + "/>" + 
    //                       "</form>" +
    //                     "</li>";

    //       var tomatoes = function(context, fn){
    //           var result = "";
    //           for (i=0; i < this.__get__("estimate"); i++){
    //             result += "<span class=\"estimated_pomodoros\" id=\"tomato_bg-icon\"></span>";}
    //           return result;
    //       };
    //       var template = Handlebars.compile(source);
    //       output += template(task, { "tomatoes": tomatoes });
    //     });
    //    
    //     return output; 
    //   }
    // }
  });
  
  $('input:text').focus(function(){
      $(this).val("");
      $(this).css({
         "border-color" : "white",
         "font-weight" : "normal"
        });
    });

  $('.delete').live("submit",function(){
    id = $(this).attr("action").split('/')[2];

    $.ajax({
      url: $(this).attr("action"),
      type: "DELETE",
      data: {"id" : id},
      success: function(response){
        if(response.success == "true"){
          $("li#task_" + id).remove();
        }  
      }
    });

    return false;
  });

  $('.edit-button').live("click",function(){
    id = $(this).attr("href").split('/')[2];
    
    $.ajax({
      url: '/tasks/'+id,
      type: "PUT",
      data: {"id" : id},
      success: function(response){
        if(response.success == "true"){
          $("li#task_" + id).remove();
        }  
      }
    });
  });

  $('#new-task-form').submit(function(){
    $.ajax({
      url: "/tasks/",
      type: "POST",
      data: $(this).serialize(), 
      dataType: "json",
      success: function(task){
       
        if(task.success == "true"){ 
          var source =  "<li id=\"task_{{task/id}}\" class=\"task\">" +
                          "<div class=\"icons-wrapper\">" +  
                            "<span class=\"pin-icon icon\"></span>" +
                            "<span class=\"edit-delete-buttons\">" + 
                              "<a class=\"edit_button_icon\" href=\"tasks/{{task/id}}/edit\" src=\"/images/edit.png\" alt=\"Edit\"></a>"+
                              "<form method=\"delete\" action=\"/tasks/{{task/id}}\" class=\"delete icon\">" +
                                 "<input name=\"_method\" type=\"hidden\" value=\"delete\" />" + 
                                 "<input type=\"image\" src=\"/images/cross.png\" class=\"delete_button\"/>" + 
                                 "<input name=\"authenticity_token\" type=\"hidden\" value=" + window._token + "/>" + 
                              "</form>" +
                            "</span>" + 
                          "</div>" +
                          "<div class=\"fields-wrapper\">" + 
                            "<div>{{task/name}}{{#tomatoes}}{{/tomatoes}}</div>" +
                          "</div>" + 
                        "</li>";

          var tomatoes = function(context, fn){
              var result = "";
              for (i=0; i < this.__get__("task/estimate"); i++){
                result += "<span class=\"estimated_pomodoros tomato_bg-icon icon\"></span>";}
              for (i=0; i < this.__get__("task/completed"); i++){
                   $.find("#tomato_bg-icon:first").attr("id","tomato-icon"); 
                result += "<span class=\"completed_pomodoros tomato-icon icon\"></span>";}
              for (i=0; i < this.__get__("task/overage"); i++){
                result += "<span class=\"overage_pomodoros over-tomato-icon icon\"></span>";}

              return result;
          };
          
          var template = Handlebars.compile(source);

          var result = template(task, { "tomatoes": tomatoes });

          $("#master-list").append(result);
        }
        else{
          // This indicates that the task couldn't be save so just render the error information
          $.each(task.errors,function(key, value){
            // Fill in each of the error divs with the information concerning that div 
            $("#task-"+ key).val(value);
            $("#task-"+ key).css({
              "border-color": "red",
              "border-width": "3px",
              });
          });
        }
        
        $("#flash").html(task.notice);
      },
      dataType: "json"});

    return false;
  });

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

// //------------------------------
//                 //  Retro Countdown
//                 //------------------------------
//                 
//                 $('#countdown-retro').epiclock({mode: $.epiclock.modes.loop, offset: {minutes: 25}, format: 'i:s', renderer: 'retro-countdown'}).bind('timer', function ()
//                 {
//                    $li =  $($(".current").children()[0]);
//                    $li.find("#tomato_bg-icon:first").attr("id","tomato-icon"); 
//                 });
//                 
//                 //------------------------------
//                 //
//                 //  Define the controls
//                 //
//                 //------------------------------
//                 
//                 $('#pause').click(function ()
//                 {
//                     $.epiclock.pause();
//                 });
//                 
//                 $('#resume').click(function ()
//                 {
//                     $.epiclock.resume();
//                 });
//                 
//                 $('#restart').click(function ()
//                 {
//                     $.epiclock.restart();
//                 });
//     
//       $.epiclock.pause();
// 
//     $(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
//       .find(".portlet-header")
//         .addClass("ui-widget-header ui-corner-all")
//         .prepend('<span class="ui-icon ui-icon-plusthick"></span>')
//         .end()
//       .find(".portlet-content");
// 
//     $(".portlet-header .ui-icon").click(function() {
//       $(this).toggleClass("ui-icon-minusthick").toggleClass("ui-icon-plusthick");
//       $(this).parents(".portlet:first").find(".portlet-content").toggle();
//     });
// 
//     /* set global variable for boxy window */
//     var contactBoxy = null;
//     /* what to do when click on contact us link */
//     $('#new-task').click(function(){
//         var boxy_content;
//         boxy_content += "<div style=\"width:300px; height:300px\"><form id=\"feedback\">";
//         boxy_content += "<form accept-charset=\"UTF-8\" action=\"/tasks\" id=\"new-task-form\" method=\"post\"><div style=\"margin:0;padding:0;display:inline\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" /><input name=\"authenticity_token\" type=\"hidden\" value=\"nKQTIvO7cUBCZcJQkRNJ39O1QNNi3wIHc7nEve5m3cc=\" /></div><input id=\"task_name\" name=\"task[name]\" size=\"30\" type=\"text\" value=\"task name\" /><select id=\"task_estimate\" name=\"task[estimate]\"><option value=\"\">estimated pomodoros</option><option value=\"1\">1</option><option value=\"2\">2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option></select><input id=\"task_tag_list\" name=\"task[tag_list]\" size=\"30\" type=\"text\" value=\"tags\" /><input id=\"task_submit\" name=\"commit\" type=\"submit\" value=\"Add Task\" />";
//         boxy_content += "</form></div>";
//         contactBoxy = new Boxy(boxy_content, {
//             title: "Add new task",
//             draggable: false,
//             modal: true,
//             behaviours: function(c) {
//                 c.find('#feedback').submit(function() {
//                     $.post("/tasks/",
//                       $(this).serialize(), 
//                       function(task, status){
//                         $(".master").append(task);},
//                       "html"); 
//                               return false;
//                           });
//             }
//         });
//         return false;
//     });
// /* set global variable for boxy window */
//     var contactBoxy = null;
//     /* what to do when click on contact us link */
//     $('#about').click(function(){
//         var boxy_content;
//         boxy_content += "<div style=\"width:300px; height:300px\">This app is based on the Pomodoro Technique and was build in a 48 hour web application development competition (<a href=\"http://railsrumble.com/\">Rails Rumble</a> 2010) by <a href=\"http://twitter.com/thedelchop\">@thedelchop</a> and <a href=\"http://twitter.com/aaronball09\">@aaronball09</a>.";
//         boxy_content += "</div>";
//         contactBoxy = new Boxy(boxy_content, {
//             title: "About",
//             draggable: false,
//             modal: true
//         });
//         return false;
//     });
// 	
// 	    $('#info').click(function(){
//         var boxy_content;
//         boxy_content += "<div style=\"width:300px; height:300px\"> The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down periods of work into 25-minute intervals called 'pomodoros' (from the Italian word for 'tomato') separated by breaks.<br><br> - <a href=\"http://en.wikipedia.org/wiki/Pomodoro_Technique\">wikipedia</a>";
//         boxy_content += "</div>";
//         contactBoxy = new Boxy(boxy_content, {
//             title: "Pomodoro Technique",
//             draggable: false,
//             modal: true
//         });
//         return false;
//     });
});






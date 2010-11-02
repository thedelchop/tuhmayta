var contentArranger = {
	 	
  jQuery: $,
	
  settings: {
    column: '.column',
    selector: '.task',
    handleSelector: '.task-handle',
    contentDefault: {
      movable: true,
      removable: true,
    },

    // Eventually allow for settings on individual pieces of content
    contentIndividual: { }
  },

  // Additional method within 'iNettuts' object:  
  init : function () {  
      this.attachStylesheet('/stylesheets/drag_drop.css');  
      this.makeSortable();  
  },

  getContentSettings: function(id){
    var settings = this.settings;
    return (id && settings.contentIndividual[id]) ?
        $.extend({}, settings.contentDefault, settings.contentIndividual[id])
        : settings.contentDefault;
  },

  attachStylesheet: function (href){
    return $('<link href="' + href + '" rel="stylesheet" type="text/css" />').appendTo('head');
  },

  makeSortable : function () {
    var contentArranger = this,
        $ = this.jQuery,
        settings = this.settings,
        $sortableItems = (function () {
          return $(settings.selector);
        })();
	 	
    $sortableItems.find(settings.handleSelector).css({
        cursor: 'move'
    }).mousedown(function (e) {

        $sortableItems.css({width:''});
        $(this).parent().css({
            width: $(this).parent().width() + 'px'
        });
    }).mouseup(function () {
        if(!$(this).parent().hasClass('dragging')) {
            $(this).parent().css({width:''});
        } else {
            $(settings.column).sortable('disable');
        }
    });

    $(settings.column).sortable({
        handle: settings.handleSelector,
        placeholder: 'placeholder',
        forcePlaceholderSize: true,
        revert: 300,
        delay: 100,
        opacity: 0.8,
        start: function (e,ui) {
          $(ui.helper).addClass('dragging');
        },
        stop: function (e,ui) {
            $(ui.item).css({width:''}).removeClass('dragging');
        },
        
        update : function() {
          $.post(location.pathname + '/sort',
            $(settings.column).sortable('serialize'));
        }
    });
  }
}

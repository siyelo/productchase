var showHiddenProducts = function() {
  $(event.target).parent().find(".hidden-post").removeClass('hidden-post');
  $(event.target).remove();
};

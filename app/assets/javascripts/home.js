var showHiddenProducts = function() {
  $(event.target).parent().find(".hidden-post").removeClass('hidden-post');
  $(event.target).remove();
};
var scrollDetectionDisabled = false;

var loadProducts = function() {
  var days = $('.posts-wrapper .posts .day').size() + 3;

  return $.ajax('/products?days=' + days).done(function(products) {
    scrollDetectionDisabled = false;

    $('.posts-wrapper .posts').empty();
    $('.posts-wrapper .posts').append(products);
  }).fail(function() {
    scrollDetectionDisabled = false;

    alert('Unable to fetch products.');
  });
};

$(function() {
  $('#more').click(function() {
    event.preventDefault();
    loadProducts();
  });
});

$(window).scroll(function() {
  if (scrollDetectionDisabled) {
    return;
  }

  if($(window).scrollTop() + $(window).height() == $(document).height()) {
    scrollDetectionDisabled = true;
    loadProducts();

    setTimeout(function() {
      scrollDetectionDisabled = false;
    }, 1000);
  }
});

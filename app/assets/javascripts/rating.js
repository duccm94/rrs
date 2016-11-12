$(document).on('ready page:load',function(){
  $('.review-rating').raty({
    readOnly:true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });
  $('.average-review-rating').raty({
    readOnly:true,
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    }
  });

  $('#rating-form').raty({
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    },
    scoreName: 'review[rating]'
  });

  $('rating-form').raty({
    path: '/assets/',
    scoreName: 'review[rating]',
  })
});

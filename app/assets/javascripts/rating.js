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
  });

  $('#rating-form1').raty({
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    },
    scoreName: 'review[rating_place]'
  });

  $('rating-form1').raty({
    path: '/assets/',
    scoreName: 'review[rating_place]',
  });

  $('#rating-form2').raty({
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    },
    scoreName: 'review[rating_service]'
  });

  $('rating-form2').raty({
    path: '/assets/',
    scoreName: 'review[rating_service]',
  });

  $('#rating-form3').raty({
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    },
    scoreName: 'review[rating_food]'
  });

  $('rating-form3').raty({
    path: '/assets/',
    scoreName: 'review[rating_food]',
  });

  $('#rating-form4').raty({
    path: '/assets/',
    score: function() {
      return $(this).attr('data-score');
    },
    scoreName: 'review[rating_price]'
  });

  $('rating-form4').raty({
    path: '/assets/',
    scoreName: 'review[rating_price]',
  });


});

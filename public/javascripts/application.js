// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.fn.extend({
  scrollTo : function(speed, easing) {
    return this.each(function() {
      var targetOffset = $(this).offset().top;
      var targetOffsetLeft = $(this).offset().left;
      $('html,body').animate({scrollTop: targetOffset, scrollLeft: targetOffsetLeft}, speed, easing);
    });
  }
});
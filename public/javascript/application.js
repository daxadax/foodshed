$(document).ready( function() {

  $(document.links).filter(function() {
      return this.hostname != window.location.hostname;
  }).attr('target', '_blank');

});

var displayAjaxLoader = function(element){
  $(element).html(
    '<div class="ajax-loader"><img src="/images/ajax-loader.gif"></div>'
  )
};

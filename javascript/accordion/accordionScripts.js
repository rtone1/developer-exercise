//NOTE. Accordion plugin works by using a parent element like .accordion-header and finding
// child element like a header (in this case a a) and body (in this case a div)

var usersAccordion; // NAME SPACE FOR USE IN TEST.JS

(function( $ ){

  $.fn.accordion = function( options ) {

      // DEFAULT OPTIONS
      var settings = $.extend({
          active: 0,
          speed: 300,
          element: this.find('div') // ELEMENT TO TOGGLE
      }, options );

      // SHOW ACTIVE PANEL
      $(settings.element[settings.active]).show();

      // GRAB HEADERS
      var header = this.find('a');

      // ClICK FUNCTION FOR ACCORDION HEADERS
      header.on('click', function(){
          var index = $('a').index(this);
          // DO NOTHING IF ALREADY ACTIVE
          if (settings.active === index){
              return false;
          }
          // ANIMATE PANELS
          else {
              $(settings.element[settings.active]).slideUp(settings.speed);
              settings.active = index;
              $(settings.element[settings.active]).slideToggle(settings.speed);
          }
      });

      return ({ active: settings.active, speed: settings.speed });

  }; // END OF ACCORDION

})( jQuery );



$(document).ready(function(){
    usersAccordion = $('.accordion-header').accordion({
                              active: 3,
                              speed: 200
                      });
});

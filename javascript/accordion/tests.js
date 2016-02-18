
$(document).ready(function(){

  module("Accordion tests");

  test( "Accordion settings Active", function( assert ) {
    var actual = $.fn.accordion().active;
    var expected = 0;
    assert.ok( actual == expected, "I expected active panel at " + actual +". Active = " + actual );
  });

  test( "Accordion settings Speed", function( assert ) {
    var actual = $.fn.accordion().speed;
    var expected = 300;
    assert.ok( actual == expected, "I expected speed at " + actual + ". Speed = " + actual );
  });

  test( "Accordion user settings Active", function( assert ) {
    var actual = usersAccordion.active;
    var expected = usersAccordion.active;
    assert.ok( actual == expected, "I expected active panel at " + actual +". Active = " + actual );
  });

  test( "Accordion user settings Speed", function( assert ) {
    var actual = usersAccordion.speed;
    var expected = usersAccordion.speed;;
    assert.ok( actual == expected, "I expected speed at " + actual + ". Speed = " + actual );
  });

  test( "Accordion settings.active is equal to index click", function( assert ) {
      var active = usersAccordion.active;
      var header = $('.accordion-header').find('a');
      header.on('click', function(){
          var index = $('a').index(this);
          active = index;
          assert.equal(active, index, "I expected that on click active panel " + active + " =  index " + index);
      });
      assert.equal(active, active, "I expected active " + active + " = " + active);
  });

}); // END OF DOCUMENT READY

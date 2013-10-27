$(function (){
  $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd', beforeShowDay: $.datepicker.noWeekends });

  $hours = $( "#hours" );
  $minutes = $( "#minutes" );

  $( "#hours" ).change(function() {
    var hour = $hours.val();

    if ( hour === '8' ) {

      $minutes.val(0);
      $minutes.prop('disabled', true);

    } else { 

      $minutes.prop('disabled', false);
    }
  });

});

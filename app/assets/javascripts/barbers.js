// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function(){

  $('.individual_day').on('click',function(){

    //on click I want to render a form to pop up with day as it date_id attribute
  let day = $(this)[0].getAttribute('data-day')
  //only from edit page
  //create Schedule
  //from barber show page
  //render the previously created schedule by barber
  // $(DaySchedule.find_by(date_id: day, barber_id: Barber.find_by(id: params[:id]).id)).show();
    console.log(day);

  });
});

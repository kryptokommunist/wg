
// for mobile ui
//= require jquery
//= require jquery_ujs
//= require jquery.mobile

function cleaned_area(area_id, mate_id)
{
    $.ajax({url: "mates/" + mate_id + "?area_id=" + area_id, type: "PATCH", data_type: "json", async: false})

}

// used for slide panel closer
$(function () {
    $("[data-role=panel]").panel().enhanceWithin();
});

function flipped_checkbox(area_id)
{
    $.ajax({url: "areas/" + area_id + "/edit", type: "GET", data_type: "json", async: false});
    //flipbox<%= area.id %>.flipswitch({ disabled: true });

    //setTimeout( function() {
    //   flipbox<%= area.id %>.flipswitch({ disabled: false });
    //}, 600 );
    
    //Timeout and disabling 
}
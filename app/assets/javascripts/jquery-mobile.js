
// for mobile ui
//= require jquery
//= require jquery_ujs
//= require jquery.mobile

function cleaned_area(area_id, mate_id)
{
    $.ajax({url: "mates/" + mate_id + "?area_id=" + area_id, type: "PATCH", data_type: "json", async: false})

}
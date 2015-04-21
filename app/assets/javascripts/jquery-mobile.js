
// for mobile ui
//= require jquery
//= require jquery_ujs
//= require jquery.mobile

// used for mate who cleaned area at /status/mate_overview.mobile.erb
function cleaned_area(area_id, mate_id)
{
    $.ajax({url: "mates/" + mate_id + "?area_id=" + area_id, type: "PATCH", data_type: "json", async: false})

};

// used for slide panel close buttons at /status/_panel.mobile.erb
$(function () {
    $("[data-role=panel]").panel().enhanceWithin();
});

// used for slide panel switches at /status/_panel.mobile.erb
function flipped_checkbox(element)
{

	area_id = element.name;
    $.ajax({url: "areas/" + area_id + "/edit", type: "GET", data_type: "json", async: false});
    
    element = $(".panel-switch")

    //Timeout and disabling, otherwise fast switching might break the label switching

    element.flipswitch({ disabled: true });

    setTimeout( function() {
       element.flipswitch({ disabled: false });
    }, 600 );
    
};

function loadLogs() {

    $.ajax({url: "duties", type: "GET", data_type: "json", async: false});

};

function openDeletePopUp(duty_id) {

    $("#delDutyLink").attr("name", duty_id);
    $("#popupDialog").popup("open");

};

function deleteDuty(duty_id) {

     $.ajax({url: "duties/" + duty_id, type: "DELETE", data_type: "json", async: false});
     $("#popupDialog").popup("close");
     loadLogs();

};
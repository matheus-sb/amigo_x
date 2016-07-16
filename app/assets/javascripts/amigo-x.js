var collapseSideBar = function (win) {
    var topOffset = 50;
    var width = (win.window.innerWidth > 0) ? win.window.innerWidth : win.screen.width;
    if (width < 768) {
        $('div.navbar-collapse').addClass('collapse');
        topOffset = 100; // 2-row-menu
    } else {
        $('div.navbar-collapse').removeClass('collapse');
    }

    var height = ((win.window.innerHeight > 0) ? win.window.innerHeight : win.screen.height) - 1;
    height = height - topOffset;
    if (height < 1) height = 1;
    if (height > topOffset) {
        $("#page-wrapper").css("min-height", (height) + "px");
    } 
}    

$(function() {

    $(window).bind("resize", function() {
        collapseSideBar(this);
    }); 
});

var do_on_load = function() {
    console.log('on load');


    $('#side-menu').metisMenu();    

    collapseSideBar($(window)[0]);


    var url = window.location;
    var element = $('ul.nav a').filter(function() {
     return this.href == url;
    }).addClass('active').parent();

    while(true){
        if (element.is('li')){
            element = element.parent().addClass('in').parent();
        } else {
            break;
        }
    }  
};

$(document).on('turbolinks:load', do_on_load);
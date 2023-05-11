$(document).ready(function () {
    var icon = $('.hamburger-bar');
    var menu = $('.menu');
    var outsite = $(".blur-screen");
    var body = $("body");
    icon.click(function () {
        if (menu.hasClass("active")) {
            menu.removeClass("active");
            body.css("overflow", "auto");
        } else {
            menu.addClass("active");
            body.css("overflow", "hidden");
        }
    });

    outsite.click(function () {
        $(this).parent().removeClass("active");
        body.css("overflow", "auto");
    });

    var menulv1 = $('header .menu>ul>li');
    menulv1.click(function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
        } else {
            $(this).siblings().removeClass("active");
            $(this).addClass("active");
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const Menu = document.querySelector('.menu');
    const mediaViewContent = window.matchMedia('(min-width: 1024px)');
    const viewChangeHandler = (mediaViewContent) => {
        Menu.classList.remove('active');
    }
    mediaViewContent.addEventListener('change', viewChangeHandler);
})
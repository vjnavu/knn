<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<script>--%>
<%--    var slideCurrent = 0;--%>
<%--    showAutoSlides();--%>

<%--    function showAutoSlides() {--%>
<%--        var j;--%>
<%--        var slides = document.getElementsByClassName("autoSlide");--%>
<%--        for (j = 0; j < slides.length; j++) {--%>
<%--            slides[j].style.display = "none";--%>
<%--        }--%>
<%--        slideCurrent++;--%>
<%--        if (slideCurrent > slides.length) {--%>
<%--            slideCurrent = 0;--%>
<%--            slides[slideCurrent].style.display = "flex";--%>
<%--        } else {--%>
<%--            slides[slideCurrent - 1].style.display = "flex";--%>
<%--        }--%>
<%--        setTimeout(showAutoSlides, 5000); // Change image every 5 seconds--%>
<%--    }--%>

<%--    var slideIndex = [1, 1];--%>
<%--    var slideId = ["slides1", "slides2"];--%>
<%--    showSlides(1, 0);--%>
<%--    showSlides(1, 1);--%>

<%--    function plusSlides(n, no) {--%>
<%--        showSlides(slideIndex[no] += n, no);--%>
<%--    }--%>

<%--    function showSlides(n, no) {--%>
<%--        var i;--%>
<%--        var x = document.getElementsByClassName(slideId[no]);--%>
<%--        if (n > x.length) {--%>
<%--            slideIndex[no] = 1--%>
<%--        }--%>
<%--        if (n < 1) {--%>
<%--            slideIndex[no] = x.length--%>
<%--        }--%>
<%--        for (i = 0; i < x.length; i++) {--%>
<%--            x[i].style.display = "none";--%>
<%--        }--%>
<%--        x[slideIndex[no] - 1].style.display = "flex";--%>
<%--    }--%>
<%--</script>--%>
<script>
    $(function() {
        $('.slide-container').slick({
            infinite: true,
            dots: true,
            arrows: false,
            speed: 300,
            dotsClass:'dotController',
            responsive: [
                {
                    breakpoint: 1400,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        infinite: true,
                    }
                }
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
            ]
        });

        $('.slideshow-container.type1').slick({
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: 8,
            slidesToScroll: 8,
            nextArrow: '.next',
            prevArrow: '.prev',
            responsive: [
                {
                    breakpoint: 1400,
                    settings: {
                        slidesToShow: 6,
                        slidesToScroll: 6,
                        infinite: true,
                        dots: false
                    }
                },
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 6,
                        slidesToScroll: 6,
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 400,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
            ]
        });

        $('.slideshow-container.type2').slick({
            dots: false,
            arrow: true,
            infinite: true,
            speed: 300,
            slidesToShow: 8,
            slidesToScroll: 1,
            responsive: [
                {
                    breakpoint: 1400,
                    settings: {
                        slidesToShow: 8,
                        slidesToScroll: 8,
                        infinite: true,
                        dots: false
                    }
                },
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 6,
                        slidesToScroll: 6,
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 400,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
            ]
        });
    })
</script>
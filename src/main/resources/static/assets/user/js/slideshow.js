// $(document).ready(function () {
//     var stt = 0;
//     var endImg = $(".slides:last").attr("idx");
//
//     var changeImg = function (stt) {
//         $(".slides").css("display", "none");
//         $(".slides").eq(stt).css("display", "block");
//         $(".dot").removeClass("active");
//         $(".dot").eq(stt).addClass("active");
//     };
//     if ($(".dot").length > 0) {
//         $(".dot").click(function () {
//             stt = $(this).attr("idx");
//             changeImg(stt);
//         });
//     }
//     if ($("#next").length > 0 && $("#prev").length > 0) {
//         $("#next").click(function () {
//             if (++stt > endImg) stt = 0;
//             changeImg(stt);
//         });
//
//         $("#prev").click(function () {
//             if (--stt < 0) stt = endImg;
//             changeImg(stt);
//         });
//     }
//
//     var interval;
//     var timer = function () {
//         interval = setInterval(function () {
//             $("#next").click();
//         }, 5000);
//     };
//
//     timer();
// });
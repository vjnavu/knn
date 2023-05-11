<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var checkEmail = false;
    $('#ad_email').focusout(function () {
        var email = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
        if (!email.test($('#ad_email').val())) {
            $('#ad_email').addClass('border-danger');
            $('#ad_email-span').text('Định dạng email không hợp lệ');
            $('#ad_email').focus();
        } else {
            $('#ad_email').removeClass('border-danger');
            $('#ad_email-span').text('');
        }
    });
    $('#ad_pw').focusout(function () {
        if (!$('#ad_pw').val().match(/^(?=.*[A-Za-z]{4,})((?=.*\d)|(?=.*?[#?!@$%^&*-]))[A-Za-z\d#?!@$%^&*-]{8,12}$/) || !$('#ad_pw').val().match(/^(?=.{2})(?!.*([a-z]|[A-Z]|[0-9]|[#?!@$%^&*-])\1{3})/)) {
            $('#ad_pw').addClass('border-danger');
            $('#ad_pw-span').html("<ul>" +
                "<li>Định dạng mật khẩu không hợp lệ.</li>" +
                "<li>- Từ 8~12 ký tự bao gồm chữ cái tiếng Anh hoa/thường + chữ số + ký tự đặc biệt</li>" +
                "<li>- Chữ cái tiếng Anh viết hoa/thường yêu cầu từ 4 ký tự trở lên</li>" +
                "<li>- Bắt buộc phải có ít nhất 1 chữ số hoặc 1 ký tự đặc biệt</li>" +
                "<li>- 4 chữ cái, số, ký tự đặc biệt giống nhau không hợp lệ (VD: aaaa, 1111, ...)</li></ul>");
        } else {
            $('#ad_pw').removeClass('border-danger');
            $('#ad_pw-span').text('');
        }
    });
    $('#ad_pw_reinput').focusout(function () {
        if ($('#ad_pw').val() != $('#ad_pw_reinput').val()) {
            $('#ad_pw_reinput').addClass('border-danger');
            $('#password-span').text('Mật khẩu không khớp');
        } else {
            $('#ad_pw_reinput').removeClass('border-danger');
            $('#password-span').text('');
        }
    });


    $('#btnRegister').click(function () {
            let code = $('#codeConfirm').val()
            $.ajax({
                url: '/code/check',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'code': code},
                success: function (data) {
                    if (data) {
                        if ($('#ad_email').val() == '' || $('#ad_pw').val() == '' || $('#ad_phone').val() == '' || $('#ad_pw-span').text() != '' || $('#ad_email-span').text() != '') {
                            alert("Vui lòng nhập đầy đủ thông tin, mật khẩu hợp lệ và email hợp lệ !!!")
                        } else {
                            if ($('#ad_pw').val() != $('#ad_pw_reinput').val()) {
                                $('#ad_pw_reinput').focus();
                                alert("Mật khẩu nhập lại không khớp")
                            } else {
                                let phone = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
                                if($('#ad_phone').val().match(phone)) {
                                    $('#signupForm').submit();
                                }
                                else {
                                    alert('Định dạng số điện thoại không hợp lệ vui lòng nhập lại')
                                }
                            }
                        }
                    } else {
                        alert("Mã xác thực chưa đúng, vui lòng kiểm tra lại")
                    }
                }
            })

        }
    );
    $('#code').click(async function () {
        let email = $('#ad_email').val();
        if (email == '') {
            alert('Vui lòng điền email của bạn')
        } else {
            $.ajax({
                url: '/cms/admin/email/check',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'email': email},
                success: async function (data) {
                    if (data) {
                        $('#code').hide()
                        $('#progressBar').show()
                        await Promise.all([sentAjaxConfirmEmail(email), countTime()]);
                    } else {
                        alert('Email đã được đăng ký tài khoản trên hệ thống')
                    }
                },
                error: function () {
                    alert('Đã xảy ra lỗi khi kiểm tra email trùng lặp');
                }
            })

        }
    });

    function sentAjaxConfirmEmail(email) {
        $.ajax({
            url: '/cms/confirm/email',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'email': email},
            success: function (data) {
                if (data) {
                    alert("Chúng tôi đã gửi mã xác thực vào email của bạn. Vui lòng kiểm tra và nhập vào bên dưới")
                } else {
                    alert("Đã xẩy ra lỗi khi gửi email")
                }
            }
        })
    }

    function countTime() {
        let timeleft = 20;
        let downloadTimer = setInterval(function () {
            if (timeleft <= 0) {
                clearInterval(downloadTimer);
                document.getElementById("timeRun").innerHTML = "Finished";
                document.getElementById("timeRun").innerHTML = "";
                $('#code').show()
                $('#code_forgot').show()
                $('#progressBar').hide()
            } else {
                document.getElementById("timeRun").innerHTML = timeleft + "s";
            }
            timeleft -= 1;
        }, 2000);
    }

    $('#confirm').click(function () {
        let code = $('#codeConfirm').val()
        $.ajax({
            url: '/code/check',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'code': code},
            success: function (data) {
                if (data) {
                    checkEmail = true;
                    alert("Xác thực thành công")
                } else {
                    checkEmail = false;
                    alert("Mã xác thực chưa đúng")
                }
            }
        })
    });

    $('#code_forgot').click(async function () {
        let email = $('#email').val();
        if (email == '') {
            alert('Vui lòng nhập email')
        } else {
            $('#code_forgot').hide()
            $('#progressBar').show()
            await Promise.all([sentAjaxForgot(email), countTime()]);
        }
    });

    function sentAjaxForgot(email) {
        $.ajax({
            url: '/forgot/email/code',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'email': email},
            success: function (data) {
                if (data) {
                    alert("Chúng tôi đã gửi mã xác thực vào email của bạn. Vui lòng kiểm tra và nhập vào bên dưới")
                } else {
                    alert("Email chưa đăng ký tài khoản trên hệ thống hoặc xẩy ra lỗi trong quá trình gửi mail")
                }
            }
        })
    }

    $('#btnForgot').click(function () {
        let email = $('#email').val();
        let codeForgot = $('#codeConfirm').val();
        if (email == '' || codeForgot == '') {
            alert('Vui lòng điền đầy dủ mã xác thực và email')
        } else {
            $.ajax({
                url: '/forgot/email/confirm',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'codeForgot': codeForgot},
                success: function (data) {
                    if (data) {
                        $('#forgotForm').submit();
                    } else {
                        alert("Mã xác thực email chưa đúng")
                    }
                }
            })
        }
    });
</script>
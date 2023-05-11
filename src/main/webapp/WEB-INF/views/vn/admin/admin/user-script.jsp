<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $('#ad_pw_reinput').focusout(function () {
        if ($('#ad_new_pw').val() != $('#ad_pw_reinput').val()) {
            $('#ad_pw_reinput').addClass('border-danger');
            $('#password-span').text('Mật khẩu không khớp');
        } else {
            $('#ad_pw_reinput').removeClass('border-danger');
            $('#password-span').text('');
        }
    });
    

    // $("#ad_email").focusout(function () {
    //     let email = $('#ad_email').val();
    //     if ($('#admin').attr('action') == '/cms/admin/new') {
    //         $.ajax({
    //             url: '/cms/admin/email/check',
    //             type: 'GET',
    //             data: {'email': email},
    //             success: function (data) {
    //                 if (!data) {
    //                     alert('Email này đã tồn tại');
    //                 } else {
    //                     $('#ad_email').val(email);
    //                 }
    //             },
    //             error: function () {
    //                 alert('Đã xảy ra lỗi khi kiểm tra email trùng lặp');
    //             }
    //         });
    //     }
    // });

    $('#btnUpdateInfo').click(function () {
        let email = $('#ad_email').val();
        let emailStart = $('#emailStart').val();
        if (email != emailStart) {
            $.ajax({
                url: '/cms/admin/email/check',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'email': email},
                success: function (data) {
                    if (data) {
                        $.ajax({
                            url: '/cms/confirm/email',
                            type: 'GET',
                            headers: {
                                Accept : "application/json"
                            },
                            data: {'email': email},
                            success: function (data) {
                                if (data) {
                                    alert("Chúng tôi đã gửi mã xác thực vào email của bạn. Vui lòng kiểm tra và nhập vào hộp thoại")
                                    $("#confirmModal").modal('show');
                                } else {
                                    alert("Email đã đăng ký tài khoản trên hệ thống")
                                }
                            }
                        })
                    } else {
                        alert('Email bạn yêu cầu đã được sử dụng vui lòng sử dụng email khác')
                    }
                },
                error: function () {
                    alert('Đã xảy ra lỗi khi kiểm tra email trùng lặp');
                }
            });
        } else {
            $('#updateInfoForm').submit();
        }
    });
    $("#checkCodeEmail").click(function () {
        let code = $("#confirmCode").val();
        if (code == null || code == '') {
            alert('Vui lòng nhập mã code xác thực đã được gửi về email của bạn.')
        } else {
            $.ajax({
                url: '/code/check',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'code': code},
                success: function (data) {
                    if (data) {
                        $("#updateInfoForm").submit();
                    } else {
                        alert("Mã xác thực chưa đúng")
                    }
                }
            })
        }
    });

    $('#sizeSelect').val($('#pageSize').val());
    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('.dataSort').click(function () {
        var sort = $('#sortDirection').val();

        if (sort == '') {
            sort = 'ASC';
        } else {
            if (sort == 'ASC') {
                sort = 'DESC';
            } else {
                sort = 'ASC';
            }
        }
        $('#sortOrder').val($(this).attr("data-sort"));
        $('#sortDirection').val(sort);
        $('#searchForm').submit();
    });

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });

    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });

    $('#ad_new_pw').focusout(function () {
        if (!$('#ad_new_pw').val().match(/^(?=.*[A-Za-z]{4,})((?=.*\d)|(?=.*?[#?!@$%^&*-]))[A-Za-z\d#?!@$%^&*-]{8,12}$/) || !$('#ad_new_pw').val().match(/^(?=.{2})(?!.*([a-z]|[A-Z]|[0-9]|[#?!@$%^&*-])\1{3})/)) {
            $('#ad_new_pw').addClass('border-danger');
            $('#ad_pw-span').text("Định dạng mật khẩu không hợp lệ." +
                "- Từ 8~12 ký tự bao gồm chữ cái tiếng anh hoa/thường+ chữ số+ ký tự đặc biệt" +
                "- Chữ cái tiếng anh viết hoa/thường yêu cầu từ 4 ký tự trở lên" +
                "- Bắt buộc phải có ít nhất 1 chữ số hoặc 1 ký tự đặc biệt" +
                "- 4 chữ cái, số, ký tự đặc biệt giống nhau không hợp lệ (VD: aaaa, 1111, ...)");
        } else {
            $('#ad_new_pw').removeClass('border-danger');
            $('#ad_pw-span').text('');
        }
    });

    function getAdminInfo(adminSeq) {
        $.ajax({
            url: '/cms/admin/update',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'adminSeq': adminSeq},
            success: function (data) {
                $('#ad_seq_ud').val(data["ad_seq"]);
                $('#ad_name_ud').val(data["ad_name"]);
                $('#ad_agency_seq_ud').val(data["ad_agency_seq"]);
                $('#ad_email_ud').val(data["ad_email"]);
                $('#ad_email_current').val(data["ad_email"]);
                $('#ad_status_ud').val(data["ad_status"]);
                $('#ad_phone_ud').val(data["ad_phone"]);
                $('#ad_pw_ud').val('12345678');
                $('#ad_pw_reinput_ud').val('12345678');
                $('#ad_role_ud').val(data["ad_role"]);
                $('#roleAdminDefault').val(data["ad_role"]);
                $('#ad_memo_ud').val(data["ad_memo"]);
                $('#updateModal').modal('toggle');
                $('#admin1').attr('action', "/cms/admin/update")
            },
            error: function () {
                alert('Đã xảy ra lỗi khi lấy thông tin quản trị viên');
            }
        });
    };

    $('#ad_new_pw, #ad_confirm_pw').on('keyup', function () {
        if ($('#ad_new_pw').val() == $('#ad_confirm_pw').val()) {
            $('#message').html('Mật Khẩu Khớp').css('color', 'green');
        } else {
            $('#message').html('Mật Khẩu Không Khớp').css('color', 'red');
        }
    });
    $('#btnAdd').click(function () {
        $('#admin').trigger("reset");
    });

    $('#btnUpdate').click(function () {
        let emailCurrent = $('#ad_email_current').val();
        let emailEdit = $('#ad_email_ud').val();
        if (emailEdit != emailCurrent) {
            let email = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            if (!email.test($('#ad_email').val())) {
                $('#ad_email_ud-span').text('Định dạng email không hợp lệ');
            } else {
                $('#ad_email_ud-span').text('');
                $.ajax({
                    url: '/cms/admin/email/check',
                    type: 'GET',
                    headers: {
                        Accept : "application/json"
                    },
                    data: {'email': emailEdit},
                    success: function (data) {
                        if (!data) {
                            alert('Email này đã tồn tại');
                        } else {
                            if ($('#ad_pw_ud').val() != '12345678') {
                                if (!$('#ad_pw_ud').val().match(/^(?=.*[A-Za-z]{4,})((?=.*\d)|(?=.*?[#?!@$%^&*-]))[A-Za-z\d#?!@$%^&*-]{8,12}$/) || !$('#ad_new_pw').val().match(/^(?=.{2})(?!.*([a-z]|[A-Z]|[0-9]|[#?!@$%^&*-])\1{3})/)) {
                                    $('#ad_pw_ud-span').text("Định dạng mật khẩu không hợp lệ." +
                                        "- Từ 8~12 ký tự bao gồm chữ cái tiếng anh hoa/thường+ chữ số+ ký tự đặc biệt" +
                                        "- Chữ cái tiếng anh viết hoa/thường yêu cầu từ 4 ký tự trở lên" +
                                        "- Bắt buộc phải có ít nhất 1 chữ số hoặc 1 ký tự đặc biệt" +
                                        "- 4 chữ cái, số, ký tự đặc biệt giống nhau không hợp lệ (VD: aaaa, 1111, ...)");
                                } else {
                                    if ($('#ad_pw_ud').val() == $('#ad_pw_reinput_ud').val()) {
                                        $('#ad_pw_ud').removeClass('border-danger');
                                        $('#ad_pw_ud-span').text('');
                                        $('#admin1').submit();
                                    } else {
                                        alert('Mật khẩu nhập lại không khớp')
                                    }
                                }
                            } else {
                                if ($('#ad_pw_ud').val() == $('#ad_pw_reinput_ud').val()) {
                                    $('#ad_pw_ud').val('');
                                    $('#admin1').submit();
                                } else {
                                    alert('Mật khẩu nhập lại không khớp')
                                }
                            }
                        }
                    },
                    error: function () {
                        alert('Đã xảy ra lỗi khi kiểm tra email trùng lặp');
                    }
                });
            }
        } else {
            if ($('#ad_pw_ud').val() != '12345678') {
                if (!$('#ad_pw_ud').val().match(/^(?=.*[A-Za-z]{4,})((?=.*\d)|(?=.*?[#?!@$%^&*-]))[A-Za-z\d#?!@$%^&*-]{8,12}$/) || !$('#ad_pw_ud').val().match(/^(?=.{2})(?!.*([a-z]|[A-Z]|[0-9]|[#?!@$%^&*-])\1{3})/)) {
                    $('#ad_pw_ud-span').text("Định dạng mật khẩu không hợp lệ." +
                        "- Từ 8~12 ký tự bao gồm chữ cái tiếng anh hoa/thường+ chữ số+ ký tự đặc biệt" +
                        "- Chữ cái tiếng anh viết hoa/thường yêu cầu từ 4 ký tự trở lên" +
                        "- Bắt buộc phải có ít nhất 1 chữ số hoặc 1 ký tự đặc biệt" +
                        "- 4 chữ cái, số, ký tự đặc biệt giống nhau không hợp lệ (VD: aaaa, 1111, ...)");
                } else {
                    if ($('#ad_pw_ud').val() == $('#ad_pw_reinput_ud').val()) {
                        $('#ad_pw_ud-span').text('');
                        $('#admin1').submit();
                    } else {
                        alert('Mật khẩu nhập lại không khớp')
                    }
                }
            } else {
                if ($('#ad_pw_ud').val() == $('#ad_pw_reinput_ud').val()) {
                    $('#ad_pw_ud-span').text('');
                    $('#ad_pw_ud').val('');
                    $('#admin1').submit();
                } else {
                    alert('Mật khẩu nhập lại không khớp')
                }
            }
        }
    });

    $('#btnChangePass').click(function () {
        let currentPass = $('#ad_pw_current').val();
        $.ajax({
            url: '/cms/admin/password/check',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'currentPass': currentPass},
            success: function (data) {
                if (data) {
                    if (!$('#ad_new_pw').val().match(/^(?=.*[A-Za-z]{4,})((?=.*\d)|(?=.*?[#?!@$%^&*-]))[A-Za-z\d#?!@$%^&*-]{8,12}$/) || !$('#ad_new_pw').val().match(/^(?=.{2})(?!.*([a-z]|[A-Z]|[0-9]|[#?!@$%^&*-])\1{3})/)) {
                        alert("Định dạng mật khẩu không hợp lệ. Độ dài từ 8-12 ký tự, bao gồm chữ cái và số hoặc ký tự đặc biệt. 4 ký tự liên tiếp không được trùng lặp")
                    } else {
                        $('#changePass').submit();
                    }
                } else {
                    alert("Mật khẩu hiện tại bạn nhập không đúng")
                }
            }
        })
    })
</script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(document).ready(function () {
        if (${formAction == 'update'}) {
            $('#birthday').val($('#birthday_tf').val())
        }
    });
    $('#cddSave').click(function () {
        if (validateForm() === true) {
            $('#candidateForm').submit();
        }
    })

    $("#cdd_avatar").on('change', function (e) {
        var fileName = $(this).val();
        var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (fileExt !== 'jpg' && fileExt !== 'jpeg' && fileExt !== 'png') {
            alert('Bạn cần tải đúng định dạng ảnh đại diện: .jpg, .jpeg, .png');
            $(this).val(null);
        }
    });

    $('#exam_seq').change(function () {
        let seq = $('#exam_seq').val();
        $.ajax({
            url: '/cms/candidate/cert2s',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {'exam_seq': seq},
            success: function (data) {
                $('#cert2_seq option:not(:first)').remove();
                if (data != null) {
                    for (let i = 0; i < data.length; i++) {
                        $('#cert2_seq').append($('<option/>', {
                            value: data[i]["cert2_seq"],
                            text: data[i]["cert2_name"]
                        }));
                    }
                }
            },
            error: function () {
                alert('Đã xảy ra lỗi trong quá trình lấy dữ liệu')
            }
        });
    })

    function validateForm() {
        let checkResult = true;
        const cdd_avatar = $('#cdd_avatar').val();
        const cdd_name = $('#cdd_name').val();
        const cdd_gender = $('#cdd_gender').val();
        const cdd_birthday = $('input[name = "birthday"]').val();
        const cdd_position = $('#cdd_position').val();
        const exam_seq = $('#exam_seq').val();
        const cert2_seq = $('#cert2_seq').val();
        const cdd_office = $('#cdd_office').val();
        const cdd_exam_address = $('#cdd_exam_address').val();
        const cdd_organize = $('#cdd_organize').val();
        const cdd_posi_organize = $('#cdd_posi_organize').val();
        const cdd_score = $('#cdd_score').val();
        const cdd_score_cis = $('#cdd_score_cis').val();
        const cdd_award = $('#cdd_award').val();

        if (cdd_avatar === '' && ${formAction == 'new'}) {
            alert('Vui lòng thêm ảnh đại diện thí sinh');
            checkResult = false;
        } else if (cdd_name === '') {
            alert('Vui lòng nhập tên thí sinh');
            checkResult = false;
        } else if (cdd_gender === '') {
            alert('Vui lòng chọn giới tính thí sinh');
            checkResult = false;
        } else if (cdd_birthday === '') {
            alert('Vui lòng chọn ngày sinh thí sinh');
            checkResult = false;
        } else if (cdd_position === '') {
            alert('Vui lòng nhập chức vụ thí sinh');
            checkResult = false;
        }
            // else if (exam_seq === '') {
            //     alert('Vui lòng chọn kỳ thi');
            //     checkResult = false;
            // }
            // else if (cert2_seq === '') {
            //     alert('Vui lòng chọn nghề dự thi');
            //     checkResult = false;
        // }
        else if (cdd_office === '') {
            alert('Vui lòng nhập địa chỉ đơn vị');
            checkResult = false;
        } else if (cdd_exam_address === '') {
            alert('Vui lòng nhập địa điểm thi');
            checkResult = false;
        } else if (cdd_organize === '') {
            alert('Vui lòng nhập tên đoàn');
            checkResult = false;
        } else if (cdd_posi_organize === '') {
            alert('Vui lòng nhập chức danh trong đoàn');
            checkResult = false;
        } else if (cdd_score === '') {
            alert('Vui lòng nhập điểm số 100 của thí sinh');
            checkResult = false;
        } else if (cdd_score < 0 || cdd_score > 100) {
            alert('Điểm số 100 của thí sinh lớn hơn 0 và nhỏ hơn 100');
            checkResult = false;
        } else if (cdd_score_cis < 0 || cdd_score_cis > 1000) {
            alert('Điểm CIS của thí sinh lớn hơn 0 và nhỏ hơn 1000');
            checkResult = false;
        } else if (cdd_score_cis === '') {
            alert('Vui lòng nhập điểm CIS cho thí sinh');
            checkResult = false;
        } else if (cdd_award === '') {
            alert('Vui lòng nhập giải thưởng cho thí sinh');
            checkResult = false;
        } else {
            checkResult = true;
        }
        return checkResult;
    }

</script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckfinder/ckfinder.js"></script>
<script>
    let editor_config = {
        filebrowserBrowseUrl: '/../../../ckfinder/ckfinder.html',
        filebrowserImageBrowseUrl: '/../../../ckfinder/ckfinder.html?type=Images',
        filebrowserFlashBrowseUrl: '/../../../ckfinder/ckfinder.html?type=Flash',
        filebrowserUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files',
        filebrowserImageUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images',
        filebrowserFlashUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash',
        allowedContent: true
    };

    CKEDITOR.replace('ag_memo', editor_config);

    $('#province').change(function () {
        if ($(this).val() != '') {
            $.ajax({
                url: '/cms/vietnam/districtList',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'proSeq': $(this).val()},
                success: function (data) {
                    $('#district option:not(:first)').remove();
                    $('#communes option:not(:first)').remove();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $('#district').append($('<option/>', {
                                value: data[i]["addr2_seq"],
                                text: data[i]["addr2_name"]
                            }));
                        }
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi trong quá trình lấy thông tin các khu vực việt nam')
                }
            });
        }
    });

    $('#district').change(function () {
        if ($(this).val() != '') {
            $.ajax({
                url: '/cms/vietnam/communestList',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'disSeq': $(this).val()},
                success: function (data) {
                    $('#communes option:not(:first)').remove();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $('#communes').append($('<option/>', {
                                value: data[i]["addr3_seq"],
                                text: data[i]["addr3_name"]
                            }));
                        }
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi trong quá trình lấy thông tin các khu vực việt nam')
                }
            });
        }
    });

    $('#btnSave').click(function () {
        $('#ag_memo').val($(CKEDITOR.instances.ag_memo.getData()).text());
        if ($('#ag_name_vn').val() == '' || $('#ag_name_en').val() == '') {
            alert("Vui lòng điền đầy đủ tên cơ quan tiếng anh và tiếng việt");
            $('#ag_name_vn').focus();
            $('#ag_name_en').focus();
        } else {
            if ($('#agencyForm').attr('action') == '/cms/agency/new' && ($("#ag_logo_file").val() == null || $("#ag_logo_file").val() == '')) {
                alert('Bạn chưa chọn Logo cơ quan');
            } else {
                $('#agencyForm').submit();
            }
        }
    })
    $("#ag_logo_file").on('change', function (e) {
        var fileName = $(this).val();
        var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (fileExt != 'jpg' && fileExt != 'jpeg' && fileExt != 'png') {
            alert("Allowed File Extensions: jpg, jpeg, png");
            $(this).val(null);
        }
    });
</script>

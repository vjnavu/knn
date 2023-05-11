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

    CKEDITOR.replace('cert3_desc', editor_config);
    $('#btnSave').click(function () {
        let name = $('#cert3_name').val()
        let cert2 = $('#cert2').val()
        let cert1 = $('#cert1').val()
        $('#cert3_desc').val($(CKEDITOR.instances.cert3_desc.getData()).text());
        if (name != '' && name != null) {
            if (cert1 == '') {
                alert('Vui lòng chọn danh mục chứng chỉ cấp 1')
            } else {
                if (cert2 == '') {
                    alert('Vui lòng chọn phân loại chứng chỉ chi tiết. Nếu chưa tồn tại danh mục chứng chỉ chi tiết vui lòng tạo danh mục chứng chỉ chi tiết trong danh mục chứng chỉ!')
                } else {
                    if (${action == 'update'}) {
                        $('#addForm').attr('action', '/cms/certificate/cert3/update');
                    }
                    $('#addForm').submit()
                }
            }
        } else {
            alert('Vui lòng nhập tên danh mục chứng chỉ cấp 2')
        }
    })

    $('#cert1').change(function () {
        if ($(this).val() != '') {
            $.ajax({
                url: '/cms/certificate/cert2/get',
                type: 'GET',
                headers: {
                    Accept : "application/json"
                },
                data: {'cert1Seq': $(this).val()},
                success: function (data) {
                    $('#cert2 option:not(:first)').remove();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            $('#cert2').append($('<option/>', {
                                value: data[i]["cert2_seq"],
                                text: data[i]["cert2_name"]
                            }));
                        }
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi trong quá trình lấy thông tin danh mục chứng chỉ chi tiết')
                }
            });
        }
    });
</script>

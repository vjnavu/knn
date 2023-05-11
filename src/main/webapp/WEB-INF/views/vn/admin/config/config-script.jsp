<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $('#config_file').on('change', function () {
            let fileName = $(this).val();
            let typeFile = fileName.substr(fileName.lastIndexOf('.') + 1);
            if (typeFile != 'jpg' && typeFile != 'jpeg' && typeFile != 'png') {
                alert('Bạn cần tải đúng định dạng file ảnh : JPG,JPEG,PNG');
                $(this).val(null);
            } else {
                $('#viewImg').hide();
            }
        }
    );
</script>

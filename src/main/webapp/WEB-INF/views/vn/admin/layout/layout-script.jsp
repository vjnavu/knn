<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $('#btnSave').click(function () {
        if ($('#layoutForm').attr('action') == '/cms/layout/new' && ($("#lo_file").val() == null || $("#lo_file").val() == '')) {
            alert('Bạn chưa chọn ảnh đính kèm');
        } else {
            $('#layoutForm').submit();
        }
    });

    $("#lo_file").on('change', function (e) {
        var fileName = $(this).val();
        var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (fileExt != 'jpg' && fileExt != 'jpeg' && fileExt != 'png') {
            alert("Allowed File Extensions: jpg, jpeg, png");
            $(this).val(null);
        }
    });

    let sort = $('#sortDirection').val();
    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });

    $('.dataSort').click(function () {
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
</script>
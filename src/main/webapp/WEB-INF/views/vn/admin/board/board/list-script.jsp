<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $('#btnSearch').click(function () {
        $('#searchForm').submit();
    })

    $('#sizeSelect').val($('#pageSize').val());

    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('#keyWord').keyup(function () {
        if ($(this).val() == '') {
            $('#searchForm').submit();
        }
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
    })

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    })

    function delBoard(boardSeq) {
        $.ajax({
            url: '/board/check/' + boardSeq,
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            success: function (data) {
                if (data) {
                    alert('Bảng tin đang được sử dụng trong menu trang chủ. Sau khi xóa ở menu, bạn  có thể xóa ở mục bảng tin')
                } else {
                    if (confirm('Bạn có chắc chắn xóa bảng tin này?')) {
                        $.ajax({
                            url: '/cms/board/delete/' + boardSeq,
                            type: 'GET',
                            headers: {
                                Accept : "application/json"
                            },
                            success: function (data) {
                                if (data) {
                                    alert('Xóa thành công')
                                    location.reload()
                                } else {
                                    alert('Xóa thất bại')
                                }
                            },
                            error: function () {
                                alert('Đã xẩy ra lỗi')
                            }
                        })
                    }
                }
            }
        })
    }
</script>

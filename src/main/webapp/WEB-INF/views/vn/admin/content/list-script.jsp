<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $('#sizeSelect').val($('#pageSize').val());

    $('#btnSearch').click(function () {
        $('#searchForm').submit();
    })

    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('#searchConditon').change(function () {
        if ($('#searchConditon').val() == "ctn_reg_dtm") {
            $('#keyWord').attr("placeholder", "yyyy-mm-dd");
        } else {
            $('#keyWord').attr("placeholder", "Nhập từ khóa tìm kiếm");
        }
    })
    $('#keyWord').keyup(function () {
        if ($(this).val() == '') {
            $('#searchForm').submit();
        }
    });

    /* table th click --> get this data-sort (= column name in SQL table) --> set val to #sortOrder --> #searchForm submit*/
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
    /* ================================================================ */

    /* click on pageNum --> get data-num (=pageNum) --> set pageNum to #page --> searchForm submit */
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    })

    function delContent(conSeq) {
        $.ajax({
            url: '/content/check/' + conSeq,
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            success: function (data) {
                if (data) {
                    alert('Nội dung đang được sử dụng trong menu trang chủ. Sau khi xóa ở menu, bạn  có thể xóa ở mục nội dung')
                } else {
                    if (confirm('Bạn có chắc chắn xóa nội dung này?')) {
                        $.ajax({
                            url: '/cms/content/delete/' + conSeq,
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

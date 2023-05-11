<%--
  Created by IntelliJ IDEA.
  User: VTA
  Date: 7/27/2021
  Time: 4:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $('#sizeSelect').val($('#pageSize').val());

    /* search Icon click */
    $('#btnSearch').click(function () {
        $('#searchForm').submit();
    })

    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('#cat_seq').change(function () {
        $('#searchForm').attr('action', "/cms/post/" + $(this).val());
        $('#searchForm').submit();
    })

    $('#keyWord').keyup(function () {
        if ($(this).val() == '') {
            $('#searchForm').submit();
        }
    });

    $('#searchConditon').change(function () {
        if ($('#searchConditon').val() == "post_reg_dtm") {
            $('#keyWord').attr("placeholder", "yyyy-mm-dd");
        } else {
            $('#keyWord').attr("placeholder", "Nhập từ khóa tìm kiếm");
        }
    })

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

    function changePostStatus(postSeq) {
        console.log(postSeq);
        $.ajax({
            url: '/cms/post/changePostSt',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            headers: {
                Accept : "application/json"
            },
            data: {'postSeq': postSeq}
        });
    }
</script>

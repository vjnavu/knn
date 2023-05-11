<script>
    $('#sizeSelect').val($('#pageSize').val());
    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });
    $('#btnSearch').click(function () {
        $('#searchForm').submit();
    })
    $('#keyWord').keyup(function () {
        if ($(this).val() == '') {
            $('#searchForm').submit();
        }
    });

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    })

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
</script>

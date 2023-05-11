<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(document).ready(function () {
        $('#linkMenu').val('enterLink')
    })
    $('#nameVn').change(function () {
        let path = $('#realPath').val()
        let name = $('#nameVn').val()
        let text = path + "/" + name
        $('#pathMenu').val(text)
    })

    $('#linkMenu').change(function () {
        let value = $(this).val();
        if (value == "cat") {
            $('#mCat').modal("show")
            $('#urlMenu').prop('readonly', true)
        } else if (value == "cont") {
            $('#mCont').modal("show")
            $('#urlMenu').prop('readonly', true)
        } else {
            $('#urlMenu').prop('readonly', false)
        }
    });

    function setLinkMenu(link) {
        $('#urlMenu').val(link)
        $('#urlMenu').prop('readonly', true)
        $('#mCat').modal("hide")
        $('#mCont').modal("hide")
    }

    $('#btnSearchContent').click(function () {
        searchContent();
    });
    $('#btnSearchCat').click(function () {
        searchCat();
    });
    $('#sizeSelect').val($('#pageSize').val());
    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        searchCat();
    });
    $('#sizeSelect1').val($('#pageSize').val());
    $('#sizeSelect1').change(function () {
        $('#page1').val(1);
        $('#pageSize1').val($('#sizeSelect1').val());
        searchContent();
    });
    $(document).on('click', '.pagination a', function () {
        $('#page').val($(this).attr("data-num"));
        if ($('#mCat').hasClass('show')) {
            searchCat();
        } else if ($('#mCont').hasClass('show')) {
            searchContent();
        }
    });

    function searchContent() {
        $.ajax({
            url: '/cms/menu/search/content',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {
                keyWord: $('#keyWord1').val(),
                size: $('#sizeSelect1').val(),
                searchItem: $('#searchConditon1').val(),
                page: $('#page').val()
            },
            success: function (data) {
                $("#tableId > tbody").empty();
                let row = "";
                for (let i = 0; i < data[0].length; i++) {
                    let date = moment(data[0][i]["cat_reg_dtm"]).format('DD MMM YYYY');
                    row += "<tr onclick=" + "setLinkMenu('/news/content/" + data[0][i]["ctn_seq"] + "')" + " data-key=" + data[0][i]["ctn_seq"] + ">"
                        + "<td>" + data[0][i]["ctn_title"] + "</td>"
                        + "<td>" + data[0][i]["ctn_reg_email"] + "</td>"
                        + "<td>" + date + "</td>"
                        + "</tr>"
                    $('.listCont').html(row);
                }
                ;
                $('#pagingCont').html('');
                $('#pagingCont').html(data[1]);
            }
        });
    };

    function searchCat() {
        $.ajax({
            url: '/cms/menu/search/board',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {
                keyWord: $('#keyWord').val(),
                size: $('#sizeSelect').val(),
                searchItem: $('#searchConditon').val(),
                page: $('#page').val()
            },
            success: function (data) {
                $("#catetableId > tbody").empty();
                let row = "";
                let boardType;
                for (let i = 0; i < data[0].length; i++) {
                    if (data[0][i]["board_type"] == 'M') {
                        boardType = 'Thông thường'
                    } else if (data[0][i]["board_type"] == 'W') {
                        boardType = 'Web'
                    } else if (data[0][i]["board_type"] == 'G') {
                        boardType = 'Gallery'
                    } else if (data[0][i]["board_type"] == 'D') {
                        boardType = 'Tài liệu'
                    } else if (data[0][i]["board_type"] == 'Q') {
                        boardType = 'Hỏi đáp'
                    } else if (data[0][i]["board_type"] == 'V') {
                        boardType = 'Video'
                    } else if (data[0][i]["board_type"] == 'L') {
                        boardType = 'GalleryList'
                    } else {
                        boardType = 'Tự cài đặt'
                    }
                    let date = moment(data[0][i]["cat_reg_dtm"]).format('DD MMM YYYY');
                    row += "<tr onclick=" + "setLinkMenu('/news/board/" + data[0][i]["board_seq"] + "')" + " data-key=" + data[0][i]["board_seq"] + ">"
                        + "<td>" + data[0][i]["board_name"] + "</td>"
                        + "<td>" + boardType + "</td>"
                        + "<td>" + date + "</td>"
                        + "</tr>"
                    $('.listCate').html(row);
                }
                $('#catPaging').html('');
                $('#catPaging').html(data[1]);
            }
        })
    };
</script>

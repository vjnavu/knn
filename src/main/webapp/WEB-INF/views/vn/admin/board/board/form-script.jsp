<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(document).ready(function () {
        let view = $('#view').val().split(',');
        let write = $('#write').val().split(',');
        let read = $('#read').val().split(',');
        let del = $('#delete').val().split(',');
        for (let i = 0; i < view.length; i++) {
            $('#vl' + view[i]).prop('checked', true);
        }
        for (let i = 0; i < write.length; i++) {
            $('#wr' + write[i]).prop('checked', true);
        }
        for (let i = 0; i < read.length; i++) {
            $('#rd' + read[i]).prop('checked', true);
        }
        for (let i = 0; i < del.length; i++) {
            $('#dl' + del[i]).prop('checked', true);
        }
    });
    $('#BoardSaveBtn').click(function () {
        let name = $('#board_name').val();
        if (name == '') {
            alert('Vui lòng điền tên bảng tin')
        } else {
            let viewList = [];
            let writePost = [];
            let readPost = [];
            let deletePost = [];
            $('.viewList:checked').each(function (idx, el) {
                viewList.push(el.value);
            });
            $('.writePost:checked').each(function (idx, el) {
                writePost.push(el.value);
            });
            $('.readPost:checked').each(function (idx, el) {
                readPost.push(el.value);
            });
            $('.deletePost:checked').each(function (idx, el) {
                deletePost.push(el.value);
            });
            $('#view').val(viewList.toString());
            $('#write').val(writePost.toString());
            $('#read').val(readPost.toString());
            $('#delete').val(deletePost.toString());
            if (check_val_title()) {
                $('#boardForm').submit();
            }
        }
    });

    function check_val_title() {
        let checkResult = true;
        let filterWordArr = [];
        $('.word').each(function () {
            let word = $(this).text();
            if (word != undefined && word != "") {
                filterWordArr.push(word.trim());
            }
        });
        let board_name = $("#board_name").val();
        if (filterWordArr.length > 0) {
            for (let i = 0; i < filterWordArr.length; i++) {
                if (board_name.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    alert("Tên đề bảng tin chứa từ không hợp lệ: " + filterWordArr[i]);
                    $("#board_name").val(board_name.replace(filterWordArr[i], ""));
                    $("#board_name").focus();
                    checkResult = false;
                    break;
                }
            }
        }
        return checkResult;
    }
</script>

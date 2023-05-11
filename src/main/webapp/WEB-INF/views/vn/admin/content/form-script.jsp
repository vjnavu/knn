<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    CKEDITOR.replace('ctn_content_vn', editor_config);
    CKEDITOR.replace('ctn_content_en', editor_config);
    $('#contentSave').click(function () {
        if ($('#ctn_title').val() == '' || ($(CKEDITOR.instances.ctn_content_vn.getData()).text() == '' && (CKEDITOR.instances.ctn_content_en.getData()).text() == '')) {
            alert("Vui lòng nhập đầy đủ tiêu đề và ít nhất một nội dung tiếng Anh hoặc tiếng Việt");
        } else {
            if (check_val_title_vn() == true && check_val_en() == true) {
                $('#ctn_content_vn').val($(CKEDITOR.instances.ctn_content_vn.getData()).text());
                $('#ctn_content_en').val($(CKEDITOR.instances.ctn_content_en.getData()).text());
                $('#contentForm').submit();
            }
        }
    })


    function check_val_title_vn() {
        let checkResult = true;
        let filterWordArr = [];
        $('.word').each(function () {
            let word = $(this).text();
            if (word != undefined && word != "") {
                filterWordArr.push(word.trim());
            }
        });
        let ctn_title = $("#ctn_title").val();
        let ctn_content_vn = $(CKEDITOR.instances.ctn_content_vn.getData()).text();
        if (filterWordArr.length > 0) {
            for (let i = 0; i < filterWordArr.length; i++) {
                if (ctn_title.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    alert("Tiêu đề nội dung chứa từ không hợp lệ: " + filterWordArr[i]);
                    $("#ctn_title").val(ctn_title.replace(filterWordArr[i], ""));
                    $("#ctn_title").focus();
                    checkResult = false;
                    break;
                }
                if (ctn_content_vn.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    alert("Nội dung chứa từ không hợp lệ: " + filterWordArr[i]);
                    $("#ctn_content_vn").val(ctn_content_vn.replace(filterWordArr[i], ""));
                    $("#ctn_content_vn").focus();
                    checkResult = false;
                    break;
                }
            }
        }
        return checkResult;
    }

    function check_val_en() {
        let checkResult = true;
        let filterWordArr = [];
        $('.word').each(function () {
            let word = $(this).text();
            if (word != undefined && word != "") {
                filterWordArr.push(word.trim());
            }
        });
        let ctn_content_en = $(CKEDITOR.instances.ctn_content_en.getData()).text();
        if (filterWordArr.length > 0) {
            for (let i = 0; i < filterWordArr.length; i++) {
                if (ctn_content_en.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                    alert("Nội dung chứa từ không hợp lệ: " + filterWordArr[i]);
                    $("#ctn_content_en").val(ctn_content_en.replace(filterWordArr[i], ""));
                    $("#ctn_content_en").focus();
                    checkResult = false;
                    break;
                }
            }
        }
        return checkResult;
    }
</script>

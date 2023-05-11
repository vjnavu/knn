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

    CKEDITOR.replace('post_content_vn', editor_config);
    CKEDITOR.replace('post_content_en', editor_config);
    const dt = new DataTransfer();
    let deteleFileSeqCtn = 0;
    $('#postSaveBtn').click(function () {
        let file;
        if (${formAction eq 'update'}) {
            file = $('.imp-Files-class').length + $('.file-delete').length;
        } else {
            file = $('#post_file')[0].files.length;
        }
        if (file <= ${fileNumber}) {
            if (check_val_title_vn() === true/* && check_val_title_en() == true*/) {
                $('#post_content_vn').val($(CKEDITOR.instances.post_content_vn.getData()).text());
                $('#post_content_en').val($(CKEDITOR.instances.post_content_en.getData()).text());
                $('#postForm').submit();
            }
            if (${boardType eq 'V'}) {
                if (check_val_title_vn() === true && check_thumbnail() === true) {
                    $('#post_content_vn').val($(CKEDITOR.instances.post_content_vn.getData()).text());
                    $('#post_content_en').val($(CKEDITOR.instances.post_content_en.getData()).text());
                    $('#postForm').submit();
                }
            }
        } else {
            alert('Số file bạn nhập quá số lượng cho phép của bảng tin. vui lòng kiểm tra lại')
        }

    })

    function check_thumbnail() {
        var link = $('#post_video').val().toString().includes('youtube.com');
        var avatar = $('#avatar').get(0).files.length;
        if (!link && avatar === 0) {
            alert('Vui lòng thêm ảnh đại diện cho video');
            return false;
        } else return true;
    }


    function check_val_title_vn() {
        let checkResult = true;
        let filterWordArr = [];
        $('.word').each(function () {
            let word = $(this).text();
            if (word != undefined && word != "") {
                filterWordArr.push(word.trim());
            }
        });
        let post_title_vn = $("#post_title_vn").val();
        let post_content_vn = $(CKEDITOR.instances.post_content_vn.getData()).text();
        if (post_title_vn != "" || post_content_vn != "") {
            if (filterWordArr.length > 0) {
                for (let i = 0; i < filterWordArr.length; i++) {
                    if (post_title_vn.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Tiêu đề tiếng Việt của bài viết chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_title_vn").val(post_title_vn.replace(filterWordArr[i], ""));
                        $("#post_title_vn").focus();
                        checkResult = false;
                        break;
                    }
                    if (post_content_vn.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Nội dung tiếng Việt chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_content_vn").val(post_content_vn.replace(filterWordArr[i], ""));
                        $("#post_content_vn").focus();
                        checkResult = false;
                        break;
                    }
                }
            }
        } else {
            alert('Vui lòng điền tiêu đề và nội dung tiếng việt')
            checkResult = false;
        }
        return checkResult;
    }

    /*function check_val_title_en() {
        let checkResult = true;
        let filterWordArr = [];
        $('.word').each(function () {
            let word = $(this).text();
            if (word != undefined && word != "") {
                filterWordArr.push(word.trim());
            }
        });
        let post_title_en = $("#post_title_en").val();
        let post_content_en = $(CKEDITOR.instances.post_content_en.getData()).text();
        if (post_title_en != "" || post_content_en != "") {
            if (filterWordArr.length > 0) {
                for (let i = 0; i < filterWordArr.length; i++) {
                    if (post_title_en.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Tiêu đề tiếng Anh của bài viết chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_title_en").val(post_title_en.replace(filterWordArr[i], ""));
                        $("#post_title_en").focus();
                        checkResult = false;
                        break;
                    }
                    if (post_content_en.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Nội dung tiếng Anh chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_content_en").val(post_content_en.replace(filterWordArr[i], ""));
                        $("#post_content_en").focus();
                        checkResult = false;
                        break;
                    }
                }
            }
        } else {
            alert('Vui lòng điền tiêu đề và nội dung tiếng anh ')
            checkResult = false;
        }
        return checkResult;
    }*/


    $('#post_file').on('change', function () {
            let ar_ext = ["jpeg", "jpg", "png", "gif", "bmp", "hwp", "txt", "pdf", "doc", "docx", "csv", "xls", "xlsx", "ppt", "pptx", "zip", "7", "z", "gz", "tar", "rar"];
            for (let file of this.files) {
                let fileName = file.name;
                let fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                if (ar_ext.indexOf(fileExt) <= -1) {
                    alert('File đính kèm chứa tệp đuôi ' + fileName + ' không hợp lệ. Vui lòng tải lại');
                    $(this).val(null);
                    break;
                } else if (file.size > (50 * 1024 * 1024)) {
                    alert("Giới hạn kích thước của tệp là 50Mb.");
                    $(this).val(null);
                    break;
                } else {
                    dt.items.add(file);
                }
            }
            document.getElementById('post_file').files = dt.files;
            $('.file-block').remove();
            for (let i = 0; i < this.files.length; i++) {
                let fileBloc = $('<span/>', {class: 'file-block'}),
                    fileName = $('<span/>', {class: 'name', text: this.files.item(i).name});
                fileBloc.append('<span class="file-delete"><span>+</span></span>')
                    .append(fileName);
                $("#filesList > #files-names").append(fileBloc);
            }
            ;
            $('span.file-delete').click(function () {
                let name = $(this).next('span.name').text();
                $(this).parent().remove();
                for (let i = 0; i < dt.items.length; i++) {
                    if (name === dt.items[i].getAsFile().name) {
                        dt.items.remove(i);
                        continue;
                    }
                }
                document.getElementById('post_file').files = dt.files;
            });
        }
    );

    $('#avatar').on('change', function () {
            let avatar = $(this).val();
            let typeFile = avatar.substr(avatar.lastIndexOf('.') + 1);
            if (typeFile != 'jpg' && typeFile != 'jpeg' && typeFile != 'png') {
                alert('Bạn cần tải đúng định dạng file ảnh đại diện : JPG,JPEG,PNG');
                $(this).val(null);
            } else {
                $('#viewImg').hide();
            }
        }
    );


    $('.imp-Files-deltete').click(function () {
        var deleteFileSeq = $(this).attr("data-fileSeq");
        console.log(deleteFileSeq);
        $(this).closest($('.imp-Files-class')).remove();
        if (deleteFileSeq != null && deleteFileSeq != '') {
            $('#deleteFileSeqs').append('<input type="hidden" name="deleteFileSeqList[' + deteleFileSeqCtn + ']" value="' + deleteFileSeq + '"/>');
            deteleFileSeqCtn++;
        }
    })
</script>
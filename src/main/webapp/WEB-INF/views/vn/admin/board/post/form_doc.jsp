<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/admin/include/navigation.jsp" charEncoding="UTF-8"/>

<div class="main-content">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-12">
                <!-- Header -->
                <div class="header">
                    <div class="header-body">
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Title -->
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">Tin Tức</h1>
                            </div>

                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>

                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <c:forEach items="${boardList}" var="item">
                                        <li class="nav-item">
                                            <a href="/cms/post/${item.board_seq}" class="nav-link text-nowrap
                                            <c:if test="${item.board_seq == boardSeq}"> active</c:if>">
                                                    ${item.board_name}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/post/${formAction}" modelAttribute="postForm" id="postForm" method="post"
                           enctype="multipart/form-data">
                <div class="card">
                    <form:input class="form-control" type="hidden" path="post_seq" required="true" readonly="true"/>
                    <form:input class="form-control" type="hidden" path="board_seq" value="${boardSeq}"
                                required="true" readonly="true"/>
                    <div class="card-body">
                        <div class="tab-content">
                            <div class="col mb-3">
                                <label for="board_seq">Ngày Ban Hành</label>
                                <div class="input-group">
                                    <input id="post_doc_date" type="text" class="form-control flatpickr-input active" data-flatpickr="" placeholder="yyyy-mm-dd" readonly="readonly" >
                                    <form:input type="hidden" id="post_doc_dt" path="post_doc_dt" />
                                </div>
                            </div>

                            <div class="col mb-3">
                                <label class="form-label">Ký Hiệu</label>
                                <form:input path="post_title_vn" type="text" class="form-control" id="post_title_vn"
                                            maxlength="100"/>
                            </div>
                            <div class="form-group mb-3">
                                <label for="post_content_vn" class="form-label">Trích Yếu</label>
                                <div class="input-group">
                                    <form:textarea class="form-control editor"
                                                   path="post_hyper_text_vn" id="post_content_vn"
                                                   rows="3"/>
                                </div>
                            </div>
                        </div>
                        <div class="col mb-3">
                            <div class="btn-group-toggle">
                                <label class="btn btn-white" for="post_file">
                                    <i class="fe fe-file-plus"></i> Đính Kèm File
                                </label>
                                <small class="text-danger ms-1">(*) Định dạng tệp được chấp nhận:
                                    jpeg, jpg, png, gif, bmp, hwp, txt, pdf, doc, docx, csv, xls, xlsx, ppt, pptx, zip,
                                    7z, gz, tar, rar</small>
                                <input class="form-control" type="file" id="post_file" name="post_file" multiple
                                       hidden/>
                                <c:if test="${formAction == 'update'}">
                                    <c:if test="${ not empty postForm.fileVOList}">
                                        <div id="imp-Files">
                                            <c:forEach items="${postForm.fileVOList}" var="files">
                                                                                    <span class="imp-Files-class"><span
                                                                                            class="imp-Files-deltete"
                                                                                            data-fileSeq="${files.file_seq}"><span>+</span></span><a
                                                                                            href="/jarvis/file/download/${files.file_uuid}"><span
                                                                                            class="name pe-3">${files.file_name}</span></a></span>
                                            </c:forEach>
                                        </div>
                                        <div id="deleteFileSeqs"></div>
                                    </c:if>
                                </c:if>
                                <p id="files-area"><span id="filesList"><span id="files-names"></span></span></p>
                            </div>

                            <div class="form-group">
                                <div>
                                    <form:radiobutton class="form-check-input" path="post_display_tf" value="true"
                                                      id="true"/>
                                    <label for="true" class="form-label">Hiển thị</label>&nbsp;&nbsp;
                                    <form:radiobutton class="form-check-input" path="post_display_tf" value="false"
                                                      id="false"/>
                                    <label for="false" class="form-label">Không hiển thị</label>
                                </div>
                            </div>
                            <div class="col text-end mt-3 mb-0">
                                <a href="#" id="postSaveBtn" class="btn btn-primary"><i class="fe fe-save"></i> Lưu</a>
                                <c:choose>
                                    <c:when test="${formAction == 'save'}">
                                        <a href="/cms/post/${postForm.board_seq}" class="btn btn-dark"><i
                                                class="fe fe-x"></i> Hủy</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/cms/post/${postForm.board_seq}" class="btn btn-dark"><i
                                                class="fe fe-x"></i> Hủy</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    </form:form>
                    <div>
                        <c:if test="${not empty wordFilter}"><c:forEach items="${wordFilter}" var="w"><p class="word"
                                                                                                         hidden>${w}</p></c:forEach></c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>

<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>

<script>
    $(document).ready(function() {
        $('#post_doc_date').val('${postForm.post_doc_dt}');
    });

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
            if (check_val_title_vn() == true) {
                $('#postForm').submit();
            }
        } else {
            alert('Số file bạn nhập quá số lượng cho phép của bảng tin. vui lòng kiểm tra lại')
        }
    })

    $('#post_doc_date').change(function (){
        $('#post_doc_dt').val($('#post_doc_date').val());
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
        let post_title_vn = $("#post_title_vn").val();
        let post_content_vn = $("#post_content_vn").val();
        if (post_title_vn != "" || post_content_vn != "") {
            if (filterWordArr.length > 0) {
                for (let i = 0; i < filterWordArr.length; i++) {
                    if (post_title_vn.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Ký hiệu văn bản chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_title_vn").val(post_title_vn.replace(filterWordArr[i], ""));
                        $("#post_title_vn").focus();
                        checkResult = false;
                        break;
                    }
                    if (post_content_vn.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                        alert("Trích yếu văn bản chứa từ không hợp lệ: " + filterWordArr[i]);
                        $("#post_content_vn").val(post_content_vn.replace(filterWordArr[i], ""));
                        $("#post_content_vn").focus();
                        checkResult = false;
                        break;
                    }
                }
            }
        } else {
            alert('Vui lòng điền ký hiệu và trích yếu văn bản')
            checkResult = false;
        }
        return checkResult;
    }
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


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
                                <h1 class="header-title text-truncate">
                                    <c:if test="${action == 'new'}">
                                        THÊM KỲ THI
                                    </c:if>
                                    <c:if test="${action == 'update'}">
                                        CHỈNH SỬA KỲ THI
                                    </c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/exam/${action}" modelAttribute="exam" id="examForm"
                           method="post" enctype="multipart/form-data">
                <div class="card">
                    <form:input class="form-control" type="hidden" path="exam_seq" required="true" readonly="true"/>
                    <div class="card-body">
                        <div class="form-group mb-4">
                            <div class="row">
                                <div class="col-6">
                                    <label class="mb-2">Tên kỳ thi</label>
                                    <div class="input-group">
                                        <form:input type="text" path="exam_name" id="exam_name" class="form-control"
                                                    placeholder="Tên kỳ thi..." required="true" maxlength="100"/>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label class="mb-2">Loại kỳ thi</label>
                                    <div class="input-group">
                                        <form:select path="exam_type" class="form-select" aria-label="">
                                            <option value="" selected>Chọn loại kỳ thi</option>
                                            <option
                                                    <c:if test="${exam.exam_type eq 'VN'}">selected</c:if> value="VN">Kỳ
                                                thi trong nước
                                            </option>
                                            <option
                                                    <c:if test="${exam.exam_type eq 'IN'}">selected</c:if> value="IN">Kỳ
                                                thi quốc tế
                                            </option>
                                        </form:select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label for="lo_file" class="form-label">Logo kỳ thi</label>
                            <input id="lo_file" name="lo_file" type="file" class="form-control"
                                   accept="image/png, image/gif, image/jpeg"/>
                            <c:if test="${action == 'update'}">
                                <img class="pt-3" width="200px"
                                     src="/jarvis/file/view/${exam.exam_logo_uuid}"/>
                            </c:if>
                        </div>

                        <div class="form-group mb-4">
                            <label class="form-label">Mô tả kỳ thi</label>
                            <form:textarea path="exam_desc" class="form-control" cols="30" rows="10"/>
                        </div>
                        <div class="form-group mb-4">
                            <div class="row">
                                <div class="col-6">
                                    <label class="form-label">Từ ngày</label>
                                    <input id="start_dt" type="text" name=""
                                           class="form-control flatpickr-input active" data-flatpickr=""
                                           placeholder="yyyy-mm-dd" readonly="readonly"/>
                                    <form:input path="exam_start_dt" id="exam_start_dt" type="hidden"/>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Đến ngày</label>
                                    <input id="end_dt" type="text" name=""
                                           class="form-control flatpickr-input active" data-flatpickr=""
                                           placeholder="yyyy-mm-dd" readonly="readonly"/>
                                    <form:input path="exam_end_dt" id="exam_end_dt" type="hidden"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-4">
                            <label class="form-label">Nghề đăng ký dự thi</label>
                            <select class="form-select" data-role="tags">
                                <option value="" selected>Chọn nghề đăng ký dự thi</option>
                                <c:forEach items="${cert2s}" var="cert2">
                                    <option value="${cert2.cert2_seq}"
                                    >${cert2.cert2_name}</option>
                                </c:forEach>
                            </select>
                            <div class="tags-input">
                            </div>
                            <form:input path="exam_cert" id="exam_cert" type="hidden" value="" class="form-control"
                                        data-role="tags"/>
                        </div>
                        <div class="form-group mb-4">
                            <label class="form-label">Địa điểm thi</label>
                            <form:input path="exam_place" id="exam_place" type="text" class="form-control"/>
                        </div>

                        <div class="form-group mb-4">
                            <div class="btn-group-toggle">
                                <label class="btn btn-white" for="post_file" id="name-file">
                                    <i class="fe fe-file-plus"></i> Đính kèm file danh sách thí sinh dự thi
                                </label>
                                <small class="text-danger ms-1">(*) Định dạng tệp được chấp nhận:
                                    jpeg, jpg, png, gif, bmp, hwp, txt, pdf, doc, docx, csv, xls, xlsx, ppt, pptx,
                                    zip, 7z, gz, tar, rar</small>
                                <input class="form-control" type="file" id="post_file" name="cdd_file"
                                       hidden/>
                                <div class="my-3" id="file-student">
                                    <c:if test="${action == 'update'}">
                                        <c:if test="${exam.exam_candi != 0 and exam.exam_candi_uuid != null}">
                                         <span class="imp-Files-class"><a
                                                 href="/jarvis/file/download/${exam.exam_candi_uuid}"><span
                                                 class="name px-3">${exam.candi_name}</span></a></span>
                                        </c:if>
                                        <input type="hidden" value="${exam.start_date}" id="convertDateStart">
                                        <input type="hidden" value="${exam.end_date}" id="convertDateEnd">
                                        <input type="hidden" value="${exam.exam_cert_name}" id="exam_cert_name">
                                    </c:if>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <label class="form-label">Hiển thị kỳ thi</label>
                                <div>
                                    <form:radiobutton path="exam_display_tf" class="form-check-input"
                                                      id="true" value="true"/>
                                    <label for="true" class="form-label">Hiển thị</label>
                                    <form:radiobutton path="exam_display_tf" class="form-check-input"
                                                      id="false" value="false"/>
                                    <label for="false" class="form-label">Không hiển thị</label>
                                </div>
                            </div>
                            <hr>
                            <div class="col mt-3 mb-0 float-end">
                                <div type="submit" id="examSave" class="btn btn-primary"><i
                                        class="fe fe-save"></i> Lưu
                                </div>
                                <a href="/cms/exam" class="btn btn-dark"><i
                                        class="fe fe-x"></i> Hủy</a>
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
        <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
    </div>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
    let _valueArr = [];
    $(document).ready(function () {
        if (${action == 'update'}) {
            $('#start_dt').val($('#convertDateStart').val())
            $('#end_dt').val($('#convertDateEnd').val())
            let arSpan = $('#exam_cert_name').val().split(",");
            for (let tmp of arSpan) {
                $('.tags-input').append('<span class="tag">' + tmp + '<i class="fe fe-x"></i></span>');
            }
            let arSeq = $('#exam_cert').val().split(",");
            for (let seq of arSeq) {
                _valueArr.push(seq)
            }
        }

        $('select[data-role="tags"]').on('change', function () {
            const text = $(this).find('option:selected').text();
            const _value = $(this).val();
            const _inputHandler = $(this).parent().find($('input[data-role="tags"]'));
            const _tagsInput = $(this).parent().find($('.tags-input'));
            const _defaultValue = 'Nghề đăng ký dự thi';
            if (_valueArr.length === 0 && _value !== _defaultValue) {
                _valueArr.push(_value);
                _tagsInput.append('<span class="tag">' + text + '<i class="fe fe-x"></i></span>');
            } else {
                let check = true;
                for (let i = 0; i < _valueArr.length; i++) {
                    if (_valueArr[i] === _value) {
                        check = false;
                        break;
                    }
                }
                if (check && _value !== _defaultValue) {
                    _valueArr.push(_value);
                    _tagsInput.append('<span class="tag">' + text + '<i class="fe fe-x"></i></span>');
                }
            }
            _inputHandler.val(_valueArr);
        });
        $(document).on('click', '.tag i', function () {
            const _text = $(this).parent().text();
            const _value = $('select[data-role="tags"] option').filter(function () {
                return $(this).html() === _text;
            }).val();
            for (let i = 0; i < _valueArr.length; i++) {
                if (_valueArr[i] === _value) {
                    _valueArr.splice($.inArray(_value, _valueArr), 1);
                }
            }
            $(this).parent().remove();
            $('select[data-role="tags"]').parent().find($('input[data-role="tags"]')).val(_valueArr);
        })

        $('#examSave').click(function () {
            let startDate = new Date($('#start_dt').val());
            let endDate = new Date($('#end_dt').val());
            if (checkInputText() === true && validateForm() === true) {
                $('#exam_start_dt').val(startDate);
                $('#exam_end_dt').val(endDate);
                $('#examForm').submit();
            }
        });

        //filter word
        function checkInputText() {
            let checkResult = true;
            let filterWordArr = [];
            $('.word').each(function () {
                let word = $(this).text();
                if (word !== undefined && word !== "") filterWordArr.push(word.trim());
            });
            let exam_name = $('#exam_name').val();
            let exam_desc = $('#exam_desc').val();
            if (exam_name !== "" || exam_desc !== "") {
                if (filterWordArr.length > 0) {
                    for (let i = 0; i < filterWordArr.length; i++) {
                        if (exam_name.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                            alert("Tên kỳ thi chứa từ không hợp lệ: " + filterWordArr[i]);
                            $("#exam_name").val(exam_name.replace(filterWordArr[i], ""));
                            $("#exam_name").focus();
                            checkResult = false;
                            break;
                        }
                        if (exam_desc.toLowerCase().indexOf(filterWordArr[i].toLowerCase()) > -1) {
                            alert("Mô tả kỳ thi chứa từ không hợp lệ: " + filterWordArr[i]);
                            $("#exam_desc").val(exam_desc.replace(filterWordArr[i], ""));
                            $("#exam_desc").focus();
                            checkResult = false;
                            break;
                        }
                    }
                }
            } else {
                alert("Vui lòng điền tên kỳ thi và mô tả kỳ thi")
                checkResult = false;
            }
            return checkResult;
        }

        //validate avatar
        $('#lo_file').on('change', function () {
            let avatar = $(this).val();
            let typeFile = avatar.substr(avatar.lastIndexOf('.') + 1);
            if (typeFile !== 'jpg' && typeFile !== 'png' && typeFile !== 'jpeg') {
                alert('Bạn cần tải đúng định dạng ảnh đại diện: .jpg, .jpeg, .png');
                $(this).val(null);
            }
        });

        //validate file
        $('#post_file').on('change', function () {
                if (document.querySelector(".imp-Files-class") != null) {
                    document.querySelector(".imp-Files-class").remove();
                }
                let filename = $(this).val().split('\\').pop();
                $('#file-student').append('<span class="imp-Files-class"><span class="name px-3">' + filename + '</span></span>');

                let ar_ext = ["jpeg", "jpg", "png", "gif", "bmp", "hwp", "txt", "pdf", "doc", "docx", "csv", "xls", "xlsx", "ppt", "pptx", "zip", "7", "z", "gz", "tar", "rar"];
                for (let file of this.files) {
                    let fileName = file.name;
                    let fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                    if (ar_ext.indexOf(fileExt) <= -1) {
                        alert('File đính kèm chứa tệp đuôi ' + fileName + ' không hợp lệ. Vui lòng tải lại');
                        $(this).val(null);
                        document.querySelector(".imp-Files-class").remove();
                        break;
                    } else if (file.size > (50 * 1024 * 1024)) {
                        alert("Giới hạn kích thước của tệp là 50Mb.");
                        $(this).val(null);
                        $('#file-student .name').text('');
                        break;
                    }
                }
            }
        );

        function validateForm() {
            let checkResult = true;
            const examName = $('#exam_name').val();
            const examCert = $('#exam_cert').val();
            const typeExam = $('#exam_type').val();
            const startDate = $('#start_dt').val();
            const endDate = $('#end_dt').val();
            const examPlace = $('#exam_place').val();
            const logo = $('#lo_file').val();
            const file = $('#post_file').val();
            let status = $("input[type='radio'][name = 'exam_display_tf']:checked").val();

            if (examName === '') {
                alert('Vui lòng thêm tên kỳ thi');
                checkResult = false;
            } else if (typeExam === '') {
                alert('Vui lòng thêm loại kỳ thi');
                checkResult = false;
            } else if (logo === '' && ${action == 'new'}) {
                alert('Vui lòng thêm logo kỳ thi');
                checkResult = false;
            } else if (examCert === '') {
                alert('Vui lòng thêm nghề đăng ký dự thi');
                checkResult = false;
            } else if (startDate === '' || endDate === '') {
                alert('Vui lòng thêm thời gian diễn ra kỳ thi');
                checkResult = false;
            } else if (startDate > endDate) {
                alert('Ngày kết thúc không thể nhỏ hơn ngày bắt đầu');
                checkResult = false;
            } else if (examPlace === '') {
                alert('Vui lòng thêm địa điểm thi');
                checkResult = false;
            }/* else if (file === '' && ${action == 'new'}) {
                alert('Vui lòng thêm danh sách thí sinh dự thi');
                checkResult = false;
            } */ else if (status === undefined) {
                alert('Vui lòng chọn trạng thái kỳ thi');
                checkResult = false;
            } else {
                checkResult = true;
            }
            return checkResult;
        }
    });

    function delImage(imgSeq) {
        let idRemove = "image" + imgSeq;
        $('#' + idRemove).remove();
        let album = $('#exam_album').val();
        let arAlbum = []
        arAlbum = album.split(",");
        let result = arAlbum.filter(function (elem) {
            return elem != imgSeq;
        });
        $('#exam_album').val(result.join(","));
    }
</script>
</body>

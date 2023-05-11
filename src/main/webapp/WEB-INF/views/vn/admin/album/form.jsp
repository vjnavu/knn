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
                <div class="header">
                    <div class="header-body">
                        <div class="row align-items-center">
                            <div class="col">
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">
                                    <c:if test="${formAction == 'new'}">THÊM ALBUM</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA ALBUM</c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <c:if test="${successMess != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fe fe-check-circle"></i> ${successMess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                            <i class="fe fe-x"></i>
                        </button>
                    </div>
                </c:if>
                <c:if test="${errorMess != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fe fe-x-circle"></i> ${errorMess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                            <i class="fe fe-x"></i>
                        </button>
                    </div>
                </c:if>
                <form:form modelAttribute="albumForm" id="albumForm" action="/cms/album/${formAction}"
                           method="post" enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <form:input path="album_seq" type="hidden"/>
                            <div class="form-group mb-4">
                                <label for="album_name" class="form-label">Tên album</label>
                                <form:input type="text" class="form-control" path="album_name" id="album_name"
                                            placeholder="Tên album..." required="true" maxlength="100"/>
                            </div>
                            <div class="form-group mb-4">
                                <label for="exam_seq" class="form-label">Kỳ thi</label>
                                <div class="input-group">
                                    <form:select path="exam_seq" id="exam_seq" class="form-select"
                                                 aria-label="">
                                        <option value="0" selected>Chọn kỳ thi</option>
                                        <c:forEach items="${exams}" var="exam">
                                            <option <c:if
                                                    test="${albumForm.exam_seq == exam.exam_seq}"> selected </c:if>
                                                    value="${exam.exam_seq}">${exam.exam_name}</option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group mb-4">
                                <label for="album_img" class="form-label">Album</label>
                                <input id="album_img" name="imgs" type="file" class="form-control"
                                       accept="image/png, image/gif, image/jpeg" multiple/>
                                <c:if test="${formAction == 'update'}">
                                    <div class="row mt-3">
                                        <c:forEach items="${albumForm.album}" var="img">
                                            <div id="image${img.file_seq}" class="img-preview-album">
                                                <img class="pt-3" width="200px"
                                                     src="/jarvis/file/view/${img.file_uuid}"/>
                                                <button class="btn btn-danger"
                                                        onclick="delImage(${img.file_seq})">
                                                    <i class="fe fe-x text-light"></i>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <form:input path="album_img" id="albumImg" type="hidden"/>
                                </c:if>
                            </div>

                            <c:if test="${albumForm.album_mod_dt != null}">
                                <div class="form-group mb-4">
                                    <label class="form-label">Thời gian chỉnh sửa</label>
                                    <div class="form-control">
                                        <fmt:formatDate value="${albumForm.album_mod_dt}"
                                                        pattern="dd-MM-yyyy"/>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                        <div class="card-footer text-end">
                            <button type="button" id="btnSave" class="btn btn-primary"><i class="fe fe-save"></i> Lưu
                            </button>
                            <a href="/cms/album" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách</a>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $(document).ready(function () {
        $('#btnSave').click(function () {
            if ($('#album_name').val() === '') {
                alert('Vui lòng nhập tên album');
            } else if ($('#exam_seq').val() == 0) {
                alert('Vui lòng chọn kỳ thi');
            } else if ($('#album_img').val() == '') {
                alert('Vui lòng thêm ảnh vào album');
            } else {
                $('#albumForm').submit();
            }
        });
    });

    function delImage(imgSeq) {
        let idRemove = "image" + imgSeq;
        $('#' + idRemove).remove();
        let album = $('#albumImg').val();
        let arAlbum = []
        arAlbum = album.split(",");
        let result = arAlbum.filter(function (elem) {
            return elem != imgSeq;
        });
        $('#albumImg').val(result.join(","));
    }
</script>
</body>
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
                                <h1 class="header-title text-truncate">THÊM CHỨNG CHỈ</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <form:form modelAttribute="cert3" action="/cms/certificate/cert2/${action}" method="post" id="addForm"
                           enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <form:input path="cert1_seq" type="hidden"/>
                            <form:input path="cert2_seq" type="hidden"/>

                            <div class="form-group">
                                <label class="form-label">Tên Phân loại chứng chỉ cấp 1</label>
                                <input type="text" class="form-control" value="${nameCer1}" readonly/>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Tên Phân loại chứng chỉ chi tiết</label>
                                <input type="text" class="form-control" value="${nameCer2}" readonly/>
                            </div>

                            <div class="form-group">
                                <label for="cert3_name" class="form-label">Tên chứng chỉ</label>
                                <form:input path="cert3_name" type="text" class="form-control" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="cert3_level" class="form-label">Cấp</label>
                                <form:input path="cert3_level" type="text" class="form-control" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="cert3_sort" class="form-label">Thứ tự sắp xếp</label>
                                <form:input path="cert3_sort" type="number" class="form-control" maxlength="4"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Có sử dụng không</label>
                                <div>
                                    <form:radiobutton class="form-check-input" path="cert3_display_tf" value="true"
                                                      id="true"/>
                                    <label for="true" class="form-label">Có</label>
                                </div>
                                <div>
                                    <form:radiobutton class="form-check-input" path="cert3_display_tf" value="false"
                                                      id="false"/>
                                    <label for="false" class="form-label">Không</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Thông tin chứng chỉ</label>
                                <form:textarea path="cert3_desc" id="cert3_desc" rows="3" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="float-end">
                        <button type="button" id="btnSave" class="btn btn-primary"><i class="fe fe-save"></i> Lưu
                        </button>
                        <a type="button" href="/cms/certificate" class="btn btn-dark"><i class="fe fe-list"></i> Danh
                            sách</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckfinder/ckfinder.js"></script>
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

    CKEDITOR.replace('cert3_desc', editor_config);
    $('#btnSave').click(function () {
        let name = $('#cert3_name').val()
        $('#cert3_desc').val($(CKEDITOR.instances.cert3_desc.getData()).text());
        if (name != '' && name != null) {
            $('#addForm').submit()
        } else {
            alert('Vui lòng nhập tên danh mục chứng chỉ cấp 2')
        }
    })
</script>
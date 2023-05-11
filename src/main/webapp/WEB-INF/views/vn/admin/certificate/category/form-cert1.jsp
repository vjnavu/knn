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
                                    <c:if test="${action == 'new'}">THÊM </c:if>
                                    <c:if test="${action == 'update'}">CHỈNH SỬA </c:if>
                                    DANH MỤC CHỨNG CHỈ CẤP 1</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <form:form modelAttribute="cert1" action="/cms/certificate/${action}" method="post" id="addForm"
                           enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <form:input path="cert1_seq" type="hidden"/>
                            <div class="form-group">
                                <label for="cert1_name" class="form-label">Tên phân loại chứng chỉ cấp 1</label>
                                <form:input path="cert1_name" type="text" class="form-control" maxlength="100"/>
                            </div>

                            <div class="col mb-3">
                                <label class="form-label">Icon phân loại cấp 1</label><br>
                                <input class="form-control" type="file" name="avatar" id="avatar"
                                       accept="image/png, image/gif, image/jpeg"
                                       size="60"/>
                            </div>
                            <c:if test="${action=='update'}">
                                <div class="col mb-3" id="viewImg">
                                    <c:if test="${cert1.cert1_icon_uuid == ''}">
                                        <span>
                                            <img src="/jarvis/file/view/${cert1.cert1_icon_uuid}" alt=""
                                                 style="width: 300px; height: 200px; margin-top: 20px; ">
                                        </span>
                                    </c:if>
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label for="cert1_sort" class="form-label">Thứ tự sắp xếp</label>
                                <form:input path="cert1_sort" type="number" class="form-control" maxlength="4"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Có sử dụng không</label>
                                <div>
                                    <form:radiobutton class="form-check-input" path="cert1_display_tf" value="true"
                                                      id="true"/>
                                    <label for="true" class="form-label">Có</label>
                                </div>
                                <div>
                                    <form:radiobutton class="form-check-input" path="cert1_display_tf" value="false"
                                                      id="false"/>
                                    <label for="false" class="form-label">Không</label>
                                </div>
                            </div>

                            <c:if test="${action == 'update'}">
                                <div class="col mb-3">
                                    <label class="form-label">Ngày đăng ký</label>
                                    <input value="<fmt:formatDate value="${cert1.cert1_reg_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                           class="form-control"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Ngày chỉnh sửa cuối</label>
                                    <c:if test="${cert1.cert1_mod_dt == null}">
                                        <input value="Chưa chỉnh sửa" type="text" readonly="true" class="form-control"
                                               class="form-control"/>
                                    </c:if>
                                    <c:if test="${cert1.cert1_mod_dt != null}">
                                        <input value="<fmt:formatDate value="${cert1.cert1_mod_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                               class="form-control"/>
                                    </c:if>
                                </div>
                            </c:if>
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
<script>
    $('#btnSave').click(function () {
        let name = $('#cert1_name').val()
        if (name != '' && name != null) {
            if (${action == 'update'}) {
                $('#addForm').attr('action', '/cms/certificate/update/${pageOld}');
            }
            $('#addForm').submit()
        } else {
            alert('Vui lòng nhập tên danh mục chứng chỉ cấp 1')
        }
    })
</script>
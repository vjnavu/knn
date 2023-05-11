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
                                    CHỨNG CHỈ</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <form:form modelAttribute="cert3" action="/cms/certificate/cert2/${action}" method="post" id="addForm"
                           enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <form:input path="cert3_seq" type="hidden"/>
                                <label class="form-label">Tên Phân loại chứng chỉ cấp 1</label>
                                <form:select class="form-select form-control" id="cert1"
                                             path="cert1_seq">
                                    <option value="">Chọn phân loại chứng chỉ cấp 1</option>
                                    <c:forEach items="${cert1s}" var="item">
                                        <option
                                                <c:if test="${cert3.cert1_seq == item.cert1_seq}">selected</c:if>
                                                value="${item.cert1_seq}">
                                                ${item.cert1_name}</option>
                                    </c:forEach>
                                </form:select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Tên Phân loại chứng chỉ chi tiết</label>
                                <form:select class="form-select form-control" id="cert2"
                                             path="cert2_seq">
                                    <option value="">Chọn phân loại chứng chỉ cấp 2</option>
                                    <c:if test="${action == 'update'}">
                                        <c:forEach items="${cert2s}" var="item">
                                            <option
                                                    <c:if test="${cert3.cert2_seq == item.cert2_seq}">selected</c:if>
                                                    value="${item.cert2_seq}">
                                                    ${item.cert2_name}</option>
                                        </c:forEach>
                                    </c:if>
                                </form:select>
                            </div>

                            <div class="form-group">
                                <label for="cert3_name" class="form-label">Tên chứng chỉ</label>
                                <form:input path="cert3_name" type="text" class="form-control" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="cert3_level" class="form-label">Cấp</label>
                                <form:input path="cert3_level" type="text" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="2"/>
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

                            <c:if test="${action == 'update'}">
                                <div class="col mb-3">
                                    <label class="form-label">Ngày Đăng Ký</label>
                                    <input value="<fmt:formatDate value="${cert3.cert3_reg_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                           class="form-control"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Ngày chỉnh sửa cuối</label>
                                    <c:if test="${cert3.cert3_mod_dt == null}">
                                        <input value="Chưa chỉnh sửa" type="text" readonly="true" class="form-control"
                                               class="form-control"/>
                                    </c:if>
                                    <c:if test="${cert3.cert3_mod_dt != null}">
                                        <input value="<fmt:formatDate value="${cert3.cert3_mod_dt}"
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
                        <a type="button" href="/cms/certificate" class="btn btn-dark"><i class="fe fe-list"></i>
                            Danh sách</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/certificate/detail/form-script.jsp" charEncoding="UTF-8"/>

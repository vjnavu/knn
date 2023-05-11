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
                                    <c:if test="${formAction == 'new'}">THÊM </c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA </c:if>
                                    THÍ SINH ĐẠT GIẢI</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/candidate/${formAction}" modelAttribute="candidateForm" id="candidateForm"
                           method="post" enctype="multipart/form-data">
                    <div class="card">
                        <form:input class="form-control" type="hidden" path="cdd_seq" required="true" readonly="true"/>
                        <div class="card-body">
                            <div class="form-group mb-4">
                                <div class="form-group mb-4">
                                    <label class="form-label">Ảnh đại diện</label>
                                    <input type="file" id="cdd_avatar" name="avatar" class="form-control"
                                           accept="image/png, image/jpeg"/>
                                    <c:if test="${formAction == 'update'}">
                                        <img class="pt-3" width="200px"
                                             src="/jarvis/file/view/${candidateForm.cdd_logo_uuid}"/>
                                    </c:if>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-sm-12 mb-4">
                                        <label class="mb-2">Tên thí sinh</label>
                                        <div class="input-group">
                                            <form:input type="text" path="cdd_name" id="cdd_name"
                                                        class="form-control"
                                                        placeholder="Tên thí thi..." required="true" maxlength="100"/>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-12 mb-4">
                                        <label class="mb-2">Giới tính</label>
                                        <div class="input-group">
                                            <form:select path="cdd_gender" class="form-select">
                                                <option value="">Chọn giới tính</option>
                                                <option
                                                        <c:if
                                                                test="${candidateForm.cdd_gender eq 'M'}"> selected </c:if>
                                                        value="M"
                                                >
                                                    Nam
                                                </option>
                                                <option
                                                        <c:if
                                                                test="${candidateForm.cdd_gender eq 'F'}"> selected </c:if>
                                                        value="F"
                                                >
                                                    Nữ
                                                </option>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-12 mb-4">
                                        <label class="form-label">Ngày sinh</label>
                                        <input id="birthday" type="text" name="birthday"
                                               class="form-control date-picker active" data-flatpickr=""
                                               placeholder="yyyy-mm-dd" readonly="readonly"/>
                                        <c:if test="${formAction == 'update'}">
                                            <form:input path="birthday_tf" id="birthday_tf" type="hidden"/>
                                        </c:if>
                                    </div>
                                    <div class="col-lg-3 col-sm-12 mb-4">
                                        <label class="form-label">Chức vụ</label>
                                        <form:input type="text" placeholder="Nhập chức vụ..." class="form-control"
                                                    path="cdd_position"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="mb-2">Kỳ thi</label>
                                        <div class="input-group">
                                            <form:select path="exam_seq" id="exam_seq" class="form-select"
                                                         aria-label="">
                                                <option value="" selected>Chọn kỳ thi</option>
                                                <c:forEach items="${exams}" var="exam">
                                                    <option <c:if
                                                            test="${candidateForm.exam_seq == exam.exam_seq}"> selected </c:if>
                                                            value="${exam.exam_seq}">${exam.exam_name}</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="mb-2">Nghề dự thi</label>
                                        <div class="input-group">
                                            <form:select path="cert2_seq" class="form-select" id="cert2_seq"
                                                         aria-label="">
                                                <option value="" selected>Chọn nghề dự thi</option>
                                                <c:if test="${formAction == 'update'}">
                                                    <c:forEach items="${cert2s}" var="cert2">
                                                        <option <c:if
                                                                test="${candidateForm.cert2_seq == cert2.cert2_seq}"> selected </c:if>
                                                                value="${cert2.cert2_seq}">${cert2.cert2_name}</option>
                                                    </c:forEach>
                                                </c:if>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="form-label">Địa chỉ đơn vị</label>
                                        <form:input type="text" placeholder="Nhập địa chỉ đơn vị..."
                                                    class="form-control" path="cdd_office"/>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="form-label">Địa điểm thi</label>
                                        <form:input type="text" placeholder="Nhập địa điểm thi..." class="form-control"
                                                    path="cdd_exam_address"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="form-label">Thuộc đoàn</label>
                                        <form:input type="text" placeholder="Nhập tên đoàn..." class="form-control"
                                                    path="cdd_organize"/>
                                    </div>
                                    <div class="col-lg-6 col-sm-12 mb-4">
                                        <label class="form-label">Chức danh trong đoàn</label>
                                        <form:input type="text" placeholder="Nhập chức danh trong đoàn..."
                                                    class="form-control" path="cdd_posi_organize"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4 col-sm-6 mb-4">
                                        <label class="form-label">Điểm số 100</label>
                                        <form:input type="number" placeholder="Nhập điểm số 100..." class="form-control"
                                                    path="cdd_score"/>
                                    </div>
                                    <div class="col-lg-4 col-sm-6 mb-4">
                                        <label class="form-label">Điểm số CIS</label>
                                        <form:input type="number" placeholder="Nhập điểm số CIS..." class="form-control"
                                                    path="cdd_score_cis"/>
                                    </div>
                                    <div class="col-lg-4 col-sm-12 mb-4">
                                        <label class="form-label">Giải thưởng</label>
                                        <form:input type="text" placeholder="Nhập giải thưởng..." class="form-control"
                                                    path="cdd_award"/>
                                    </div>
                                </div>
                            </div>

                            <hr>
                            <div class="col mt-3 mb-0 float-end">
                                <div type="submit" id="cddSave" class="btn btn-primary"><i
                                        class="fe fe-save"></i> Lưu
                                </div>
                                <a href="/cms/candidate" class="btn btn-dark"><i class="fe fe-x"></i> Hủy</a>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/candidate/form-script.jsp" charEncoding="UTF-8"/>

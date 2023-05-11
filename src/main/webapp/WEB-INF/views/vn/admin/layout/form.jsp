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
                                    <c:if test="${formAction == 'new'}">THÊM LAYOUT</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA LAYOUT</c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>

                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/config" class="nav-link text-nowrap">Cài đặt chung</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/menu" class="nav-link text-nowrap ">Menu</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/layout" class="nav-link text-nowrap active">Layout</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <form:form modelAttribute="layoutForm" action="/cms/layout/${formAction}" method="post"
                           enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <form:input path="lo_seq" type="hidden"/>

                            <div class="form-group">
                                <label for="lo_title" class="form-label">Tiêu đề</label>
                                <form:input path="lo_title" type="text" class="form-control" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="lo_descr" class="form-label">Mô tả</label>
                                <form:textarea path="lo_descr" rows="3" class="form-control" laceholder="Mô tả"
                                               maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="lo_file" class="form-label">Ảnh đính kèm</label>
                                <input id="lo_file" name="lo_file" type="file" class="form-control"
                                       accept="image/png, image/gif, image/jpeg"/>
                                <c:if test="${formAction == 'update'}">
                                    <img class="pt-3" width="200px"
                                         src="/jarvis/file/view/${layoutForm.lo_img_file_uuid}"/>
                                </c:if>
                            </div>

                            <div class="form-group">
                                <label for="lo_link" class="form-label">Link URL</label>
                                <form:input path="lo_link" type="text" class="form-control" placeholder="Liên kết"
                                            maxlength="200"/>
                            </div>

                            <c:if test="${formAction == 'update'}">
                                <div class="form-group">
                                    <label for="lo_type">Phân Loại</label>
                                    <div class="input-group">
                                        <form:select class="form-select form-control" id="lo_type" path="lo_type">
                                            <option value="MainVisual"
                                                    <c:if test="${layoutForm.lo_type == 'MainVisual'}">selected</c:if>>
                                                Main Visual
                                            </option>
                                            <option value="Popup"
                                                    <c:if test="${layoutForm.lo_type == 'Popup'}">selected</c:if>>Popup
                                            </option>
                                            <option value="Banner"
                                                    <c:if test="${layoutForm.lo_type == 'Banner'}">selected</c:if>>
                                                Banner
                                            </option>
                                            <option value="CQLQ"
                                                    <c:if test="${layoutForm.lo_type == 'CQLQ'}">selected</c:if>>
                                                CQLQ
                                            </option>
                                            <option value="CQHT"
                                                    <c:if test="${layoutForm.lo_type == 'CQHT'}">selected</c:if>>
                                                CQHT
                                            </option>
                                        </form:select>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${formAction == 'new'}">
                                <div class="form-group">
                                    <label for="lo_type">Phân Loại</label>
                                    <div class="input-group">
                                        <form:select class="form-select form-control" id="lo_type" path="lo_type">
                                            <option value="MainVisual">
                                                Main Visual
                                            </option>
                                            <option value="Popup">
                                                Popup
                                            </option>
                                            <option value="Banner">
                                                Banner
                                            </option>
                                            <option value="CQLQ">
                                                CQLQ
                                            </option>
                                            <option value="CQHT">
                                                CQHT
                                            </option>
                                        </form:select>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label for="lo_sort" class="form-label">Thứ Tự sắp xếp</label>
                                <form:input path="lo_sort" type="number" class="form-control" placeholder="0"
                                            maxlength="4"/>
                            </div>
                            <div class="form-group">
                                <form:checkbox class="form-check-input" path="lo_target_blank_tf"/> Mở liên kết trong
                                tab mới
                            </div>
                            <div class="form-group">
                                <form:checkbox id="lo_display" class="form-check-input" path="lo_display_tf"/> Hiển thị
                            </div>
                            <c:if test="${formAction == 'update'}">
                                <div class="form-group">
                                    <label class="form-label">Ngày đăng ký : </label>
                                    <span style="font-weight: bold;"><fmt:formatDate value="${layoutForm.lo_reg_dt}"
                                                                                     pattern="dd-MM-yyyy"/></span>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Ngày sửa : </label>
                                    <span style="font-weight: bold;">
                                        <c:if test="${layoutForm.lo_mod_dt != null}">
                                            <fmt:formatDate value="${layoutForm.lo_mod_dt}"
                                                            pattern="dd-MM-yyyy"/>
                                        </c:if>
                                        <c:if test="${layoutForm.lo_mod_dt == null}">
                                            "Chưa chỉnh sửa"
                                        </c:if>
                                    </span>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-footer text-end">
                            <button type="button" id="btnSave" class="btn btn-primary"><i class="fe fe-save"></i> Lưu
                            </button>
                            <a type="button" href="/cms/layout" class="btn btn-dark"><i class="fe fe-list"></i> Danh
                                sách</a>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/layout/layout-script.jsp" charEncoding="UTF-8"/>
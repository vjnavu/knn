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
                                    <c:if test="${formAction == 'new'}">THÊM NỘI DUNG</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA NỘI DUNG</c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/content/${formAction}" modelAttribute="contentForm" id="contentForm"
                           method="post" enctype="multipart/form-data">
                    <div class="card">
                        <form:input class="form-control" type="hidden" path="ctn_seq" required="true" readonly="true"/>
                        <div class="card-body">
                            <div class="form-group mb-4">
                                <label class="mb-2">Tiêu đề bài viết</label>
                                <div class="input-group">
                                    <form:input type="text" path="ctn_title" id="ctn_title" class="form-control"
                                                placeholder="Tiêu Đề Bài Viết" required="true" maxlength="100"/>
                                </div>
                            </div>
                            <nav>
                                <div class="nav nav-pills ps-3" role="tablist">
                                    <button class="nav-link active me-3" id="nav-vn-tab" data-bs-toggle="pill"
                                            data-bs-target="#nav-vn" type="button" role="tab"
                                            aria-selected="true"
                                            aria-controls="nav-vn">Nội dung bài viết tiếng Việt
                                    </button>
                                    <button class="nav-link" id="nav-en-tab" data-bs-toggle="pill"
                                            data-bs-target="#nav-en" type="button" role="tab"
                                            aria-selected="false"
                                            aria-controls="nav-en">Nội dung bài viết tiếng Anh
                                    </button>
                                </div>
                            </nav>
                            <div class="tab-content tab-pills">
                                <div class="tab-pane fade show active" id="nav-vn" role="tabpanel"
                                     aria-labelledby="nav-vn-tab">
                                    <div class="input-group">
                                        <form:textarea class="form-control editor" path="ctn_hyper_text_vn"
                                                       id="ctn_content_vn"
                                                       rows="3"/>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="nav-en" role="tabpanel"
                                     aria-labelledby="nav-en-tab">
                                    <div class="input-group">
                                        <form:textarea class="form-control editor" path="ctn_hyper_text_en"
                                                       id="ctn_content_en"
                                                       rows="3"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-4 mb-3">
                                <div>
                                    <form:radiobutton class="form-check-input" path="ctn_display_tf" value="true"
                                                      id="true"/>
                                    <label for="true" class="form-label">Hiển thị</label>&nbsp;&nbsp;

                                    <form:radiobutton class="form-check-input" path="ctn_display_tf" value="false"
                                                      id="false"/>
                                    <label for="false" class="form-label">Không hiển thị</label>
                                </div>
                            </div>
                            <c:if test="${formAction eq 'update'}">
                                <div class="col mb-3">
                                    <label class="form-label">Email người đăng ký</label>
                                    <form:input path="ctn_reg_email" type="text" readonly="true" class="form-control"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Ngày Đăng Ký</label>
                                    <input value="<fmt:formatDate value="${contentForm.ctn_reg_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                           class="form-control"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Email Người chỉnh sửa</label>
                                    <form:input path="ctn_mod_email" type="text" readonly="true" class="form-control"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Ngày chỉnh sửa</label>
                                    <input value="<fmt:formatDate value="${contentForm.ctn_mod_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                           class="form-control"/>
                                </div>
                            </c:if>
                            <hr>
                            <div class="col mt-3 mb-0 float-end">
                                <div type="submit" id="contentSave" class="btn btn-primary"><i
                                        class="fe fe-save"></i> Lưu
                                </div>
                                <c:choose>
                                    <c:when test="${formAction == 'save' or formAction == 'update'or formAction == 'new'}">
                                        <a href="/cms/content" class="btn btn-dark"><i class="fe fe-x"></i> Hủy</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/cms/content/view/${contentForm.ctn_seq}" class="btn btn-dark"><i
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
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckfinder/ckfinder.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/content/form-script.jsp" charEncoding="UTF-8"/>

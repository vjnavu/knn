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
                                    <c:if test="${formAction == 'new'}">THÊM BẢNG TIN</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA BẢNG TIN</c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <c:if test="${errorMess != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">${errorMess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <form:form action="/cms/board/${formAction}" modelAttribute="boardForm" id="boardForm"
                           method="post">
                <form:input class="form-control" type="hidden" path="board_seq" required="true"
                            readonly="true"/>

                <div class="card">
                    <div class="card-body" style="max-height: 100%;">
                        <div class="form-group mb-3">
                            <label>Tên bảng tin</label>
                            <div class="input-group">
                                <form:input type="text" path="board_name" id="board_name" class="form-control"
                                            required="true"/>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="board_seq">Loại bảng tin</label>
                            <div class="input-group">
                                <form:select class="form-select form-control" id="board_type" path="board_type">
                                    <option value="M"
                                            <c:if test="${boardForm.board_type == 'M'}">selected</c:if>>Thông thường
                                    </option>
                                    <option value="W"
                                            <c:if test="${boardForm.board_type == 'W'}">selected</c:if>>Web
                                    </option>
                                    <option value="G"
                                            <c:if test="${boardForm.board_type == 'G'}">selected</c:if>>Gallery
                                    </option>
                                    <option value="L"
                                            <c:if test="${boardForm.board_type == 'G'}">selected</c:if>>Gallery List
                                    </option>
                                    <option value="D"
                                            <c:if test="${boardForm.board_type == 'D'}">selected</c:if>>Tài liệu
                                    </option>
                                    <option value="U"
                                            <c:if test="${boardForm.board_type == 'U'}">selected</c:if>>Tự cài đặt
                                    </option>
                                    <option value="V"
                                            <c:if test="${boardForm.board_type == 'V'}">selected</c:if>>Video
                                    </option>
                                </form:select>
                            </div>
                        </div>
                        <div class="row d-flex align-items-center">
                            <label class="col-sm-1 col-form-label fw-bold">Quyền xem danh
                                sách</label>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input viewList" id="vl2"
                                       value="2"/>
                                <label class="form-check-label">DSD</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input viewList" id="vl3"
                                       value="3"/>
                                <label class="form-check-label">NSAO</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input viewList" id="vl4"
                                       value="4"/>
                                <label class="form-check-label">Guest</label>
                            </div>
                            <form:input path="board_perm_view_list" type="hidden" id="view"/>
                        </div>
                        <div class="row d-flex align-items-center">
                            <label class="col-sm-1 col-form-label fw-bold">Quyền viết</label>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input writePost" id="wr2"
                                       value="2"/>
                                <label class="form-check-label">DSD</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input writePost" id="wr3"
                                       value="3"/>
                                <label class="form-check-label">NSAO</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input writePost" id="wr4"
                                       value="4"/>
                                <label class="form-check-label">Guest</label>
                            </div>
                            <form:input path="board_perm_write" type="hidden" id="write"/>
                        </div>
                        <div class="row d-flex align-items-center">
                            <label class="col-sm-1 col-form-label fw-bold">Quyền đọc</label>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input readPost" id="rd2"
                                       value="2"/>
                                <label class="form-check-label">DSD</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input readPost" id="rd3"
                                       value="3"/>
                                <label class="form-check-label">NSAO</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input readPost" id="rd4"
                                       value="4"/>
                                <label class="form-check-label">Guest</label>
                            </div>
                            <form:input path="board_perm_view_post" type="hidden" id="read"/>
                        </div>
                        <div class="row d-flex align-items-center">
                            <label class="col-sm-1 col-form-label fw-bold">Quyền xóa</label>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input deletePost" id="dl2"
                                       value="2"/>
                                <label class="form-check-label">DSD</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input deletePost" id="dl3"
                                       value="3"/>
                                <label class="form-check-label">NSAO</label>
                            </div>
                            <div class="col-auto mb-2">
                                <input type="checkbox" class="form-check-input deletePost" id="dl4"
                                       value="4"/>
                                <label class="form-check-label">Guest</label>
                            </div>
                            <form:input path="board_perm_delete" type="hidden" id="delete"/>
                        </div>

                        <div class="col mb-3">
                            <label>Số lượng file đính kèm bài viết</label>
                            <form:input class="form-control" type="number" path="board_files"
                                        id="board_files" maxlength="2"/>
                        </div>

                        <div class="col mb-3">
                            <div>
                                <form:radiobutton class="form-check-input" path="board_display_tf" value="true"
                                                  id="true"/>
                                <label for="true">Hiển thị</label>

                                <form:radiobutton class="form-check-input" path="board_display_tf" value="false"
                                                  id="false"/>
                                <label for="false">Không hiển thị</label>
                            </div>
                        </div>

                        <c:if test="${formAction eq 'update'}">
                            <div class="col mb-3">
                                <label class="form-label">Email người đăng ký</label>
                                <form:input path="board_reg_email" type="text" readonly="true"
                                            class="form-control"/>
                            </div>
                            <div class="col mb-3">
                                <label class="form-label">Ngày Đăng Ký</label>
                                <input value="<fmt:formatDate value="${boardForm.board_reg_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                       class="form-control"/>
                            </div>
                            <div class="col mb-3">
                                <label class="form-label">Email Người chỉnh sửa</label>
                                <c:if test="${boardForm.board_mod_email == null}">
                                    <input value="Chưa chỉnh sửa" type="text" readonly="true" class="form-control"
                                           class="form-control"/>
                                </c:if>
                                <c:if test="${boardForm.board_mod_email != null}">
                                    <input type="text" readonly="true"
                                           class="form-control" value="${boardForm.board_mod_email}"/>
                                </c:if>
                            </div>
                            <div class="col mb-3">
                                <label class="form-label">Ngày chỉnh sửa</label>
                                <c:if test="${boardForm.board_mod_dt == null}">
                                    <input value="Chưa chỉnh sửa" type="text" readonly="true" class="form-control"
                                           class="form-control"/>
                                </c:if>
                                <c:if test="${boardForm.board_mod_dt != null}">
                                    <input value="<fmt:formatDate value="${boardForm.board_mod_dt}"
                                                pattern="dd-MM-yyyy"/>" type="text" readonly="true"
                                           class="form-control"/>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                    <div class="card-footer text-end">
                        <a href="#" id="BoardSaveBtn" class="btn btn-primary"><i class="fe fe-save"></i> Lưu</a>
                        <a href="/cms/board" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách</a>
                    </div>
                </div>
            </div>
        </div>
        </form:form>

        <div>
            <c:if test="${not empty wordFilter}"><c:forEach items="${wordFilter}" var="word"><p class="word"
                                                                                                hidden>${word}</p></c:forEach></c:if>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>

<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/board/board/form-script.jsp" charEncoding="UTF-8"/>

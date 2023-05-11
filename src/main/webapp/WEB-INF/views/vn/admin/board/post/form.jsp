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
                                <h1 class="header-title text-truncate"><c:if test="${formAction == 'save'}">THÊM</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA</c:if> BÀI VIẾT</h1>
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
                        <nav>
                            <div class="nav nav-pills ps-3" role="tablist">
                                <button class="nav-link active me-3" id="nav-vn-tab" data-bs-toggle="pill"
                                        data-bs-target="#nav-vn" type="button" role="tab"
                                        aria-selected="true"
                                        aria-controls="nav-vn">Tiếng Việt
                                </button>
                                <button class="nav-link" id="nav-en-tab" data-bs-toggle="pill"
                                        data-bs-target="#nav-en" type="button" role="tab"
                                        aria-selected="false"
                                        aria-controls="nav-en">Tiếng Anh
                                </button>
                            </div>
                        </nav>
                        <div class="tab-content tab-pills">
                            <div class="tab-pane fade show active" id="nav-vn" role="tabpanel"
                                 aria-labelledby="nav-vn-tab">
                                <div class="col mb-3">
                                    <label class="form-label">Tiêu đề</label>
                                    <form:input path="post_title_vn" type="text" class="form-control" id="post_title_vn"
                                                maxlength="100"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <form:input path="post_desc_vn" type="text" class="form-control" id="post_desc_vn"
                                                maxlength="500"/>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="post_content_vn" class="form-label">Nội dung</label>
                                    <div class="input-group">
                                        <form:textarea class="form-control editor"
                                                       path="post_hyper_text_vn" id="post_content_vn"
                                                       rows="3"/>
                                    </div>
                                </div>

<%--                                <div class="col mb-3">--%>
<%--                                    <label for="board_seq">Ngày Đăng</label>--%>
<%--                                    <div class="input-group">--%>
<%--                                        <input id="reg_dt" type="text" name="reg_dt"--%>
<%--                                               class="form-control flatpickr-input active" data-flatpickr=""--%>
<%--                                               placeholder="yyyy-mm-dd" readonly="readonly">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="form-group mb-3">--%>
<%--                                    <label for="post_content_vn" class="form-label">Lượt Xem</label>--%>
<%--                                    <div class="input-group">--%>
<%--                                        <form:input path="post_view_cnt" type="text" class="form-control"--%>
<%--                                                    id="post_view_cnt"/>--%>
<%--                                    </div>--%>
<%--                                </div>--%>

                            </div>
                            <div class="tab-pane fade" id="nav-en" role="tabpanel"
                                 aria-labelledby="nav-en-tab">
                                <div class="col mb-3">
                                    <label class="form-label">Tiêu đề tiếng Anh</label>
                                    <form:input path="post_title_en" type="text" class="form-control" id="post_title_en"
                                                maxlength="100"/>
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label">Mô tả tiếng Anh</label>
                                    <form:input path="post_desc_en" type="text" class="form-control" id="post_desc_en"
                                                maxlength="500"/>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="post_content_en" class="form-label">Nội dung tiếng Anh</label>
                                    <div class="input-group">
                                        <form:textarea class="form-control editor"
                                                       path="post_hyper_text_en" id="post_content_en"
                                                       rows="3"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col mb-3">
                            <label class="form-label">Ảnh đại diện</label><br>
                            <input class="form-control" type="file" name="avatar" id="avatar"
                                   accept="image/png, image/gif, image/jpeg"
                                   size="60"/>
                        </div>
                        <c:if test="${formAction=='update'}">
                            <div class="col mb-3" id="viewImg">
                                <span>
                                    <img src="/jarvis/file/view/${postForm.post_avatar_uuid}" alt="" class="img-fluid"
                                         style="object-fit: contain;">
                                </span>
                            </div>
                        </c:if>
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

                            <c:if test="${boardType eq 'V'}">
                                <div class="form-group mb-3">
                                    <label>URL Video</label>
                                    <div class="input-group">
                                        <form:input type="text" path="post_video_url" id="post_video"
                                                    class="form-control" maxlength="300"/>
                                    </div>
                                </div>
                            </c:if>

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
<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckfinder/ckfinder.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/board/post/form-script.jsp" charEncoding="UTF-8"/>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
    li {
        list-style: none;
    }
</style>
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
                                <h1 class="header-title text-truncate">Xem bài viết</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                            <div class="row align-items-center">
                                <div class="col">
                                    <ul class="nav nav-tabs nav-overflow header-tabs">
                                        <c:forEach items="${boardList}" var="item">
                                            <li class="nav-item">
                                                <a href="/cms/post/${item.board_seq}" class="nav-link text-nowrap
                                            <c:if test="${item.board_seq == postView.board_seq}"> active</c:if>">
                                                        ${item.board_name}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="card">
                        <div class="card-body">
                            <nav>
                                <div class="nav nav-pills ps-3" role="tablist">
                                    <button class="nav-link active me-3" id="nav-vn-tab" data-bs-toggle="pill"
                                            data-bs-target="#nav-vn" type="button" role="tab"
                                            aria-selected="true"
                                            aria-controls="nav-vn">Bài viết tiếng Việt
                                    </button>
                                    <button class="nav-link" id="nav-en-tab" data-bs-toggle="pill"
                                            data-bs-target="#nav-en" type="button" role="tab"
                                            aria-selected="false"
                                            aria-controls="nav-en">Bài viết tiếng Anh
                                    </button>
                                </div>
                            </nav>
                            <div class="tab-content tab-pills">
                                <div class="tab-pane fade show active" id="nav-vn" role="tabpanel"
                                     aria-labelledby="nav-vn-tab">
                                    <h1 class="header-title text-truncate">${postView.post_title_vn}</h1>
                                    <b>${postView.post_desc_vn}</b>
                                    <div class="my-3">
                                            <span class="pe-3 fw-bold"> Ngày đăng: <span
                                                    class="fw-normal"><fmt:formatDate
                                                    value="${postView.post_reg_dt}"
                                                    pattern="dd-MM-yyyy"/></span>
                                            </span>
                                        <span class="ps-3 fw-bold"> Người đăng: <span
                                                class="fw-normal">${postView.regis_name}</span></span>
                                    </div>
                                    <p style="text-align: center">
                                        <img src="/jarvis/file/view/${postView.post_avatar_uuid}"
                                             class="img-fluid my-3">
                                    </p>

                                    <c:if test="${postView.board_type != 'V'}">
                                        <div>${postView.post_hyper_text_vn}</div>
                                    </c:if>
                                </div>
                                <div class="tab-pane fade" id="nav-en" role="tabpanel"
                                     aria-labelledby="nav-en-tab">
                                    <h1 class="header-title text-truncate">${postView.post_title_en}</h1>
                                    <b>${postView.post_desc_en}</b>
                                    <div class="my-3">
                                             <span class="pe-3 fw-bold"> Ngày đăng : <span
                                                     class="fw-normal"><fmt:formatDate
                                                     value="${postView.post_reg_dt}"
                                                     pattern="dd-MM-yyyy"/></span>
                                             </span>
                                        <span class="px-3 fw-bold"> Người đăng: <span
                                                class="fw-normal">${postView.regis_name}</span>
                                            </span>
                                    </div>
                                    <c:if test="${not empty postView.post_avatar_uuid}">
                                        <p style="text-align: center">
                                            <img src="/jarvis/file/view/${postView.post_avatar_uuid}"
                                                 class="img-fluid my-3">
                                        </p>
                                    </c:if>

                                    <c:if test="${postView.board_type != 'V'}">
                                        <div>${postView.post_hyper_text_vn}</div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty postView.fileVOList}">
                                    <c:forEach items="${postView.fileVOList}" var="fileVO">
                                                <span class="px-4">
                                                    <a href="/jarvis/file/download/${fileVO.file_uuid}"><i
                                                            class="fe fe-save"></i> ${fileVO.file_name}</a>
                                                </span>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${postView.board_type == 'V'}">
                                    <iframe width="765"
                                            height="428"
                                            src="${postView.post_video_url}"
                                            title="YouTube video player" allowfullscreen></iframe>
                                </c:if>
                            </div>

                            <div class="col text-end mt-3 mb-0">
                                <a href="/cms/post/update/${postView.post_seq}" id="postSaveBtn"
                                   class="btn btn-primary"><i class="fe fe-edit"></i> Chỉnh Sửa</a>
                                <a href="/cms/post/${postView.board_seq}" class="btn btn-dark"><i
                                        class="fe fe-list"></i> Danh sách</a>
                            </div>
                        </div>
                    </div>
                </div>
                <ul class="d-flex justify-content-between align-items-center ps-0">
                    <li class="page-item">
                        <c:if test="${prePost.post_title_vn != null}">
                            <a class="page-link px-4"
                                    <c:choose>
                                        <c:when test="${not empty prePost}">href="/cms/post/view/${prePost.post_seq}"</c:when>
                                        <c:otherwise>href="#"</c:otherwise>
                                    </c:choose>
                            >
                                <i class="fe fe-arrow-left me-1"></i><span>Bài viết trước</span> :
                                <span class="fw-bold">${prePost.post_title_vn}</span>
                            </a>
                        </c:if>
                    </li>
                    <li class="page-item">
                        <c:if test="${nextPost.post_title_vn != null}">
                            <a class="page-link px-4"
                                    <c:choose>
                                        <c:when test="${not empty nextPost}">href="/cms/post/view/${nextPost.post_seq}"</c:when>
                                        <c:otherwise>href="#"</c:otherwise>
                                    </c:choose>
                            >
                                <span class="fw-bold">${nextPost.post_title_vn}</span> :
                                <span>Bài viết tiếp</span><i
                                    class="fe fe-arrow-right ms-1"></i>
                            </a>
                        </c:if>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $(document).ready(function () {
        $('#deletePost').click(function () {
            if (confirm('Bạn muốn xóa bài viết này?')) {
                postRequest('/cms/post/dlt/${postView.post_seq}');
            }
        });
    })
    var CSRF_PARAMETER = $("meta[name='_csrf_parameter']").attr("content");
    var CSRF_HEADER = $("meta[name='_csrf_header']").attr("content");
    var CSRF_TOKEN = $("meta[name='_csrf']").attr("content");

    function postRequest(url, data) {
        const form = document.createElement("form");
        form.setAttribute("method", 'post');
        form.setAttribute("action", url);
        if (!data) data = {};
        data[CSRF_PARAMETER] = CSRF_TOKEN;
        for (let i in data) {
            let dataField = document.createElement("input");
            dataField.setAttribute("type", "hidden");
            dataField.setAttribute("name", i);
            dataField.setAttribute("value", data[i]);
            form.appendChild(dataField);
        }
        document.body.appendChild(form);
        form.submit();
    }
</script>

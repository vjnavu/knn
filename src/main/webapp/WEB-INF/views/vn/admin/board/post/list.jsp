<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                                <h1 class="header-title text-truncate">QUẢN LÝ BÀI VIẾT</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/album"
                                           class="nav-link text-nowrap">
                                            Sự kiện
                                        </a>
                                    </li>
                                    <c:forEach items="${boardList}" var="item">
                                        <li class=" nav-item">
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
                <!-- Tab content -->
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

                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p>Bài viết hiển thị: <span class="fw-bold">${activePost}</span> / <span
                                class="fw-bold">${totalPost}</span> bài</p>
                    </div>
                    <a class="btn btn-primary mb-5" href="/cms/post/new/${boardSeq}"><i class="fe fe-plus-circle"></i>
                        Thêm
                        bài viết</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/post/${boardSeq}" modelAttribute="postSearch" id="searchForm"
                                       method="get">
                                <form:input type="hidden" class="form-control" path="page" id="page"/>
                                <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                                <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                                <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                                <div class="card-header">
                                    <div class="row align-items-center col-4">
                                        <div class="col col-md-3">
                                            <select class="form-select" id="sizeSelect">
                                                <option value="5">5 dòng</option>
                                                <option value="10">10 dòng</option>
                                                <option value="20">20 dòng</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row align-items-center col-8">
                                        <div class="col col-md-3"></div>
                                        <div class="col col-md-3">
                                            <form:select class="form-select" id="searchConditon" path="searchItem">
                                                <option value="post_title_vn">Tiêu đề tiếng việt</option>
                                                <option value="post_title_en">Tiêu đề tiếng anh</option>
                                            </form:select>
                                        </div>
                                        <div class="col col-md-6">
                                            <div class="input-group">
                                                <form:input class="form-control" path="keyWord" type="search"
                                                            placeholder="Nhập từ khóa tìm kiếm"/>
                                                <span class="input-group-text" id="btnSearch"><i
                                                        class="fe fe-search"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover text-center table-nowrap card-table">
                                        <colgroup>
                                            <col>
                                            <col>
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>Tiêu đề tiếng Việt</th>
                                            <th>Tiêu đề tiếng Anh</th>
                                            <th>Trạng thái</th>
                                            <th>Người đăng ký</th>
                                            <th>Ngày đăng ký</th>
                                            <th>Ngày chỉnh sửa cuối</th>
                                            <th>Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty postList}">
                                            <tr>
                                                <td colspan="7" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${postList}" var="item">
                                            <tr>
                                                <td class="text-start"><a
                                                        href="/cms/post/view/${item.post_seq}">${item.post_title_vn}</a>
                                                </td>
                                                <td class="text-start"><a
                                                        href="/cms/post/view/${item.post_seq}">${item.post_title_en}</a>
                                                </td>
                                                <td>
                                                    <c:if test="${item.post_display eq 'Y'}">
                                                        Hiển thị
                                                    </c:if>
                                                    <c:if test="${item.post_display eq 'N'}">
                                                        <span style="color: red;">Không hiển thị</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                        ${item.post_reg_email}
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${item.post_reg_dt}" pattern="dd-MM-yyyy"/>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${item.post_mod_dt}" pattern="dd-MM-yyyy"/>
                                                </td>
                                                <td>
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/post/update/${item.post_seq}">Chỉnh
                                                        sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết?');"
                                                       href="/cms/post/delete/${item.post_seq}">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer d-flex justify-content-center">
                                ${paging.page}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/board/post/list-script.jsp" charEncoding="UTF-8"/>

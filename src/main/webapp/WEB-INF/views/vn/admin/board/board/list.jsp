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
                <!-- Header -->
                <div class="header">
                    <div class="header-body">
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Title -->
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">QUẢN LÝ BẢNG TIN</h1>
                            </div>

                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>

                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/board" class="nav-link text-nowrap active">
                                            Bảng Tin
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/content" class="nav-link text-nowrap">
                                            Content
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/qa" class="nav-link text-nowrap">
                                            Hỏi đáp
                                        </a>
                                    </li>
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
                        <p>Bảng tin sử dụng: <span class="fw-bold">${activeBoard}</span> / <span class="fw-bold">${totalBoard}</span> bảng tin</p>
                    </div>
                    <a class="btn btn-primary mb-5" href="/cms/board/new"><i class="fe fe-plus-circle"></i> Thêm
                        bảng tin</a>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/board" modelAttribute="categorySearch" id="searchForm"
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
                                                <option value="board_name">Tiêu đề</option>
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
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>Tên bảng tin</th>
                                            <th>Tổng số bài viết</th>
                                            <th>Dạng xuất</th>
                                            <th>Ngày chỉnh sửa cuối</th>
                                            <th>Trạng thái</th>
                                            <th>Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty boardList}">
                                            <tr>
                                                <td colspan="5" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${boardList}" var="item">
                                            <tr>
                                                <td class="text-start">${item.board_name}</td>
                                                <td>${item.number_board}</td>
                                                <td>
                                                    <c:if test="${item.board_type eq 'M'}">
                                                        Thông thường
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'W'}">
                                                        Web
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'G'}">
                                                        Gallery
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'D'}">
                                                        Tài liệu
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'Q'}">
                                                        Hỏi đáp
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'V'}">
                                                        Video
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'U'}">
                                                        Tự cài đặt
                                                    </c:if>
                                                    <c:if test="${item.board_type eq 'L'}">
                                                        Gallery List
                                                    </c:if>

                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${item.board_mod_dt}"
                                                                    pattern="dd-MM-yyyy"/>
                                                </td>
                                                <td>
                                                    <c:if test="${item.board_display eq 'Y'}">
                                                        Hiển thị
                                                    </c:if>
                                                    <c:if test="${item.board_display eq 'N'}">
                                                        <span style="color: red;">Không hiển thị</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/board/update/${item.board_seq}">Chỉnh
                                                        sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="delBoard(${item.board_seq})"
                                                       id="btnDel${item.board_seq}">Xóa</a>
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
<c:import url="/WEB-INF/views/vn/admin/board/board/list-script.jsp" charEncoding="UTF-8"/>

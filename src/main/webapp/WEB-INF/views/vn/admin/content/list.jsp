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
                                <h1 class="header-title text-truncate">QUẢN LÝ NỘI DUNG</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/board" class="nav-link text-nowrap">
                                            Bảng Tin
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/content" class="nav-link text-nowrap active">
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
                        <p>Content sử dụng: <span class="fw-bold">${activeContent}</span> / <span
                                class="fw-bold">${totalContent}</span> content</p>
                    </div>
                    <a class="btn btn-primary mb-5" href="/cms/content/new"><i class="fe fe-plus-circle"></i> Thêm
                        Nội Dung</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/content" modelAttribute="contentSearch" id="searchForm"
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
                                                <option value="">Tất Cả</option>
                                                <option value="ctn_title">Tiêu Đề</option>
                                                <option value="ctn_content">Nội Dung</option>
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
                                    <!-- / .row -->
                                </div>
                            </form:form>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm text-center table-hover table-nowrap card-table">
                                        <colgroup>
                                            <col>
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th class="col-8"><a class="dataSort" data-sort="ctn_title" href="#">Tiêu đề
                                                nội
                                                dung</a></th>
                                            <th>Trạng thái</th>
                                            <th>Ngày chỉnh sửa cuối
                                                cùng
                                            </th>
                                            <th>Quản Lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty contentList}">
                                            <tr>
                                                <td colspan="5" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${contentList}" var="item">
                                            <tr>
                                                <td class="text-start"><a
                                                        href="/cms/content/view/${item.ctn_seq}">${item.ctn_title}</a>
                                                </td>
                                                <td>
                                                    <c:if test="${item.ctn_display eq 'Y'}">Hiển thị</c:if>
                                                    <c:if test="${item.ctn_display eq 'N'}"><span
                                                            style="color: red">Không hiển thị</span></c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${item.ctn_mod_dt != null}">
                                                        <fmt:formatDate value="${item.ctn_mod_dt}"
                                                                        pattern="dd-MM-yyyy"/>
                                                    </c:if>
                                                    <c:if test="${item.ctn_mod_dt == null}">
                                                        Chưa chỉnh sửa
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/content/update/${item.ctn_seq}">Chỉnh sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="delContent(${item.ctn_seq})">Xóa</a>
                                                    <a style="visibility: hidden"
                                                       id="btnDel${item.ctn_seq}"></a>
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
<c:import url="/WEB-INF/views/vn/admin/content/list-script.jsp" charEncoding="UTF-8"/>
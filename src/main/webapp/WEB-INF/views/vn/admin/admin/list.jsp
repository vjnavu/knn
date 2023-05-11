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
                                <h1 class="header-title text-truncate">DANH SÁCH QUẢN TRỊ VIÊN</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/admin" class="nav-link text-nowrap active">
                                            Quản trị viên <span
                                                class="badge rounded-pill bg-secondary-soft">${paging.totalRow}</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/login" class="nav-link text-nowrap ">
                                            Lịch sử đăng nhập <span
                                                class="badge rounded-pill bg-secondary-soft">${countSign}</span>
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
                <!-- Tab content -->
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p>Quản trị viên hoạt động: <span
                                class="fw-bold">${activeMember} / ${totalAdmin} quản trị viên</span></p>
                    </div>
                    <button type="button" class="btn btn-primary mb-2 text-left" data-bs-toggle="modal" id="btnAdd"
                            data-bs-target="#adminModal"><i class="fe fe-plus-circle"></i> Thêm quản trị viên
                    </button>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card p-4" data-list=''>
                            <form:form action="/cms/admin" modelAttribute="admin" id="searchForm"
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
                                                <option value="ad_name">Tên</option>
                                                <option value="ad_email">Email</option>
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
                            <div class="table-responsive">
                                <table class="table table-hover text-center table-nowrap card-table my-5">
                                    <colgroup>
                                        <col width="10%">
                                        <col>
                                        <col>
                                        <col width="10%">
                                        <col width="10%">
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th>Phân loại</th>
                                        <th>Tên</th>
                                        <th>Email</th>
                                        <th>Trạng thái</th>
                                        <th>Quản lý</th>
                                    </tr>
                                    </thead>
                                    <tbody class="list fs-base">
                                    <c:if test="${empty adminList}">
                                        <tr>
                                            <td colspan="10" class="text-center">Không có dữ liệu</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach items="${adminList}" var="item">
                                        <tr>
                                            <td>
                                                <c:if test="${item.ad_role == 1}">ADMIN</c:if>
                                                <c:if test="${item.ad_role == 2}">DSD</c:if>
                                                <c:if test="${item.ad_role == 3}">NSAO</c:if>
                                                <c:if test="${item.ad_role != 1 and item.ad_role != 2 and item.ad_role != 3}">Chưa phân quyền</c:if>
                                            </td>
                                            <td>${item.ad_name}</td>
                                            <td>${item.ad_email}</td>
                                            <td>
                                                <c:if test="${item.ad_status == 'D'}"><p class="text-warning">Chờ phê
                                                    duyệt</p></c:if>
                                                <c:if test="${item.ad_status == 'Y'}"><p>Bình
                                                    thường</p></c:if>
                                                <c:if test="${item.ad_status == 'N'}"><p class="text-danger">Tạm
                                                    khóa</p></c:if>
                                            </td>
                                            <td>
                                                <a class="btn btn-outline-primary"
                                                   onclick="getAdminInfo(${item.ad_seq})">Chỉnh sửa</a>
                                                <a class="btn btn-outline-danger"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa quản trị viên?');"
                                                   href="/cms/admin/delete/${item.ad_seq}">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
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
<c:import url="/WEB-INF/views/vn/admin/admin/add-modal.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/update-modal.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>


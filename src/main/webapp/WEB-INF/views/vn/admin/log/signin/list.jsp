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
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">LỊCH SỬ ĐĂNG NHẬP</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/admin" class="nav-link text-nowrap ">
                                            Người dùng <span
                                                class="badge rounded-pill bg-secondary-soft">${countAdmin}</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/login" class="nav-link text-nowrap active ">
                                            Lịch sử đăng nhập <span
                                                class="badge rounded-pill bg-secondary-soft">${paging.totalRow}</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="/cms/login/export" class="btn btn-success mb-5"><i class="fe fe-download"></i>
                    Tải danh sách lịch sử đăng nhập
                </a>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/login" modelAttribute="signSearch" id="searchForm"
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
                                                <option value="login_adm_name">Tên</option>
                                                <option value="login_adm_email">Email</option>
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
                                    <table class="table table-sm table-hover table-nowrap card-table">
                                        <colgroup>
                                            <col width="10%">
                                            <col width="25%">
                                            <col width="25%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>Phân Loại</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Ngày Đăng Nhập</th>
                                            <th>Địa Chỉ IP</th>
                                            <th>Trình Duyệt</th>
                                            <th>Hệ Điều Hành</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty listSign}">
                                            <tr>
                                                <td colspan="8" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${listSign}" var="item">
                                            <tr>
                                                <td>
                                                    <c:if test="${item.login_adm_role == 1}">ADMIN</c:if>
                                                    <c:if test="${item.login_adm_role == 2}">DSD</c:if>
                                                    <c:if test="${item.login_adm_role == 3}">NSAO</c:if>
                                                    <c:if test="${item.login_adm_role != 1 and item.login_adm_role != 2 and item.login_adm_role != 3}">Chưa phân quyền</c:if>
                                                </td>
                                                <td>${item.login_adm_name}</td>
                                                <td>${item.login_adm_email}</td>
                                                <td><fmt:formatDate value="${item.login_dt}" pattern="dd-MM-yyyy HH:mm"/></td>
                                                <td>${item.login_ip}</td>
                                                <td>${item.login_browser}</td>
                                                <td>${item.login_os}</td>
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
<script>
    $('#sizeSelect').val($('#pageSize').val());

    $('#btnSearch').click(function () {
        $('#searchForm').submit();
    })

    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    })
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
    .table {
        margin-bottom: 0;
    }

    .table-sm > :not(caption) > * > * {
        padding: .5rem;
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
                                <h1 class="header-title text-truncate">QUẢN LÝ MENU</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/config" class="nav-link text-nowrap">
                                            Cài đặt chung
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/menu" class="nav-link text-nowrap active">
                                            Menu
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/layout" class="nav-link text-nowrap">
                                            Layout
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
                <a class="btn btn-primary mb-5" href="/cms/menu/new/0"><i class="fe fe-plus-circle"></i> Thêm
                    Menu</a>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover table-nowrap">
                                        <colgroup>
                                            <col>
                                            <col>
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr class="text-center">
                                            <th>Tên menu(VN)</th>
                                            <th>Tên menu(EN)</th>
                                            <th>Thứ tự</th>
                                            <th>Link</th>
                                            <th>Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty menus}">
                                            <tr>
                                                <td colspan="8" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${menus}" var="item">
                                            <tr>
                                                <td>
                                                    <c:if test="${item.mn_top == 0}">
                                                        <span class="fw-bold">${item.mn_name_vn}</span>
                                                        <a type="button" class="btn btn-secondary float-end"
                                                           href="/cms/menu/new/${item.mn_seq}">
                                                            Thêm menu phụ
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${item.mn_top != 0}">
                                                        <i class="fe fe-corner-down-right ms-5"></i>
                                                    </c:if>
                                                    <c:if test="${item.mn_top != 0}">${item.mn_name_vn}</c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${item.mn_top == 0}"><span
                                                            class="fw-bold">${item.mn_name_en}</span></c:if>
                                                    <c:if test="${item.mn_top != 0}">
                                                        <i class="fe fe-corner-down-right ms-5"></i>
                                                    </c:if>
                                                    <c:if test="${item.mn_top != 0}">${item.mn_name_en}</c:if>
                                                </td>
                                                <td>${item.mn_sort}</td>
                                                <td>${item.mn_link}</td>
                                                <td class="">
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/menu/update/${item.mn_seq}">Chỉnh
                                                        sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa menu?');"
                                                       href="/cms/menu/delete/${item.mn_seq}">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
</script>
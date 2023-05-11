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
                                <h1 class="header-title text-truncate">QUẢN LÝ LAYOUT</h1>
                            </div>

                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>

                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/config" class="nav-link text-nowrap">
                                            Cài Đặt Chung
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/menu" class="nav-link text-nowrap">
                                            Menu
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/layout" class="nav-link text-nowrap active">
                                            Layout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/layout" modelAttribute="layoutSearch" id="searchForm"
                           method="get">
                    <form:input type="hidden" class="form-control" path="page" id="page"/>
                    <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                    <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                    <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                </form:form>

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
                <div class="d-flex align-items-center justify-content-between mb-5">
                    <p>Tổng số layout : <span class="fw-bold">${quantilyLayout}</span> layout</p>
                    <a class="btn btn-primary mb-3" href="/cms/layout/new"><i class="fe fe-plus-circle"></i> Thêm
                        Mới</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover text-center table-nowrap card-table">
                                        <thead>
                                        <tr>
                                            <th><a class="dataSort" data-sort="lo_type" href="#">Phân loại</a></th>
                                            <th>Ảnh</th>
                                            <th><a class="dataSort" data-sort="lo_title" href="#">Tiêu Đề</a></th>
                                            <th><a class="dataSort" data-sort="lo_link" href="#">Địa chỉ link</a></th>
                                            <th>Quản Lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty layoutList}">
                                            <tr>
                                                <td colspan="8" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${layoutList}" var="item">
                                            <tr>
                                                <td>${item.lo_type}</td>
                                                <td>
                                                    <img src="/jarvis/file/view/${item.lo_img_file_uuid}"
                                                         class="img-fluid" style="max-width:200px;">
                                                </td>
                                                <td>${item.lo_title}</td>
                                                <td>${item.lo_link}</td>
                                                <td>
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/layout/update/${item.lo_seq}">Chỉnh
                                                        sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa layout?');"
                                                       href="/cms/layout/delete/${item.lo_seq}">Xóa</a>
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
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/layout/layout-script.jsp" charEncoding="UTF-8"/>
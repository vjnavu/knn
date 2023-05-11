<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
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
                                <h1 class="header-title text-truncate">QUẢN LÝ CHỨNG CHỈ</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/certificate" class="nav-link text-nowrap">
                                            Danh mục chứng chỉ
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/certificate/detail" class="nav-link text-nowrap active">
                                            Chứng chỉ
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
                        <p>Chứng chỉ sử dụng: <span class="fw-bold">${activeCert3}</span> / <span
                                class="fw-bold">${totalCert3}</span> chứng chỉ</p>
                    </div>
                    <a class="btn btn-primary mb-5" href="/cms/certificate/cert3/new"><i class="fe fe-plus-circle"></i>
                        Thêm
                        Chứng Chỉ</a>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/certificate/detail" modelAttribute="catSearch" id="searchForm"
                                       method="get">
                                <form:input type="hidden" class="form-control" path="page" id="page"/>
                                <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                                <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                                <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                                <div class="card-header">
                                    <div class="row align-items-center col-1">
                                        <div class="col col-md-3"></div>
                                        <div class="col col-md-3"></div>
                                        <div class="col col-md-2">
                                            <form:select class="form-select" id="searchConditon" path="searchItem">
                                                <option value="">Tên chứng chỉ</option>
                                            </form:select>
                                        </div>
                                        <div class="col col-md-4">
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
                                        <thead>
                                        <tr>
                                            <th>Phân loại danh mục chứng chỉ</th>
                                            <th>Tên chứng chỉ</th>
                                            <th>Thứ tự</th>
                                            <th>Có sử dụng không</th>
                                            <th>Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty cats}">
                                            <tr>
                                                <td colspan="5" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${cats}" var="item">
                                            <tr>
                                                <td class="text-start">
                                                    <span class="fw-bold">${item.key.cert1_name}</span>
                                                </td>
                                                <td></td>
                                                <td>${item.key.cert1_sort}</td>
                                                <td>
                                                    <c:if test="${item.key.cert1_display eq 'Y'}">
                                                        Có
                                                    </c:if>
                                                    <c:if test="${item.key.cert1_display eq 'N'}">
                                                        <span class="text-danger">Không</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/certificate/update/cert1/detail/${item.key.cert1_seq}">Chỉnh
                                                        sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa chứng chỉ?');"
                                                       href="/cms/certificate/delete/cert1/${item.key.cert1_seq}">Xóa</a>
                                                </td>
                                            </tr>
                                            <c:if test="${empty item.value}">
                                                <tr>
                                                    <td colspan="5" class="text-center">Chưa có chứng chỉ</td>
                                                </tr>
                                            </c:if>
                                            <c:forEach items="${item.value}" var="item2">
                                                <tr>
                                                    <td class="text-start"><i
                                                            class="fe fe-corner-down-right ms-5"></i> ${item2.cert2_name}
                                                    </td>
                                                    <td>${item2.cert3_name}</td>
                                                    <td>${item2.cert3_sort}</td>
                                                    <td>
                                                        <c:if test="${item2.cert3_display eq 'Y'}">
                                                            Có
                                                        </c:if>
                                                        <c:if test="${item2.cert3_display eq 'N'}">
                                                            <span class="text-danger">Không</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-outline-primary"
                                                           href="/cms/certificate/cert3/update/${item2.cert3_seq}">Chỉnh
                                                            sửa</a>
                                                        <a class="btn btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa chứng chỉ?');"
                                                           href="/cms/certificate/delete/cert3/${item2.cert3_seq}">Xóa</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
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
        $('#page').val('1');
        $('#searchForm').submit();
    });

    $('#sizeSelect').change(function () {
        $('#page').val(1);
        $('#pageSize').val($('#sizeSelect').val());
        $('#searchForm').submit();
    });

    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });
</script>
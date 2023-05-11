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
                                <h1 class="header-title text-truncate">QUẢN LÝ CƠ QUAN</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
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
                        <p>Cơ quan hoạt động: <span class="fw-bold">${activeAgency}</span> / <span
                                class="fw-bold">${totalAgency}</span> cơ quan</p>
                    </div>
                    <a class="btn btn-primary mb-5" href="/cms/agency/new"><i class="fe fe-plus-circle"></i> Thêm cơ
                        quan</a>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/agency" modelAttribute="agencySearch" id="searchForm"
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
                                                <option value="">Tất cả</option>
                                                <option value="ag_name_vn">Tên cơ quan(VN)</option>
                                                <option value="ag_name_en">Tên cơ quan(EN)</option>
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
                                    <table class="table table-sm table-hover text-center card-table">
                                        <colgroup>
                                            <col width="10%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>Logo cơ quan</th>
                                            <th><a class="dataSort" data-sort="ag_name_vn" href="#">Tên cơ quan(VN)</a>
                                            </th>
                                            <th><a class="dataSort" data-sort="ag_name_en" href="#">Tên cơ quan(EN)</a>
                                            </th>
                                            <th>Địa chỉ</th>
                                            <th>Hoạt động hay không</th>
                                            <th>Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty agencyList}">
                                            <tr>
                                                <td colspan="8" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${agencyList}" var="item">
                                            <tr>
                                                <td>
                                                    <img src="/jarvis/file/view/${item.ag_logo_file_uuid}"
                                                         class="img-fluid"
                                                         style="object-fit: contain; max-height: 100px">
                                                </td>
                                                <td>${item.ag_name_vn}</td>
                                                <td>${item.ag_name_en}</td>
                                                <td>${item.ag_addr},${item.addr3_name}, ${item.addr2_name}, ${item.addr1_name} </td>
                                                <td>
                                                    <c:if test="${item.ag_acti eq 'Y'}">
                                                        Có
                                                    </c:if>
                                                    <c:if test="${item.ag_acti eq 'N'}">
                                                        <span class="text-danger">Không</span>
                                                    </c:if>
                                                </td>
                                                <td class="text-nowrap">
                                                    <a class="btn btn-outline-primary"
                                                       href="/cms/agency/update/${item.ag_seq}">Chỉnh sửa</a>
                                                    <a class="btn btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa cơ quan không?');"
                                                       href="/cms/agency/delete/${item.ag_seq}">Xóa</a>
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
<c:import url="/WEB-INF/views/vn/admin/agency/list-script.jsp" charEncoding="UTF-8"/>

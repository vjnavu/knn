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
                                <h1 class="header-title text-truncate">QUẢN LÝ THÍ SINH ĐẠT GIẢI</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/exam" class="nav-link text-nowrap">
                                            Kỳ Thi
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/candidate" class="nav-link text-nowrap active">
                                            Thí sinh đạt giải
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
                    <a class="btn btn-primary mb-5" href="/cms/candidate/new"><i class="fe fe-plus-circle"></i> Thêm
                        Thí Sinh</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/candidate" modelAttribute="candidateSearch" id="searchForm"
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
                                    <table class="table table-sm text-center table-hover table-nowrap card-table">
                                        <colgroup>
                                            <col>
                                            <col>
                                            <col width="10%">
                                            <col width="20%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th scope="col">Ảnh đại diện</th>
                                            <th scope="col">Tên thí sinh</th>
                                            <th scope="col">Ngày sinh</th>
                                            <th scope="col">Giới tính</th>
                                            <th scope="col">Nghề nghiệp</th>
                                            <th scope="col">Địa chỉ đơn vị</th>
                                            <th scope="col">Kỳ thi</th>
                                            <th scope="col">Nghề dự thi</th>
                                            <th scope="col">Thuộc đoàn</th>
                                            <th scope="col">Chức danh trong đoàn</th>
                                            <th scope="col">Địa điểm thi</th>
                                            <th scope="col">Điểm số 100</th>
                                            <th scope="col">Điểm số SIS</th>
                                            <th scope="col">Đạt giải</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty candidates}">
                                            <tr>
                                                <td colspan="15" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty candidates}">
                                            <c:forEach items="${candidates}" var="candidate">
                                                <tr>
                                                    <td>
                                                        <img src="/jarvis/file/view/${candidate.cdd_logo_uuid}"
                                                             class="img-fluid"
                                                             style="object-fit: contain; max-height: 100px">
                                                    </td>
                                                    <td>${candidate.cdd_name}</td>
                                                    <td>
                                                        <fmt:formatDate value="${candidate.cdd_birthday}"
                                                                        pattern="dd-MM-yyyy"/>
                                                    </td>
                                                    <td>
                                                        <c:if test="${candidate.cdd_gender == 'M'}">Nam</c:if>
                                                        <c:if test="${candidate.cdd_gender == 'F'}">Nữ</c:if>
                                                    </td>
                                                    <td>${candidate.cdd_position}</td>
                                                    <td>${candidate.cdd_office}</td>
                                                    <td>${candidate.exam_name}</td>
                                                    <td>${candidate.cert2_name}</td>
                                                    <td>${candidate.cdd_organize}</td>
                                                    <td>${candidate.cdd_posi_organize}</td>
                                                    <td>${candidate.cdd_exam_address}</td>
                                                    <td>${candidate.cdd_score}</td>
                                                    <td>${candidate.cdd_score_cis}</td>
                                                    <td>${candidate.cdd_award}</td>
                                                    <td>
                                                        <a class="btn btn-outline-primary"
                                                           href="/cms/candidate/update/${candidate.cdd_seq}">Chỉnh
                                                            sửa</a>
                                                        <a class="btn btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa thí sinh này?');"
                                                           href="/cms/candidate/delete/${candidate.cdd_seq}">Xóa</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
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
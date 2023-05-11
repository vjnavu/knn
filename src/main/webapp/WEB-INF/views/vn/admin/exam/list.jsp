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
                                <h1 class="header-title text-truncate">QUẢN LÝ KỲ THI</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/exam" class="nav-link text-nowrap active">
                                            Kỳ Thi
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/candidate" class="nav-link text-nowrap">
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
                    <a class="btn btn-primary mb-5" href="/cms/exam/new"><i class="fe fe-plus-circle"></i> Thêm
                        Kỳ Thi</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/exam" modelAttribute="examSearch" id="searchForm"
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
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="20%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th scope="col">Loại kỳ thi</th>
                                            <th scope="col">Logo kỳ thi</th>
                                            <th scope="col">Tên kỳ thi</th>
                                            <th scope="col">Thời gian bắt đầu</th>
                                            <th scope="col">Thời gian kết thúc</th>
                                            <th scope="col">Địa điểm thi</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty exams}">
                                            <tr>
                                                <td colspan="10" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty exams}">
                                            <c:forEach items="${exams}" var="exam">
                                                <tr>
                                                    <td>
                                                        <c:if test="${exam.exam_type eq 'IN'}">
                                                            Kỳ thi quốc tế
                                                        </c:if>
                                                        <c:if test="${exam.exam_type eq 'VN'}">
                                                            Kỳ thi trong nước
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <img src="/jarvis/file/view/${exam.exam_logo_uuid}"
                                                             class="img-fluid"
                                                             style="object-fit: contain; max-height: 100px">
                                                    </td>
                                                    <td>
                                                            ${exam.exam_name}
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${exam.exam_start_dt}"
                                                                        pattern="dd-MM-yyyy"/>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${exam.exam_end_dt}"
                                                                        pattern="dd-MM-yyyy"/>
                                                    </td>
                                                    <td>
                                                            ${exam.exam_place}
                                                    </td>
                                                    <td>
                                                        <c:if test="${exam.exam_display eq 'Y'}">
                                                            Hiển thị
                                                        </c:if>
                                                        <c:if test="${exam.exam_display eq 'N'}">
                                                            Ẩn
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-outline-primary"
                                                           href="/cms/exam/update/${exam.exam_seq}">Chỉnh sửa</a>
                                                        <a class="btn btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa bài thi này?');"
                                                           href="/cms/exam/delete/${exam.exam_seq}">Xóa</a>
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
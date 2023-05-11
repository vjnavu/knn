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
                                <h1 class="header-title text-truncate">QUẢN LÝ ALBUM</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/album"
                                           class="nav-link text-nowrap active">
                                            Sự kiện
                                        </a>
                                    </li>
                                    <c:forEach items="${boardList}" var="item">
                                        <li class=" nav-item">
                                            <a href="/cms/post/${item.board_seq}" class="nav-link text-nowrap">
                                                    ${item.board_name}
                                            </a>
                                        </li>
                                    </c:forEach>
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
                    <a class="btn btn-primary mb-5" href="/cms/album/new"><i class="fe fe-plus-circle"></i> Thêm
                        Album</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <form:form action="/cms/album" modelAttribute="albumSearch" id="searchForm"
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
                                        <div class="col col-md-6"></div>
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
                                            <col>
                                            <col width="10%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th scope="col">Tên album</th>
                                            <th scope="col">Kì thi</th>
                                            <th scope="col">Số lượng ảnh trong album</th>
                                            <th scope="col">Thời gian tạo</th>
                                            <th scope="col">Ngày chỉnh sửa cuối</th>
                                            <th scope="col">Quản lý</th>
                                        </tr>
                                        </thead>
                                        <tbody class="list fs-base">
                                        <c:if test="${empty albums}">
                                            <tr>
                                                <td colspan="5" class="text-center">Không có dữ liệu</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty albums}">
                                            <c:forEach items="${albums}" var="album">
                                                <tr>
                                                    <td class="text-start">${album.album_name}</td>
                                                    <td>
                                                        <c:if test="${album.exam_name == ''}">
                                                            <i style="font-style: italic">Chưa thuộc kỳ thi nào</i>
                                                        </c:if>
                                                        <c:if test="${album.exam_name != ''}">
                                                            ${album.exam_name}
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <input class="num" value="${album.album_img}" hidden>
                                                    </td>
                                                    <td><fmt:formatDate value="${album.album_regis}"
                                                                        pattern="dd-MM-yyyy"/></td>
                                                    <td><fmt:formatDate value="${album.album_mod_dt}"
                                                                        pattern="dd-MM-yyyy"/></td>
                                                    <td>
                                                        <a class="btn btn-outline-primary"
                                                           href="/cms/album/update/${album.album_seq}">
                                                            Chỉnh sửa</a>
                                                        <a class="btn btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa album này?');"
                                                           href="/cms/album/delete/${album.album_seq}">
                                                            Xóa</a>
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
<script>
    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });

    $(document).ready(function () {
        $(".num").each(function () {
            const arr = $(this).val().split(",");
            let count = arr.length;
            $(this).parent().append(count);
        })
    });
</script>
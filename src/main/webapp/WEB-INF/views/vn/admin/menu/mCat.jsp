<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal fade" id="mCat" tabindex="-1" role="dialog" aria-hidden="true" aria-labelledby="categories">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-card card">
                <div class="card-header">
                    <h4 class="card-header-title modeltitle" id="exampleModalCenterTitle">
                        CHỌN BẢNG TIN
                    </h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="card-body">
                    <form:form action="/cms/menu/search/board" modelAttribute="catSearch" id="catSearch"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <div class="card-header">
                            <div class="row align-items-center col-4">
                                <div class="col col-md-6">
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
                                        <option value="board_name">Tên Bảng Tin</option>
                                    </form:select>
                                </div>
                                <div class="col col-md-6">
                                    <div class="input-group">
                                        <form:input class="form-control search" id="keyWord" path="keyWord"
                                                    type="search"
                                                    placeholder="Nhập từ khóa tìm kiếm"/>
                                        <span class="input-group-text" id="btnSearchCat"><i
                                                class="fe fe-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <!-- / .row -->
                        </div>
                    </form:form>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover table-nowrap card-table" id="catetableId">
                            <thead>
                            <tr>
                                <th><a href="#">Tên bảng tin</a></th>
                                <th><a href="#">Kiểu bảng tin</a></th>
                                <th><a href="#">Ngày tạo</a></th>
                            </tr>
                            </thead>
                            <tbody class="list fs-base listCate">
                            <c:if test="${empty cats}">
                                <tr>
                                    <td colspan="7" class="text-center">Không có dữ liệu</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${cats}" var="item">
                                <tr data-key="${item.board_seq}"
                                    onclick="setLinkMenu('/news/board/${item.board_seq}')">
                                    <td>${item.board_name}</td>
                                    <td>
                                        <c:if test="${item.board_type eq 'M'}">
                                            Thông thường
                                        </c:if>
                                        <c:if test="${item.board_type eq 'W'}">
                                            Web
                                        </c:if>
                                        <c:if test="${item.board_type eq 'G'}">
                                            Gallery
                                        </c:if>
                                        <c:if test="${item.board_type eq 'D'}">
                                            Tài liệu
                                        </c:if>
                                        <c:if test="${item.board_type eq 'Q'}">
                                            Hỏi đáp
                                        </c:if>
                                        <c:if test="${item.board_type eq ''}">
                                            Video
                                        </c:if>
                                        <c:if test="${item.board_type eq 'U'}">
                                            Tự cài đặt
                                        </c:if>
                                        <c:if test="${item.board_type eq 'L'}">
                                            Gallery List
                                        </c:if>
                                    </td>
                                    <td><fmt:formatDate value="${item.board_reg_dt}" pattern="dd-MM-yyyy"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <div id="catPaging">${pagingCat.page}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

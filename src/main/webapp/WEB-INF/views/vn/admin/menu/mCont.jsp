<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal fade" id="mCont" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-card card">
                <div class="card-header">
                    <h4 class="card-header-title modeltitle" id="exampleModalCenterTitle">
                        CHỌN CONTENT
                    </h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="card-body" data-list=''>
                    <form:form action="/cms/menu" modelAttribute="conSearch" id="searchForm"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <div class="card-header">
                            <div class="row align-items-center col-4">
                                <div class="col col-md-6">
                                    <select class="form-select" id="sizeSelect1">
                                        <option value="5">5 dòng</option>
                                        <option value="10">10 dòng</option>
                                        <option value="20">20 dòng</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row align-items-center col-8">
                                <div class="col col-md-3"></div>
                                <div class="col col-md-3">
                                    <form:select class="form-select" id="searchConditon1" path="searchItem">
                                        <option value="">Tất Cả</option>
                                        <option value="ctn_title">Tiêu Đề</option>
                                        <option value="ctn_content">Nội Dung</option>
                                    </form:select>
                                </div>
                                <div class="col col-md-6">
                                    <div class="input-group">
                                        <form:input class="form-control" id="keyWord1" path="keyWord" type="search"
                                                    placeholder="Nhập từ khóa tìm kiếm"/>
                                        <span class="input-group-text" id="btnSearchContent"> <i
                                                class="fe fe-search"> </i> </span>
                                    </div>
                                </div>
                            </div>
                            <!-- / .row -->
                        </div>
                    </form:form>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover table-nowrap card-table" id="tableId">
                            <thead>
                            <tr>
                                <th>Tiêu Đề</th>
                                <th>Người tạo</th>
                                <th>Ngày Tạo</th>
                            </tr>
                            </thead>
                            <tbody class="list fs-base listCont">
                            <c:if test="${empty cons}">
                                <tr>
                                    <td colspan="8" class="text-center">Không có dữ liệu</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${cons}" var="item">
                                <tr data-key="${item.ctn_seq}"
                                    onclick="setLinkMenu('/news/content/${item.ctn_seq}')">
                                    <td>${item.ctn_title}</td>
                                    <td>${item.ctn_reg_email}</td>
                                    <td><fmt:formatDate value="${item.ctn_reg_dt}" pattern="dd-MM-yyyy"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <div id="pagingCont">${pagingCon.page}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
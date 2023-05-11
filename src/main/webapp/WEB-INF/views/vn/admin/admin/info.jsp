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
                                <h1 class="header-title text-truncate">CHỈNH SỬA THÔNG TIN CÁ NHÂN</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/user/info" class="nav-link text-nowrap active">
                                            Thông tin cá nhân <span class="badge rounded-pill bg-secondary-soft"></span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/admin/password/change" class="nav-link text-nowrap ">
                                            Đổi mật khẩu <span class="badge rounded-pill bg-secondary-soft"></span>
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
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <div class="content" style="margin: 20px">
                                <form:form modelAttribute="infoAdmin" action="/cms/admin/info" id="updateInfoForm"
                                           method="post">
                                    <form:input type="hidden" path="ad_seq" class="form-control" id="ad_seq"
                                                value="${infoAdmin.ad_seq}"/>
                                    <input type="hidden" id="emailStart" value="${infoAdmin.ad_email}">
                                    <div class="form-group row">
                                        <label for="ad_name" class="col-sm-2 col-form-label">Tên</label>
                                        <div class="col-sm-6">
                                            <form:input type="text" path="ad_name" class="form-control" id="ad_name"
                                                        value="${infoAdmin.ad_name}" maxlength="100"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ad_email" class="col-sm-2 col-form-label">Email</label>
                                        <div class="col-sm-6">
                                            <form:input type="text" path="ad_email" class="form-control" id="ad_email"
                                                        value="${infoAdmin.ad_email}" maxlength="100"/>
                                        </div>
                                    </div>
                                    <div class="form-group row" id="department">
                                        <label for="ad_agency_seq" class="col-sm-2 col-form-label">Tên cơ quan</label>
                                        <div class="col-sm-6">
                                            <form:select class="form-select form-control" path="ad_agency_seq"
                                                         disabled="true">
                                                <option
                                                        <c:if test="${infoAdmin.ad_agency_seq == 0}">selected</c:if>
                                                        value="0">Chọn cơ quan
                                                </option>
                                                <option
                                                        <c:if test="${infoAdmin.ad_agency_seq == -1}">selected</c:if>
                                                        value="-1">DSD
                                                </option>
                                                <c:forEach items="${agencyList}" var="item">
                                                    <option value="${item.ag_seq}"
                                                            <c:if test="${infoAdmin.ad_agency_seq == item.ag_seq}">selected</c:if>
                                                    >NSAO-${item.ag_name_vn}</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ad_phone" class="col-sm-2 col-form-label">Số Điện Thoại</label>
                                        <div class="col-sm-6">
                                            <form:input type="text" path="ad_phone" class="form-control" id="ad_phone"
                                                        value="${infoAdmin.ad_phone}" maxlength="20"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ad_memo" class="col-sm-2 col-form-label">Ghi Chú</label>
                                        <div class="col-sm-6">
                                            <form:input type="text" path="ad_memo" class="form-control" id="ad_memo"
                                                        value="${infoAdmin.ad_memo}" maxlength="200"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Role</label>
                                        <div class="col-sm-6">
                                            <c:if test="${infoAdmin.ad_role == 1}">
                                                <input type="text" class="form-control"
                                                       value="ADMIN" readonly="true"/>
                                            </c:if>
                                            <c:if test="${infoAdmin.ad_role == 2}">
                                                <input type="text" class="form-control"
                                                       value="DSD" readonly="true"/>
                                            </c:if>
                                            <c:if test="${infoAdmin.ad_role == 3}">
                                                <input type="text" class="form-control"
                                                       value="NSAO" readonly="true"/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Trạng Thái</label>
                                        <div class="col-sm-6">
                                            <c:if test="${infoAdmin.ad_status eq 'Y'}">
                                                <input type="text" class="form-control"
                                                       value="Hoạt động (Đã phê duyệt)" readonly="true"/>
                                            </c:if>
                                            <c:if test="${infoAdmin.ad_status eq 'D'}">
                                                <input type="text" class="form-control"
                                                       value="Yêu cầu" readonly="true"/>
                                            </c:if>
                                            <c:if test="${infoAdmin.ad_status eq 'N'}">
                                                <input type="text" class="form-control"
                                                       value="Tạm khóa" readonly="true"/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div>
                                        <button class="btn btn-primary float-end" id="btnUpdateInfo" type="submit"><i class="fe fe-save"></i> Lưu
                                        </button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--modal--%>
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">XÁC THỰC EMAIL</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="ad_phone" class="col-sm-2 col-form-label">Nhập mã xác thực : </label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="confirmCode"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="checkCodeEmail">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>
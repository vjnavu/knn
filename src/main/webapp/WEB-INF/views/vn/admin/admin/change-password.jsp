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
                                <h1 class="header-title text-truncate">THAY ĐỔI MẬT KHẨU</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/admin/info" class="nav-link text-nowrap ">
                                            Thông tin cá nhân <span class="badge rounded-pill bg-secondary-soft"></span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/admin/pass/change" class="nav-link text-nowrap active">
                                            Đổi mật khẩu <span class="badge rounded-pill bg-secondary-soft"></span>
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
                <div class="tab-content">
                    <div class="tab-pane fade show active">
                        <div class="card" data-list=''>
                            <div class="content" style="margin: 20px">
                                <form:form modelAttribute="adminForm" action="/cms/admin/password/change"
                                           id="changePass"
                                           method="post">
                                    <div class="form-group row">
                                        <label for="ad_pw" class="col-sm-2 col-form-label">Mật khẩu hiện tại</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" id="ad_pw_current">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ad_new_pw" class="col-sm-2 col-form-label">Mật khẩu mới</label>
                                        <div class="col-sm-10">
                                            <form:input type="password" path="ad_pw" class="form-control"
                                                        id="ad_new_pw"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ad_confirm_pw" class="col-sm-2 col-form-label">Xác nhận mật khẩu
                                            mới</label>
                                        <div class="col-sm-10">
                                            <input type="password" name="ad_confirm_pw" class="form-control"
                                                   id="ad_confirm_pw">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label"></label>
                                        <div class="col-sm-10">
                                            <span id='message'></span>
                                        </div>
                                    </div>
                                    <span class="text-danger">
                                        Định dạng mật khẩu:
                                        <ul>
                                            <li>- Từ 8~12 ký tự bao gồm chữ cái tiếng anh hoa/thường+ chữ số+ ký tự đặc biệt</li>
                                            <li>- Chữ cái tiếng anh viết hoa/thường yêu cầu từ 4 ký tự trở lên</li>
                                            <li>- Bắt buộc phải có ít nhất 1 chữ số hoặc 1 ký tự đặc biệt</li>
                                            <li>- 4 chữ cái, số, ký tự đặc biệt giống nhau không hợp lệ (VD: aaaa, 1111, ...)</li>
                                        </ul>
                                    </span>
                                    <div>
                                        <button class="btn btn-primary float-end" type="button" id="btnChangePass"
                                        >
                                            <i class="fe fe-save"></i> Lưu
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
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>


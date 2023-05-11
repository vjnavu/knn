<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
    .auth form {
        margin-bottom: 30px;
        margin-top: 40px;
        border-bottom: none;
    }

    .btn {
        width: 120px;
    }

</style>
<body class="d-flex align-items-center bg-auth auth">
<div class="container">
    <div class="text-center my-5">
        <a href="/cms/sign-in">
            <img src="${pageContext.request.contextPath}/assets/cms/img/logo.png" class="logo" alt="">
        </a>
    </div>
    <div class="row justify-content-center">
        <div class="col-10 col-md-8 col-xl-6 main"
             style="padding:40px 60px; border:1px solid #d2ddec; width: 720px; border-radius: 10px">
            <h1 class="text-center mb-2">Đăng ký quản trị viên mới</h1>
            <h6 class="text-center mb-3">
                Homepage Management System
            </h6>
            <h3 class="text-danger">${message}</h3>
            <form:form modelAttribute="registerForm" action="/cms/sign-up" id="signupForm" method="post" enctype="multipart/form-data">
                <input id="ad_file" name="ad_file" type="file" class="form-control"
                       accept="image/png, image/gif, image/jpeg" hidden/>
                <dl class="row">
                    <dt>
                        <label for="ad_email" class="form-label">Email <small>*</small></label>
                    </dt>
                    <dd class="d-flex">
                        <div>
                            <form:input path="ad_email" type="email" class="form-control" placeholder="Nhập email..."
                                        required="true"
                                        title="Vui lòng nhập email của bạn" maxlength="100"/>
                            <span class="text-danger" id="ad_email-span"></span>
                        </div>
                        <a id="code" class="text-nowrap btn btn-primary ms-3">Gửi mã</a>
                        <button id="progressBar" class="btn btn-secondary ms-3">
                            <span>Gửi lại(</span><span id="timeRun"></span><span>)</span>
                        </button>
                    </dd>
                </dl>
                <dl class="row">
                    <dt><label for="codeConfirm" class="form-label">Mã xác thực <small>*</small></label></dt>
                    <dd>
                        <input id="codeConfirm" type="text" class="form-control" placeholder="Nhập mã xác thực..."/>
                    </dd>
                    <span class="text-danger" id="resultCheckCode"></span>
                </dl>
                <dl class="row">
                    <dt><label for="ad_name" class="form-label">Họ và tên <small>*</small></label></dt>
                    <dd>
                        <form:input path="ad_name" type="text" class="form-control" placeholder="Nhập họ tên..."
                                    required="true"
                                    title="Vui lòng điền họ tên" maxlength="100"/>
                    </dd>
                </dl>
                <dl class="row">
                    <dt><label for="ad_agency_seq" class="form-label">Tên Cơ Quan <small>*</small></label></dt>
                    <dd>
                        <form:select class="form-select form-control" path="ad_agency_seq" required="">
                            <option value="0">Chọn cơ quan</option>
                            <option value="-1">DSD</option>
                            <c:forEach items="${agencyList}" var="item">
                                <option value="${item.ag_seq}">NSAO-${item.ag_name_vn}</option>
                            </c:forEach>
                        </form:select>
                    </dd>
                </dl>
                <dl class="row">
                    <dt><label for="ad_phone" class="form-label">Số Điện Thoại <small>*</small></label></dt>
                    <dd>
                        <form:input path="ad_phone" type="text" class="form-control" placeholder="Nhập số điện thoại..."
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                    required="true" maxlength="20"/>
                    </dd>
                </dl>
                <dl class="row">
                    <dt>
                        <label for="ad_pw" class="form-label">Mật khẩu <small>*</small></label>
                    </dt>
                    <dd>
                        <form:input path="ad_pw" type="password" class="form-control" placeholder="Nhập mật khẩu"
                                    maxlength="80"/>
                        <span class="text-danger" id="ad_pw-span"></span>
                    </dd>
                </dl>
                <dl class="row">
                    <dt>
                        <label for="ad_pw_reinput" class="form-label">Nhập lại mật khẩu
                            <small>*</small></label>
                    </dt>
                    <dd>
                        <input id="ad_pw_reinput" type="password" class="form-control"
                               placeholder="Nhập lại mật khẩu..."
                               required="true" maxlength="80"/>
                        <span class="text-danger" id="password-span"></span>
                    </dd>
                </dl>
                <dl class="row" style="border-bottom: 1px solid #d2ddec;">
                    <dt>
                        <label for="ad_memo" class="form-label">Ghi Chú</label>
                    </dt>
                    <dd>
                        <form:textarea path="ad_memo" type="text" class="form-control"
                                       required="true" placeholder="Nhập ghi chú nếu có..."/>
                    </dd>
                </dl>

                <div class="text-center form-group" style="margin-top: 20px;">
                    <button type="button" href="/cms/sign-up" id="btnRegister"
                            class="btn btn-lg w-20 btn-primary mb-3">
                        Đăng ký
                    </button>
                    <a type="button" href="/cms/sign-in" class="btn btn-lg w-20 btn-dark mb-3">
                        Hủy bỏ
                    </a>
                </div>
            </form:form>
            <ul>
                <li>&#8251; Có thể đăng nhập sau khi quản trị viên phê duyệt đăng ký.</li>
                <li>&#8251; Email giải đáp thắc mắc của quản trị viên: <span
                        style="color: #2e9ad0">${emailAdmin}</span></li>
            </ul>
        </div>
    </div>
    <div class="text-center">
        <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:import url="/WEB-INF/views/vn/admin/authentication/authen-script.jsp" charEncoding="UTF-8"/>
<script>
    $(document).ready(function () {
        $('#progressBar').hide()
    });
</script>
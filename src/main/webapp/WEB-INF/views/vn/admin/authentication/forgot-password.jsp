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
        width: 105px !important;
    }
</style>
<body class="d-flex align-items-center bg-auth auth">
<!-- CONTENT
   ================================================== -->
<div class="container">
    <div class="text-center my-5">
        <a href="/cms/sign-in">
            <img src="${pageContext.request.contextPath}/assets/cms/img/logo.png" class="logo" alt="">
        </a>
    </div>
    <div class="row justify-content-center">
        <div class="col-10 col-md-8 col-xl-6 my-5 main"
             style="width: 720px;">
            <h1 class="text-center mb-2">Tìm mật khẩu</h1>
            <h6 class="text-center mb-3">Homepage Management System</h6>
            <h3 class="text-danger">${message}</h3>
            <form:form modelAttribute="forgotForm" action="/cms/forgot-password" id="forgotForm" method="post">
                <dl class="row">
                    <dt>
                        <label for="ad_email" class="form-label">Email <small>*</small></label>
                    </dt>
                    <dd style="display: flex">
                        <form:input path="ad_email" type="email" name="email" id="email" class="form-control"
                                    placeholder="Nhập email..."
                                    required="true" maxlength="100"/>
                        <a id="code_forgot" class="text-nowrap btn btn-primary ms-3">Gửi mã</a>
                        <button id="progressBar" class="btn btn-secondary ms-3">
                            <span>Gửi lại(</span><span id="timeRun"></span><span>)</span>
                        </button>
                    </dd>
                </dl>
                <dl style="border-bottom: 1px solid #d2ddec;" class="row">
                    <dt>
                        <label class="form-label">Mã xác thực <small>*</small></label>
                    </dt>
                    <dd>
                        <input id="codeConfirm" type="text" class="form-control" required="true"
                               placeholder="Nhập mã xác thực..."/>
                    </dd>
                </dl>
                <div class="text-center form-group" style="margin-top: 20px;">
                    <a type="submit" id="btnForgot" class="btn btn-primary mb-3">
                        Xác nhận
                    </a>
                    <a href="/cms/sign-in" class="btn btn-dark mb-3">
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
</style>
<body class="d-flex align-items-center bg-auth auth">
<div class="container">
    <div class="text-center my-5">
        <a href="/cms/sign-in">
            <img src="${pageContext.request.contextPath}/assets/cms/img/logo.png" class="logo" alt="">
        </a>
    </div>
    <div class="row justify-content-center">
        <div class="col-12 col-md-5 col-xl-4 main"
             style="">
            <!-- Heading -->
            <h1 class="text-center mb-2">Quản trị viên đăng nhập</h1>
            <h6 class="text-center mb-3">
                Homepage Management System
            </h6>
            <!-- Form -->
            <form:form modelAttribute="loginForm" action="/cms/sign-in" id="loginForm"
                       method="post">
                <!-- Email address -->
                <div class="form-group auth-email">
                    <i class="fe fe-user"></i>
                    <!-- Input -->
                    <form:input path="ad_email" type="text" class="form-control" placeholder="Email" required="true"
                                maxlength="100"/>
                </div>
                <div class="form-group auth-password">
                    <i class="fe fe-lock"></i>
                    <form:input path="ad_pw" class="form-control" type="password" placeholder="Mật khẩu"
                                required="true" maxlength="80"/>
                    <div class="text-danger mt-3">${message}</div>
                </div>
                <%--<input type="hidden" id="check" value="${checkCfrs}"/>--%>
                <div id="btnLogin" class="btn btn-lg w-100 btn-primary mb-3">
                    Đăng nhập
                </div>
                <!-- Link -->
                <div class="d-flex justify-content-center">
                    <small class="text-muted text-center">
                        <a href="/cms/sign-up" style="font-size: 15px;">Đăng ký</a>
                    </small>
                    <span style="margin: 0 20px">|</span>
                    <small class="text-muted text-center">
                        <a href="/cms/forgot-password" style="font-size: 15px;">Tìm lại mật khẩu</a>
                    </small>
                </div>
            </form:form>
            <ul>
                <li>&#8251; Có thể đăng nhập sau khi quản trị viên phê duyệt đăng ký.</li>
                <li>&#8251; Có thể đăng nhập bằng mật khẩu cấp tạm thời thông qua tìm mật khẩu.</li>
                <li>&#8251; Email giải đáp thắc mắc của quản trị viên: <span
                        style="color: #2e9ad0">${emailAdmin}</span></li>
            </ul>

        </div>
    </div>
    <div class="text-center">
        <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
    </div>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>

    $('#btnLogin').click(function () {
        $('#loginForm').submit();
    })
</script>
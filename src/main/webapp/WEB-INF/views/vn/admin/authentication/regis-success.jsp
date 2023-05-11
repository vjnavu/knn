<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <div class="col-12 col-md-5 col-xl-4 main">
            <!-- Heading -->
            <h1 class="text-center mb-2">Hoàn thành đăng ký quản trị viên mới</h1>
            <h6 class="text-center">
                Homepage Management System
            </h6>
            <div class="success-alert-wrap text-center my-5">
                <img src="${pageContext.request.contextPath}/assets/cms/img/icon/success-bg.png">
                <p style="font-size: 18px;" class="mb-0 mt-3">Đăng ký quản trị viên mới đã <span class="text-danger">hoàn thành</span>
                </p>
                <p style="font-size: 13px;">Bạn có thể đăng nhập sau khi quản trị viên trang chủ DSD phê duyệt</p>
                <a href="/cms/sign-in" class="btn btn-primary">Di chuyển đến màn hình đăng nhập</a>
            </div>
            <ul>
                <li>&#8251; Có thể đăng nhập sau khi quản trị viên phê duyệt đăng ký.</li>
                <li>&#8251; Email giải đáp thắc mắc của quản trị viên: <span
                        style="color: #2e9ad0">knn.gdnn@molisa.gov.vn</span></li>
            </ul>
        </div>
    </div>
    <div class="text-center">
        <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
    </div>
</div>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<style>
    .auth .success-alert-wrap {
        height: 400px;
        align-items: start;
        padding: 0 60px;
    }

    .auth .success-alert-wrap p {
        margin-bottom: 0;
        font-weight: bold;
    }

    .auth dl {
        width: 100%;
        border: 1px solid #d2ddec;
        background: #fff;
    }

    .auth dt {
        width: 130px;
        font-size: 13px;
        font-weight: bold;
    }

    .auth dd {
        font-size: 13px;
        width: calc(100% - 130px);
        color: #437dea;
        font-weight: bold;
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
        <div class="col-12 col-md-5 col-xl-4 main">
            <!-- Heading -->
            <h1 class="text-center mb-2">Kết quả tìm mật khẩu</h1>
            <h6 class="text-center">
                Homepage Management System
            </h6>
            <div class="success-alert-wrap my-5">
                <img class="mx-auto" src="${pageContext.request.contextPath}/assets/cms/img/icon/success-bg.png">
                <p class="mt-3" style="font-size: 15px;">Thông báo mật khẩu tạm thời của ${admin.ad_name}</p>
                <dl style="border-bottom: none" class="mt-3">
                    <dt>Email</dt>
                    <dd>${admin.ad_email}</dd>
                </dl>
                <dl class="mb-3">
                    <dt>Mật khẩu</dt>
                    <dd>${admin.ad_pw}</dd>
                </dl>
                <p class="text-center text-danger">Sau khi đăng nhập bằng mật khẩu tạm thời, vui lòng cài đặt lại mật
                    khẩu và sử
                    dụng.</p>
                <a href="/cms/sign-in" class="btn btn-primary mt-3 mx-auto">Di chuyển đến màn hình đăng nhập</a>
            </div>
        </div>
    </div>
    <div class="text-center">
        <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
    </div>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/admin/user-script.jsp" charEncoding="UTF-8"/>


<%@ page import="vn.gov.knn.admin.admin.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-auto">
    <div class="dropdown mb-2 me-2">
        <% Admin user = (Admin) request.getSession().getAttribute("CurrentUser"); %>
        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fe fe-settings"></i> Xin chào, <%=user.getAd_name() %>
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="">
            <a class="dropdown-item" href="/cms/admin/info"><i class="fe fe-user"></i> Thông tin cá nhân</a>
            <a class="dropdown-item" href="/cms/sign-out"><i class="fe fe-log-out"></i> Đăng xuất</a>
        </div>
    </div>
</div>

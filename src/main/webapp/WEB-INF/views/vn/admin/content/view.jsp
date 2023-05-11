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
                                <!-- Title -->
                                <h1 class="header-title text-truncate">CONTENT</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/board" class="nav-link text-nowrap">
                                            Bảng tin
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/content" class="nav-link text-nowrap active">
                                            Content
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <h1 class="header-title text-truncate">${contentView.ctn_title}</h1>
                <hr>
                <span class="px-3"> Ngày đăng : <strong><fmt:formatDate value="${contentView.ctn_reg_dt}"
                                                                        pattern="dd-MM-yyyy"/></strong></span>
                <span class="px-3"> Người đăng: <strong>${contentView.ctn_reg_email}</strong></span><br>
                <hr>
                <p>Nội dung Tiếng Việt</p>
                <c:if test="${contentView.ctn_hyper_text_vn == ''}">
                    Nội dung trống
                </c:if>
                <c:if test="${contentView.ctn_hyper_text_vn != ''}">
                    <div>${contentView.ctn_hyper_text_vn}</div>
                </c:if>
                <hr>
                <hr>
                <p>Nội dung Tiếng Anh</p>
                <c:if test="${contentView.ctn_hyper_text_en == ''}">
                    Nội dung trống
                </c:if>
                <c:if test="${contentView.ctn_hyper_text_en != ''}">
                    <div>${contentView.ctn_hyper_text_en}</div>
                </c:if>
                <hr>
                <div>
                    <a class="btn btn-primary" href="/cms/content/update/${contentView.ctn_seq}">Chỉnh sửa</a>
                    <a class="btn btn-danger" id="deletePost">Xóa</a>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/content/view-script.jsp" charEncoding="UTF-8"/>

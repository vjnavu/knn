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
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">CÀI ĐẶT CƠ BẢN</h1>
                            </div>

                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>

                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Nav -->
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/config" class="nav-link text-nowrap active">
                                            Cài đặt chung
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/menu" class="nav-link text-nowrap ">
                                            Menu
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/layout" class="nav-link text-nowrap">
                                            Layout
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
                <form:form modelAttribute="config" action="/cms/config/update" method="post"
                           enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <div class="col mb-3">
                                <label class="form-label">Hình Ảnh</label><br>
                                <input class="form-control" type="file" name="config_file" id="config_file"
                                       accept="image/png, image/gif, image/jpeg"
                                       size="60"/>
                            </div>
                            <div class="col mb-3" id="viewImg">
                                <span>
                                    <img src="/jarvis/file/view/${config.config_logo_uuid}" alt="logo website" style="width: 300px;" class="img-fluid">
                                </span>
                            </div>
                            <div class="form-group">
                                <label for="config_site_title" class="form-label">Tiêu đề trang chủ</label>
                                <form:input path="config_site_title" type="text" class="form-control"
                                            placeholder="Tiêu đề Website" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="config_home_url" class="form-label">Địa chỉ trang chủ</label>
                                <form:input path="config_home_url" type="text" class="form-control"
                                            placeholder="Tiêu đề Website" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="config_admin_url" class="form-label">Địa chỉ quản trị viên</label>
                                <form:input path="config_admin_url" type="text" class="form-control"
                                            placeholder="Tiêu đề Website" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="config_email" class="form-label">Email quản trị viên</label>
                                <form:input path="config_email" type="text" class="form-control"
                                            placeholder="Tiêu đề Website" maxlength="100"/>
                            </div>
                            <div class="form-group">
                                <label for="config_addr" class="form-label">Địa chỉ</label>
                                <form:input path="config_addr" type="text" class="form-control"
                                            placeholder="Địa chỉ cơ quan" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <label for="config_addr" class="form-label">Fax</label>
                                <form:input path="config_fax" type="text" class="form-control"
                                            placeholder="fax" maxlength="20"/>
                            </div>

                            <div class="form-group">
                                <label for="config_phone" class="form-label">Số điện thoại liên hệ</label>
                                <form:input path="config_phone" type="text" class="form-control"
                                            placeholder="Số điện thoại liên hệ"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                            maxlength="20"/>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="config_block_word" class="form-label">Bộ lọc từ ngữ (Ngăn cách bởi dấu ,
                                    )</label>
                                <form:textarea path="config_block_word" rows="3" class="form-control"
                                               placeholder="Những từ có trong đây sẽ không được phép nhập vào bài viết"
                                               maxlength="300"/>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary float-end"><i class="fe fe-save"></i> Lưu</button>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/config/config-script.jsp" charEncoding="UTF-8"/>

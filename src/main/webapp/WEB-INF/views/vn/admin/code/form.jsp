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
                <div class="header">
                    <div class="header-body">
                        <div class="row align-items-center">
                            <div class="col">
                                <!-- Title -->
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">Thêm Code</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <!-- / .row -->
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/code" class="nav-link text-nowrap active">
                                            Quản lý code
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/role" class="nav-link text-nowrap">
                                            Quản lý quyền
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${errorMess != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fe fe-x-circle"></i> ${errorMess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                            <i class="fe fe-x"></i>
                        </button>
                    </div>
                </c:if>

                <form:form modelAttribute="code" action="/cms/code/new" id="newCode" method="post">
                    <form:input class="form-control" type="hidden" path="code_seq" name="code_seq" required="true"
                                readonly="true"/>
                    <div class="card-body" style="max-height: 100%;">
                        <div class="col mb-3">
                            <label class="form-label">Tên code</label>
                            <form:input path="code_name" type="text" name="code_name" class="form-control"
                                        placeholder="Tên Code" maxlength="100"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="saveBtn" class="btn btn-primary"><i class="fe fe-save"></i> Lưu
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/agency/form-script.jsp" charEncoding="UTF-8"/>
<script>
    $('#saveBtn').click(function (){
        if($('input[name=code_name]').val() == ''){
            alert('Bạn chưa nhập tên code');
        }else{
            $('#newCode').submit();
        }
    })
</script>

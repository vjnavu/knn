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
                                <h1 class="header-title text-truncate">QUẢN LÝ QUYỀN TRUY CẬP</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                        <div class="row align-items-center">
                            <div class="col">
                                <ul class="nav nav-tabs nav-overflow header-tabs">
                                    <li class="nav-item">
                                        <a href="/cms/code" class="nav-link text-nowrap">
                                            Quản lý code
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/cms/role" class="nav-link text-nowrap active">
                                            Quản lý quyền
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover text-left table-nowrap card-table">
                                <thead>
                                <tr>
                                    <th>Menu cấp 1</th>
                                    <th>Menu Cấp 2</th>
                                    <th>DSD</th>
                                    <th>NSAO</th>
                                </tr>
                                </thead>
                                <tbody class="list fs-base">
                                <input type="hidden" value="${dsd}" id="dsd">
                                <input type="hidden" value="${nsao}" id="nsao">
                                <c:if test="${empty roles}">
                                    <tr>
                                        <td colspan="10" class="text-center">Không có dữ liệu</td>
                                    </tr>
                                </c:if>
                                <c:forEach items="${roles}" var="item">
                                    <tr>
                                        <td rowspan="${item.value.size()+1}">${item.key.role_name}</td>
                                    </tr>
                                    <c:forEach items="${item.value}" var="item1">
                                        <tr>
                                            <td>${item1.role_name}</td>
                                            <td>
                                                <input type="checkbox" class="form-check-input mx-2 dsd"
                                                       id="dsd${item1.role_seq}"
                                                       value="${item1.role_seq}"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="form-check-input mx-2 nsao"
                                                       id="nsao${item1.role_seq}"
                                                       value="${item1.role_seq}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a id="roleSaveBtn" class="btn btn-primary float-end"><i class="fe fe-save"></i> Lưu</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>

<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>

    $(document).ready(function () {
        let dsd = $('#dsd').val().split(',');
        let nsao = $('#nsao').val().split(',');
        for (let i = 0; i < dsd.length; i++) {
            $('#dsd' + dsd[i]).prop('checked', true);
        }
        for (let i = 0; i < nsao.length; i++) {
            $('#nsao' + nsao[i]).prop('checked', true);
        }
    });

    $('#roleSaveBtn').click(function () {
        let dsd = [];
        let nsao = [];
        $('.dsd:checked').each(function (idx, el) {
            dsd.push(el.value);
        });
        $('.nsao:checked').each(function (idx, el) {
            nsao.push(el.value);
        });

        $.ajax({
            url: '/cms/role/update',
            type: 'GET',
            headers: {
                Accept : "application/json"
            },
            data: {
                'dsd': dsd,
                'nsao': nsao
            },
            success: function (data) {
                if (data) {
                    Swal.fire(
                        'Thông Báo',
                        'Chỉnh sửa quyền thành công',
                        'success'
                    ).then(function () {
                        location.reload();
                    })
                } else {
                    Swal.fire(
                        'Thông Báo',
                        'Đã xẩy ra lỗi khi lưu thông tin',
                        'error'
                    )
                }
            },
            error: function () {
                Swal.fire(
                    'Thất Bại',
                    'Đã xảy ra lỗi. Vui lòng thử lại sau.',
                    'error'
                )
            }
        })
    })

</script>

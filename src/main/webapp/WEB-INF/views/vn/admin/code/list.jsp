<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/vn/admin/include/header.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/admin/include/navigation.jsp" charEncoding="UTF-8"/>
<style>
    .table thead th, tbody td, tbody th {
        vertical-align: top;
    }
    hr{margin: unset}
    .selectBox {
        /*height: 150px;*/
        overflow-y: auto;
        /*border: #d2ddec solid 1px;*/
        border-radius: 5px;
        /*padding: 2px;*/
    }

    .input-code, .input-code-2{
        padding: 5px;
        border: none; width: 80%;
        /*border-bottom: #d2ddec solid 1px;*/
    }
    .code-delete{
        float: right;
        font-size: 15px;
        padding: 3px 5px;
        margin-top: 2px;
        margin-right: 5px;
    }

    .selectBox .boxValue {
        cursor: pointer;
        padding: 5px;
        display: block;
        color: #000;
    }

    .tools > span {
        width: 185px;
        cursor: pointer;
    }

    .selectBox .hide {
        display: none;
    }

    .code-group{cursor: pointer}
    .code-group:hover{color: #2c7be5; text-decoration: underline}
</style>
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
                                <h1 class="header-title text-truncate">Mã Code</h1>
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

                <button type="button" class="btn btn-primary mb-2 text-left" data-bs-toggle="modal" id="btnAdd"
                        data-bs-target="#newCodeModal"><i class="fe fe-plus-circle"></i> Thêm Nhóm Code
                </button>

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
                <!-- Tab content -->
                <div>
                    <div class="card">
                        <!-- change start / changer : choi gyeong won / 2022.07.05 / plus div .table-responsive -->
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <colgroup>
                                        <col style="width: 20%">
                                        <col style="width: 40%;">
                                        <col style="width: 40%;">
                                    </colgroup>
                                    <thead>
                                    <tr class="text-center">
                                        <th>Phân loại code</th>
                                        <th>1 Depth</th>
                                        <th>2 Depth</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${codes}" var="item">
                                        <tr>
                                            <th><span class="code-group" code-id="${item.key.code_id}">${item.key.code_name}</span></th>
                                            <td>
                                                <div class="selectBox">
                                                    <c:forEach items="${item.value}" var="item1">
                                                        <input class="input-code" id="box${item1.key.code_seq}"
                                                               code-seq="${item1.key.code_seq}"
                                                               code-id="${item1.key.code_id}"
                                                               original-name="${item1.key.code_name}"
                                                               value="${item1.key.code_name}"
                                                               code-top1-seq="${item.key.code_seq}"
                                                               code-top1-id="${item.key.code_id}"
                                                        />
                                                        <span class="btn btn-outline-danger code-delete" code-id="${item1.key.code_id}">Xoá</span>
                                                        <hr/>
                                                    </c:forEach>
                                                    <input type="text" class="form-control new-code-input" code-top1-seq="${item.key.code_seq}" code-top1-id="${item.key.code_id}" value="" placeholder="Nhập tên code mới và nhấn Enter">
                                                </div>
<%--                                                <div class="d-flex mt-4 tools">--%>
<%--                                                    <input type="text" class="form-control" value="" placeholder="Nhập tên code mới bạn cần thêm">--%>
<%--                                                    <span code-top1-seq="${item.key.code_seq}" code-top1-id="${item.key.code_id}" class="btn btn-dark mx-2 code-create">Đăng ký</span>--%>
<%--                                                </div>--%>
                                            </td>
                                            <td>
                                                <div class="selectBox">
                                                    <c:forEach items="${item.value}" var="item2">
                                                        <div class="value2 hide" data-box="box${item2.key.code_seq}">
                                                            <c:forEach items="${item2.value}" var="item3">
                                                                <input class="input-code-2" id="box${item1.key.code_seq}" code-id="${item3.code_id}" original-name="${item3.code_name}" value="${item3.code_name}"/>
                                                                <span class="btn btn-outline-danger code-delete" code-id="${item3.code_id}">Xoá</span>
                                                                <hr/>
                                                            </c:forEach>
                                                    <input type="text" class="form-control new-code-2-input" placeholder="Nhập tên code mới và nhấn Enter">
                                                        </div>
                                                    </c:forEach>
                                                </div>
<%--                                                <div class="d-flex mt-4 tools">--%>
<%--                                                    <input type="text" class="form-control" value="" placeholder="Nhập tên code mới bạn cần thêm">--%>
<%--                                                    <span code-top1-seq="${item.key.code_seq}" code-top1-id="${item.key.code_id}" class="btn btn-dark mx-2 code-create">Đăng ký</span>--%>
<%--                                                </div>--%>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- change end / 2022.07.05 -->
                    </div>
                </div>

                <div class="modal fade" id="newCodeModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-card card">
                                <div class="card-header">
                                    <h4 class="card-header-title">
                                        Thêm Nhóm Code Mới
                                    </h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form>
                                    <input type="hidden" name="CODE_ID">
                                    <div class="card-body">
                                        <div class="col mb-3">
                                            <label class="form-label">Tên Code</label>
                                            <input type="text" name="CODE_NAME" class="form-control">
                                        </div>
                                        <div class="col  mb-3">
                                            <label class="form-label">Chú Thích</label>
                                            <textarea rows="4" name="CODE_DESC" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary code-new-modal"><i class="fe fe-save"></i> Lưu </button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" ><i class="fe fe-x"></i> Huỷ </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="groupCodeDetail" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-card card">
                                <div class="card-header">
                                    <h4 class="card-header-title">
                                        Thông Tin Nhóm Code
                                    </h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form>
                                    <input type="hidden" name="CODE_ID">
                                    <div class="card-body">
                                        <div class="col mb-3">
                                            <label class="form-label">Tên Code</label>
                                            <input type="text" name="CODE_NAME" class="form-control">
                                        </div>
                                        <div class="col  mb-3">
                                            <label class="form-label">Chú Thích</label>
                                            <textarea rows="4" name="CODE_DESC" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary code-update-modal"><i class="fe fe-save"></i> Lưu </button>
                                        <button type="button" class="btn btn-danger code-delete-modal"><i class="fe fe-trash"></i> Xoá </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $('.tools').find('input').keypress(function (){
        $()
    });

    $('.input-code, .new-code-input').click(function () {
        let depth1 = $(this).attr('id');
        let code2Seq = $(this).attr('code-seq');
        let code2Id = $(this).attr('code-id');
        let code1Seq = $(this).attr('code-top1-seq');
        let code1Id = $(this).attr('code-top1-id');

        $(".value2").addClass('hide');
        $(".value2").each(function (index) {
            if ($(this).attr('data-box') == depth1) {
                $(this).removeClass('hide');
                $(this).attr('code-1-se', code1Seq);
                $(this).attr('code-1-id', code1Id);
                $(this).attr('code-2-se', code2Seq);
                $(this).attr('code-2-id', code2Id);

            }
        });

        let codeName = $(this).text();
        $(this).parent().next('.mt-4.tools').find('input').attr('code-id',$(this).attr('code-id'));
        $(this).parent().next('.mt-4.tools').find('input').val(codeName);
    });

    $('.new-code-input').on('keypress', function (e) {
        if(e.which === 13){
            if($(this).val() == ''){
                alert('Bạn chưa nhập tên Code');
            }else{
                let codeTop1Seq = $(this).attr('code-top1-seq');
                let codeTop1Id = $(this).attr('code-top1-id');
                let codeName = $(this).val();
                $.ajax({
                    url: '/cms/code/new-api/top1',
                    type: 'GET',
                    dataType: 'json',
                    data: {'codeTop1Seq': codeTop1Seq, 'codeTop1Id': codeTop1Id, 'codeName': codeName},
                    success: function (data) {
                        if(data.status == '204'){
                            alert(data.message);
                        }else{
                            location.reload();
                        }
                    },
                    error: function () {
                        alert('Đã xẩy ra lỗi');
                    }
                });
            }
        }
    });

    $('.new-code-2-input').on('keypress', function (e) {
        if(e.which === 13){
            if($(this).val() == ''){
                alert('Bạn chưa nhập tên Code');
            }else{
                let codeTop1Seq = $(this).parent().attr('code-1-se');
                let codeTop1Id = $(this).parent().attr('code-1-id');
                let codeTop2Seq = $(this).parent().attr('code-2-se');
                let codeTop2Id = $(this).parent().attr('code-2-id');
                let codeName = $(this).val();
                $.ajax({
                    url: '/cms/code/new-api/top2',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        'codeTop1Seq': codeTop1Seq,
                        'codeTop1Id': codeTop1Id,
                        'codeTop2Seq': codeTop2Seq,
                        'codeTop2Id': codeTop2Id,
                        'codeName': codeName},
                    success: function (data) {
                        if(data.status == '204'){
                            alert(data.message);
                        }else{
                            location.reload();
                        }
                    },
                    error: function () {
                        alert('Đã xẩy ra lỗi');
                    }
                });
            }
        }
    });

    $('.code-create').click(function (){
        if($(this).parent().find('input').val() == ''){
            alert('Bạn chưa nhập tên Code');
        }else{
            let codeTop1Seq = $(this).attr('code-top1-seq');
            let codeTop1Id = $(this).attr('code-top1-id');
            let codeName = $(this).parent().find('input').val();
            $.ajax({
                url: '/cms/code/new-api/top1',
                type: 'GET',
                dataType: 'json',
                data: {'codeTop1Seq': codeTop1Seq, 'codeTop1Id': codeTop1Id, 'codeName': codeName},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                    }else{
                        location.reload();
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');
                }
            });
        }
    })

    $('.code-edit').click(function (){
        if($(this).parent().find('input').val() == ''){
            alert('Bạn chưa chọn code cần chỉnh sửa');
        }else if ($(this).parent().find('input').attr('code-id') == ''){
            alert('Tên code không tồn tại. Vui lòng đăng ký tên code');
        }
    })

    $('.input-code, .input-code-2').focusout(function (){
        if($(this).attr('original-name').trim() != $(this).val().trim()){
            let inputId = $(this).attr('id');
            let codeId = $(this).attr('code-id');
            let codeName = $(this).val().trim();
            $.ajax({
                url: '/cms/code/edit-api',
                type: 'GET',
                dataType: 'json',
                data: {'codeId': codeId, 'codeName': codeName, 'codeDesc': ''},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                        $('#'+inputId).val($('#'+inputId).attr('original-name'));
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');

                }
            });
        }
    })

    $('.code-delete').click(function (){
        if(confirm("Bạn muốn xoá mã Code này?")){
            $.ajax({
                url: '/cms/code/delete-api',
                type: 'GET',
                dataType: 'json',
                data: {'codeId': $(this).attr('code-id')},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                    }else{
                        location.reload();
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');

                }
            });
        }
    })

    $('.code-delete-modal').click(function (){
        if(confirm("Bạn muốn xoá mã Code này?")){
            let codeId = $('#groupCodeDetail').find('[name=CODE_ID]').val();
            $.ajax({
                url: '/cms/code/delete-api',
                type: 'GET',
                dataType: 'json',
                data: {'codeId': codeId},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                    }else{
                        location.reload();
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');

                }
            });
        }
    })

    $('.code-update-modal').click(function (){
        if($('#groupCodeDetail').find('[name=CODE_NAME]').val() == ''){
            alert('Tên Code không được để trống');
        }else{
            let codeId = $('#groupCodeDetail').find('[name=CODE_ID]').val();
            let codeName = $('#groupCodeDetail').find('[name=CODE_NAME]').val();
            let codeDesc = $('#groupCodeDetail').find('[name=CODE_DESC]').val();

            $.ajax({
                url: '/cms/code/edit-api',
                type: 'GET',
                dataType: 'json',
                data: {'codeId': codeId, 'codeName':codeName,'codeDesc':codeDesc},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                    }else{
                        location.reload();
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');
                }
            });
        }
    })

    $('.code-new-modal').click(function (){
        if($('#newCodeModal').find('[name=CODE_NAME]').val() == ''){
            alert('Tên Code không được để trống');
        }else{
            let codeName = $('#newCodeModal').find('[name=CODE_NAME]').val();
            let codeDesc = $('#newCodeModal').find('[name=CODE_DESC]').val();

            $.ajax({
                url: '/cms/code/new-api/group',
                type: 'GET',
                dataType: 'json',
                data: {'codeName':codeName,'codeDesc':codeDesc},
                success: function (data) {
                    if(data.status == '204'){
                        alert(data.message);
                    }else{
                        location.reload();
                    }
                },
                error: function () {
                    alert('Đã xẩy ra lỗi');
                }
            });
        }
    })



    $('.code-group').click(function (){
        $.ajax({
            url: '/cms/code/'+$(this).attr('code-id'),
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                if(data.status == '204'){
                    alert(data.message);
                }else{
                    cleanElementBeforeBlind('#groupCodeDetail');
                    bindObjectToElement(data.code, '#groupCodeDetail');
                    $('#groupCodeDetail').modal('toggle');
                }
            },
            error: function () {
                alert('Đã xẩy ra lỗi');

            }
        });
    })


</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="adminModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-card card">
                <div class="card-header">
                    <h4 class="card-header-title" id="exampleModalCenterTitle">
                        THÊM QUẢN TRỊ VIÊN
                    </h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form:form action="/cms/admin/new" modelAttribute="adminForm" id="admin" method="post"
                           enctype="multipart/form-data">
                    <form:input path="ad_seq" type="hidden"/>
                    <div class="card-body" style="max-height: 100%;">
                        <div class="form-group row" id="avatar">
                            <label class="col-sm-4 col-form-label">Ảnh đại diện</label>
                            <div class="col-sm-8">
                                <input id="ad_file" name="ad_file" type="file" class="form-control"
                                       accept="image/png, image/gif, image/jpeg"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="ad_email" class="col-sm-4 col-form-label">Email</label>
                            <div class="col-sm-8">
                                <form:input path="ad_email" id="ad_email" type="email" class="form-control"
                                            placeholder="Email" required="true"
                                            title="Vui lòng nhập email của bạn" maxlength="100"/>
                                <span class="text-danger" id="ad_email-span"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="ad_name" class="col-sm-4 col-form-label">Tên</label>
                            <div class="col-sm-8">
                                <form:input path="ad_name" type="text" class="form-control"
                                            placeholder="Nhập tên của bạn" required="true"
                                            title="Nhập tên của bạn" maxlength="100"/>
                            </div>
                        </div>
                        <div class="form-group row" id="department">
                            <label for="ad_agency_seq" class="col-sm-4 col-form-label">Tên cơ quan</label>
                            <div class="col-sm-8">
                                <form:select class="form-select form-control" path="ad_agency_seq">
                                    <option value="0">Chọn cơ quan</option>
                                    <option value="-1">DSD</option>
                                    <c:forEach items="${agencyList}" var="item">
                                        <option value="${item.ag_seq}">NSAO-${item.ag_name_vn}</option>
                                    </c:forEach>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_phone" class="col-sm-4 col-form-label">Số điện thoại</label>
                            <div class="col-sm-8">
                                <form:input path="ad_phone" type="text" class="form-control" placeholder="Số điện thoại"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                            required="true" maxlength="20"/>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_pw" class="col-sm-4 col-form-label">Mật khẩu</label>
                            <div class="col-sm-8">
                                <form:input path="ad_pw" id="ad_new_pw" type="password" class="form-control"
                                            maxlength="80"/>
                                <span class="text-danger" id="ad_pw-span"></span>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_pw_reinput" id="lb_ad_pw_reinput" class="col-sm-4 col-form-label">Xác nhận
                                mật khẩu</label>
                            <div class="col-sm-8">
                                <input id="ad_pw_reinput" type="password" class="form-control"
                                       placeholder="Nhập lại mật khẩu" required="true" maxlength="80"/>
                                <span class="text-danger" id="password-span"></span>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_memo" class="col-sm-4 col-form-label">Thông tin bổ sung</label>
                            <div class="col-sm-8">
                                <form:input path="ad_memo" type="text" class="form-control"
                                            placeholder="Nhập ghi chú" maxlength="200"/>
                                <span class="text-danger" id="ad_id-span"></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" id="btnSave" class="btn btn-primary" value="Lưu">
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>


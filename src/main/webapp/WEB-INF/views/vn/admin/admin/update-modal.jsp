<%@ page import="vn.gov.knn.admin.admin.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-card card">
                <div class="card-header">
                    <h4 class="card-header-title" id="updateUser">
                        CHỈNH SỬA QUẢN TRỊ VIÊN
                    </h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form:form action="/cms/admin/new" modelAttribute="adminForm" id="admin1" method="post"
                           enctype="multipart/form-data">
                    <form:input id="ad_seq_ud" path="ad_seq" type="hidden"/>
                    <input id="ad_email_current" type="hidden"/>

                    <div class="card-body" style="max-height: 100%;">
                        <div class="form-group row">
                            <label for="ad_email" class="col-sm-4 col-form-label">Email</label>
                            <div class="col-sm-8">
                                <form:input path="ad_email" id="ad_email_ud" type="email" class="form-control"
                                            placeholder="Email" required="true"
                                            title="Vui lòng nhập email của bạn" maxlength="100"/>
                                <span class="text-danger" id="ad_email_ud-span"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="ad_name" class="col-sm-4 col-form-label">Tên người dùng</label>
                            <div class="col-sm-8">
                                <form:input id="ad_name_ud" path="ad_name" type="text" class="form-control"
                                            placeholder="Nhập tên của bạn" required="true"
                                            title="Nhập tên của bạn" maxlength="100"/>
                            </div>
                        </div>
                        <div class="form-group row" id="department">
                            <label for="ad_agency_seq" class="col-sm-4 col-form-label">Tên cơ quan</label>
                            <div class="col-sm-8">
                                <form:select id="ad_agency_seq_ud" class="form-select form-control"
                                             path="ad_agency_seq">
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
                                <form:input id="ad_phone_ud" path="ad_phone" type="text" class="form-control"
                                            placeholder="Số điện thoại"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                            required="true" maxlength="20"/>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_pw_ud" class="col-sm-4 col-form-label">Mật khẩu</label>
                            <div class="col-sm-8">
                                <form:input path="ad_pw" id="ad_pw_ud" type="password" class="form-control"
                                            maxlength="80"/>
                                <span class="text-danger" id="ad_pw_ud-span"></span>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_pw_reinput_ud" id="lb_ad_pw_reinput" class="col-sm-4 col-form-label">Nhập Lại
                                Mật khẩu</label>
                            <div class="col-sm-8">
                                <input id="ad_pw_reinput_ud" type="password" class="form-control"
                                       placeholder="Nhập lại mật khẩu" required="true" maxlength="80"/>
                                <span class="text-danger" id="password_ud-span"></span>
                            </div>
                        </div>

                        <div class="form-group row" id="role">
                            <label for="ad_role_ud" class="col-sm-4 col-form-label">Phân Quyền</label>
                            <% Admin admin = (Admin) request.getSession().getAttribute("CurrentUser"); %>
                            <div class="col-sm-8">
                                <form:select id="ad_role_ud" class="form-select form-control" path="ad_role">
                                    <option value="1">ADMIN</option>
                                    <option value="2">DSD</option>
                                    <option value="3">NSAO</option>
                                </form:select>
                            </div>
                            <input type="hidden" value="<%=admin.getAd_role()%>" id="roleCurrentAdmin">
                            <input type="hidden" value="" id="roleAdminDefault">
                        </div>

                        <div class="form-group row">
                            <label for="ad_status" class="col-sm-4 col-form-label">Trạng Thái</label>
                            <div class="col-sm-8">
                                <form:select path="ad_status" id="ad_status_ud" class="form-select form-control">
                                    <option value="D"
                                            <c:if test="${item.ad_status == 'D'}">selected</c:if>>
                                        Đang đợi phê duyệt
                                    </option>
                                    <option value="Y"
                                            <c:if test="${item.ad_status == 'Y'}">selected</c:if>>
                                        Bình thường (Đã phê duyệt)
                                    </option>
                                    <option value="N"
                                            <c:if test="${item.ad_status == 'N'}">selected</c:if>>
                                        Ngưng sử dụng
                                    </option>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="ad_memo" class="col-sm-4 col-form-label">Thông tin bổ sung</label>
                            <div class="col-sm-8">
                                <form:input id="ad_memo_ud" path="ad_memo" type="text" class="form-control"
                                            placeholder="Nhập ghi chú" maxlength="200"/>
                                <span class="text-danger" id="ad_id-span"></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" id="btnUpdate" class="btn btn-primary" value="Lưu">
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script>
    $('#ad_role_ud').change(function () {
        let roled = parseInt($('#roleAdminDefault').val())
        let roles = parseInt($('#roleCurrentAdmin').val())
        let role = parseInt($('#ad_role_ud').val())
        if (role < roles) {
            alert('Bạn không thể cài đặt loại quyền cao hơn quyền của bạn. Thứ tự ADMIN>DSD>NSAO')
            $('#ad_role_ud').val(roled)
        }
    })
</script>
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
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">
                                    <c:if test="${formAction == 'new'}">THÊM CƠ QUAN</c:if>
                                    <c:if test="${formAction == 'update'}">CHỈNH SỬA CƠ QUAN</c:if>
                                </h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
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
                <form:form modelAttribute="agencyForm" id="agencyForm" action="/cms/agency/${formAction}"
                           method="post" enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body">
                            <form:input path="ag_seq" type="hidden"/>
                            <div class="col-6 float-start">
                                <div class="form-group me-5">
                                    <label for="ag_name_vn" class="form-label">Tên cơ quan (VN)</label>
                                    <form:input path="ag_name_vn" id="ag_name_vn" type="text" class="form-control"
                                                placeholder="Tên cơ quan (Tiếng Việt)" maxlength="100"/>
                                </div>
                            </div>

                            <div class="col-6 float-start">
                                <div class="form-group">
                                    <label for="ag_name_en" class="form-label">Tên cơ quan (EN)</label>
                                    <form:input path="ag_name_en" id="ag_name_en" type="text" class="form-control"
                                                placeholder="Tên cơ quan (Tiếng Anh)" maxlength="100"/>
                                </div>
                            </div>

                            <div class="form-group col-12">
                                <label for="ag_logo_file" class="form-label">Logo cơ quan</label>
                                <input id="ag_logo_file" name="ag_logo_file" type="file" class="form-control"
                                       accept="image/png, image/gif, image/jpeg"/>
                                <c:if test="${formAction == 'update'}">
                                    <img class="pt-3" class="img-fluid" style="object-fit:contain;"
                                         src="/jarvis/file/view/${agencyForm.ag_logo_file_uuid}"/>
                                </c:if>
                            </div>

                            <div class="form-group">
                                <label for="ag_addr1" class="form-label">Địa chỉ cơ quan</label>
                                <div class="row">
                                    <div class="col-3">
                                        <form:select class="form-select form-control" id="province"
                                                     path="ag_addr1">
                                            <option value="">Tỉnh / Thành phố</option>
                                            <c:if test="${not empty provinceList}">
                                                <c:forEach items="${provinceList}" var="item">
                                                    <option value="${item.addr1_seq}"
                                                            <c:if test="${agencyForm.ag_addr1 == item.addr1_seq}">selected</c:if>>
                                                            ${item.addr1_name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </form:select>
                                    </div>
                                    <div class="col-3 px-1">
                                        <form:select class="form-select form-control" id="district"
                                                     path="ag_addr2">
                                            <option value="">Quận / Huyện</option>
                                            <c:if test="${formAction == 'update' and not empty districtList}">
                                                <c:forEach items="${districtList}" var="item">
                                                    <option value="${item.addr2_seq}"
                                                            <c:if test="${agencyForm.ag_addr2 == item.addr2_seq}">selected</c:if>>
                                                            ${item.addr2_name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </form:select>
                                    </div>
                                    <div class="col-3 px-1">
                                        <form:select class="form-select form-control" id="communes"
                                                     path="ag_addr3">
                                            <option value="">Phường / Xã</option>
                                            <c:if test="${formAction == 'update' and not empty communesList}">
                                                <c:forEach items="${communesList}" var="item">
                                                    <option value="${item.addr3_seq}"
                                                            <c:if test="${agencyForm.ag_addr3 == item.addr3_seq}">selected</c:if>>
                                                            ${item.addr3_name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </form:select>
                                    </div>
                                    <div class="col-3 px-1">
                                        <form:input path="ag_addr" type="text" class="form-control"
                                                    placeholder="Địa chỉ chi tiết" maxlength="100"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group col-12">
                                <label for="ag_phone" class="form-label">Số Điện Thoại</label>
                                <form:input path="ag_phone" type="text" class="form-control"
                                            placeholder="Số điện thoại cơ quan"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                            maxlength="20"/>
                            </div>
                            <div class="form-group col-12">
                                <label for="ag_fax" class="form-label">Số Fax</label>
                                <form:input path="ag_fax" type="text" class="form-control"
                                            placeholder="Số Fax cơ quan" maxlength="20"/>
                            </div>
                            <div class="form-group col-12">
                                <label for="ag_web" class="form-label">Link Website Cơ Quan</label>
                                <form:input path="ag_web" type="text" class="form-control"
                                            placeholder="Link website cơ quan" maxlength="100"/>
                            </div>
                            <div class="form-group col-12">
                                <label for="ag_email" class="form-label">Email</label>
                                <form:input path="ag_email" type="email" class="form-control"
                                            placeholder="Email cơ quan" maxlength="100"/>
                            </div>
                            <div class="form-group col-12">
                                <label class="form-label">Hoạt động hay không</label>
                                <div>
                                    <form:radiobutton class="form-check-input" path="ag_acti_tf" value="true"
                                                      id="true"/>
                                    <label for="true" class="form-label">Có</label>
                                </div>
                                <div>
                                    <form:radiobutton class="form-check-input" path="ag_acti_tf" value="false"
                                                      id="false"/>
                                    <label for="false" class="form-label">Không</label>
                                </div>
                            </div>
                            <div class="form-group col-12">
                                <label for="ag_memo" class="form-label">Thông tin bổ sung</label>
                                <form:textarea path="ag_memo" id="ag_memo" rows="3" class="form-control"
                                               laceholder="Chú thích thông tin cơ quan"/>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="button" id="btnSave" class="btn btn-primary"><i class="fe fe-save"></i> Lưu
                            </button>
                            <a href="/cms/agency" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách</a>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/agency/form-script.jsp" charEncoding="UTF-8"/>
</body>


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
                                <h1 class="header-title text-truncate">CHỈNH SỬA MENU</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <form:form modelAttribute="menu" action="/cms/menu/update" method="post">
                            <form:input path="mn_seq" type="hidden"/>
                            <c:if test="${menu.mn_top != 0}">
                                <div class="form-group">
                                    <div class="col mb-3">
                                        <label class="form-label">Menu cha</label>
                                        <div>
                                            <form:select path="mn_top" class="form-select">
                                                <option value="0">--Select--</option>
                                                <c:forEach items="${menus}" var="item">
                                                    <option
                                                            <c:if test="${item.mn_seq == menu.mn_top}">selected</c:if>
                                                            value="${item.mn_seq}">${item.mn_name_vn}</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label class="form-label">Tên Menu (VN)</label>
                                <form:input path="mn_name_vn" type="text" name="mn_name_vn" id="nameVn"
                                            class="form-control"
                                            placeholder="Menu Name VN" maxlength="100"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Tên Menu (EN)</label>
                                <form:input path="mn_name_en" type="text" name="mn_name_en" class="form-control"
                                            placeholder="Menu Name EN" maxlength="100"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Thứ tự sắp xếp</label>
                                <form:input path="mn_sort" type="text" class="form-control" placeholder="1"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                            maxlength="3"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label col-3">Địa chỉ link</label>
                                <select class="form-select form-control col-2" id="linkMenu">
                                    <option value="enterLink">Tự nhập link</option>
                                    <option value="cat">Board</option>
                                    <option value="cont">Content</option>
                                </select>
                                <form:input path="mn_link" type="text" id="urlMenu" name="mn_link"
                                            class="form-control col-7"
                                            placeholder="Url..." cssStyle="margin-top: 10px;" maxlength="100"/>
                            </div>

                            <div class="form-group">
                                <form:checkbox class="form-check-input" path="mn_target_blank_tf" id="yes"/> <label
                                    for="yes" class="form-label">Mở liên kết trong tab mới</label>
                            </div>
                            <div class="form-group">
                                <div class="mt-2">
                                    <form:checkbox class="form-check-input" path="mn_display_vn_tf" id="vn"/>
                                    <label for="vn" class="form-label">Hiển thị trang tiếng Việt</label>&nbsp;&nbsp;

                                    <form:checkbox class="form-check-input" path="mn_display_en_tf" id="eng"/>
                                    <label for="eng" class="form-label">Hiển thị trang tiếng Anh</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Ngày đăng ký</label>
                                <input type="text" class="form-control" readonly
                                       value="<fmt:formatDate value="${menu.mn_reg_dt}" pattern="dd-MM-yyyy"/>"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Ngày chỉnh sửa</label>
                                <input type="text" class="form-control" readonly
                                        <c:if test="${menu.mn_mod_dt != null}">
                                            value="<fmt:formatDate value="${menu.mn_mod_dt}" pattern="dd-MM-yyyy"/>"
                                        </c:if>
                                        <c:if test="${menu.mn_mod_dt == null}">
                                            value = "Chưa chỉnh sửa"
                                        </c:if>
                                />
                            </div>
                            <div class="float-end">
                                <button type="submit" id="menuSaveBtn" class="btn btn-primary"><i
                                        class="fe fe-save"></i> Lưu
                                </button>
                                <a href="/cms/menu" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách
                                </a>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<c:import url="/WEB-INF/views/vn/admin/menu/mCat.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/menu/mCont.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/menu/format-date.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/admin/menu/Uform-script.jsp" charEncoding="UTF-8"/>

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
                                <h1 class="header-title text-truncate">THÊM MENU <c:if
                                        test="${menuParent != null}">PHỤ</c:if></h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <form:form modelAttribute="menu" action="/cms/menu/new" method="post">
                        <div class="card-body" style="max-height: 100%;">
                            <c:if test="${menuParent != null}">
                                <form:input path="mn_top" type="hidden" value="${menuParent.mn_seq}"/>
                            </c:if>
                            <c:if test="${menuParent == null}">
                                <form:input path="mn_top" type="hidden" value="0"/>
                            </c:if>

                            <c:if test="${menuParent != null}">
                                <div class="form-group">
                                    <label class="form-label">Phân loại cấp</label>
                                    <input type="hidden" id="realPath" value="${menuParent.mn_name_vn}">
                                    <input readonly class="form-control" type="text" id="pathMenu"
                                           value="${menuParent.mn_name_vn}/">
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
                                <form:input path="mn_sort" type="number" name="mn_sort" class="form-control"
                                            placeholder="1"
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
                                <form:checkbox class="form-check-input" path="mn_target_blank_tf" id="mn_target_blank"/>
                                <label for="mn_target_blank">Mở liên kết trong tab mới</label>
                            </div>
                            <div class="form-group">
                                <div class="mt-2">
                                    <form:checkbox class="form-check-input" path="mn_display_vn_tf" id="vn"/>
                                    <label for="vn" class="form-label">Hiển thị trang tiếng Việt</label>&nbsp;&nbsp;

                                    <form:checkbox class="form-check-input" path="mn_display_en_tf" id="eng"/>
                                    <label for="eng" class="form-label">Hiển thị trang tiếng Anh</label>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="submit" id="menuSaveBtn" class="btn btn-primary"><i class="fe fe-save"></i>
                                Lưu
                            </button>
                            <a href="/cms/menu" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách
                            </a>
                        </div>
                    </form:form>
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
<c:import url="/WEB-INF/views/vn/admin/menu/form-script.jsp" charEncoding="UTF-8"/>

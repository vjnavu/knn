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
                                <h5 class="sub-header text-truncate">Homepage Management System</h5>
                                <h1 class="header-title text-truncate">TRẢ LỜI HỎI ĐÁP</h1>
                            </div>
                            <c:import url="/WEB-INF/views/vn/admin/include/user-info.jsp" charEncoding="UTF-8"/>
                        </div>
                    </div>
                </div>

                <form:form action="/cms/qa/update" modelAttribute="qa" id="qaForm"
                           method="post">
                    <div class="card">
                        <form:input class="form-control" type="hidden" path="qa_seq" readonly="true"/>
                        <div class="card-body" style="max-height: 100%;">
                            <div class="form-group mb-3">
                                <label>Người hỏi</label>
                                <div class="input-group">
                                    <input type="text" value="${qa.qa_email}" class="form-control" readonly/>
                                </div>
                            </div>
                            <div class="form-group mb-3">
                                <label>Tiêu đề</label>
                                <div class="input-group">
                                    <input type="text" value="${qa.qa_title}" class="form-control"
                                           readonly/>
                                </div>
                            </div>
                            <div class="form-group mb-3">
                                <label>Nội dung câu hỏi</label>
                                <div class="input-group">
                                    <textarea class="form-control"
                                              rows="3" readonly>${qa.qa_question}</textarea>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <label for="qa_answer">Câu trả lời</label>
                                <div class="input-group">
                                    <form:textarea class="form-control editor" path="qa_answer" id="qa_answer"
                                                   rows="3"/>
                                </div>
                            </div>
                            <c:if test="${qa.admin_email != null}">
                                <div class="form-group mb-3">
                                    <label for="qa_answer">Admin trả lời</label>
                                    <div class="input-group">
                                        <input class="form-control" readonly value="${qa.admin_email}">
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${qa.qa_answer_dt != null}">
                                <div class="form-group mb-3">
                                    <label for="qa_answer">Ngày trả lời cuối</label>
                                    <div class="input-group">
                                        <input class="form-control" readonly value="<fmt:formatDate value='${qa.qa_answer_dt}'
                                                                pattern='dd-MM-yyyy'/>">
                                    </div>
                                </div>
                            </c:if>

                            <hr>
                            <div class="float-end">
                                <div type="submit" id="qaSave" class="btn btn-primary"><i
                                        class="fe fe-save"></i> Lưu
                                </div>
                                <a href="/cms/qa" class="btn btn-dark"><i class="fe fe-list"></i> Danh sách</a>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/vn/admin/include/footer.jsp" charEncoding="UTF-8"/>
</div>
<script src="/ckeditor/ckeditor.js"></script>
<script src="/ckfinder/ckfinder.js"></script>
<c:import url="/WEB-INF/views/vn/admin/include/script.jsp" charEncoding="UTF-8"/>
<script>
    let editor_config = {
        filebrowserBrowseUrl: '/../../../ckfinder/ckfinder.html',
        filebrowserImageBrowseUrl: '/../../../ckfinder/ckfinder.html?type=Images',
        filebrowserFlashBrowseUrl: '/../../../ckfinder/ckfinder.html?type=Flash',
        filebrowserUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files',
        filebrowserImageUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images',
        filebrowserFlashUploadUrl: 'ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash'
    };
    CKEDITOR.replace('qa_answer', editor_config);
    $('#qaSave').click(function () {
        if (CKEDITOR.instances['qa_answer'].getData() != '') {
            $('#qaForm').submit()
        } else {
            alert('Vui lòng điền câu trả lời')
        }
    });
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<style>
    .noti-null {
        font-style: italic;
    }

    .author {
        background: #ddd;
        border-radius: 5px;
    }

    .author > div {
        display: inline-block;
        min-width: 50%;
    }

    .table-qa dl > * {
        border-top: 0;
    }

    .qa-title {
        font-weight: 900;
        padding-bottom: 20px;
        color: var(--main-color);
        font-size: 20px;
    }

    .qa-question-content {
        min-height: 200px;
    }

    .qa-question-content textarea {
        padding: 10px;
        resize: none;
        background: #fff;
        border: none !important;
        min-height: 200px;
        height: unset !important;
    }

    .btn-edit-qa {
    }

    .btn-delete-qa {
        margin: 0 10px;
        background: #dc3545;
    }
</style>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <div class="container">
        <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
        <div class="row" style="min-height: 550px;">
            <div class="lnb">
                <div class="menu-name">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC2.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC2.mn_name_en}
                    </c:if>
                </div>

                <ul class="sub-nav">
                    <c:if test="${not empty menuSub}">
                        <c:forEach items="${menuSub}" var="sub">
                            <c:if test='<%=language.equals("vn")%>'>
                                <c:if test="${sub.mn_display_vn eq 'Y'}">
                                    <li
                                            <c:if test="${activeMenu == sub.mn_seq}">class="active"</c:if>
                                    ><a href="${sub.mn_link}">${sub.mn_name_vn}</a></li>
                                </c:if>
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                <c:if test="${sub.mn_display_en eq 'Y'}">
                                    <li
                                            <c:if test="${activeMenu == sub.mn_seq}">class="active"</c:if>
                                    ><a href="${sub.mn_link}">${sub.mn_name_en}</a></li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
            <div class="content qa">
                <div class="title-page">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC3.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC3.mn_name_en}
                    </c:if>
                </div>
                <hr>
                <div class="table-qa">
                    <dl>
                        <dd>
                            <h1 class="qa-title">${qa.qa_title}</h1>
                        </dd>
                    </dl>
                    <dl style="margin-bottom: 10px;">
                        <dd class="author">
                            <div><strong>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Người đăng câu hỏi:
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Poster:
                                </c:if> </strong>${qa.qa_email}
                            </div>
                            <div><strong>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Ngày đăng câu hỏi:
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Question post date:
                                </c:if> </strong><fmt:formatDate value="${qa.qa_question_dt}"
                                                                 pattern="dd-MM-yyyy"/>
                            </div>
                        </dd>
                    </dl>
                    <dl>
                        <dd class="qa-question-content"
                                <c:if test='${qa.qa_answer == null}'> style="border-bottom: 1px solid #ddd;"
                                </c:if>
                        >
                            <label for="qa_question"></label>
                            <textarea id="qa_question" disabled>${qa.qa_question}</textarea>
                        </dd>
                    </dl>
                    <c:if test='${qa.qa_answer != null}'>
                        <dl style="margin: 20px 0">
                            <dd class="author">
                                <div><strong>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Người trả lời:
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Respondent:
                                    </c:if> </strong>${qa.admin_email}
                                </div>
                                <div><strong>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Ngày trả lời:
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Question answer date:
                                    </c:if> </strong><fmt:formatDate value="${qa.qa_answer_dt}"
                                                                     pattern="dd-MM-yyyy"/>
                                </div>
                            </dd>
                        </dl>
                    </c:if>
                    <dl>
                        <c:if test='${qa.qa_answer != null}'>
                            <dd>${qa.qa_answer}</dd>
                        </c:if>
                        <c:if test='${qa.qa_answer == null}'>
                            <dd style="text-align: center; padding: 20px 0;">
                                <c:if test='<%=language.equals("vn")%>'>
                                    <span class="noti-null">Chưa có câu trả lời</span>
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    <span class="noti-null">No answer yet</span>
                                </c:if>
                            </dd>
                        </c:if>
                    </dl>
                </div>
                <div class="row" style="float: right; margin-bottom: 100px;">
                    <c:if test="${qa.qa_type == 'pri'}">
                        <c:if test='<%=language.equals("vn")%>'>
                            <c:if test="${qa.qa_answer == null}">
                                <a href="/news/qa/update/${key}"
                                   class="btn btn-dark btn-edit-qa">
                                    Chỉnh sửa
                                </a>
                            </c:if>
                            <a href="/news/qa/delete/${key}" class="btn btn-delete-qa">
                                Xoá
                            </a>
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <c:if test="${qa.qa_answer == null}">
                                <a href="/news/qa/update/${key}" class="btn btn-dark btn-edit-qa">
                                    Edit
                                </a>
                            </c:if>
                            <a href="/news/qa/delete/${key}" class="btn btn-delete-qa">
                                Delete
                            </a>
                        </c:if>
                    </c:if>
                    <a href="/news/qa/questions" class="btn btn-primary">
                        <c:if test='<%=language.equals("vn")%>'>
                            Danh sách
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Post list
                        </c:if>
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>

<script>

</script>
</body>
</html>

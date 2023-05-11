<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
<style>
    .news-detail .main .slides img {
        margin: auto auto 42px auto;
        display: block;
        width: 840px;
        height: 500px;
        object-fit: contain;
    }

    .table tbody tr td {
        text-align: center;
    }

    @media screen and (max-width: 767px) {
        .news-detail .table-basic tr td:nth-child(1):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Tên thí sinh : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Candidate name : '</c:if>;
            font-weight: bold;
        }

        .news-detail .table-basic tr td:nth-child(2):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Ngày sinh : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Date of birth : '</c:if>;
            font-weight: bold;
        }

        .news-detail .table-basic tr td:nth-child(3):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Giới tính : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Gender : '</c:if>;
            font-weight: bold;
        }

        .news-detail .table-basic tr td:nth-child(4):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Địa chỉ đơn vị : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Unit address : '</c:if>;
            font-weight: bold;
        }

        .news-detail .table-basic tr td:nth-child(5):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Lĩnh vực kỹ năng : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Vocational Skill : '</c:if>;
            font-weight: bold;
        }

        .news-detail .table-basic tr td:nth-child(6):before {
        <c:if test='<%=language.equals("vn")%>'> content: 'Giải thưởng : '</c:if>;
        <c:if test='<%=language.equals("en")%>'> content: 'Award : '</c:if>;
            font-weight: bold;
        }
    }

</style>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <div class="container">
        <div class="row">
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
                <div class="news-detail">
                    <div class="header" style="border-bottom: none;">
                        <div class="title">${exam.exam_name}</div>
                    </div>
                    <table class="table table-basic" style="margin-bottom: 30px;">
                        <caption></caption>
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Tên thí sinh
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Candidate name
                                </c:if>
                            </th>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Ngày sinh
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Date of birth
                                </c:if>
                            </th>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Giới tính
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Gender
                                </c:if>
                            </th>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Địa chỉ đơn vị
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Unit address
                                </c:if>
                            </th>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Lĩnh vực kỹ năng
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Vocational Skill
                                </c:if>
                            </th>
                            <th scope="col">
                                <c:if test='<%=language.equals("vn")%>'>
                                    Giải thưởng
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Award
                                </c:if>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty candidates}">
                            <tr>
                                <td colspan="6" style="font-style: italic">
                                    Không có dữ liệu thí sinh
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach items="${candidates}" var="cdd">
                            <c:if test="${cdd != null}">
                                <tr>
                                    <td>${cdd.cdd_name}</td>
                                    <td><fmt:formatDate value="${cdd.cdd_birthday}"
                                                        pattern="dd-MM-yyyy"/></td>
                                    <td>
                                        <c:if test="${cdd.cdd_gender eq 'M'}">Nam</c:if>
                                        <c:if test="${cdd.cdd_gender eq 'F'}">Nữ</c:if>
                                    </td>
                                    <td>${cdd.cdd_office}</td>
                                    <td>${cdd.cert2_name}</td>
                                    <td>${cdd.cdd_award}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <form:form action="/exam/view/${examSeq}/candidate" modelAttribute="cddSearch" id="searchForm"
                           method="get">
                    <form:input type="hidden" class="form-control" path="page" id="page"/>
                    <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                    <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                    <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                </form:form>
                <div class="row" style="justify-content: flex-end;">
                    <a href="/exam/${fn:toLowerCase(exam.exam_type)}" class="btn btn-primary">
                        <c:if test='<%=language.equals("vn")%>'>
                            Danh sách
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            List
                        </c:if>
                    </a>
                </div>
                ${paging.page}
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });
</script>
</body>
</html>

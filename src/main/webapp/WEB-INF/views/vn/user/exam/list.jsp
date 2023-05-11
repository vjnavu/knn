<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
<% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
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
                <div class="row header-qa">
                    <div class="total">
                        <c:if test='<%=language.equals("vn")%>'>Tổng : </c:if>
                        <c:if test='<%=language.equals("en")%>'>Total : </c:if>
                        ${totalRow}
                    </div>
                    <div class="page">
                        <c:if test='<%=language.equals("vn")%>'>Trang : </c:if>
                        <c:if test='<%=language.equals("en")%>'>Page : </c:if>
                        ${examSearch.page} / ${totalPage}
                    </div>
                </div>

                <table class="tableItem">
                    <caption></caption>
                    <colgroup>
                        <col style="width: 220px">
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${exams}" var="exam">
                        <tr>
                            <td><img src="/jarvis/file/view/${exam.exam_logo_uuid}" alt="logo exam"></td>
                            <td>
                                <ul>
                                    <li class="title">
                                        <a href="/exam/view/${exam.exam_seq}">${exam.exam_name}</a>
                                    </li>
                                    <li class="content">
                                            ${exam.exam_desc}
                                    </li>
                                    <li class="name">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            <span>Địa điểm thi: </span>
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            <span>Location: </span>
                                        </c:if>
                                            ${exam.exam_place}
                                    </li>
                                    <li class="time">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            <span>Thời gian: </span>
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            <span>Time: </span>
                                        </c:if>
                                        <fmt:formatDate value="${exam.exam_start_dt}"
                                                        pattern="dd-MM-yyyy"/> ~ <fmt:formatDate
                                            value="${exam.exam_end_dt}"
                                            pattern="dd-MM-yyyy"/>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="search-container">
                    <form:form action="/exam/${examType}" modelAttribute="examSearch" id="searchForm"
                               method="get">
                        <form:input type="hidden" class="form-control" path="page" id="page"/>
                        <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                        <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                        <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                        <label for="keyWord"></label>
                        <c:if test='<%=language.equals("vn")%>'>
                            <form:input path="keyWord" type="text" placeholder="Vui lòng nhập cụm từ tìm kiếm của bạn"
                                        />
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <form:input path="keyWord" type="text" placeholder="Please enter your search term"
                                        />
                        </c:if>
                        <button class="btn btn-primary bold">
                            <c:if test='<%=language.equals("vn")%>'>
                                Tìm kiếm
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Search
                            </c:if>
                        </button>
                    </form:form>
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

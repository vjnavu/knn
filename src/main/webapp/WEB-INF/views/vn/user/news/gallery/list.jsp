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
    <div class="container">
        <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
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
            <div class="content common">
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
                        <c:if test='<%=language.equals("vn")%>'>
                            Tổng
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Total
                        </c:if>
                        : ${totalRow}</div>
                    <div class="page">
                        <c:if test='<%=language.equals("vn")%>'>
                            Trang
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Page
                        </c:if>
                        : ${postSearch.page} /${totalPage}
                    </div>
                </div>

                <div class="card-list">
                    <div class="row">
                        <c:forEach items="${posts}" var="post">
                            <div class="card">
                                <a href="/news/gallery/view/${post.post_seq}">
                                    <div class="card-img">
                                        <img src="/jarvis/file/view/${post.post_avatar_uuid}" alt="Thumbnail news">
                                    </div>
                                    <div class="card-title">
                                        <c:if test='<%=language.equals("vn")%>'>
                                            ${post.post_title_vn}
                                        </c:if>
                                        <c:if test='<%=language.equals("en")%>'>
                                            <c:if test="${post.post_title_en == ''}">
                                                ${post.post_title_vn}
                                            </c:if>
                                            <c:if test="${post.post_title_en != ''}">
                                                ${post.post_title_en}
                                            </c:if>
                                        </c:if>
                                    </div>
                                </a>
                                <div class="card-content">
                                    <c:if test='<%=language.equals("vn")%>'>
                                        ${post.post_desc_vn}
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        <c:if test="${post.post_desc_en == ''}">
                                            ${post.post_desc_vn}
                                        </c:if>
                                        <c:if test="${post.post_desc_en != ''}">
                                            ${post.post_desc_en}
                                        </c:if>
                                    </c:if>
                                </div>
                                <div class="card-date"><fmt:formatDate value="${post.post_reg_dt}"
                                                                       pattern="dd-MM-yyyy"/></div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <form:form action="/news/board/${boardSeq}" modelAttribute="postSearch" id="searchForm"
                           method="get">
                    <form:input type="hidden" class="form-control" path="page" id="page"/>
                    <form:input type="hidden" class="form-control" path="size" id="pageSize"/>
                    <form:input type="hidden" class="form-control" path="order" id="sortOrder"/>
                    <form:input type="hidden" class="form-control" path="sort" id="sortDirection"/>
                        <sec:csrfInput />
                </form:form>
                ${paging.page}
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
<script>
    $('#btnSearch').click(function () {
        $('#page').val('1');
        $('#searchForm').submit();
    });
    $('.pagination>a').click(function () {
        $('#page').val($(this).attr("data-num"));
        $('#searchForm').submit();
    });
</script>
</body>
</html>
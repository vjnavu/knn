<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<c:import url="/WEB-INF/views/vn/user/include/head.jsp" charEncoding="UTF-8"/>
<style>
    .news-detail .main .slides img {
        margin: auto auto 42px auto;
        display: block;
        width: 840px;
        height: 500px;
        object-fit: contain;
    }

    .main ul,
    .main ul li {
        list-style: auto inside;
    }

    .main ul li {
        margin-bottom: 5px;
    }

    .main ul li span {
        position: relative;
        right: -5px;
    }
</style>
<body>
<c:import url="/WEB-INF/views/vn/user/include/header.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/views/vn/user/include/breadcrumb.jsp" charEncoding="UTF-8"/>
<div class="body">
    <div class="container">
        <div class="row">
            <div class="lnb">
                <% String language = (String) request.getSession().getAttribute("language");
    if(language == null){
        language = "vn";
        request.getSession().setAttribute("language",language);
    }
%>
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
                        Nghề tổ chức thi
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        Organization examination skill
                    </c:if>
                </div>
                <hr>
                <div class="news-detail">
                    <div class="header">
                        <div class="title">${exam.exam_name}</div>
                    </div>
                    <div class="main">
                        <ul>
                            <c:if test="${empty cert2s}">
                                <li style="list-style: none; text-align: center"><span style="font-style: italic">Không có dữ liệu nghề</span>
                                </li>
                            </c:if>
                            <c:forEach items="${cert2s}" var="item" varStatus="loop">
                                <li><span>${item.cert2_name}</span></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <a href="/exam/${fn:toLowerCase(exam.exam_type)}" class="btn btn-primary"
                   style="float: right; margin-bottom: 100px;">
                    <c:if test='<%=language.equals("vn")%>'>
                        Danh sách
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        List
                    </c:if>
                </a>
            </div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>
</body>
</html>

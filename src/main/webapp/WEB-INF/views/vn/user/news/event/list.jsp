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

            <div class="content videos">
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
                        : ${eventSearch.page} /${totalPage}
                    </div>
                </div>

                <div class="card-list">
                    <div class="row">
                        <ul class="album" style="margin-top: 0;">
                            <c:forEach items="${albums}" var="album">
                                <li class="album-image">
                                    <a>
                                        <c:forEach items="${album.album}" end="0" var="item">
                                            <%-- change start // changer : choi gyeong won, plus div className : album-image-wrap --%>
                                            <div class="album-image-wrap">
                                                <img src="/jarvis/file/view/${item.file_uuid}" alt="Album thumbnail">
                                            </div>
                                            <%-- change end // date : 2022.06.30 --%>
                                        </c:forEach>
                                        <p>${album.album_name}</p>
                                    </a>
                                    <div class="album-content">
                                        <i class="icon icon-close"></i>
                                        <div class="count"></div>
                                        <i class="next-btn icon-next"></i>
                                        <p class="title-album-element">${album.album_name}</p>
                                        <c:forEach items="${album.album}" var="items">
                                            <img src="/jarvis/file/view/${items.file_uuid}" class="album-element"
                                                 alt="Album element">
                                        </c:forEach>
                                        <i class="prev-btn icon-prev"></i>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <form:form action="/events" modelAttribute="eventSearch" id="searchForm"
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
    $(document).ready(function () {
        $('#btnSearch').click(function () {
            $('#page').val('1');
            $('#searchForm').submit();
        });

        $('.pagination>a').click(function () {
            $('#page').val($(this).attr("data-num"));
            $('#searchForm').submit();
        });

        $('.album-image > a').on('click', function () {
            $(this).parent().find('.album-content').addClass('active');
            $('.album-content').find('img:first').addClass('active');
        });

        $('.next-btn').on('click', function () {
            let currentImg = $(this).parent().find('.album-element.active');
            let nextImg = currentImg.next('.album-element');
            if (nextImg.length) {
                currentImg.removeClass('active');
                nextImg.addClass('active');
            }
        });

        $('.prev-btn').on('click', function () {
            let currentImg = $(this).parent().find('.album-element.active');
            let prevImg = currentImg.prev('.album-element');
            if (prevImg.length) {
                currentImg.removeClass('active');
                prevImg.addClass('active');
            }
        });

        $('.icon-close').on('click', function () {
            $(this).parent().removeClass('active');
            $(this).parent().find('.album-element').removeClass('active');
        });
    });
</script>
</body>
</html>
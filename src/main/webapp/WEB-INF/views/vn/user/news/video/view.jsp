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
                <div class="news-detail">
                    <div class="header">
                        <div class="title">
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
                        <div class="row">
                         <span class="date"><span>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Ngày đăng
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Date
                                </c:if>
                                : </span><fmt:formatDate value="${post.post_reg_dt}"
                                                         pattern="dd-MM-yyyy"/></span>
                            <span class="views"><span>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Lượt xem
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    View
                                </c:if>
                                : </span>${post.post_view_cnt}</span>
                        </div>
                    </div>
                    <div class="main">
                        <div style="text-align: center">
                            <iframe
                                    width="800"
                                    height="500"
                                    src=""
                                    title="Video player" allowfullscreen>
                            </iframe>
                        </div>
                        <c:if test='<%=language.equals("vn")%>'>
                            ${post.post_hyper_text_vn}
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            <c:if test="${post.post_hyper_text_en == ''}">
                                ${post.post_hyper_text_vn}
                            </c:if>
                            <c:if test="${post.post_hyper_text_en != ''}">
                                ${post.post_hyper_text_en}
                            </c:if>
                        </c:if>
                    </div>
                </div>
                <a href="/news/board/${boardSeq}" class="btn btn-primary"
                   style="float: right; margin-bottom: 100px;">
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

<c:import url="/WEB-INF/views/vn/user/include/footer.jsp" charEncoding="UTF-8"/>
<c:import url="/WEB-INF/views/vn/user/include/script.jsp" charEncoding="UTF-8"/>

<script>
    $(document).ready(() => {
        var iframeUrl = '${post.post_video_url}';
        if (iframeUrl.includes('youtube.com')) {
            var urlId = iframeUrl.slice(iframeUrl.indexOf('=') + 1, iframeUrl.length)
            var embedUrl = iframeUrl.replace(iframeUrl, 'https://www.youtube.com/embed/' + urlId);
            $('iframe').attr('src', embedUrl);
        } else {
            $('iframe').attr('src', iframeUrl);
        }
    })

</script>

</body>

</html>

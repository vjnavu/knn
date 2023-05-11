<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="content document">
                <div class="title-page">
                    <c:if test='<%=language.equals("vn")%>'>
                        ${breadcrumb.menuC3.mn_name_vn}
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        ${breadcrumb.menuC3.mn_name_en}
                    </c:if>
                </div>
                <hr>

                <ul class="table-document">
                    <li class="title">
                        <c:if test='<%=language.equals("vn")%>'>
                            Tiêu đề bài viết: ${post.post_title_vn}
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            Title: ${post.post_title_en}
                        </c:if>
                    </li>
                    <li>
                        <span>
                            <c:if test='<%=language.equals("vn")%>'>
                                Ngày đăng
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                Date
                            </c:if>
                            : </span><fmt:formatDate value="${post.post_reg_dt}"
                                                     pattern="dd-MM-yyyy"/>
                        <span>
                            <c:if test='<%=language.equals("vn")%>'>
                                Lượt xem
                            </c:if>
                            <c:if test='<%=language.equals("en")%>'>
                                View
                            </c:if>
                            : </span>${post.post_view_cnt}
                    </li>
                    <li>
                        <c:if test='<%=language.equals("vn")%>'>
                            ${post.post_hyper_text_vn}
                        </c:if>
                        <c:if test='<%=language.equals("en")%>'>
                            ${post.post_hyper_text_en}
                        </c:if>
                    </li>
                    <c:if test="${not empty post.fileVOList}">
                        <li>
                            <ul>
                                <li>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Tệp đính kèm
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        Attachment
                                    </c:if>
                                </li>
                                <li>
                                    <table class="document-attach">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        <c:forEach items="${post.fileVOList}" var="fileVO">
                                            <tr class="document-file">
                                                <td><i class="icon icon-attach"></i></td>
                                                <td><span>${fileVO.file_name}</span></td>
                                                <td>
                                                    <a href="/jarvis/file/download/${fileVO.file_uuid}"
                                                       class="btn btn-primary">
                                                        <c:if test='<%=language.equals("vn")%>'>
                                                            Tải xuống
                                                        </c:if>
                                                        <c:if test='<%=language.equals("en")%>'>
                                                            Download
                                                        </c:if>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>


                                        <%--                                    <c:forEach items="${post.fileVOList}" var="fileVO">--%>
                                        <%--                                        <div class="document-file">--%>
                                        <%--                                            <i class="icon icon-attach"></i>--%>
                                        <%--                                            <span>${fileVO.file_name}</span>--%>
                                        <%--                                            <a href="/jarvis/file/download/${fileVO.file_uuid}" class="btn btn-primary">--%>
                                        <%--                                                <c:if test='<%=language.equals("vn")%>'>--%>
                                        <%--                                                    Tải xuống--%>
                                        <%--                                                </c:if>--%>
                                        <%--                                                <c:if test='<%=language.equals("en")%>'>--%>
                                        <%--                                                    Download--%>
                                        <%--                                                </c:if>--%>
                                        <%--                                            </a>--%>
                                        <%--                                        </div>--%>
                                        <%--                                    </c:forEach>--%>
                                </li>
                            </ul>
                        </li>
                    </c:if>

                </ul>
                <div class="nav-bottom">
                    <div class="nav-wrap">
                        <a
                                <c:choose>
                                    <c:when test="${not empty prePost}">href="/news/basic/view/${prePost.post_seq}"</c:when>
                                    <c:otherwise>href="#"</c:otherwise>
                                </c:choose>
                        >
                            <span>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Bài viết trước
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Previous Post
                                </c:if>
                            </span>
                            <i class="icon icon-arrow-up"></i>
                        </a>
                        <span class="nav-content">
                            <c:choose>
                                <c:when test="${not empty prePost}">${prePost.post_title_vn}</c:when>
                                <c:otherwise>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Không có bài viết trước.
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        No previous posts.
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span><fmt:formatDate value="${prePost.post_reg_dt}"
                                              pattern="dd-MM-yyyy"/></span>
                    </div>
                    <div class="nav-wrap">
                        <a
                                <c:choose>
                                    <c:when test="${not empty nextPost}">href="/news/basic/view/${nextPost.post_seq}"</c:when>
                                    <c:otherwise>href="#"</c:otherwise>
                                </c:choose>
                        >
                            <span>
                                <c:if test='<%=language.equals("vn")%>'>
                                    Bài viết sau
                                </c:if>
                                <c:if test='<%=language.equals("en")%>'>
                                    Next Post
                                </c:if>
                            </span>
                            <i class="icon icon-arrow-down"></i>
                        </a>
                        <span class="nav-content">
                            <c:choose>
                                <c:when test="${not empty nextPost}">${nextPost.post_title_vn}</c:when>
                                <c:otherwise>
                                    <c:if test='<%=language.equals("vn")%>'>
                                        Không có bài viết sau.
                                    </c:if>
                                    <c:if test='<%=language.equals("en")%>'>
                                        There are no following posts.
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span><fmt:formatDate value="${nextPost.post_reg_dt}"
                                              pattern="dd-MM-yyyy"/></span>
                    </div>
                </div>
                <a href="/news/board/${boardSeq}" class="btn btn-primary" style="float: right; margin-bottom: 100px;">
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
</body>

</html>

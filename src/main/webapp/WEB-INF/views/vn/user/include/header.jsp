<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header>
    <% String language = (String) request.getSession().getAttribute("language");
        if (language == null) {
            language = "vn";
            request.getSession().setAttribute("language", language);
        }
    %>
    <div class="container">
        <div class="top-wrap">
            <a href="/">
                <img src="/jarvis/file/view/${config.config_logo_uuid}" alt="logo" class="logo">
            </a>
            <div class="search-container">
                <form:form action="/search" modelAttribute="generalSearch" id="genSearchForm"
                           method="get">
                    <form:input type="hidden" path="page" id="pageGen"/>
                    <form:input type="hidden" path="size" id="pageSizeGen"/>
                    <form:input type="hidden" path="order" id="sortOrderGen"/>
                    <form:input type="hidden" path="sort" id="sortDirectionGen"/>
                    <sec:csrfInput/>
                    <label for="keyGen"></label>
                    <c:if test='<%=language.equals("vn")%>'>
                        <form:input path="keyWord" type="text" placeholder="Vui lòng nhập cụm từ tìm kiếm của bạn"
                                    id="keyGen"/>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <form:input path="keyWord" type="text" placeholder="Please enter your search term"
                                    id="keyGen"/>
                    </c:if>
                    <button type="button" id="generalSearch" class="btn">
                        <i class="icon icon-search"></i>
                    </button>
                </form:form>
            </div>
            <div class="language-wrap">
                <div class="icon icon-global"></div>
                <div class="custom-select type2" style="width:105px;">
                    <label for="language"></label>
                    <select id="language">
                        <option value="0">GLOBAL</option>
                        <option value="1">VIETNAM</option>
                        <option value="2">ENGLISH</option>
                    </select>
                </div>
            </div>
            <span class="hamburger-bar">
                    <i class="icon icon-hamburger-bar"></i>
                </span>
        </div>

        <div class="menu">
            <ul>
                <c:if test="<%=language == null %>">
                    <% request.getSession().setAttribute("language", "vn");%>
                    <c:forEach items="${menus}" var="menu">
                        <li>
                            <c:if test="${menu.key.mn_display_vn eq 'Y'}">
                                <a <c:if test="${menu.key.mn_target_blank eq 'Y'}">target="_blank"</c:if> href="${menu.key.mn_link}"><span>${menu.key.mn_name_vn}</span></a>
                                <c:if test="${menu.value.size()>0}">
                                    <ul>
                                        <c:forEach items="${menu.value}" var="menuc">
                                            <c:if test="${menuc.mn_display_vn eq 'Y'}">
                                                <li><a <c:if test="${menuc.mn_target_blank eq 'Y'}">target="_blank"</c:if> href="${menuc.mn_link}">${menuc.mn_name_vn}</a></li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </c:if>
                        </li>
                    </c:forEach>
                </c:if>
                <c:if test="<%=language != null %>">
                    <c:if test='<%=language.equals("vn")%>'>
                        <c:forEach items="${menus}" var="menu">
                            <li>
                                <c:if test="${menu.key.mn_display_vn eq 'Y'}">
                                    <a <c:if test="${menu.key.mn_target_blank eq 'Y'}">target="_blank"</c:if> href="${menu.key.mn_link}"><span>${menu.key.mn_name_vn}</span></a>
                                    <c:if test="${menu.value.size()>0}">
                                        <ul>
                                            <c:forEach items="${menu.value}" var="menuc">
                                                <c:if test="${menuc.mn_display_vn eq 'Y'}">
                                                    <li><a <c:if test="${menuc.mn_target_blank eq 'Y'}">target="_blank"</c:if> href="${menuc.mn_link}">${menuc.mn_name_vn}</a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </c:if>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test='<%=language.equals("en")%>'>
                        <c:forEach items="${menus}" var="menu">
                            <li>
                                <c:if test="${menu.key.mn_display_en eq 'Y'}">
                                    <span>${menu.key.mn_name_en}</span>
                                    <c:if test="${menu.value.size()>0}">
                                        <ul>
                                            <c:forEach items="${menu.value}" var="menuc">
                                                <c:if test="${menuc.mn_display_en eq 'Y'}">
                                                    <li><a href="${menuc.mn_link}">${menuc.mn_name_en}</a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </c:if>
                            </li>
                        </c:forEach>
                    </c:if>
                </c:if>
            </ul>
            <div class="blur-screen"></div>
        </div>
    </div>
</header>
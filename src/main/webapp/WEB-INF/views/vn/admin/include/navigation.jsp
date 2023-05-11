<%@ page import="vn.gov.knn.admin.admin.Admin" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.gov.knn.admin.role.Role" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-vertical fixed-start navbar-expand-md navbar-light" id="sidebar">
    <div class="container-fluid">
        <% Admin admin = (Admin) request.getSession().getAttribute("CurrentUser"); %>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarCollapse"
                aria-controls="sidebarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="/cms/home">
            <img src="${pageContext.request.contextPath}/assets/cms/img/logo.png" class="navbar-brand-img mx-auto logo"
                 alt="...">
        </a>
        <div class="collapse navbar-collapse" id="sidebarCollapse">
            <% Map<Role, List<Role>> menus = (Map<Role, List<Role>>) request.getSession().getAttribute("menus"); %>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#sidebarDashboards" data-bs-toggle="collapse" role="button"
                       aria-expanded="false" aria-controls="sidebarDashboards">
                        <i class="fe fe-home"></i> Dashboard
                    </a>
                    <div class="collapse " id="sidebarDashboards">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="/cms/home" class="nav-link ">
                                    Dashboard
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <c:forEach var="item" items="<%=menus %>">
                    <li class="nav-item">
                        <a class="nav-link" href="#menu${item.key.role_seq}" data-bs-toggle="collapse" role="button"
                           aria-expanded="false"
                           aria-controls="sidebarBasics">
                            <i class="${item.key.role_icon}"></i> ${item.key.role_name}
                        </a>
                        <div class="collapse " id="menu${item.key.role_seq}">
                            <ul class="nav nav-sm flex-column">
                                <c:forEach var="item1" items="${item.value}">
                                    <li class="nav-item">
                                        <a href="${item1.role_url}" class="nav-link"
                                           <c:if
                                                   test="${item1.role_url == '/cms/certificate/detail'}">id="cerDetail"</c:if>
                                           <c:if test="${item1.role_url =='/cms/album'}">id="postMenu"</c:if>
                                        >
                                                ${item1.role_name}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                </c:forEach>
                <input type="hidden" id="saveActive"/>
            </ul>
        </div>
    </div>
</nav>
